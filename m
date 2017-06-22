From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 2/2] rt: Increase/decrease the nr of migratory tasks when
 enabling/disabling migration
Date: Thu, 22 Jun 2017 21:49:44 +0200
Message-ID: <20170622194943.ho4yekdqqeg2qiva@gmail.com>
References: <cover.1498068819.git.bristot@redhat.com>
 <a6c37371135c028dda5fb09133e093b234576ee3.1498068819.git.bristot@redhat.com>
 <20170622083830.5thlni7wy6ggdbh5@gmail.com>
 <5c90773d-1283-d3de-4282-e3855331d4e4@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
        "Luis Claudio R . Goncalves" <lgoncalv@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Daniel Bristot de Oliveira <bristot@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5c90773d-1283-d3de-4282-e3855331d4e4@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Daniel Bristot de Oliveira <bristot@redhat.com> wrote:

> On 06/22/2017 10:38 AM, Ingo Molnar wrote:
> > 
> > * Daniel Bristot de Oliveira <bristot@redhat.com> wrote:
> > 
> >>  void migrate_disable(void)
> >>  {
> >>  	struct task_struct *p = current;
> >> +	struct rq *rq;
> >> +	struct rq_flags rf;
> >> +
> >>  
> >>  	if (in_atomic() || irqs_disabled()) {
> >>  #ifdef CONFIG_SCHED_DEBUG
> >> @@ -7593,10 +7596,21 @@ void migrate_disable(void)
> >>  	preempt_disable();
> >>  	preempt_lazy_disable();
> >>  	pin_current_cpu();
> >> -	p->migrate_disable = 1;
> >>  
> >> -	p->cpus_ptr = cpumask_of(smp_processor_id());
> >> +	rq = task_rq_lock(p, &rf);
> >> +	if (unlikely((p->sched_class == &rt_sched_class ||
> >> +		      p->sched_class == &dl_sched_class) &&
> >> +		      p->nr_cpus_allowed > 1)) {
> >> +		if (p->sched_class == &rt_sched_class)
> >> +			task_rq(p)->rt.rt_nr_migratory--;
> >> +		else
> >> +			task_rq(p)->dl.dl_nr_migratory--;
> >> +	}
> >>  	p->nr_cpus_allowed = 1;
> >> +	task_rq_unlock(rq, p, &rf);
> >> +	p->cpus_ptr = cpumask_of(smp_processor_id());
> >> +	p->migrate_disable = 1;
> >> +
> >>  
> >>  	preempt_enable();
> >>  }
> >> @@ -7605,6 +7619,9 @@ EXPORT_SYMBOL(migrate_disable);
> >>  void migrate_enable(void)
> >>  {
> >>  	struct task_struct *p = current;
> >> +	struct rq *rq;
> >> +	struct rq_flags rf;
> >> +
> >>  
> >>  	if (in_atomic() || irqs_disabled()) {
> >>  #ifdef CONFIG_SCHED_DEBUG
> >> @@ -7628,17 +7645,24 @@ void migrate_enable(void)
> >>  
> >>  	preempt_disable();
> >>  
> >> -	p->cpus_ptr = &p->cpus_mask;
> >> -	p->nr_cpus_allowed = cpumask_weight(&p->cpus_mask);
> >>  	p->migrate_disable = 0;
> >> +	p->cpus_ptr = &p->cpus_mask;
> >>  
> >> -	if (p->migrate_disable_update) {
> >> -		struct rq *rq;
> >> -		struct rq_flags rf;
> >> +	rq = task_rq_lock(p, &rf);
> >> +	p->nr_cpus_allowed = cpumask_weight(&p->cpus_mask);
> >> +	if (unlikely((p->sched_class == &rt_sched_class ||
> >> +		      p->sched_class == &dl_sched_class) &&
> >> +		      p->nr_cpus_allowed > 1)) {
> >> +		if (p->sched_class == &rt_sched_class)
> >> +			task_rq(p)->rt.rt_nr_migratory++;
> >> +		else
> >> +			task_rq(p)->dl.dl_nr_migratory++;
> >> +	}
> >> +	task_rq_unlock(rq, p, &rf);
> > 
> > The fix looks good to me, but AFAICS the repeat pattern introduced here could be 
> > factored out into a helper function instead, right?
> 
> Like:
> 
> static inline int task_in_rt_class(struct task_struct *p)
> {
> 	return p->sched_class == &rt_sched_class;
> }
> 
> static inline int task_in_dl_class(struct task_struct *p)
> {
> 	return p->sched_class == &dl_sched_class;
> }
> 
> ?

So AFAICS it's this block that is used twice:

> >> +	rq = task_rq_lock(p, &rf);
> >> +	p->nr_cpus_allowed = cpumask_weight(&p->cpus_mask);
> >> +	if (unlikely((p->sched_class == &rt_sched_class ||
> >> +		      p->sched_class == &dl_sched_class) &&
> >> +		      p->nr_cpus_allowed > 1)) {
> >> +		if (p->sched_class == &rt_sched_class)
> >> +			task_rq(p)->rt.rt_nr_migratory++;
> >> +		else
> >> +			task_rq(p)->dl.dl_nr_migratory++;
> >> +	}
> >> +	task_rq_unlock(rq, p, &rf);

or is there some difference I haven't noticed?

Thanks,

	Ingo
