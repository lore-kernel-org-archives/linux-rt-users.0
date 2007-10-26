From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: Re: Interrupt Latency module for intel
Date: Fri, 26 Oct 2007 02:39:38 -0700
Message-ID: <1193391578.6271.20.camel@sven.thebigcorporation.com>
References: <1985e0f60710192336l5469682ai9dc47d5bc1a87c55@mail.gmail.com>
	 <1193255575.3557.2.camel@imap.mvista.com>
	 <1193260511.4040.42.camel@sven.thebigcorporation.com>
	 <1985e0f60710250941j44e40b5evb186e2cbebffdae8@mail.gmail.com>
	 <Pine.LNX.4.58.0710251321020.8703@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jaswinder Singh <jaswinderlinuxrt@gmail.com>,
	Daniel Walker <dwalker@mvista.com>,
	RT <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from alnrmhc13.comcast.net ([204.127.225.93]:46158 "EHLO
	alnrmhc13.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753618AbXJZJjx (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 26 Oct 2007 05:39:53 -0400
In-Reply-To: <Pine.LNX.4.58.0710251321020.8703@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2007-10-25 at 13:23 -0400, Steven Rostedt wrote:
> 
> Please don't top post.
> 
> --
> 
> On Thu, 25 Oct 2007, Jaswinder Singh wrote:
> 
> > Hello Daniel and Sven-Thorsten Dietrich,
> >
> > Can you please let me know the procedure of :
> > 1. high resolution timers from userspace
> 
> http://rt.wiki.kernel.org/index.php/Cyclictest
> 
> > 2. ingo's irq latency timing and tracing
> 
> I need to write up some howtos for that.
> 
> >
> > I will also try these methods and try to compare the performance numbers.
> >
> 
> The cyclictest is fine for comparisons, but the latency trace is only
> available with the -rt patch.
> 


First, configure IRQ timing or wake-up timing in Kernel Hacking.

IRQ-disabled, and preempt-disabled Kernel code-paths are measured.

If you enable latency tracing, code paths are reported
to /proc/latency_trace if they exceed the cpu-cyles-count
specified in proc/sys/kernel/preempt_thresh.

If you enable histogram, you get the distribution.

To enable latency tracing, use the following commands:

# cd /proc/sys/kernel

# echo 400000 > preempt_thresh 
# echo 1 > trace_enabled 
# echo 0 > preempt_max_latency

You need to set preempt_thresh to a reasonably large cycles value, or
you will get traces for every Kernel transition.

Sven

> -- Steve
> 
