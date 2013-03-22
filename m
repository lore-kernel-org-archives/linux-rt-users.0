From: Staffan Tjernstrom <stjernstrom@eagleseven.com>
Subject: RE: Beginner's questions on userspace latency
Date: Fri, 22 Mar 2013 15:06:04 -0500
Message-ID: <7A2FC0CD30EF4745AE15F485252D38AC303F921173@clark>
References: <514CB285.4050100@nittka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: Oliver Nittka <oly@nittka.com>, RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.eagleseven.com ([38.98.183.218]:32380 "EHLO
	mail.eagleseven.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422691Ab3CVULS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Mar 2013 16:11:18 -0400
In-Reply-To: <514CB285.4050100@nittka.com>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Have you turned off all CPU power saving / turbo mode settings in the BIOS/UEFI ? 

-----Original Message-----
From: linux-rt-users-owner@vger.kernel.org [mailto:linux-rt-users-owner@vger.kernel.org] On Behalf Of Oliver Nittka
Sent: Friday, March 22, 2013 2:36 PM
To: RT
Subject: Beginner's questions on userspace latency

Hello,

I need to get data from a data acquisition board into user space at least every 2 milliseconds.

My setup: There's a kernel module that gets measurement data from a data acquisition board via USB. We're talking about 6 channels @ 100kHz each, so 512 bytes every 500us. Kernel timing is fine, I checked this using
get_cycles() and computing the delta to the previous urb callback.

The kernel module puts the data into a ring buffer which the user space application accesses via mmap() (using remap_vmalloc_range()) which i suppose has better timing compared to copy_to_user()?

Now the user space application needs to be notified at least every 2 milliseconds (so it can evaluate the data and trigger an action in due time). Currently, I'm using an ioctl which calls wait_event_interruptible(), the module then wakes up the waitq in its urb_callback using wake_up_interruptible().

To minimize latency in user space, the application does the following right at the beginning of its main():

  mlockall(MCL_FUTURE);

  schparm.sched_priority = 99;
  sched_setscheduler(0, SCHED_FIFO, &schparm);

  CPU_SET(1, &cpuset);
  sched_setaffinity(0, sizeof(cpuset), &cpuset);

I'm using a vanilla kernel 2.6.33.9 with patch-2.6.33.9-rt31.

I've also tuned the scheduler using
echo 500000 > /proc/sys/kernel/sched_latency_ns echo 200000 > /proc/sys/kernel/sched_wakeup_granularity_ns
echo 100000 > /proc/sys/kernel/sched_min_granularity_ns

The timing is fine most of the time, but putting the system under heavy CPU and USB load leads to occasional glitches where the time between two ioctl calls can be as high as 50ms.

I'm an experienced developer on linux, but mostly on the application front. Writing the device driver was as close to the hardware as I ever got, yet ;-)

I read through the RT wiki, but I'm still unsure on how to proceed from here. Is there any way to determine what's causing the glitches?
Anything I could do to improve the realtime behavior of my application?

Thank you all very much in advance!

O. Nittka



--
To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
