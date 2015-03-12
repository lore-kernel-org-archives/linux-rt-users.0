From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 15/36] futex: Split out the first waiter attachment from lookup_pi_state()
Date: Thu, 12 Mar 2015 15:21:54 -0400
Message-ID: <20150312192157.037578282@goodmis.org>
References: <20150312192139.799127123@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Darren Hart <darren@dvhart.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Davidlohr Bueso <davidlohr@hp.com>,
	Kees Cook <kees@outflux.net>, <wad@chromium.org>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.228]:42218 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755799AbbCLTWA (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 Mar 2015 15:22:00 -0400
Content-Disposition: inline; filename=0015-futex-Split-out-the-first-waiter-attachment-from-loo.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

3.12.38-rt53-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

upstream commit: 04e1b2e52b17195c9a1daa5935c55a4c8716095c

We want to be a bit more clever in futex_lock_pi_atomic() and separate
the possible states. Split out the code which attaches the first
waiter to the owner into a separate function. No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Darren Hart <darren@dvhart.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Davidlohr Bueso <davidlohr@hp.com>
Cc: Kees Cook <kees@outflux.net>
Cc: wad@chromium.org
Link: http://lkml.kernel.org/r/20140611204237.271300614@linutronix.de
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/futex.c | 42 ++++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 82db5ec564d2..f3b070e4ae7b 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -718,21 +718,16 @@ out_state:
 	return 0;
 }
 
-static int
-lookup_pi_state(u32 uval, struct futex_hash_bucket *hb,
-		union futex_key *key, struct futex_pi_state **ps)
+/*
+ * Lookup the task for the TID provided from user space and attach to
+ * it after doing proper sanity checks.
+ */
+static int attach_to_pi_owner(u32 uval, union futex_key *key,
+			      struct futex_pi_state **ps)
 {
-	struct futex_q *match = futex_top_waiter(hb, key);
-	struct futex_pi_state *pi_state = NULL;
-	struct task_struct *p;
 	pid_t pid = uval & FUTEX_TID_MASK;
-
-	/*
-	 * If there is a waiter on that futex, validate it and
-	 * attach to the pi_state when the validation succeeds.
-	 */
-	if (match)
-		return attach_to_pi_state(uval, match->pi_state, ps);
+	struct futex_pi_state *pi_state;
+	struct task_struct *p;
 
 	/*
 	 * We are the first waiter - try to look up the real owner and attach
@@ -775,7 +770,7 @@ lookup_pi_state(u32 uval, struct futex_hash_bucket *hb,
 	pi_state = alloc_pi_state();
 
 	/*
-	 * Initialize the pi_mutex in locked state and make 'p'
+	 * Initialize the pi_mutex in locked state and make @p
 	 * the owner of it:
 	 */
 	rt_mutex_init_proxy_locked(&pi_state->pi_mutex, p);
@@ -795,6 +790,25 @@ lookup_pi_state(u32 uval, struct futex_hash_bucket *hb,
 	return 0;
 }
 
+static int lookup_pi_state(u32 uval, struct futex_hash_bucket *hb,
+			   union futex_key *key, struct futex_pi_state **ps)
+{
+	struct futex_q *match = futex_top_waiter(hb, key);
+
+	/*
+	 * If there is a waiter on that futex, validate it and
+	 * attach to the pi_state when the validation succeeds.
+	 */
+	if (match)
+		return attach_to_pi_state(uval, match->pi_state, ps);
+
+	/*
+	 * We are the first waiter - try to look up the owner based on
+	 * @uval and attach to it.
+	 */
+	return attach_to_pi_owner(uval, key, ps);
+}
+
 /**
  * futex_lock_pi_atomic() - Atomic work required to acquire a pi aware futex
  * @uaddr:		the pi futex user address
-- 
2.1.4


