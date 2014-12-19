From: Frank Rowand <frowand.list@gmail.com>
Subject: Re: Latency measurement with oscilloscope, randomly high latency
 times
Date: Thu, 18 Dec 2014 20:14:52 -0800
Message-ID: <5493A63C.5030005@gmail.com>
References: <OFDF470C3A.9CBABFAA-ONC1257DB2.005370FE-C1257DB2.00538C5D@leica-geosystems.com>
Reply-To: frowand.list@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Camera.Geomatics@leica-geosystems.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:59540 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284AbaLSEO4 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 18 Dec 2014 23:14:56 -0500
Received: by mail-pa0-f51.google.com with SMTP id ey11so351228pad.24
        for <linux-rt-users@vger.kernel.org>; Thu, 18 Dec 2014 20:14:55 -0800 (PST)
In-Reply-To: <OFDF470C3A.9CBABFAA-ONC1257DB2.005370FE-C1257DB2.00538C5D@leica-geosystems.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 12/18/2014 7:12 AM, Camera.Geomatics@leica-geosystems.com wrote:
> Hi
> 
> We try to achieve hard real time requirements with a 
> FPGA->IRQ->ISR->User-Space->Kernel-Module->FPGA loop.
> 
> Kernel IRQ handler which toggles IO pins is executed by a Hardware 
> interrupt every 200us (FPGA). Priority is set to 99 via chrt ?f ?p99 
> pid-module.
> 
> Problem:
> The test is working (Pins are toggled in time, <50us), but for some reason 
> 
> we have randomly (every 2-3sec) big latency times of several ms.

Often, the easiest way to identify the big latencies is to run
cyclictest, using its debug facilities such as ftrace triggering.

For a several ms latency you might want to start with hwlatdetect
to check for SMIs.  But it is possible to get large latencies
from other causes than SMIs.

But I would start with adjusting the IRQ handler priority, as you
suspected you might need to (see below).

> 
> We sometimes get already interrupted in our IRQ handler (which we 
> registered with request_irq) before we wakeup our user space task. 
> 
> Kernel Version: linux-socfpga 3.10.37-ltsi-rt37
> Development board: Altera Cyclone V SoC Development Kit
> 
> Do we have to somehow set the priority 99 for the IRQ handler seperately? 
> Is there any kind of priority inheritance from user space task to kernel 
> module?

First off, you should not use priority 99 unless you _really_ understand
what that is doing to the other kernel threads that are priority 99 (they
have that priority for a reason).

Yes, you need to set the priority of your IRQ handler thread to the
value that you decide is appropriate. If your IRQ handler or the
other parts of your real time application depend on services from
other kernel threads, you may need to adjust the priority of those
threads.

"The user space task" is causing the kernel module to execute by doing
a system call, correct?  Thus the current task while executing the
kernel module code is the "user space task", so the priority is the
"user space task" priority.  This is assuming that there is nothing
in the path from the syscall to the kernel module acting on the FPGA
that is asynchronous (for example, the kernel module could pass a
message to a kernel thread that acts on the FPGA).

> 
> Best Regards
> Hannes
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

