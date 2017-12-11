From: Corey Minyard <cminyard@mvista.com>
Subject: Re: [ANNOUNCE] 4.1.46-rt52
Date: Mon, 11 Dec 2017 13:04:58 -0600
Message-ID: <7b0d39d5-91ab-c8f0-bfec-7e26e71395bd@mvista.com>
References: <20171129231317.GB1361@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Julia Cartwright <julia@ni.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, Alex Shi <alex.shi@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171129231317.GB1361@jcartwri.amer.corp.natinst.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 11/29/2017 05:13 PM, Julia Cartwright wrote:
> Hello RT Folks!
>
> I'm pleased to announce the 4.1.46-rt52 stable release.
>
> You can get this release via the git tree at:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
>
>    branch: v4.1-rt
>    Head SHA1: 6e737a91c1ce923d4e10db831e14cfef9a2459cc
>
> Or to build 4.1.46-rt52 directly, the following patches should be applied:
>
>    http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.1.tar.xz
>
>    http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.1.46.xz
>
>    http://www.kernel.org/pub/linux/kernel/projects/rt/4.1/patch-4.1.46-rt52.patch.xz
>
>
> You can also build from 4.1.46-rt51 by applying the incremental patch:
>
>    http://www.kernel.org/pub/linux/kernel/projects/rt/4.1/incr/patch-4.1.46-rt51-rt52.patch.xz
>
> Enjoy!
>     Julia
>
> Changes from v4.1.46-rt51:
> ---
> Julia Cartwright (2):
>        workqueue: fixup rcu check for RT
>        Linux 4.1.46-rt52
>
> Sebastian Andrzej Siewior (2):
>        PM / CPU: replace raw_notifier with atomic_notifier (fixup)

This change breaks the compile of 4.1 on ARM (and other things using 
kernel/cpu_pm.c).

rcu_irq_enter_irqson() and friends doesn't exist in 4.1.  In fact,
rcu_irq_enter() doesn't even exist.

Sorry I didn't get to testing this earlier, I've been focused on other things.

-corey


>        kernel/hrtimer: migrate deferred timer on CPU down
>
> ---
>   kernel/cpu_pm.c       | 7 +++++++
>   kernel/time/hrtimer.c | 5 +++++
>   kernel/workqueue.c    | 2 +-
>   localversion-rt       | 2 +-
>   4 files changed, 14 insertions(+), 2 deletions(-)
> ---
> diff --git a/kernel/cpu_pm.c b/kernel/cpu_pm.c
> index 9da42f83ee03..d1d1c3961553 100644
> --- a/kernel/cpu_pm.c
> +++ b/kernel/cpu_pm.c
> @@ -28,8 +28,15 @@ static int cpu_pm_notify(enum cpu_pm_event event, int nr_to_call, int *nr_calls)
>   {
>   	int ret;
>   
> +	/*
> +	 * __atomic_notifier_call_chain has a RCU read critical section, which
> +	 * could be disfunctional in cpu idle. Copy RCU_NONIDLE code to let
> +	 * RCU know this.
> +	 */
> +	rcu_irq_enter_irqson();
>   	ret = __atomic_notifier_call_chain(&cpu_pm_notifier_chain, event, NULL,
>   		nr_to_call, nr_calls);
> +	rcu_irq_exit_irqson();
>   
>   	return notifier_to_errno(ret);
>   }
> diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> index 2c6be169bdc7..75c990b00525 100644
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -1951,6 +1951,11 @@ static void migrate_hrtimer_list(struct hrtimer_clock_base *old_base,
>   		/* Clear the migration state bit */
>   		timer->state &= ~HRTIMER_STATE_MIGRATE;
>   	}
> +#ifdef CONFIG_PREEMPT_RT_BASE
> +	list_splice_tail(&old_base->expired, &new_base->expired);
> +	if (!list_empty(&new_base->expired))
> +		raise_softirq_irqoff(HRTIMER_SOFTIRQ);
> +#endif
>   }
>   
>   static void migrate_hrtimers(int scpu)
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 6bdcab98501c..90e261c8811e 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -363,7 +363,7 @@ static void workqueue_sysfs_unregister(struct workqueue_struct *wq);
>   			   "RCU or wq->mutex should be held")
>   
>   #define assert_rcu_or_wq_mutex_or_pool_mutex(wq)			\
> -	rcu_lockdep_assert(rcu_read_lock_sched_held() ||		\
> +	rcu_lockdep_assert(rcu_read_lock_held() ||			\
>   			   lockdep_is_held(&wq->mutex) ||		\
>   			   lockdep_is_held(&wq_pool_mutex),		\
>   			   "sched RCU, wq->mutex or wq_pool_mutex should be held")
> diff --git a/localversion-rt b/localversion-rt
> index 75493460c41f..66a5ed8bf3d7 100644
> --- a/localversion-rt
> +++ b/localversion-rt
> @@ -1 +1 @@
> --rt51
> +-rt52
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
