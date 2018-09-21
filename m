Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35525 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388909AbeIUTXU (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 Sep 2018 15:23:20 -0400
Subject: Re: [BUG] dw_wdt watchdog on linux-rt 4.18.5-rt4 not triggering
References: <73d0tbdjqz.fsf@pengutronix.de>
 <714e73d5-f7ce-bdcf-b7fd-fc9f02b12693@roeck-us.net>
 <20180919064619.soi27bbq3xtatpxp@pengutronix.de>
 <20180919194303.GA5033@roeck-us.net>
 <20180920204843.GY23084@jcartwri.amer.corp.natinst.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <88588d0f-6673-cb45-85e1-537f69135c86@roeck-us.net>
Date: Fri, 21 Sep 2018 06:34:24 -0700
MIME-Version: 1.0
In-Reply-To: <20180920204843.GY23084@jcartwri.amer.corp.natinst.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Julia Cartwright <julia@ni.com>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>, Christophe Leroy <christophe.leroy@c-s.fr>, "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>


On 09/20/2018 01:48 PM, Julia Cartwright wrote:
> Hello all-
> 
> On Wed, Sep 19, 2018 at 12:43:03PM -0700, Guenter Roeck wrote:
>> On Wed, Sep 19, 2018 at 08:46:19AM +0200, Steffen Trumtrar wrote:
>>> On Tue, Sep 18, 2018 at 06:46:15AM -0700, Guenter Roeck wrote:
> [..]
>>> The problem I observe, is that the watchdog is trigged, because it doesn't get pinged.
>>> The ksoftirqd seems to be blocked although it runs at a much higher priority than the
>>> blocking userspace task.
>>>
>> Are you sure about that ? The other email seemed to suggest that the userspace
>> task is running at higher priority.
> 
> Also: ksoftirqd is irrelevant on RT for the kernel watchdog thread.  The
> relevant thread is ktimersoftd, which is the thread responsible for
> invoking hrtimer expiry functions, like what's being used for watchdogd.
> 
> [..]
>> Overall, we have a number possibilities to consider:
>>
>> - The kernel watchdog timer thread is not triggered at all under some
>>    circumstances, meaning it is not set properly. So far we have no real
>>    indication that this is the case (since the code works fine unless some
>>    userspace task takes all available CPU time).
> 
> What do you mean by "not triggered".  Do you mean woken-up/activated
> from a scheduling perspective?  In the case I identified in my other
> email, the watchdogd thread wakeup doesn't even occur, even when the
> periodic ping timer expires, because ktimersoftd has been starved.
> 

Sorry for not using the correct term. Sometimes I am a bit sloppy.
Yes, I meant "woken-up/activated from a scheduling perspective".

> I suspect that's what's going on for Steffen, but am not yet sure.
> 
>> - The watchdog device is closed. The kernel watchdog timer thread is
>>    starved and does not get to run. The question is what to do in this
>>    situation. In a real time system, this is almost always a fatal
>>    condition. Should the system really be kept alive in this situation ?
> 
> Sometimes its the right decision, sometimes its not.  The only sensible
> thing to do is to allow the user make the decision that's right for
> their application needs by allowing the relative prioritization of
> watchdogd and their application threads.
> 
Agreed, but that doesn't help if the watchdog daemon is not open or if the
hardware watchdog interval is too small and the kernel mechanism is needed
to ping the watchdog.

> ...which they can do now, but it's not effective on RT because of the
> timer deferral through ktimersoftd.
> 
> The solution, in my mind, and like I mentioned in my other email, is to
> opt-out of the ktimersoftd-deferral mechanism.  This requires some
> tweaking with the kthread_worker bits to ensure safety in hardirq
> context, but that seems straightforward.  See the below.
> 
Makes sense to me, though I have no idea what it would take to push
the necessary changes into the core kernel.

However, I must be missing something: Looking into the kernel code,
it seems to me that the spin_lock functions call the respective raw_
spinlock functions right away. With that in mind, why would the kernel
code change be necessary ? Also, I don't see HRTIMER_MODE_REL_HARD
defined anywhere. Is this RT specific ?

Thanks,
Guenter

>     Julia
> 
> -- 8< --
> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
> index ffbdc4642ea5..9c2b3e5cebdc 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -945,7 +945,7 @@ static int watchdog_cdev_register(struct watchdog_device *wdd, dev_t devno)
>   		return -ENODEV;
>   
>   	kthread_init_work(&wd_data->work, watchdog_ping_work);
> -	hrtimer_init(&wd_data->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +	hrtimer_init(&wd_data->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
>   	wd_data->timer.function = watchdog_timer_expired;
>   
>   	if (wdd->id == 0) {
> diff --git a/include/linux/kthread.h b/include/linux/kthread.h
> index c1961761311d..ad292898f7f2 100644
> --- a/include/linux/kthread.h
> +++ b/include/linux/kthread.h
> @@ -85,7 +85,7 @@ enum {
>   
>   struct kthread_worker {
>   	unsigned int		flags;
> -	spinlock_t		lock;
> +	raw_spinlock_t		lock;
>   	struct list_head	work_list;
>   	struct list_head	delayed_work_list;
>   	struct task_struct	*task;
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index 486dedbd9af5..c1d9ee6671c6 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -597,7 +597,7 @@ void __kthread_init_worker(struct kthread_worker *worker,
>   				struct lock_class_key *key)
>   {
>   	memset(worker, 0, sizeof(struct kthread_worker));
> -	spin_lock_init(&worker->lock);
> +	raw_spin_lock_init(&worker->lock);
>   	lockdep_set_class_and_name(&worker->lock, key, name);
>   	INIT_LIST_HEAD(&worker->work_list);
>   	INIT_LIST_HEAD(&worker->delayed_work_list);
> @@ -639,21 +639,21 @@ int kthread_worker_fn(void *worker_ptr)
>   
>   	if (kthread_should_stop()) {
>   		__set_current_state(TASK_RUNNING);
> -		spin_lock_irq(&worker->lock);
> +		raw_spin_lock_irq(&worker->lock);
>   		worker->task = NULL;
> -		spin_unlock_irq(&worker->lock);
> +		raw_spin_unlock_irq(&worker->lock);
>   		return 0;
>   	}
>   
>   	work = NULL;
> -	spin_lock_irq(&worker->lock);
> +	raw_spin_lock_irq(&worker->lock);
>   	if (!list_empty(&worker->work_list)) {
>   		work = list_first_entry(&worker->work_list,
>   					struct kthread_work, node);
>   		list_del_init(&work->node);
>   	}
>   	worker->current_work = work;
> -	spin_unlock_irq(&worker->lock);
> +	raw_spin_unlock_irq(&worker->lock);
>   
>   	if (work) {
>   		__set_current_state(TASK_RUNNING);
> @@ -810,12 +810,12 @@ bool kthread_queue_work(struct kthread_worker *worker,
>   	bool ret = false;
>   	unsigned long flags;
>   
> -	spin_lock_irqsave(&worker->lock, flags);
> +	raw_spin_lock_irqsave(&worker->lock, flags);
>   	if (!queuing_blocked(worker, work)) {
>   		kthread_insert_work(worker, work, &worker->work_list);
>   		ret = true;
>   	}
> -	spin_unlock_irqrestore(&worker->lock, flags);
> +	raw_spin_unlock_irqrestore(&worker->lock, flags);
>   	return ret;
>   }
>   EXPORT_SYMBOL_GPL(kthread_queue_work);
> @@ -841,7 +841,7 @@ void kthread_delayed_work_timer_fn(struct timer_list *t)
>   	if (WARN_ON_ONCE(!worker))
>   		return;
>   
> -	spin_lock(&worker->lock);
> +	raw_spin_lock(&worker->lock);
>   	/* Work must not be used with >1 worker, see kthread_queue_work(). */
>   	WARN_ON_ONCE(work->worker != worker);
>   
> @@ -850,7 +850,7 @@ void kthread_delayed_work_timer_fn(struct timer_list *t)
>   	list_del_init(&work->node);
>   	kthread_insert_work(worker, work, &worker->work_list);
>   
> -	spin_unlock(&worker->lock);
> +	raw_spin_unlock(&worker->lock);
>   }
>   EXPORT_SYMBOL(kthread_delayed_work_timer_fn);
>   
> @@ -906,14 +906,14 @@ bool kthread_queue_delayed_work(struct kthread_worker *worker,
>   	unsigned long flags;
>   	bool ret = false;
>   
> -	spin_lock_irqsave(&worker->lock, flags);
> +	raw_spin_lock_irqsave(&worker->lock, flags);
>   
>   	if (!queuing_blocked(worker, work)) {
>   		__kthread_queue_delayed_work(worker, dwork, delay);
>   		ret = true;
>   	}
>   
> -	spin_unlock_irqrestore(&worker->lock, flags);
> +	raw_spin_unlock_irqrestore(&worker->lock, flags);
>   	return ret;
>   }
>   EXPORT_SYMBOL_GPL(kthread_queue_delayed_work);
> @@ -949,7 +949,7 @@ void kthread_flush_work(struct kthread_work *work)
>   	if (!worker)
>   		return;
>   
> -	spin_lock_irq(&worker->lock);
> +	raw_spin_lock_irq(&worker->lock);
>   	/* Work must not be used with >1 worker, see kthread_queue_work(). */
>   	WARN_ON_ONCE(work->worker != worker);
>   
> @@ -961,7 +961,7 @@ void kthread_flush_work(struct kthread_work *work)
>   	else
>   		noop = true;
>   
> -	spin_unlock_irq(&worker->lock);
> +	raw_spin_unlock_irq(&worker->lock);
>   
>   	if (!noop)
>   		wait_for_completion(&fwork.done);
> @@ -994,9 +994,9 @@ static bool __kthread_cancel_work(struct kthread_work *work, bool is_dwork,
>   		 * any queuing is blocked by setting the canceling counter.
>   		 */
>   		work->canceling++;
> -		spin_unlock_irqrestore(&worker->lock, *flags);
> +		raw_spin_unlock_irqrestore(&worker->lock, *flags);
>   		del_timer_sync(&dwork->timer);
> -		spin_lock_irqsave(&worker->lock, *flags);
> +		raw_spin_lock_irqsave(&worker->lock, *flags);
>   		work->canceling--;
>   	}
>   
> @@ -1043,7 +1043,7 @@ bool kthread_mod_delayed_work(struct kthread_worker *worker,
>   	unsigned long flags;
>   	int ret = false;
>   
> -	spin_lock_irqsave(&worker->lock, flags);
> +	raw_spin_lock_irqsave(&worker->lock, flags);
>   
>   	/* Do not bother with canceling when never queued. */
>   	if (!work->worker)
> @@ -1060,7 +1060,7 @@ bool kthread_mod_delayed_work(struct kthread_worker *worker,
>   fast_queue:
>   	__kthread_queue_delayed_work(worker, dwork, delay);
>   out:
> -	spin_unlock_irqrestore(&worker->lock, flags);
> +	raw_spin_unlock_irqrestore(&worker->lock, flags);
>   	return ret;
>   }
>   EXPORT_SYMBOL_GPL(kthread_mod_delayed_work);
> @@ -1074,7 +1074,7 @@ static bool __kthread_cancel_work_sync(struct kthread_work *work, bool is_dwork)
>   	if (!worker)
>   		goto out;
>   
> -	spin_lock_irqsave(&worker->lock, flags);
> +	raw_spin_lock_irqsave(&worker->lock, flags);
>   	/* Work must not be used with >1 worker, see kthread_queue_work(). */
>   	WARN_ON_ONCE(work->worker != worker);
>   
> @@ -1088,13 +1088,13 @@ static bool __kthread_cancel_work_sync(struct kthread_work *work, bool is_dwork)
>   	 * In the meantime, block any queuing by setting the canceling counter.
>   	 */
>   	work->canceling++;
> -	spin_unlock_irqrestore(&worker->lock, flags);
> +	raw_spin_unlock_irqrestore(&worker->lock, flags);
>   	kthread_flush_work(work);
> -	spin_lock_irqsave(&worker->lock, flags);
> +	raw_spin_lock_irqsave(&worker->lock, flags);
>   	work->canceling--;
>   
>   out_fast:
> -	spin_unlock_irqrestore(&worker->lock, flags);
> +	raw_spin_unlock_irqrestore(&worker->lock, flags);
>   out:
>   	return ret;
>   }
> 
