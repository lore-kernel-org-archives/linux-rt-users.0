From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH-rt] rtmutex/rt: don't BUG for -EDEADLK when detect_deadlock is off
Date: Wed, 15 Oct 2014 20:09:24 -0400
Message-ID: <1413418164-9405-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <tglx@linutronix.de>, <rostedt@goodmis.org>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:35728 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318AbaJPAKO (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 15 Oct 2014 20:10:14 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The stable cherry pick of commit 3d5c9340d1949733eb37616abd15db36aef9a57c
("rtmutex: Handle deadlock detection smarter")  essentially makes the
deadlock_detect flag a no-op, as it says:

    Even in the case when deadlock detection is not requested by the
    caller, we can detect deadlocks. Right now the code stops the lock
    chain walk and keeps the waiter enqueued, even on itself. Silly not to
    yell when such a scenario is detected and to keep the waiter enqueued.

    Return -EDEADLK unconditionally and handle it at the call sites.

So, as part of that change, we see this:

 @@ -453,7 +453,7 @@ static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
          * which is wrong, as the other waiter is not in a deadlock
          * situation.
          */
 -       if (detect_deadlock && owner == task)
 +       if (owner == task)
                 return -EDEADLK;

However, as part of the -rt baseline patches, there exists this change
within rt-mutex-add-sleeping-spinlocks-support.patch:

	ret = task_blocks_on_rt_mutex(lock, &waiter, self, 0);
	BUG_ON(ret);

Note that the zero in the call to task_blocks_on_rt_mutex is the value
of detect_deadlock; off, but now ignored, and so we get ret = -EDEADLK
which triggers the BUG_ON().

Per the quoted commit above, we handle EDEADLK at the call site, by
not triggering the BUG_ON for it, and instead it will fall through
to the existing for(;;) { ... debug_rt_mutex_print_deadlock() ...}
code immediately below.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

Notes:

 -this patch is against 3.10-rt, but the code for all recent -rt
  that include the recent linux-stable rtmutex changes should have
  the same issue.  [The 3.14-rt has a trivial path change where the
  kernel/rtmutex.c of v3.10 becomes kernel/locking/rtmutex.c but
  aside from that it applies to 3.14 too]

 -I'd got a report of this BUG_ON triggering on a v3.4-rt based
  kernel; that kernel was using my integration of the tglx rtmutex
  stable changes into 3.4-rt as described here:
	https://lkml.org/lkml/2014/9/23/944
  but the related code in rostedt's 3.10.53-rt56 (in linux-stable-rt)
  and in tglx's 3.14.12-rt9 patch queue is AFAICT identical.  So I
  have to conclude that anything using the stable rtmutex changes
  can inadvertently suffer the same BUG trigger.

 -this change gets us back to the pre-rtmutex stable commit behaviour,
  but I suspect that smarter people than me can advise on a way to
  achieve the same end result.  So I'll wait before adding anything
  to the linux-stable-rt branches I'd put here at:
	https://git.kernel.org/cgit/linux/kernel/git/paulg/linux-stable-rt.git

 kernel/rtmutex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rtmutex.c b/kernel/rtmutex.c
index 5f17f55c562d..70edaaee60dc 100644
--- a/kernel/rtmutex.c
+++ b/kernel/rtmutex.c
@@ -887,7 +887,7 @@ static void  noinline __sched rt_spin_lock_slowlock(struct rt_mutex *lock)
 	pi_unlock(&self->pi_lock);
 
 	ret = task_blocks_on_rt_mutex(lock, &waiter, self, 0);
-	BUG_ON(ret);
+	BUG_ON(ret && ret != -EDEADLK);
 
 	for (;;) {
 		/* Try to acquire the lock again. */
-- 
2.1.0

