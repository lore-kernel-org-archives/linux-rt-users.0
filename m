From: Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 2/2] rt: Increase/decrease the nr of migratory tasks when
 enabling/disabling migration
Date: Thu, 22 Jun 2017 15:31:19 +0200
Message-ID: <5c90773d-1283-d3de-4282-e3855331d4e4@redhat.com>
References: <cover.1498068819.git.bristot@redhat.com>
 <a6c37371135c028dda5fb09133e093b234576ee3.1498068819.git.bristot@redhat.com>
 <20170622083830.5thlni7wy6ggdbh5@gmail.com>
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
Received: from mail-qk0-f169.google.com ([209.85.220.169]:35224 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbdFVNbZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 22 Jun 2017 09:31:25 -0400
Received: by mail-qk0-f169.google.com with SMTP id 16so11934616qkg.2
        for <linux-rt-users@vger.kernel.org>; Thu, 22 Jun 2017 06:31:24 -0700 (PDT)
In-Reply-To: <20170622083830.5thlni7wy6ggdbh5@gmail.com>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 06/22/2017 10:38 AM, Ingo Molnar wrote:
> 
> * Daniel Bristot de Oliveira <bristot@redhat.com> wrote:
> 
>>  void migrate_disable(void)
>>  {
>>  	struct task_struct *p = current;
>> +	struct rq *rq;
>> +	struct rq_flags rf;
>> +
>>  
>>  	if (in_atomic() || irqs_disabled()) {
>>  #ifdef CONFIG_SCHED_DEBUG
>> @@ -7593,10 +7596,21 @@ void migrate_disable(void)
>>  	preempt_disable();
>>  	preempt_lazy_disable();
>>  	pin_current_cpu();
>> -	p->migrate_disable = 1;
>>  
>> -	p->cpus_ptr = cpumask_of(smp_processor_id());
>> +	rq = task_rq_lock(p, &rf);
>> +	if (unlikely((p->sched_class == &rt_sched_class ||
>> +		      p->sched_class == &dl_sched_class) &&
>> +		      p->nr_cpus_allowed > 1)) {
>> +		if (p->sched_class == &rt_sched_class)
>> +			task_rq(p)->rt.rt_nr_migratory--;
>> +		else
>> +			task_rq(p)->dl.dl_nr_migratory--;
>> +	}
>>  	p->nr_cpus_allowed = 1;
>> +	task_rq_unlock(rq, p, &rf);
>> +	p->cpus_ptr = cpumask_of(smp_processor_id());
>> +	p->migrate_disable = 1;
>> +
>>  
>>  	preempt_enable();
>>  }
>> @@ -7605,6 +7619,9 @@ EXPORT_SYMBOL(migrate_disable);
>>  void migrate_enable(void)
>>  {
>>  	struct task_struct *p = current;
>> +	struct rq *rq;
>> +	struct rq_flags rf;
>> +
>>  
>>  	if (in_atomic() || irqs_disabled()) {
>>  #ifdef CONFIG_SCHED_DEBUG
>> @@ -7628,17 +7645,24 @@ void migrate_enable(void)
>>  
>>  	preempt_disable();
>>  
>> -	p->cpus_ptr = &p->cpus_mask;
>> -	p->nr_cpus_allowed = cpumask_weight(&p->cpus_mask);
>>  	p->migrate_disable = 0;
>> +	p->cpus_ptr = &p->cpus_mask;
>>  
>> -	if (p->migrate_disable_update) {
>> -		struct rq *rq;
>> -		struct rq_flags rf;
>> +	rq = task_rq_lock(p, &rf);
>> +	p->nr_cpus_allowed = cpumask_weight(&p->cpus_mask);
>> +	if (unlikely((p->sched_class == &rt_sched_class ||
>> +		      p->sched_class == &dl_sched_class) &&
>> +		      p->nr_cpus_allowed > 1)) {
>> +		if (p->sched_class == &rt_sched_class)
>> +			task_rq(p)->rt.rt_nr_migratory++;
>> +		else
>> +			task_rq(p)->dl.dl_nr_migratory++;
>> +	}
>> +	task_rq_unlock(rq, p, &rf);
> 
> The fix looks good to me, but AFAICS the repeat pattern introduced here could be 
> factored out into a helper function instead, right?

Like:

static inline int task_in_rt_class(struct task_struct *p)
{
	return p->sched_class == &rt_sched_class;
}

static inline int task_in_dl_class(struct task_struct *p)
{
	return p->sched_class == &dl_sched_class;
}

?

Thanks!

-- Daniel

