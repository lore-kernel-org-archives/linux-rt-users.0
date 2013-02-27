From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: rt: rtmutex experiment doubled tbench throughput
Date: Tue, 26 Feb 2013 21:22:56 -0500
Message-ID: <CAP=VYLpWCDztU6-cMR1BVCUUeaa7eqKnXM88wzoqxDCR=SKdSw@mail.gmail.com>
References: <1361551010.32441.50.camel@marge.simpson.net> <1361913901.11373.59.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mike Galbraith <bitbucket@online.de>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:42262 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932259Ab3B0CX3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 26 Feb 2013 21:23:29 -0500
Received: by mail-wg0-f47.google.com with SMTP id dr13so48009wgb.14
        for <linux-rt-users@vger.kernel.org>; Tue, 26 Feb 2013 18:23:26 -0800 (PST)
In-Reply-To: <1361913901.11373.59.camel@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Feb 26, 2013 at 4:25 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Fri, 2013-02-22 at 17:36 +0100, Mike Galbraith wrote:
>
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -2083,6 +2083,9 @@ extern unsigned int sysctl_sched_latency
>>  extern unsigned int sysctl_sched_min_granularity;
>>  extern unsigned int sysctl_sched_wakeup_granularity;
>>  extern unsigned int sysctl_sched_child_runs_first;
>> +#ifdef CONFIG_PREEMPT_RT_FULL
>> +extern unsigned int sysctl_sched_rt_spin_yield;
>> +#endif
>>
>>  enum sched_tunable_scaling {
>>       SCHED_TUNABLESCALING_NONE,
>> @@ -2146,12 +2149,12 @@ extern unsigned int sysctl_sched_cfs_ban
>>  #endif
>>
>>  #ifdef CONFIG_RT_MUTEXES
>> -extern void task_setprio(struct task_struct *p, int prio);
>> +extern void task_setprio(struct task_struct *p, int prio, int yield);
>
> BTW, what kernel did you apply this too, as there's no task_setprio()
> anymore in 3.0-rt, 3.2-rt, 3.4-rt or 3.6-rt?

Hi Steve -- are you sure on that?

------------------
paul@PhenomX6:~/git/linux-stable-rt$ git describe
v3.0.66-rt93
paul@PhenomX6:~/git/linux-stable-rt$ git grep -l task_setprio
include/linux/sched.h
kernel/sched.c
paul@PhenomX6:~/git/linux-stable-rt$
------------------

Paul.
--

>
> -- Steve
>
>
>>  extern int rt_mutex_getprio(struct task_struct *p);
>>  extern int rt_mutex_check_prio(struct task_struct *task, int newprio);
>>  static inline void rt_mutex_setprio(struct task_struct *p, int prio)
>>  {
>> -     task_setprio(p, prio);
>> +     task_setprio(p, prio, 0);
>>  }
>>  extern void rt_mutex_adjust_pi(struct task_struct *p);
>>  static inline bool tsk_is_pi_blocked(struct task_struct *tsk)
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
