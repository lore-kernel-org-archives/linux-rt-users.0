From: Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [PATCH RT]  rt,ipc,sem: fix -rt livelock
Date: Wed, 11 Sep 2013 16:03:00 +0200
Message-ID: <52307814.4020104@colorfullife.com>
References: <20130819213324.405942342@goodmis.org> <1377842245.5422.7.camel@marge.simpson.net> <1377873580.5422.25.camel@marge.simpson.net> <1377926850.6234.22.camel@marge.simpson.net> <1378451338.5434.91.camel@marge.simpson.net> <1378794614.6046.37.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Mike Galbraith <bitbucket@online.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bk0-f44.google.com ([209.85.214.44]:64484 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686Ab3IKODF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 11 Sep 2013 10:03:05 -0400
Received: by mail-bk0-f44.google.com with SMTP id mz10so3577831bkb.17
        for <linux-rt-users@vger.kernel.org>; Wed, 11 Sep 2013 07:03:03 -0700 (PDT)
In-Reply-To: <1378794614.6046.37.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Mike,

On 09/10/2013 08:30 AM, Mike Galbraith wrote:
>
> You can kill this particular (osim induced) livelock by using Manfred's
> completion wakeup scheme.  It may not make it all better, but it does
> eliminate this trigger, despite that not being what the patch is about.

[snip]

> +#elif defined(SYSVSEM_CUSTOM)
> +	struct queue_done {
> +		atomic_t done;
> +	};
> +
> +	static void queuewakeup_prepare(void)
> +	{
> +		preempt_disable();
> +	}
> +
> +	static void queuewakeup_completed(void)
> +	{
> +		preempt_enable();
> +	}
> +
> +	static void queuewakeup_handsoff(struct queue_done *qd)
> +	{
> +		BUG_ON(atomic_read(&qd->done) != 2);
> +		smp_mb();
> +		atomic_set(&qd->done, 1);
> +	}
> +
> +	static void queuewakeup_init(struct queue_done *qd)
> +	{
> +		atomic_set(&qd->done, 2);
> +	}
> +
> +	static void queuewakeup_wait(struct queue_done *qd)
> +	{
> +		while (atomic_read(&qd->done) != 1)
> +			cpu_relax();
> +
> +		smp_mb();
> +	}
Two remarks:
- The reason why a standard waitqueue is not used should be mentioned in 
the commit comment:

A standard wait queue that waits with a timeout (or with 
TASK_INTERRUPTIBLE) doesn't allow the caller of add_wait_queue to figure 
out if the thread was woken up to due expiry of the timer or due to an 
explicit wake_up() call.
a) The ipc code must know that in order to decide if the task must 
return with -EAGAIN/-EINTR or with 0. Therefore ipc/sem.c, ipc/msg.c and 
ipc/mqueue.c use custom queues.
b) These custom queues have a lockless fast-path for a successful 
operation - and this fast path must handle the various races that may 
happen the timer expires in parallel with a wake_up() call.

- the ipc/msg.c and ipc/mqueue.c should be converted as well (just 
search for cpu_relax()).

--
     Manfred

