From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Re: Re: Hard lockup with 2.6.24.7-rt26 on x86 - cause found
Date: Fri, 6 Feb 2009 09:16:05 -0500 (EST)
Message-ID: <alpine.DEB.1.10.0902060915300.10059@gandalf.stny.rr.com>
References: <49725.1233916457@vtxmail.ch> <1233919704.10894.5.camel@laptop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: m.luescher@vtxmail.ch, ghaskins@novell.com,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Carsten.Emde@osadl.org
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.124]:50533 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104AbZBFOQH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 6 Feb 2009 09:16:07 -0500
In-Reply-To: <1233919704.10894.5.camel@laptop>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Fri, 6 Feb 2009, Peter Zijlstra wrote:

> On Fri, 2009-02-06 at 11:34 +0100, Matthias Luescher wrote:
> > Hi
> > 
> > I finally found out which patch does not work well with my configuration:
> > 
> > 2.6.24.7-rt12 seems to be ok, with 2.6.24.7-rt13 the command cyclictest -p99 -t10 -n -i250 crashes the kernel.
> > 
> > 2.6.24.7-rt13 has the follwing new patches:
> > ftrace-hotplug-fix.patch
> > ftrace-wakeup-rawspinlock.patch
> > radix-tree-lockdep-plus1.patch
> > sched-cpupri-hotplug-support.patch
> > sched-cpupri-priocount.patch
> > 
> > No I went again to 2.6.24.7-rt26 but removed some patches:
> > 2.6.24.7-rt26 with all patches -> CRASH
> > 2.6.24.7-rt26 without sched-cpupri-hotplug-support.patch and without sched-cpupri-priocount.patch ->OK
> > 2.6.24.7-rt26 without sched-cpupri-hotplug-support.patch ->CRASH
> 
> sched-cpupri-priocount.patch is buggy

Yes, I was suppose to remove that patch. It somehow escaped deletion.

-- Steve
