From: Austin Schuh <austin@peloton-tech.com>
Subject: Re: [PATCH] sched: fix RLIMIT_RTTIME when PI-boosting to RT
Date: Thu, 5 Mar 2015 09:10:47 -0800
Message-ID: <CANGgnMaiiBDO=pYs2n7HbOMf58m0FOreSC8y8RmDvu-zdO+ibA@mail.gmail.com>
References: <1424305436-6716-1-git-send-email-brian@peloton-tech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: mingo@redhat.com, peterz@infradead.org,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, bigeasy@linutronix.de,
	rt-users <linux-rt-users@vger.kernel.org>
To: Brian Silverman <brian@peloton-tech.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424305436-6716-1-git-send-email-brian@peloton-tech.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

ping?

On Wed, Feb 18, 2015 at 4:23 PM,  <brian@peloton-tech.com> wrote:
> From: Brian Silverman <brian@peloton-tech.com>
>
> When non-realtime tasks get priority-inheritance boosted to a realtime
> scheduling class, RLIMIT_RTTIME starts to apply to them. However, the
> counter used for checking this (the same one used for SCHED_RR
> timeslices) was not getting reset. This meant that tasks running with a
> non-realtime scheduling class which are repeatedly boosted to a realtime
> one, but never block while they are running realtime, eventually hit the
> timeout without ever running for a time over the limit. This patch
> resets the realtime timeslice counter when un-PI-boosting from an RT to
> a non-RT scheduling class.
>
> I have some test code with two threads and a shared PTHREAD_PRIO_INHERIT
> mutex which induces priority boosting and spins while boosted that gets
> killed by a SIGXCPU on non-fixed kernels but doesn't with this patch
> applied. It happens much faster with a CONFIG_PREEMPT_RT kernel, and
> does happen eventually with PREEMPT_VOLUNTARY kernels.
>
> Signed-off-by: Brian Silverman <brian@peloton-tech.com>
> ---
> I am not subscribed to the list so please CC me on any responses.
>
>  kernel/sched/core.c |    2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 87b9814..16ad0ed 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3192,6 +3192,8 @@ void rt_mutex_setprio(struct task_struct *p, int prio)
>         } else {
>                 if (dl_prio(oldprio))
>                         p->dl.dl_boosted = 0;
> +               if (rt_prio(oldprio))
> +                       p->rt.timeout = 0;
>                 p->sched_class = &fair_sched_class;
>         }
>
> --
> 1.7.10.4
>
