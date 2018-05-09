Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:47260 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934331AbeEIR4y (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 May 2018 13:56:54 -0400
Date: Wed, 9 May 2018 12:56:38 -0500
From: Julia Cartwright <julia@ni.com>
Subject: Re: uio drivers with IRQF_NO_THREAD on preempt-rt kernel
Message-ID: <20180509175638.GE963@jcartwri.amer.corp.natinst.com>
References: <f6171f5e-1faf-1bec-4fa8-c6bb6cc7d0ac@ma-fu.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f6171f5e-1faf-1bec-4fa8-c6bb6cc7d0ac@ma-fu.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Matthias Fuchs <mfuchs@ma-fu.de>
Cc: linux-rt-users@vger.kernel.org

On Tue, May 08, 2018 at 05:59:27PM +0200, Matthias Fuchs wrote:
> Hi folks,

Hello Matthias-

> I am running stable kernel v4.4.110 with preempt-rt patch rt125 on a AM335x non-SMP system.
> There is one thread with hard realtime requirements running on this system. This thread is scheduled
> by a hardware interrupt (either AM335x PRUSS or external FPGA).
> 
> Latencies from interrupt into process are as expected. Interrupt thread prio has been
> bumped to 90. But I want/need even shorter latencies.
> 
> So I tried to use IRQF_NO_THREAD in my uio driver to get rid of the scheduling detour through over the interrupt thread. The interrupt handling should be quiet fast - most handling is done in userspace.
> 
> Here comes the problem. The uio framework uses wake_up_interruptible() in the isr which does
> not work from hard interrupt handlers. I tried to modify uio.c to use wake_up_process() with a limitation
> to support a single process having opened the device.

I didn't look at your code in detail, but you might consider looking at
the simple waitqueue implementation.  See include/linux/swait.h in the
kernel tree.  In -rt, completions have been reworked to use them, if you
want to look at an example.  swake_up_*() can be used in hardirq context.

Good luck,

   Julia
