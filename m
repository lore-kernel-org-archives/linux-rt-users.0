Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.22]:14752 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755059AbeEHQFu (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 8 May 2018 12:05:50 -0400
Received: from oskar
        by smtp.strato.de (RZmta 43.8 DYNA|AUTH)
        with ESMTPSA id Y060cbu48FxVwoh
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate)
        for <linux-rt-users@vger.kernel.org>;
        Tue, 8 May 2018 17:59:31 +0200 (CEST)
Received: from [192.168.2.15] (hp250g6.home [192.168.2.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by oskar (Postfix) with ESMTPSA id E4361180258
        for <linux-rt-users@vger.kernel.org>; Tue,  8 May 2018 17:59:30 +0200 (CEST)
From: Matthias Fuchs <mfuchs@ma-fu.de>
Subject: uio drivers with IRQF_NO_THREAD on preempt-rt kernel
Message-ID: <f6171f5e-1faf-1bec-4fa8-c6bb6cc7d0ac@ma-fu.de>
Date: Tue, 8 May 2018 17:59:27 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: linux-rt-users@vger.kernel.org

Hi folks,

I am running stable kernel v4.4.110 with preempt-rt patch rt125 on a AM335x non-SMP system.
There is one thread with hard realtime requirements running on this system. This thread is scheduled
by a hardware interrupt (either AM335x PRUSS or external FPGA).

Latencies from interrupt into process are as expected. Interrupt thread prio has been
bumped to 90. But I want/need even shorter latencies.

So I tried to use IRQF_NO_THREAD in my uio driver to get rid of the scheduling detour through over the interrupt thread. The interrupt handling should be quiet fast - most handling is done in userspace.

Here comes the problem. The uio framework uses wake_up_interruptible() in the isr which does
not work from hard interrupt handlers. I tried to modify uio.c to use wake_up_process() with a limitation
to support a single process having opened the device.

This works fine in most cases :-( Userspace uses select() on the device with timeouts. Sometimes my process is woken
by interrupt event and sometimes by timeout - fine. But it looks like I am missing some interrupts.
I expect some issue with uio poll/waitqueue handling. 

Any idea how to fix this? It would be fine to stay with poll in the uio drivers. I already thought about a special hrtimer handling in my situation. But I hope about something more pretty.

BTW, latencies are shorter with this approach!

Matthias


diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index bcc1fc0..7eb8257 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -394,8 +394,12 @@ void uio_event_notify(struct uio_info *info)
 	struct uio_device *idev = info->uio_dev;
 
 	atomic_inc(&idev->event);
-	wake_up_interruptible(&idev->wait);
-	kill_fasync(&idev->async_queue, SIGIO, POLL_IN);
+	if (idev->rt_consumer) {
+		wake_up_process(idev->rt_consumer);
+	} else {
+		wake_up_interruptible(&idev->wait);
+		kill_fasync(&idev->async_queue, SIGIO, POLL_IN);
+	}
 }
 EXPORT_SYMBOL_GPL(uio_event_notify);
 
@@ -439,6 +443,17 @@ static int uio_open(struct inode *inode, struct file *filep)
 		goto out;
 	}
 
+	if (idev->rt_consumer) {
+		ret = -EBUSY;
+		goto err_alloc_listener;
+	}
+
+#ifdef CONFIG_PREEMPT_RT_FULL
+	if (idev->info->irq_flags & IRQF_NO_THREAD) {
+	  idev->rt_consumer = current;
+	}
+#endif
+
 	listener = kmalloc(sizeof(*listener), GFP_KERNEL);
 	if (!listener) {
 		ret = -ENOMEM;
@@ -480,6 +495,7 @@ static int uio_release(struct inode *inode, struct file *filep)
 	struct uio_listener *listener = filep->private_data;
 	struct uio_device *idev = listener->dev;
 
+	idev->rt_consumer = NULL;
 	if (idev->info->release)
 		ret = idev->info->release(idev->info, inode);
 
diff --git a/include/linux/uio_driver.h b/include/linux/uio_driver.h
index 32c0e83..cf314da 100644
--- a/include/linux/uio_driver.h
+++ b/include/linux/uio_driver.h
@@ -73,6 +73,7 @@ struct uio_device {
         struct uio_info         *info;
         struct kobject          *map_dir;
         struct kobject          *portio_dir;
+        struct task_struct      *rt_consumer;
 };
 

