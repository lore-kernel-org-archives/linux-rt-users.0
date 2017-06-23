From: Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 2/2] rt: Increase/decrease the nr of migratory tasks when
 enabling/disabling migration
Date: Fri, 23 Jun 2017 15:36:16 +0200
Message-ID: <ba3011dc-4437-b0ea-4537-83051b83c914@redhat.com>
References: <cover.1498068819.git.bristot@redhat.com>
 <a6c37371135c028dda5fb09133e093b234576ee3.1498068819.git.bristot@redhat.com>
 <20170622083830.5thlni7wy6ggdbh5@gmail.com>
 <5c90773d-1283-d3de-4282-e3855331d4e4@redhat.com>
 <20170622194943.ho4yekdqqeg2qiva@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
        "Luis Claudio R . Goncalves" <lgoncalv@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:35101 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751230AbdFWNgW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 23 Jun 2017 09:36:22 -0400
Received: by mail-qk0-f174.google.com with SMTP id 16so35611454qkg.2
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Jun 2017 06:36:22 -0700 (PDT)
In-Reply-To: <20170622194943.ho4yekdqqeg2qiva@gmail.com>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 06/22/2017 09:49 PM, Ingo Molnar wrote:
> So AFAICS it's this block that is used twice:
> 
>>>> +	rq = task_rq_lock(p, &rf);
>>>> +	p->nr_cpus_allowed = cpumask_weight(&p->cpus_mask);
>>>> +	if (unlikely((p->sched_class == &rt_sched_class ||
>>>> +		      p->sched_class == &dl_sched_class) &&
>>>> +		      p->nr_cpus_allowed > 1)) {
>>>> +		if (p->sched_class == &rt_sched_class)
>>>> +			task_rq(p)->rt.rt_nr_migratory++;
>>>> +		else
>>>> +			task_rq(p)->dl.dl_nr_migratory++;
>>>> +	}
>>>> +	task_rq_unlock(rq, p, &rf);
> or is there some difference I haven't noticed?

One block increases the number of migratory tasks, and the
other one decreases... 

How about this version? (if it is good, I will polish it in a v2).

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ce34e4f..0f66376 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7566,10 +7566,57 @@ const u32 sched_prio_to_wmult[40] = {
 
 #if defined(CONFIG_PREEMPT_COUNT) && defined(CONFIG_SMP)
 
+enum inc_dec_migratory {
+	DEC_NR_MIGRATORY = -1,
+	INC_NR_MIGRATORY = 1,
+};
+
+static inline void
+inc_dec_nr_migratory(struct task_struct *p, enum inc_dec_migratory id)
+{
+	if (unlikely((p->sched_class == &rt_sched_class ||
+		      p->sched_class == &dl_sched_class) &&
+		      p->nr_cpus_allowed > 1)) {
+		if (p->sched_class == &rt_sched_class)
+			task_rq(p)->rt.rt_nr_migratory += id;
+		else
+			task_rq(p)->dl.dl_nr_migratory += id;
+	}
+}
+
+static inline void
+migrate_disable_update_cpus_allowed(struct task_struct *p)
+{
+	struct rq *rq;
+	struct rq_flags rf;
+
+	p->cpus_ptr = cpumask_of(smp_processor_id());
+
+	rq = task_rq_lock(p, &rf);
+	inc_dec_nr_migratory(p, DEC_NR_MIGRATORY);
+	p->nr_cpus_allowed = 1;
+	task_rq_unlock(rq, p, &rf);
+}
+
+static inline void
+migrate_enable_update_cpus_allowed(struct task_struct *p)
+{
+	struct rq *rq;
+	struct rq_flags rf;
+
+	p->cpus_ptr = &p->cpus_mask;
+
+	rq = task_rq_lock(p, &rf);
+	p->nr_cpus_allowed = cpumask_weight(&p->cpus_mask);
+	inc_dec_nr_migratory(p, INC_NR_MIGRATORY);
+	task_rq_unlock(rq, p, &rf);
+}
+
 void migrate_disable(void)
 {
 	struct task_struct *p = current;
 
+
 	if (in_atomic() || irqs_disabled()) {
 #ifdef CONFIG_SCHED_DEBUG
 		p->migrate_disable_atomic++;
@@ -7593,10 +7640,9 @@ void migrate_disable(void)
 	preempt_disable();
 	preempt_lazy_disable();
 	pin_current_cpu();
-	p->migrate_disable = 1;
 
-	p->cpus_ptr = cpumask_of(smp_processor_id());
-	p->nr_cpus_allowed = 1;
+	migrate_disable_update_cpus_allowed(p);
+	p->migrate_disable = 1;
 
 	preempt_enable();
 }
@@ -7606,6 +7652,7 @@ void migrate_enable(void)
 {
 	struct task_struct *p = current;
 
+
 	if (in_atomic() || irqs_disabled()) {
 #ifdef CONFIG_SCHED_DEBUG
 		p->migrate_disable_atomic--;
@@ -7628,9 +7675,8 @@ void migrate_enable(void)
 
 	preempt_disable();
 
-	p->cpus_ptr = &p->cpus_mask;
-	p->nr_cpus_allowed = cpumask_weight(&p->cpus_mask);
 	p->migrate_disable = 0;
+	migrate_enable_update_cpus_allowed(p);
 
 	if (p->migrate_disable_update) {
 		struct rq *rq;
