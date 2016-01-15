From: Carsten Emde <C.Emde@osadl.org>
Subject: Re: trace/latency-hist: Consider new argument when probing the
 sched_switch tracer
Date: Fri, 15 Jan 2016 12:30:55 +0100
Message-ID: <5698D86F.607@osadl.org>
References: <568B8B37.9070804@osadl.org>
 <20160113154526.GJ29964@linutronix.de>
 <20160113105135.3334856c@gandalf.local.home> <56967681.9070204@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Linux RT Users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:39420 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751095AbcAOLbo (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Jan 2016 06:31:44 -0500
In-Reply-To: <56967681.9070204@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Sebastian, hi Steven,

>>> [..] What is blocking the latency-hist tracer from entering
>>> mainline?
>> 
>> Has it been submitted. Like lots of things in -rt, it just takes
>> the effort of pushing out an RFC for inclusion.
> 
> Not that I recall. But this means that there is nothing specific
> that you are aware of that needs to be changed before RFC.
> 
> So, Carsten do you mind taking the latency-hist patch and submitting
> it as RFC for upstream inclusion?
There are two things here:

1. The sum of the timer latency and the wakeup latency does not completely
cover the total preemption latency as, for example, determined by cyclictest.
The time of the context switch until the new task resumes execution at the
next line after the wait instruction is still lacking. I wrote a related
patch sometime ago that is working since then in numerous farm systems -
but I never posted the patch of this switchtime histogram, because someone
said that we first need to re-engineer the histogram code in general.
Nevertheless, I used the opportunity of your posting to submit the patch in
a separate thread so you can have a look. As a bonus, the name of the
delayed system call that caused the highest latency until then is provided
when the switchtime histogram is enabled - this may or may not be helpful
when searching for the source of a latency.

2. The idea behind re-engineering the histogram code someone proposed several
years ago is to create a general framework that can be used throughout the
kernel (or even from user space through a dedicated tracer interface) for any
variable the frequency distribution of which is of interest and that would
best be monitored in form of a frequency histogram - such as a latency
distribution. The various latency tracers would then serve as a practical
example of how to use this fancy new framework. I let you guess why this
re-engineering did not yet happen.

So the question is whether you still encourage me to write the RFC for
upstream inclusion of the current code after some polishing - maybe, in the
hope that someone will come up with the framework during RFC discussion -
or we better wait, since writing an RFC for hopeless code really doesn't
make sense.

Thanks,
	-Carsten.
