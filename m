Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41862 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730314AbfBDN4f (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 4 Feb 2019 08:56:35 -0500
Received: by mail-qt1-f196.google.com with SMTP id b15so3591823qto.8
        for <linux-rt-users@vger.kernel.org>; Mon, 04 Feb 2019 05:56:35 -0800 (PST)
Date: Mon, 4 Feb 2019 11:56:30 -0200
From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Re: System lockup causes reboot but no panic and no kernel crash dump
Message-ID: <20190204135630.GA3847@uudg.org>
References: <AM0PR03MB4804EC083BE1023391C829B1BB910@AM0PR03MB4804.eurprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR03MB4804EC083BE1023391C829B1BB910@AM0PR03MB4804.eurprd03.prod.outlook.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Tom Putzeys <tom.putzeys@be.atlascopco.com>
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>

On Thu, Jan 31, 2019 at 12:26:48AM +0000, Tom Putzeys wrote:
> Hi all,
> 
> I am trying to debug a series of random system freezes / lockups by making use of the kernel lockup detector / NMI watchdog to trigger a kernel crash dump when a system lockup occurs.
> 
> We are running the 4.14.93-rt kernel on a quad-core x86_64 Intel Atom SMP machine.
> 
> The lockup detector is fully enabled and configured to trigger a panic when a hard or soft lockup occurs:
> CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
> CONFIG_LOCKUP_DETECTOR=y
> CONFIG_SOFTLOCKUP_DETECTOR=y
> CONFIG_HARDLOCKUP_DETECTOR_PERF=y
> CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
> CONFIG_HARDLOCKUP_DETECTOR=y
> CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
> CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
> CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
> CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=1
> 
> I also set the correct sysctl variables:
> kernel.panic = 1
> kernel.panic_on_oops = 1
> kernel.unknown_nmi_panic = 1
> kernel.panic_on_unrecovered_nmi = 1
> kernel.panic_on_io_nmi = 1
> kernel.softlockup_panic = 1
> kernel.hung_task_panic = 1
> 
> I also enabled the NMI watchdog via the kernel cmdline (nmi_watchdog=1). 
> 
> I configured my system to generate a kernel crash dump using kdump /
> kexec when a panic occurs. When I trigger a manual kernel panic via
> /proc/sysrq-trigger, the crash dump mechanism works perfectly. I see a
> switch to my dump-capture kernel and ramdisk. 
> 
> The problem: when a real-life lockup or system freeze occurs, the system
> just reboots without generating a crash dump. There is no switch to the
> dump-capture kernel. AFAIK, there is no panic. I find nothing in the logs
> and nothing appears on the console.
> 
> To replicate the problem: I wrote a small program that runs an infinite
> nop while loop. When running this program on all 4 cores with max.
> real-time priority (SCHED_FIFO) to hog the CPU, I get a complete system
> lockup (no keyboard input, no serial console, no ping reply). This freeze
> then triggers a reboot (I guess when the watchdog kicks in) but no crash
> dump or no visible kernel panic.
> 
> I find it strange that the RT throttling mechanism does not prevent a
> freeze in this case (we did not disable it), but apart from that, I guess
> my hog application should be detected as a hung task and cause a panic. 

With regards to RT throttling, you probably need to run this command line:

    # echo NO_RT_RUNTIME_SHARE > /sys/kernel/debug/sched_features

In short, a CPU about to hit the point where the RT throttling mechanism
would kick in can borrow "RT time" from other CPUs that are not running
RT tasks. That is the default behavior and the command line above disables
that feature.

You could also, for testing purposes, increase the slice of CPU time reserved
for non-rt tasks. You could try 10% instead of the usual 5%:

    # echo 1000000 > /proc/sys/kernel/sched_rt_period_us
    # echo 900000 > /proc/sys/kernel/sched_rt_runtime_us

Luis
