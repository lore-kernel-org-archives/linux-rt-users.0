From: "Peter W. Morreale" <pmorreale@novell.com>
Subject: rt mutex priority boost
Date: Wed, 28 Nov 2007 06:51:16 -0700
Message-ID: <1196257876.4078.195.camel@hermosa.morrealenet>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:37433 "EHLO
	victor.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175AbXK1N4e (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 28 Nov 2007 08:56:34 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Steve, 

I'm directing this question to you, however it may be of interest to the
community as well...

I've been looking closely at the rtmutex code, spin locks in particular,
and noticed something that has me confused.  I instrumented the code to
add some simple counters and have found that for non-rt loads, we seem
to perform priority boosts more frequently than expected.  Here are some
numbers...

rs_pi_boost            = 2060
rs_pi_unboost          = 1451
rs_rt_contention       = 708

'rs_pi_boost' and 'rs_pi_unboost' are are counts of the number of times
a task priority is about to be changed in __rt_mutext_adjust_prio().
'rs_rt_contention' is a count of the number of times an RT-priority task
entered task_blocks_on_rt_mutex() (which means the lock was outstanding
at that time the counter was incremented)

I'm confused on two counts, 1) the disparity between the boost and
unboost, and 2) the factor of 2x difference between the (potentially)
about to block RT task and the boost counts. 

My expectation would be that all three counters would be more or less
the same.  Further, that we would only boost non-RT tasks in contention
with an RT task.  Is that a wrong assumption?  The code seems to imply
that we boost anyone.

The samples were taken after a reboot followed by a 'make' in an already
built kernel tree.  The counts (gradually) grow in this proportion as
time/load passes.  They are currently low due to the reboot. 

What got me started on this path was noticing the context switch counts
go extremely high with the addition of a single process.  Here is the
output of a silly little program I wrote that reads /proc/stat and calcs
context-switches/second: 

prev:    1990167, current:    1992750, diff:        516/s
prev:    1992755, current:    1994567, diff:        362/s
prev:    1994569, current:    1997847, diff:        655/s
prev:    1997849, current:    2011904, diff:       2811/s # make start
prev:    2011913, current:    2041192, diff:       5855/s
prev:    2041194, current:    2074749, diff:       6711/s
prev:    2074752, current:    2107060, diff:       6461/s
prev:    2107065, current:    2139376, diff:       6462/s
prev:    2139378, current:    2164268, diff:       4978/s # make killed
prev:    2164274, current:    2166674, diff:        480/s
prev:    2166676, current:    2168187, diff:        302/s
prev:    2168189, current:    2169576, diff:        277/s

Factor of 10x for a single make (no -j) on an otherwise idle system.
Again, this was on an already built kernel tree and taken shortly after
the a previous make invocation (implying the caches should be warm).
Since I'm hitting on the dcache and inode spin locks (that are now
rt_spin_locks) and only contending with other system processes (syslog,
etc) I'm at a loss attempting to understand why the dramatic increase in
the context switch rate. 

Any insights appreciated....

Thx,
-PWM
