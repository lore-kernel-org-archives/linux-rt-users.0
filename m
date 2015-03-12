From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 14/39] futex: Split out the first waiter attachment from lookup_pi_state()
Date: Thu, 12 Mar 2015 15:13:21 -0400
Message-ID: <20150312191409.402073902@goodmis.org>
References: <20150312191307.081068717@goodmis.org>
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
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0014-futex-Split-out-the-first-waiter-attachment-from-loo.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.14.34-rt32-rc1 stable review patch.
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
index 8377eec3f650..e0802beff9ad 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -855,21 +855,16 @@ out_state:
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
@@ -912,7 +907,7 @@ lookup_pi_state(u32 uval, struct futex_hash_bucket *hb,
 	pi_state = alloc_pi_state();
 
 	/*
-	 * Initialize the pi_mutex in locked state and make 'p'
+	 * Initialize the pi_mutex in locked state and make @p
 	 * the owner of it:
 	 */
 	rt_mutex_init_proxy_locked(&pi_state->pi_mutex, p);
@@ -932,6 +927,25 @@ lookup_pi_state(u32 uval, struct futex_hash_bucket *hb,
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
