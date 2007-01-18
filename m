From: Guennadi Liakhovetski <gl@dsa-ac.de>
Subject: Re: changes to task_blocks_on_rt_mutex between 18-rt6 and 20-rc5-rt3
Date: Thu, 18 Jan 2007 13:22:36 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701181312340.16286@pcgl.dsa-ac.de>
References: <Pine.LNX.4.63.0701161642470.16286@pcgl.dsa-ac.de>
 <1169025704.2941.215.camel@localhost.localdomain>
 <Pine.LNX.4.63.0701171127030.16286@pcgl.dsa-ac.de>
 <1169031749.2941.220.camel@localhost.localdomain>
 <Pine.LNX.4.63.0701171214520.16286@pcgl.dsa-ac.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.dsa-ac.de ([62.112.80.99]:59093 "EHLO mail.dsa-ac.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932231AbXARMWm (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 18 Jan 2007 07:22:42 -0500
To: Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <Pine.LNX.4.63.0701171214520.16286@pcgl.dsa-ac.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 17 Jan 2007, Guennadi Liakhovetski wrote:

> ...as you saw it's with 2.6.18-rc6. Trying to upgrade to 20-rc5-rt3 ATM.

Same problem with 2.6.20-rc5-rt3. Below are relevant code fragments:

The sleeper sleeps on a wait queue::

#define __hrt_wait_event_timeout(wq, condition, ret)			\
do {									\
 	DEFINE_WAIT(__wait);						\
 									\
 	for (;;) {							\
 		prepare_to_wait(&wq, &__wait, TASK_UNINTERRUPTIBLE);	\
 		if (condition)						\
 			break;						\
 		ret = hrt_schedule_timeout_ns(ret);			\
 		if (!ret)						\
 			break;						\
 	}								\
 	finish_wait(&wq, &__wait);					\
} while (0)

s64 hrt_schedule_timeout_ns(s64 timeout) // max. 9223372035 seconds (292 years)
{
 	vdm_hashtable_el_t *he = vdm_hashtable_find(&thread_hash, (__u32)current);
 	os_thread_t *thread;
 	struct hrtimer_sleeper t;
 	struct timespec now, end;
 	s64 elapsed;
 	unsigned long flags;

 	might_sleep();

 	if (unlikely(!he)) {
 		printk(KERN_ERR "%s called from a non-hashed thread!\n",
 		       __FUNCTION__);
 		WARN_ON(1);
 		/* Avoid endless loop in hrt_wait_event_timeout() */
 		return 0;
 	}
 	if (unlikely(timeout <= 0))	/* do not wait for moments in the past */
 		return 0;

 	thread = he->private;

 	ktime_get_ts(&now);

 	spin_lock_irqsave(&thread->lock, flags);

 	hrtimer_init(&t.timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
 	t.timer.expires = ktime_add_ns(timespec_to_ktime(now), timeout);
 	hrtimer_init_sleeper(&t, current);
 	thread->sleeper = &t;
 	hrtimer_start(&t.timer, t.timer.expires, HRTIMER_MODE_ABS);

 	spin_unlock_irqrestore(&thread->lock, flags);

 	schedule();

 	spin_lock_irqsave(&thread->lock, flags);

 	hrtimer_cancel(&t.timer);
 	thread->sleeper = NULL;

 	spin_unlock_irqrestore(&thread->lock, flags);

 	ktime_get_ts(&end);

 	elapsed = NSEC_PER_SEC * (s64)(end.tv_sec - now.tv_sec) + (s64)end.tv_nsec - (s64)now.tv_nsec;

 	rtpreempt_check_abort();

 	return elapsed >= timeout ? 0 : timeout - elapsed;
}

And the waker just calls wake_up() on the queue while holding the lock:

 	spin_lock_irqsave(&sem->lock, flags);
 	sem->signal++;
 	wake_up(&sem->wq);
 	spin_unlock_irqrestore(&sem->lock, flags);

Am I doing anything wrong?

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany
