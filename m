From: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>
Subject: RE: How to measue the total CPU specific load (including real time
 tasks)?
Date: Thu, 9 Jul 2015 11:31:27 +0000
Message-ID: <3babf224e0c0477ca7828cb480318189@FE-MBX1012.de.bosch.com>
References: <0b987de237404a13b1753e28e3853d2f@FE-MBX1012.de.bosch.com>
 <20150708171943.GA11993@zipoli.ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"c.emde@osadl.org" <c.emde@osadl.org>
To: Joe Korty <joe.korty@ccur.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:51934 "EHLO
	smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751341AbbGILba convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 9 Jul 2015 07:31:30 -0400
In-Reply-To: <20150708171943.GA11993@zipoli.ccur.com>
Content-Language: de-DE
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Joe,

> > we use the RT_PREEMPT kernel fairly long now and it is working really fine.
> > However, I have one question that is related to measure the available "CPU
> > headroom" on all available CPU cores.  We are using an Intel Core i7 PC
> > (32 and 64bit, Debian distribution, vanilla kernel + rt_preempt patch).
> > The question is the same for kernel 3.2.x and 3.18.x.
> >
> > On the PC a couple of real time threads are running. They are hard bound
> > to a particular CPU core (via pthread_setaffinity_np or sched_setaffinity).
> > As we are using the boot parameter  "isolcpus=1-31", all processes run per
> > default on CPU core 0.  Now, I want to measure the total CPU specific load.
> > How can this be done easily?
> >
> > When I use "top" in thread-mode I see the relative CPU load for particular
> > threads/processes.  However the "idle" value in the "top" summary does
> > not fit. With some experiments I saw the idle value for a CPU core to
> > be nearly 100% even if on the very same CPU core a real time thread was
> > consuming about 40% CPU time.  I looked into /proc/stat to take the idle
> > tick value but this value seems not to consider the real time threads.
> >
> >
> > The only approach I found so far is to parse all /proc/PID/stat files
> > periodically and to extract the fields utime, stime, cutime, cstime,
> > task_cpu. These values can be used to compute the CPU specific load.
> > However, the effort to do so is really high.
> >
> > Is there any /proc file (or something similar) I can use to get the total
> > CPU specific load (including real time threads)?  Or do I have to enable
> > a particular kernel configuration to get this value?
> >
> > Thanks for any feedback on this question.
> >
> > Regards
> > Mathias
> 
> 
> I think that if you turn on CONFIG_VIRT_CPU_ACCOUNTING_GEN,
> you will get per-cpu high resolution idle time accounting
> as a side effect.  (I'm looking at the 3.18 kernel, YMMV
> for earlier kernels).
> 
> Regards,
> Joe
the x86 (32bit) does not support HAVE_VIRT_CPU_ACCOUNTING_GEN. Only the 64bit version does...
And I need an approach that works for 32 and 64 bit x86.
In the meantime  I have found a patch from Carsten Emde that is used on the OSADL QA farm:
https://www.osadl.org/monitoring/patches/r5s1/sched-add-per-cpu-load-measurement.patch

This patch does exactly what I need...
One minor note on this patch:
There is an issue with writing to /proc/idleruntime/resetall.
The following patch fixes that...

Index: linux-3.18.13-rt10/kernel/sched/cpu_idleruntime.c
===================================================================
--- linux-3.18.13-rt10.orig/kernel/sched/cpu_idleruntime.c
+++ linux-3.18.13-rt10/kernel/sched/cpu_idleruntime.c
@@ -82,7 +82,6 @@ static ssize_t idleruntime_resetall(stru
 
 static const struct file_operations idleruntime_resetall_fops = {
 	.write = idleruntime_resetall,
-	.release = single_release,
 };
 
 static int idleruntime_open(struct inode *inode, struct file *file)


Regards

Mathias

