From: gowrishankar <gowrishankar.m@linux.vnet.ibm.com>
Subject: Re: kernel 2.6.33.7-rt29 problem
Date: Fri, 15 Oct 2010 23:29:11 +0530
Message-ID: <4CB8966F.1000605@linux.vnet.ibm.com>
References: <594976.7463.qm@web114205.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users linux-rt-users <linux-rt-users@vger.kernel.org>
To: Primus Mutasingwa <pmutasingwa@yahoo.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e23smtp06.au.ibm.com ([202.81.31.148]:57481 "EHLO
	e23smtp06.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756474Ab0JOR7T (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Oct 2010 13:59:19 -0400
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp06.au.ibm.com (8.14.4/8.13.1) with ESMTP id o9FHxDtS015150
	for <linux-rt-users@vger.kernel.org>; Sat, 16 Oct 2010 04:59:13 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id o9FHxHjD2547934
	for <linux-rt-users@vger.kernel.org>; Sat, 16 Oct 2010 04:59:17 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id o9FHxHSi031665
	for <linux-rt-users@vger.kernel.org>; Sat, 16 Oct 2010 04:59:17 +1100
In-Reply-To: <594976.7463.qm@web114205.mail.gq1.yahoo.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Friday 15 October 2010 01:13 AM, Primus Mutasingwa wrote:
> Hello,
>
> I am using a linux kernel 2.6.33.7+preempt rt patch (patch-2.6.33.7-rt29)
> My system is running a user-space application that is made of multiple threads
> with varying priorities.
> This app is also making read/write calls into a kernel space driver that is
> running at priority 99 (very high priority)
> These are priorities fo some of the items running in the system
>       Threads in the app (10 ... 98, FIFO) 
>       Serial console isr (99, FIFO)
>       Driver used by app (99, FIFO)
> Different threads fail at different times (even ones with priority 50 or 98)
>
> System randomly fails after running for anywhere from 1 to 20 minutes.
>    

Could be due to cpu stall detected by rcu which will further request for
NMI to be sent.. your app may block rcu system threads which if fails to
extend the grace time, rcu will assume cpu stalled.. Any such info you saw
in /var/log/messages ? Anyhow, please reduce your threads prio atleast to
80 to give cpu chances to system priority threads.

Thanks,
Gowrishankar
> When it fails, these are the symptoms observed.
> 1. Running function/thread gets preempted and never gets time to run after that.
>     Console locks up, can no longer run ethernet traffic.
>     It is possible to get some console use by changing the scheduler
>     throttling threshold.   Usually it is at 95% and we change it to about 60%.
>   
>     /* from the console  */
>     echo 600000>  /proc/sys/kernel/sched_rt_runtime_us
> 2. When we get console use:
>     Displaying processor status (ps) shows that this thread is running even
> though we
>
>     never returned to the function
>     Using a top utility , it is reported that that particular thread consumes
>     about 95% of the CPU resources.
> 3. Using a JTAG based debugger
>       -- the stack was verified to be ok.
>       -- If we set a breakpoint in the function that fails we never hit the
> breakpoint (we expected function to return after preemption)
>
> I am looking for suggestions on how to resolve this problem. Why doesnt the
> thread run ?
> Why is the system locked up ?
> Is there any tools included in the kernel that can allow me to debug this ?
> I am not aware of an available lttng package available for this kernel version.
>
> Thank you,
>
> P. Mutasingwa
>
> Included is the kernel configuration file (omap3_beagle_defconfig) used in my
> setup
> Sent Separately
>
>
>
>        

