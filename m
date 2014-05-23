From: "Brad Mouring" <bmouring@ni.com>
Subject: [PATCH 0/1] Faux deadlock detection fixup
Date: Fri, 23 May 2014 09:30:09 -0500
Message-ID: <1400855410-14773-1-git-send-email-brad.mouring@ni.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Brad Mouring <brad.mouring@ni.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:36782 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752541AbaEWOka (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 23 May 2014 10:40:30 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Greetings punctual folks (or at least folks who make linux punctual).

I recently ran into an issue that I've been spending a few
weeks trying to characterize, which includes trying my best to
comprehend glibc's pthread_mutex implementation that uses futexes
(which, in turn, use rtmutexes). I'll try my best to describe the
situation I saw before presenting the patch that I wrote to fix the
issue. By all means, if I get some part of this wrong or the approach
taken to resolve the issue is incorrect, please let me know. Without
futher ado, consider the following scenario for a priority chain:

All tasks involved here are SCHED_OTHER, so same priority. All user-
space mutexes are pthread_mutexes configured to be PI (useless if all
threads are SCHED_OTHER, I know, but we allow users to give rt
priorities to threads, just not in this instance) and recursive (this
doesn't seem to be involved here, as that keeps things in userspace.)

Thread (task) C attempts to take a pthread_mutex that's already
owned, resulting in a sys_futex call. The current priority chain is
as follows

task A owns lock L1
 task^           L1 blocks task D < top_waiter on L1
                 L1 blocks task B
             lock^         task B owns lock L2
                                            L2 blocks task C
                                                    current^

We walk the chain, at the point when we attempt to take task A's
pi_lock (and it is contended) or from the explicit attempt at L1's
wait_lock, either one being contended can result in C being scheduled
out. The top_waiter variable currently points at "L1 blocks task D".
The task variable currently points at A.

When C scheduled out, A is scheduled in. A releases L1, wins L3 (in
userspace, since it's uncontended), and turns around and blocks on L2.

Since A released L1, this frees D to take it. D is running the same
code path as A, so it does what it needs to with L1, releases it,
attempts to take L3 and blocks. Funny thing is, the waiter for this
dependency is at the same address pointed to by the top_waiter, that
previously expressed "L1 blocks D" when top_waiter was set when C
blocked on L2.

At this point, the chain resembles some facsimile of the of the
following:

task B owns L2
            L2 blocks task C
            L2 blocks task A
                      task A owns L3
                       task^      L3 blocks task D < top_waiter

Task C is scheduled back in after this shuffle, resumes walking the
prio_chain, *passes* the test looking at top_waiter and task's top
pi_waiter (top_waiter is tragically pointing at "L3 blocks D" now),
and the test to see if the lock that's blocking A is the original
lock that C originally blocked on. Hmm.

We report EDEADLK to userspace that, sanely, SIGABRTs our process.

This series of events seems outlandish, but I have traces that show
just this behavior (and similar notes) at 
http://www.the-bradlands.net/waitergate.tar.gz

Anyway, this patch simply checks to ensure that the current task is
indeed the owner of the current lock examined. A test in our 
(unfortunately complicated) execution framework (LabVIEW) would
reproduce the issue on an arm cortex-a9 within minutes and an x64
Atom within hours. After applying this patch, we were unable to 
reproduce the issue after running the test for days.

Originally, the check and fixup happened outside of the deadlock
detection block but we found the fixup code was being hit with
alarming regularity, considering we only wanted to address the false
deadlock case, and as such, I was convinced to move it inside the
deadlock detected block.

Brad Mouring (1):
  rtmutex: Handle when top lock owner changes

 kernel/locking/rtmutex.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

-- 
1.8.3-rc3

