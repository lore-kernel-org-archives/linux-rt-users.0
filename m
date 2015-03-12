From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 12/39] futex: Use futex_top_waiter() in lookup_pi_state()
Date: Thu, 12 Mar 2015 15:13:19 -0400
Message-ID: <20150312191409.089635345@goodmis.org>
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
Content-Disposition: inline; filename=0012-futex-Use-futex_top_waiter-in-lookup_pi_state.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.14.34-rt32-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

upstream commit: bd1dbcc67cd2c1181e2c01daac51eabf1b964dd8

No point in open coding the same function again.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Darren Hart <darren@dvhart.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Davidlohr Bueso <davidlohr@hp.com>
Cc: Kees Cook <kees@outflux.net>
Cc: wad@chromium.org
Link: http://lkml.kernel.org/r/20140611204237.092947239@linutronix.de
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/futex.c | 124 ++++++++++++++++++++++++++++-----------------------------
 1 file changed, 61 insertions(+), 63 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index a3ce98c65127..8bb158215e2c 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -786,87 +786,85 @@ static int
 lookup_pi_state(u32 uval, struct futex_hash_bucket *hb,
 		union futex_key *key, struct futex_pi_state **ps)
 {
+	struct futex_q *match = futex_top_waiter(hb, key);
 	struct futex_pi_state *pi_state = NULL;
-	struct futex_q *this, *next;
 	struct task_struct *p;
 	pid_t pid = uval & FUTEX_TID_MASK;
 
-	plist_for_each_entry_safe(this, next, &hb->chain, list) {
-		if (match_futex(&this->key, key)) {
-			/*
-			 * Sanity check the waiter before increasing
-			 * the refcount and attaching to it.
-			 */
-			pi_state = this->pi_state;
-			/*
-			 * Userspace might have messed up non-PI and
-			 * PI futexes [3]
-			 */
-			if (unlikely(!pi_state))
-				return -EINVAL;
+	if (match) {
+		/*
+		 * Sanity check the waiter before increasing the
+		 * refcount and attaching to it.
+		 */
+		pi_state = match->pi_state;
+		/*
+		 * Userspace might have messed up non-PI and PI
+		 * futexes [3]
+		 */
+		if (unlikely(!pi_state))
+			return -EINVAL;
 
-			WARN_ON(!atomic_read(&pi_state->refcount));
+		WARN_ON(!atomic_read(&pi_state->refcount));
 
+		/*
+		 * Handle the owner died case:
+		 */
+		if (uval & FUTEX_OWNER_DIED) {
 			/*
-			 * Handle the owner died case:
+			 * exit_pi_state_list sets owner to NULL and
+			 * wakes the topmost waiter. The task which
+			 * acquires the pi_state->rt_mutex will fixup
+			 * owner.
 			 */
-			if (uval & FUTEX_OWNER_DIED) {
+			if (!pi_state->owner) {
 				/*
-				 * exit_pi_state_list sets owner to NULL and
-				 * wakes the topmost waiter. The task which
-				 * acquires the pi_state->rt_mutex will fixup
-				 * owner.
+				 * No pi state owner, but the user
+				 * space TID is not 0. Inconsistent
+				 * state. [5]
 				 */
-				if (!pi_state->owner) {
-					/*
-					 * No pi state owner, but the user
-					 * space TID is not 0. Inconsistent
-					 * state. [5]
-					 */
-					if (pid)
-						return -EINVAL;
-					/*
-					 * Take a ref on the state and
-					 * return. [4]
-					 */
-					goto out_state;
-				}
-
-				/*
-				 * If TID is 0, then either the dying owner
-				 * has not yet executed exit_pi_state_list()
-				 * or some waiter acquired the rtmutex in the
-				 * pi state, but did not yet fixup the TID in
-				 * user space.
-				 *
-				 * Take a ref on the state and return. [6]
-				 */
-				if (!pid)
-					goto out_state;
-			} else {
+				if (pid)
+					return -EINVAL;
 				/*
-				 * If the owner died bit is not set,
-				 * then the pi_state must have an
-				 * owner. [7]
+				 * Take a ref on the state and
+				 * return. [4]
 				 */
-				if (!pi_state->owner)
-					return -EINVAL;
+				goto out_state;
 			}
 
 			/*
-			 * Bail out if user space manipulated the
-			 * futex value. If pi state exists then the
-			 * owner TID must be the same as the user
-			 * space TID. [9/10]
+			 * If TID is 0, then either the dying owner
+			 * has not yet executed exit_pi_state_list()
+			 * or some waiter acquired the rtmutex in the
+			 * pi state, but did not yet fixup the TID in
+			 * user space.
+			 *
+			 * Take a ref on the state and return. [6]
+			 */
+			if (!pid)
+				goto out_state;
+		} else {
+			/*
+			 * If the owner died bit is not set,
+			 * then the pi_state must have an
+			 * owner. [7]
 			 */
-			if (pid != task_pid_vnr(pi_state->owner))
+			if (!pi_state->owner)
 				return -EINVAL;
-
-		out_state:
-			atomic_inc(&pi_state->refcount);
-			*ps = pi_state;
-			return 0;
 		}
+
+		/*
+		 * Bail out if user space manipulated the
+		 * futex value. If pi state exists then the
+		 * owner TID must be the same as the user
+		 * space TID. [9/10]
+		 */
+		if (pid != task_pid_vnr(pi_state->owner))
+			return -EINVAL;
+
+	out_state:
+		atomic_inc(&pi_state->refcount);
+		*ps = pi_state;
+		return 0;
 	}
 
 	/*
-- 
2.1.4
