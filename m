From: "Remy Bohmer" <linux@bohmer.net>
Subject: [Question]: Regarding time stability, NTP, clock adjustments
Date: Tue, 18 Dec 2007 13:03:52 +0100
Message-ID: <3efb10970712180403hded3efdu188a2ed83ecc88ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>,
	"Alex van der Wak" <alexvanderwal@gmail.com>
To: "Steven Rostedt" <rostedt@goodmis.org>,
	"Thomas Gleixner" <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.188]:61098 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752630AbXLRMDx (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 18 Dec 2007 07:03:53 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2249797rvb.1
        for <linux-rt-users@vger.kernel.org>; Tue, 18 Dec 2007 04:03:52 -0800 (PST)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Steven and/or Thomas,

I have a question regarding the stability of the time-of-day on
PREEMPT_RT and NTP and such. I hope one of you can answer them.

In a hard real time user space application, running on a PREEMPT_RT
kernel (currently 2.6.20-rt8), we are using the clock_gettime() API
from <time.h> to get the time for the CLOCK_REALTIME clock. We use
this to perform all time based operations including timer timeouts and
timed waits on semaphores and mutexes. We use CLOCK_REALTIME and not
CLOCK_MONOTONIC since semaphores only support timed waits for
CLOCK_REALTIME. Other time related APIs have similar constraints.

Our requirement is that 'the' time returned by clock_gettime() is
stable (e.g does not slow down or accelerate) and never changes
disjunctly (e.g never jumps to the future or past). If this cannot be
guaranteed, the real time behaviour of our application cannot be
guaranteed.

We achieve time stability by not enabling NTP on the system. Looking
at kernel source code we found that NTP time manipulation is deeply
embedded so we disable this. However, things are less clear when we
add time zones and daylight savings time to the equation.

We have observed that dynamic changes in the time zone (e.g changing
/etc/localtime) result is a different time returned by the `date`
command, but not by clock_gettime(). This is excellent, but is this a
fluke or design?

What factors influence the (kernel) time as returned by
clock_gettime() for CLOCK_REALTIME in terms of rate of passage of time
(NTP), and disjunct (time zone and DST) time changes? Next, what is
allowed and disallowed related to time in order to meet the stable
clock requirment for a real time application?

We want to make this clear and then publish something on the rt kernel
wiki since the existing man pages do not mention potential
interactions and design decisions related to this. This information is
very relevant to running real time applications on a real time kernel.

If you have any other comments related to this then these are more than welcome.
Thanks in advance for your time,

Kind Regards,

Remy
