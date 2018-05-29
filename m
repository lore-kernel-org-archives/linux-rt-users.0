Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from Galois.linutronix.de ([146.0.238.70]:43323 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935486AbeE2Qv0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 29 May 2018 12:51:26 -0400
Date: Tue, 29 May 2018 18:51:21 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: uio drivers with IRQF_NO_THREAD on preempt-rt kernel
Message-ID: <20180529165121.3huwcrxaxzaqvr2f@linutronix.de>
References: <f6171f5e-1faf-1bec-4fa8-c6bb6cc7d0ac@ma-fu.de>
 <20180509175638.GE963@jcartwri.amer.corp.natinst.com>
 <20180515140216.2k6465u5k5xvp5v6@linutronix.de>
 <bcca25da-6b7d-bfd5-d95e-77acd798f118@ma-fu.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bcca25da-6b7d-bfd5-d95e-77acd798f118@ma-fu.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Matthias Fuchs <mfuchs@ma-fu.de>
Cc: Julia Cartwright <julia@ni.com>, linux-rt-users@vger.kernel.org

On 2018-05-28 22:26:55 [+0200], Matthias Fuchs wrote:
> Hi,
> 
> I updated my modified uio.c code using simple wake queues. See below.
> Blocking read on the uio device is fine. But select() with timeout
> behaves a little strange. I am still digging to find out what happens,
> but it seems that even I should never run into a timeout in my test application,
> the event_count of two consecutive select()/read() pairs is not advanced by one.
> 
> So is my implementation correct? Does using the normal waitqueue in this
> manner satisfy uio_poll(). So in my case irq_flags has IRQF_NO_THREAD always set. This means 
> idev->wait never gets a wake_up_interruptible().
>
> diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
> index bcc1fc0..779dcaf 100644
> --- a/drivers/uio/uio.c
> +++ b/drivers/uio/uio.c
> @@ -25,6 +25,7 @@
>  #include <linux/kobject.h>
>  #include <linux/cdev.h>
>  #include <linux/uio_driver.h>
> +#include <linux/swait.h>
>  
>  #define UIO_MAX_DEVICES		(1U << MINORBITS)
>  
> @@ -394,8 +395,12 @@ void uio_event_notify(struct uio_info *info)
>  	struct uio_device *idev = info->uio_dev;
>  
>  	atomic_inc(&idev->event);
> -	wake_up_interruptible(&idev->wait);
> -	kill_fasync(&idev->async_queue, SIGIO, POLL_IN);
> +	if (idev->info->irq_flags & IRQF_NO_THREAD) {
> +		swake_up_locked(&idev->swait);

you want swake_up().

> +	} else {
> +		wake_up_interruptible(&idev->wait);
> +		kill_fasync(&idev->async_queue, SIGIO, POLL_IN);

also you need do this if you have someone is in poll(). You could the
upper part in the primary handler this in the threaded handler.

> +	}
>  }
>  EXPORT_SYMBOL_GPL(uio_event_notify);
>  
> @@ -508,6 +513,7 @@ static ssize_t uio_read(struct file *filep, char __user *buf,
>  	struct uio_listener *listener = filep->private_data;
>  	struct uio_device *idev = listener->dev;
>  	DECLARE_WAITQUEUE(wait, current);
> +	DECLARE_SWAITQUEUE(swait);
>  	ssize_t retval;
>  	s32 event_count;
>  
> @@ -520,11 +526,10 @@ static ssize_t uio_read(struct file *filep, char __user *buf,
>  	add_wait_queue(&idev->wait, &wait);
>  
>  	do {
> -		set_current_state(TASK_INTERRUPTIBLE);
> +		prepare_to_swait(&idev->swait, &swait, TASK_INTERRUPTIBLE);
>  
>  		event_count = atomic_read(&idev->event);
>  		if (event_count != listener->event_count) {
> -			__set_current_state(TASK_RUNNING);
>  			if (copy_to_user(buf, &event_count, count))
>  				retval = -EFAULT;
>  			else {
> @@ -546,7 +551,7 @@ static ssize_t uio_read(struct file *filep, char __user *buf,
>  		schedule();
>  	} while (1);
>  
> -	__set_current_state(TASK_RUNNING);
> +	finish_swait(&idev->swait, &swait);
>  	remove_wait_queue(&idev->wait, &wait);

and ->wait isn't used in ->read() anymore, right? Just in ->poll(). If
so it could go.

>  	return retval;
> @@ -814,6 +819,7 @@ int __uio_register_device(struct module *owner,
>  	idev->owner = owner;
>  	idev->info = info;
>  	init_waitqueue_head(&idev->wait);
> +	init_swait_queue_head(&idev->swait);
>  	atomic_set(&idev->event, 0);
>  
>  	ret = uio_get_minor(idev);
> 
> 
> Cheers,
> Matthias

Sebastian
