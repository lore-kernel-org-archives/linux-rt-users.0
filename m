From: "John Kacur" <jkacur@gmail.com>
Subject: Re: [PATCH 2/2] [RT] hrtimer __run_hrtimer code cleanup
Date: Wed, 20 Aug 2008 23:48:26 +0200
Message-ID: <520f0cf10808201448g2d0906c8g2ab18a8547fe285a@mail.gmail.com>
References: <1219070552-30783-1-git-send-email-gilles.carry@bull.net>
	 <1219070552-30783-3-git-send-email-gilles.carry@bull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu,
	tinytim@us.ibm.com, jean-pierre.dion@bull.net,
	sebastien.dugue@bull.net
To: "Gilles Carry" <gilles.carry@bull.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:14464 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752791AbYHTVs3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 20 Aug 2008 17:48:29 -0400
Received: by ey-out-2122.google.com with SMTP id 6so4984eyi.37
        for <linux-rt-users@vger.kernel.org>; Wed, 20 Aug 2008 14:48:26 -0700 (PDT)
In-Reply-To: <1219070552-30783-3-git-send-email-gilles.carry@bull.net>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Aug 18, 2008 at 4:42 PM, Gilles Carry <gilles.carry@bull.net> wrote:
> This is a code cleanup that makes the code more readable.
> Some HRTIMER_CB_SOFTIRQ processing have been moved to __run_hrtimer.
>
> Signed-off-by: Gilles Carry <gilles.carry@bull.net>
>
> ---
>  kernel/hrtimer.c |   32 +++++++++++---------------------
>  1 files changed, 11 insertions(+), 21 deletions(-)
>
> diff --git a/kernel/hrtimer.c b/kernel/hrtimer.c
> index 778eb7e..26cfcdc 100644
> --- a/kernel/hrtimer.c
> +++ b/kernel/hrtimer.c
> @@ -1293,7 +1293,7 @@ static void run_hrtimer_pending(struct hrtimer_cpu_base *cpu_base)
>        wake_up_timer_waiters(cpu_base);
>  }
>
> -static void __run_hrtimer(struct hrtimer *timer)
> +static int __run_hrtimer(struct hrtimer *timer)
>  {
>        struct hrtimer_clock_base *base = timer->base;
>        struct hrtimer_cpu_base *cpu_base = base->cpu_base;
> @@ -1311,7 +1311,7 @@ static void __run_hrtimer(struct hrtimer *timer)
>                spin_unlock(&cpu_base->lock);
>                fn(timer);
>                spin_lock(&cpu_base->lock);
> -               return;
> +               return 0;
>        case HRTIMER_CB_IRQSAFE_NO_SOFTIRQ:
>                /*
>                 * Used for scheduler timers, avoid lock inversion with
> @@ -1326,6 +1326,12 @@ static void __run_hrtimer(struct hrtimer *timer)
>                restart = fn(timer);
>                spin_lock(&cpu_base->lock);
>                break;
> +       case HRTIMER_CB_SOFTIRQ:
> +               /* Move softirq callbacks to the pending list */
> +               __remove_hrtimer(timer, base, HRTIMER_STATE_PENDING, 0);
> +               timer_stats_account_hrtimer(timer);
> +               list_add_tail(&timer->cb_entry, &base->cpu_base->cb_pending);
> +               return 1; /* Raise soft irq */

I kind of find this confusing, because the return value is only useful
in one specific instance. In other cases, the return value is thrown
away. People who are not aware of the history of this code and examine
it later may ask why the return value is being ignored in some cases.

>        default:
>                __remove_hrtimer(timer, base, HRTIMER_STATE_CALLBACK, 0);
>                timer_stats_account_hrtimer(timer);
> @@ -1342,6 +1348,8 @@ static void __run_hrtimer(struct hrtimer *timer)
>                enqueue_hrtimer(timer, base, 0);
>        }
>        timer->state &= ~HRTIMER_STATE_CALLBACK;
> +
> +       return 0;
>  }
>
>  #ifdef CONFIG_HIGH_RES_TIMERS
> @@ -1394,17 +1402,7 @@ void hrtimer_interrupt(struct clock_event_device *dev)
>
>                        ftrace_event_timer_triggered(&timer->expires, timer);
>
> -                       /* Move softirq callbacks to the pending list */
> -                       if (timer->cb_mode == HRTIMER_CB_SOFTIRQ) {
> -                               __remove_hrtimer(timer, base,
> -                                                HRTIMER_STATE_PENDING, 0);
> -                               list_add_tail(&timer->cb_entry,
> -                                             &base->cpu_base->cb_pending);
> -                               raise = 1;
> -                               continue;
> -                       }
> -
> -                       __run_hrtimer(timer);
> +                       raise |= __run_hrtimer(timer);
>                }
>                spin_unlock(&cpu_base->lock);
>                base++;
> @@ -1497,14 +1495,6 @@ void hrtimer_run_queues(void)
>                        if (base->softirq_time.tv64 <= timer->expires.tv64)
>                                break;
>
> -                       if (timer->cb_mode == HRTIMER_CB_SOFTIRQ) {
> -                               __remove_hrtimer(timer, base,
> -                                       HRTIMER_STATE_PENDING, 0);
> -                               list_add_tail(&timer->cb_entry,
> -                                       &base->cpu_base->cb_pending);
> -                               continue;
> -                       }
> -
>                        __run_hrtimer(timer);
>                }
>                spin_unlock(&cpu_base->lock);
> --
> 1.5.2.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
