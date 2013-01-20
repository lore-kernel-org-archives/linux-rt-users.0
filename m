From: Carsten Emde <C.Emde@osadl.org>
Subject: Re: Detecting PREEMPT_RT
Date: Sun, 20 Jan 2013 02:43:13 +0100
Message-ID: <50FB4BB1.7070005@osadl.org>
References: <50FB36A0.7000702@zultron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: John Morris <john@zultron.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:55400 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752292Ab3ATBpG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 19 Jan 2013 20:45:06 -0500
In-Reply-To: <50FB36A0.7000702@zultron.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

John,

> I'm part of a project that recently added PREEMPT_RT support (as well as
> Xenomai) to LinuxCNC/EMC2.
>
> The next sub-project is a 'universal binary'.  The LCNC real-time module
> will run some checks to determine what RT systems, if any, are available
> on the running kernel, and then load the appropriate RT support module.
>
> We wish to distinguish between PREEMPT_RT and non-RT kernels because
> LCNC must confirm that the kernel really does have realtime
> capabilities, if that's what the user expects, and print big warning
> messages if not.  LCNC drives machines that weigh many tons and spins
> spindles at 24k RPM, so this is important!
>
> The RT PREEMPT HOWTO discusses checking the kernel here:
>
> https://rt.wiki.kernel.org/index.php/RT_PREEMPT_HOWTO#Checking_the_Kernel
>
> One method is to use string matching against the kernel version, which
> I'm a bit suspicious of.
Unfortunately, this wiki article is old and unmaintained. You're 
probably right to be a bit suspicious when checking for the "-rt" suffix 
of the kernel release (uname -r). But looking for the occurrence of 
"PREEMPT RT" in the kernel version (uname -v) should work. An 
application may use the system call uname() and check the version 
element of the utsname structure.

In addition you may want to make sure the system has high-resolution 
timers. If so, the timers in /proc/timer_list have ".resolution: 1 
nsecs". An application may use the function check_timer() from 
cyclictest for this purpose:
static int check_timer(void)
{
   struct timespec ts;

   if (clock_getres(CLOCK_MONOTONIC, &ts))
     return 1;

   return (ts.tv_sec != 0 || ts.tv_nsec != 1);
}

Hope this helps,
	-Carsten.
