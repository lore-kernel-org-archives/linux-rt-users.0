From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 2/2] rt: Increase/decrease the nr of migratory tasks when
 enabling/disabling migration
Date: Sat, 24 Jun 2017 08:41:57 +0200
Message-ID: <20170624064157.tc7xogi4aa5t7maf@gmail.com>
References: <cover.1498068819.git.bristot@redhat.com>
 <a6c37371135c028dda5fb09133e093b234576ee3.1498068819.git.bristot@redhat.com>
 <20170622083830.5thlni7wy6ggdbh5@gmail.com>
 <5c90773d-1283-d3de-4282-e3855331d4e4@redhat.com>
 <20170622194943.ho4yekdqqeg2qiva@gmail.com>
 <ba3011dc-4437-b0ea-4537-83051b83c914@redhat.com>
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
In-Reply-To: <ba3011dc-4437-b0ea-4537-83051b83c914@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Daniel Bristot de Oliveira <bristot@redhat.com> wrote:

> On 06/22/2017 09:49 PM, Ingo Molnar wrote:
> > So AFAICS it's this block that is used twice:
> > 
> >>>> +	rq = task_rq_lock(p, &rf);
> >>>> +	p->nr_cpus_allowed = cpumask_weight(&p->cpus_mask);
> >>>> +	if (unlikely((p->sched_class == &rt_sched_class ||
> >>>> +		      p->sched_class == &dl_sched_class) &&
> >>>> +		      p->nr_cpus_allowed > 1)) {
> >>>> +		if (p->sched_class == &rt_sched_class)
> >>>> +			task_rq(p)->rt.rt_nr_migratory++;
> >>>> +		else
> >>>> +			task_rq(p)->dl.dl_nr_migratory++;
> >>>> +	}
> >>>> +	task_rq_unlock(rq, p, &rf);
> > or is there some difference I haven't noticed?
> 
> One block increases the number of migratory tasks, and the
> other one decreases... 
> 
> How about this version? (if it is good, I will polish it in a v2).
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index ce34e4f..0f66376 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7566,10 +7566,57 @@ const u32 sched_prio_to_wmult[40] = {
>  
>  #if defined(CONFIG_PREEMPT_COUNT) && defined(CONFIG_SMP)
>  
> +enum inc_dec_migratory {
> +	DEC_NR_MIGRATORY = -1,
> +	INC_NR_MIGRATORY = 1,
> +};
> +
> +static inline void
> +inc_dec_nr_migratory(struct task_struct *p, enum inc_dec_migratory id)
> +{
> +	if (unlikely((p->sched_class == &rt_sched_class ||
> +		      p->sched_class == &dl_sched_class) &&
> +		      p->nr_cpus_allowed > 1)) {
> +		if (p->sched_class == &rt_sched_class)
> +			task_rq(p)->rt.rt_nr_migratory += id;
> +		else
> +			task_rq(p)->dl.dl_nr_migratory += id;
> +	}
> +}

How about just 'long delta', pass in +1 or -1 and do away with the 
inc_dec_migratory complication?

Thanks,

	Ingo
