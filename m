From: Scot Salmon <scot.salmon@ni.com>
Subject: Detecting shift of CLOCK_REALTIME with clock_nanosleep (again)
Date: Wed, 31 Oct 2012 10:54:26 -0500
Message-ID: <OFB404C2D9.B6E5E0B9-ON86257AA8.0054900F-86257AA8.005761C4@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Alexander Shishkin <virtuoso@slind.org>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailserver6.natinst.com ([130.164.80.6]:59715 "EHLO
	spamkiller06.natinst.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935768Ab2JaQPz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 31 Oct 2012 12:15:55 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

At RTLWS, I talked to tglx about patching clock_nanosleep to detect shifts 
in CLOCK_REALTIME.  He suggested I bring it up here for comments.

Alexander Shishkin proposed a patch for this a while back: 
http://thread.gmane.org/gmane.linux.kernel/1110759/focus=1131917

At that time Thomas rightly responded that hacking the POSIX 
clock_nanosleep API (both overloading a parameter and adding a new return 
value) was quite horrible.  The nanosleep use case in that thread seemed 
somewhat speculative, with references to "weird" cron jobs, and Alexander 
seemed satisfied when Thomas added this feature to timerfd.

I described a more concrete use case to Thomas that is not solved by 
timerfd.  We have multiple devices running control loops using 
clock_nanosleep and TIMER_ABSTIME to get good periodic wakeups.  The 
clocks need to be synchronized across the controllers so that the loops 
themselves can be in sync.  In order to use a synchronized clock we have 
to use CLOCK_REALTIME.  But if the control loop starts, and then the time 
sync protocol kicks in and shifts the clock, that breaks the control loop, 
the most obvious case being if time shifts backwards and a loop that 
should be running at 100us takes 100us + some arbitrary amount of time 
shift, potentially measured in minutes or even days.  timerfd has the 
behavior I need, but its performance is much worse than clock_nanosleep, 
we believe because the wakeup goes through ksoftirqd.

I applied Alexander's patches 2 and 3, which is the subset I care about 
(avoiding 1 and 4, since we already implemented 1 as a first pass at this 
issue, and Thomas already implemented 4 separately), and it does what I 
need.  But, Thomas's objections are still valid so I am not sure I like 
this solution.

Could reworking the way that timerfd handles wakeups be an option?  We'd 
like some guidance: if that's something you feel worth investigating, 
we're willing to do so.

-Scot

------
Scot Salmon (scot.salmon@ni.com)
National Instruments, Austin, TX
101010, 222, 52, ...
