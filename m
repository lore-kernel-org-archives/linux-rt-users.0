From: louis@museresearch.com
Subject: Suspend: Mem leak and "sleeping function .. invalid context"
Date: Tue, 22 Jun 2010 13:11:24 -0700
Message-ID: <668e33c19aa7d25f3a95bc750068e2bb.squirrel@master.museresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from master.museresearch.com ([69.59.28.231]:41364 "EHLO
	master.museresearch.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751668Ab0FVUsT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 22 Jun 2010 16:48:19 -0400
Received: from localhost ([127.0.0.1] helo=master.museresearch.com)
	by master.museresearch.com with esmtpa (Exim 4.69)
	(envelope-from <louis@museresearch.com>)
	id 1OR9oa-0007yi-7D
	for linux-rt-users@vger.kernel.org; Tue, 22 Jun 2010 13:11:24 -0700
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi, I've come across a bug when using the RT patch in Fedora 8 (CCRMA
kernel derivative):  When I suspend, I get a "BUG: sleeping function
called from invalid context pm-suspend" message.  After resuming, I see a
memory leak that can rapidly eat memory just by doing this in BASH: 
"while /bin/true; do continue; done".  The system will slow and then
finally lock up with "free" reporting approx. 1 GB left (on a 2 GB
system).

This has been seen on both the Intel D510MO motherboard and the Intel
DQ35JOE board.  I have tried the CCRMA kernel
2.6.33.4-106.rt20.1.fc13.ccrma.i686.rtPAE  and a custom kernel based off
the 2.6.24.3-1 CCRMA kernel.  Versions of the kernel without the rt patch
do not fail (tried the stock FC8 kernel and stock FC11 kernel).

Here is a snippit of the backtrace I get:

kernel: BUG: sleeping function called from invalid context
pm-suspend(14941) at kernel/rtmutex.c:638
kernel: in_atomic():1 [00000001], irqs_disabled():1
kernel: Pid: 14941, comm: pm-suspend Not tainted
2.6.24.3-1.rec15.rt1.fc8rt #1
kernel:  [<c0699de1>] __rt_spin_lock+0x21/0x5e
kernel:  [<c04898ce>] kfree+0x29/0x88
kernel:  [<c0427be5>] rq_attach_root+0x5b/0xac
kernel:  [<c042a2df>] cpu_attach_domain+0x2af/0x2ef
kernel:  [<c0489929>] kfree+0x84/0x88
kernel:  [<c0489929>] kfree+0x84/0x88
kernel:  [<c042a33f>] detach_destroy_domains+0x20/0x33

The line number in question is:
        /* Temporary HACK! */
        if (!current->in_printk)
                might_sleep();    <--- line 638

I've found similar threads before, but did not see a resolution to this
problem on the x86 architecture (it looks like a similar problem might
have been solved on ARM..?).

Thanks for your help,
Louis


