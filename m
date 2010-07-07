From: Mike Galbraith <efault@gmx.de>
Subject: Re: 2.6.33.[56]-rt23: howto create repeatable explosion in
 wakeup_next_waiter()
Date: Wed, 07 Jul 2010 16:17:24 +0200
Message-ID: <1278512244.10564.10.camel@marge.simson.net>
References: <1278478019.10245.77.camel@marge.simson.net>
	 <alpine.LFD.2.00.1007071356480.2604@localhost.localdomain>
	 <4C348940.9070805@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Darren Hart <dvhltc@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:48537 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752623Ab0GGORY (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 7 Jul 2010 10:17:24 -0400
In-Reply-To: <4C348940.9070805@us.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2010-07-07 at 07:03 -0700, Darren Hart wrote:
> On 07/07/2010 04:57 AM, Thomas Gleixner wrote:
> > Cc'ing Darren.
> >
> > On Wed, 7 Jul 2010, Mike Galbraith wrote:
> >
> 
> Hi Mike,
> 
> >> Greetings,
> >>
> >> Stress testing, looking to trigger RCU stalls, I've managed to find a
> >> way to repeatably create fireworks.  (got RCU stall, see attached)
> >>
> >> 1. download ltp-full-20100630.  Needs to be this version because of
> >> testcase bustage in earlier versions, and must be built with gcc>  4.3,
> >> else testcases will segfault due to a gcc bug.
> 
> Interesting, I had not hit any gcc specific issues with this. Can you 
> point me to the bug?

gcc-4.3 doesn't grok volatile inside a struct.  Workaround below.

Index: ltp-full-20090930/testcases/realtime/include/librttest.h
===================================================================
--- ltp-full-20090930.orig/testcases/realtime/include/librttest.h
+++ ltp-full-20090930/testcases/realtime/include/librttest.h
@@ -88,7 +88,7 @@ struct thread {
 	int flags;
 	int id;
 };
-typedef struct { volatile int counter; } atomic_t;
+typedef volatile struct { volatile int counter; } atomic_t;
 
 // flags for threads
 #define THREAD_START 1

> >> --- run.sh.org	2010-07-06 15:54:58.000000000 +0200
> >> +++ run.sh	2010-07-06 16:37:34.000000000 +0200
> >> @@ -22,7 +22,7 @@ make
> >>   # process to run realtime.  The remainder of the processes (if any)
> >>   # will run non-realtime in any case.
> >>
> >> -nthread=5000
> >> +nthread=500
> 
> Was this just to lighten the load, or was it required to reproduce?

Just to lighten it.

> Which architecture?

x64_64.

> Glibc version?

glibc-2.11.2-2.3

> I see kernel version is: 2.6.33.6-rt23, have you reproduced this on 
> earlier kernel versions as well? Any 2.6.31 rt kernel would be a good 
> data point.

Yes, both 2.6.31.14-rt21 and 2.6.29.6-rt24.

> Is this immediately reproducible for you?

Yes, nearly instant kaboom.

> I see a possibly fault occuring in the stack, if you run with 
> mlockall(), does the problem go away? (assuming not, but an easy thing 
> to test).

Nope, -m made no difference.

	-Mike

