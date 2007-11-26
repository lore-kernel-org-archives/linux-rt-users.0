From: John Sigler <linux.kernel@free.fr>
Subject: Priorities of IRQ handlers
Date: Mon, 26 Nov 2007 16:31:19 +0100
Message-ID: <474AE6C7.4090204@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp4-g19.free.fr ([212.27.42.30]:41564 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751505AbXKZPbV (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 26 Nov 2007 10:31:21 -0500
Received: from smtp4-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp4-g19.free.fr (Postfix) with ESMTP id 4E12B3EA0B2
	for <linux-rt-users@vger.kernel.org>; Mon, 26 Nov 2007 16:31:20 +0100 (CET)
Received: from [10.10.10.208] (ims92-1-88-163-235-69.fbx.proxad.net [88.163.235.69])
	by smtp4-g19.free.fr (Postfix) with ESMTP id 30DBD3EA105
	for <linux-rt-users@vger.kernel.org>; Mon, 26 Nov 2007 16:31:20 +0100 (CET)
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello everyone,

I'm running 2.6.22.1-rt9 on x86.

CONFIG_PREEMPT_RT=y
CONFIG_PREEMPT=y
CONFIG_PREEMPT_SOFTIRQS=y
CONFIG_PREEMPT_HARDIRQS=y
CONFIG_PREEMPT_BKL=y
# CONFIG_CLASSIC_RCU is not set
CONFIG_PREEMPT_RCU=y

I need to change the priorities of several soft and hard IRQ handlers.

Namely,

o reduce the prio of "softirq-timer" handler to 10

o reduce the prio of IRQ14 and IRQ15 handlers to 20
   (my flash drives do not support DMA BTW...)

o boost the prio of my I/O boards' IRQ handlers to 60
   (there can be 1 or 2 boards, the driver is a kernel module
    which is loaded after the system has booted.)

I've written a short program that calls
   sched_setscheduler(pid, SCHED_FIFO, &param);
with the appropriate pid, which I look up using ps -ef

I need to automate the process of tweaking priorities.

Can someone offer advice and / or pointers?

Regards.
