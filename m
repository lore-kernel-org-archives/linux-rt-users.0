Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:32408 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932451AbeE1U1A (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 28 May 2018 16:27:00 -0400
Subject: Re: uio drivers with IRQF_NO_THREAD on preempt-rt kernel
References: <f6171f5e-1faf-1bec-4fa8-c6bb6cc7d0ac@ma-fu.de>
 <20180509175638.GE963@jcartwri.amer.corp.natinst.com>
 <20180515140216.2k6465u5k5xvp5v6@linutronix.de>
From: Matthias Fuchs <mfuchs@ma-fu.de>
Message-ID: <bcca25da-6b7d-bfd5-d95e-77acd798f118@ma-fu.de>
Date: Mon, 28 May 2018 22:26:55 +0200
MIME-Version: 1.0
In-Reply-To: <20180515140216.2k6465u5k5xvp5v6@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Julia Cartwright <julia@ni.com>
Cc: linux-rt-users@vger.kernel.org

Hi,

I updated my modified uio.c code using simple wake queues. See below.
Blocking read on the uio device is fine. But select() with timeout
behaves a little strange. I am still digging to find out what happens,
but it seems that even I should never run into a timeout in my test application,
the event_count of two consecutive select()/read() pairs is not advanced by one.

So is my implementation correct? Does using the normal waitqueue in this
manner satisfy uio_poll(). So in my case irq_flags has IRQF_NO_THREAD always set. This means 
idev->wait never gets a wake_up_interruptible().

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index bcc1fc0..779dcaf 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -25,6 +25,7 @@
 #include <linux/kobject.h>
 #include <linux/cdev.h>
 #include <linux/uio_driver.h>
+#include <linux/swait.h>
 
 #define UIO_MAX_DEVICES		(1U << MINORBITS)
 
@@ -394,8 +395,12 @@ void uio_event_notify(struct uio_info *info)
 	struct uio_device *idev = info->uio_dev;
 
 	atomic_inc(&idev->event);
-	wake_up_interruptible(&idev->wait);
-	kill_fasync(&idev->async_queue, SIGIO, POLL_IN);
+	if (idev->info->irq_flags & IRQF_NO_THREAD) {
+		swake_up_locked(&idev->swait);
+	} else {
+		wake_up_interruptible(&idev->wait);
+		kill_fasync(&idev->async_queue, SIGIO, POLL_IN);
+	}
 }
 EXPORT_SYMBOL_GPL(uio_event_notify);
 
@@ -508,6 +513,7 @@ static ssize_t uio_read(struct file *filep, char __user *buf,
 	struct uio_listener *listener = filep->private_data;
 	struct uio_device *idev = listener->dev;
 	DECLARE_WAITQUEUE(wait, current);
+	DECLARE_SWAITQUEUE(swait);
 	ssize_t retval;
 	s32 event_count;
 
@@ -520,11 +526,10 @@ static ssize_t uio_read(struct file *filep, char __user *buf,
 	add_wait_queue(&idev->wait, &wait);
 
 	do {
-		set_current_state(TASK_INTERRUPTIBLE);
+		prepare_to_swait(&idev->swait, &swait, TASK_INTERRUPTIBLE);
 
 		event_count = atomic_read(&idev->event);
 		if (event_count != listener->event_count) {
-			__set_current_state(TASK_RUNNING);
 			if (copy_to_user(buf, &event_count, count))
 				retval = -EFAULT;
 			else {
@@ -546,7 +551,7 @@ static ssize_t uio_read(struct file *filep, char __user *buf,
 		schedule();
 	} while (1);
 
-	__set_current_state(TASK_RUNNING);
+	finish_swait(&idev->swait, &swait);
 	remove_wait_queue(&idev->wait, &wait);
 
 	return retval;
@@ -814,6 +819,7 @@ int __uio_register_device(struct module *owner,
 	idev->owner = owner;
 	idev->info = info;
 	init_waitqueue_head(&idev->wait);
+	init_swait_queue_head(&idev->swait);
 	atomic_set(&idev->event, 0);
 
 	ret = uio_get_minor(idev);


Cheers,
Matthias


On 15.05.2018 16:02, Sebastian Andrzej Siewior wrote:
> On 2018-05-09 12:56:38 [-0500], Julia Cartwright wrote:
>> On Tue, May 08, 2018 at 05:59:27PM +0200, Matthias Fuchs wrote:
>>> Hi folks,
>>
>> Hello Matthias-
>>
>>> I am running stable kernel v4.4.110 with preempt-rt patch rt125 on a AM335x non-SMP system.
>>> There is one thread with hard realtime requirements running on this system. This thread is scheduled
>>> by a hardware interrupt (either AM335x PRUSS or external FPGA).
>>>
>>> Latencies from interrupt into process are as expected. Interrupt thread prio has been
>>> bumped to 90. But I want/need even shorter latencies.
>>>
>>> So I tried to use IRQF_NO_THREAD in my uio driver to get rid of the scheduling detour through over the interrupt thread. The interrupt handling should be quiet fast - most handling is done in userspace.
>>>
>>> Here comes the problem. The uio framework uses wake_up_interruptible() in the isr which does
>>> not work from hard interrupt handlers. I tried to modify uio.c to use wake_up_process() with a limitation
>>> to support a single process having opened the device.
>>
>> I didn't look at your code in detail, but you might consider looking at
>> the simple waitqueue implementation.  See include/linux/swait.h in the
>> kernel tree.  In -rt, completions have been reworked to use them, if you
>> want to look at an example.  swake_up_*() can be used in hardirq context.
> 
> This can be done but the "normal" waitqueue has to remain. If a process
> blocks on read() then you can wake it up via swait() from hardirq
> context. You need to keep the waitqueue for a possible poll() user.
> 
>> Good luck,
>>
>>    Julia
> 
> Sebastian
> 

