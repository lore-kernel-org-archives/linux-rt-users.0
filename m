From: Joe Korty <joe.korty@ccur.com>
Subject: Re: How to measue the total CPU specific load (including real time
 tasks)?
Date: Wed, 8 Jul 2015 13:19:43 -0400
Message-ID: <20150708171943.GA11993@zipoli.ccur.com>
References: <0b987de237404a13b1753e28e3853d2f@FE-MBX1012.de.bosch.com>
Reply-To: Joe Korty <joe.korty@ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from vpnflf.ccur.com ([12.220.59.2]:59311 "EHLO zipoli.ccur.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758589AbbGHRTu (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 8 Jul 2015 13:19:50 -0400
Content-Disposition: inline
In-Reply-To: <0b987de237404a13b1753e28e3853d2f@FE-MBX1012.de.bosch.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Jul 07, 2015 at 08:18:08AM -0400, Koehrer Mathias (ETAS/ESW5) wrote:
> Hi all,
> 
> we use the RT_PREEMPT kernel fairly long now and it is working really fine.
> However, I have one question that is related to measure the available "CPU
> headroom" on all available CPU cores.  We are using an Intel Core i7 PC
> (32 and 64bit, Debian distribution, vanilla kernel + rt_preempt patch).
> The question is the same for kernel 3.2.x and 3.18.x.
> 
> On the PC a couple of real time threads are running. They are hard bound
> to a particular CPU core (via pthread_setaffinity_np or sched_setaffinity).
> As we are using the boot parameter  "isolcpus=1-31", all processes run per
> default on CPU core 0.  Now, I want to measure the total CPU specific load.
> How can this be done easily?
> 
> When I use "top" in thread-mode I see the relative CPU load for particular
> threads/processes.  However the "idle" value in the "top" summary does
> not fit. With some experiments I saw the idle value for a CPU core to
> be nearly 100% even if on the very same CPU core a real time thread was
> consuming about 40% CPU time.  I looked into /proc/stat to take the idle
> tick value but this value seems not to consider the real time threads.
> 
> 
> The only approach I found so far is to parse all /proc/PID/stat files
> periodically and to extract the fields utime, stime, cutime, cstime,
> task_cpu. These values can be used to compute the CPU specific load.
> However, the effort to do so is really high.
> 
> Is there any /proc file (or something similar) I can use to get the total
> CPU specific load (including real time threads)?  Or do I have to enable
> a particular kernel configuration to get this value?
> 
> Thanks for any feedback on this question.
> 
> Regards
> Mathias


I think that if you turn on CONFIG_VIRT_CPU_ACCOUNTING_GEN,
you will get per-cpu high resolution idle time accounting
as a side effect.  (I'm looking at the 3.18 kernel, YMMV
for earlier kernels).

Regards,
Joe
