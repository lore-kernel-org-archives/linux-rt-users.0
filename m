From: Julia Cartwright <julia@ni.com>
Subject: [PATCH RT 01/22] futex: Fix pi_state->owner serialization
Date: Mon,  6 Aug 2018 04:17:17 -0500
Message-ID: <43d23e5c64e32c64e18559ef810157700bf3eac4.1533540554.git.julia@ni.com>
References: <cover.1533540554.git.julia@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, Peter Zijlstra <peterz@infradead.org>,
        dvhart@infradead.org, stable@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1533540554.git.julia@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

4.9.115-rt94-rc1 stable review patch.
If you have any objection to the inclusion of this patch, let me know.

--- 8< --- 8< --- 8< ---
[ Upstream commit c74aef2d06a9f59cece89093eecc552933cba72a ]

There was a reported suspicion about a race between exit_pi_state_list()
and put_pi_state(). The same report mentioned the comment with
put_pi_state() said it should be called with hb->lock held, and it no
longer is in all places.

As it turns out, the pi_state->owner serialization is indeed broken. As per
the new rules:

  734009e96d19 ("futex: Change locking rules")

pi_state->owner should be serialized by pi_state->pi_mutex.wait_lock.
For the sites setting pi_state->owner we already hold wait_lock (where
required) but exit_pi_state_list() and put_pi_state() were not and
raced on clearing it.

Fixes: 734009e96d19 ("futex: Change locking rules")
Reported-by: Gratian Crisan <gratian.crisan@ni.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: dvhart@infradead.org
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20170922154806.jd3ffltfk24m4o4y@hirez.programming.kicks-ass.net
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Julia Cartwright <julia@ni.com>
---
 kernel/futex.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 8ab0ddd4cf8f..47e42faad6c5 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -819,8 +819,6 @@ static void get_pi_state(struct futex_pi_state *pi_state)
 /*
  * Drops a reference to the pi_state object and frees or caches it
  * when the last reference is gone.
- *
- * Must be called with the hb lock held.
  */
 static void put_pi_state(struct futex_pi_state *pi_state)
 {
@@ -835,16 +833,22 @@ static void put_pi_state(struct futex_pi_state *pi_state)
 	 * and has cleaned up the pi_state already
 	 */
 	if (pi_state->owner) {
-		raw_spin_lock_irq(&pi_state->owner->pi_lock);
-		list_del_init(&pi_state->list);
-		raw_spin_unlock_irq(&pi_state->owner->pi_lock);
+		struct task_struct *owner;
 
-		rt_mutex_proxy_unlock(&pi_state->pi_mutex, pi_state->owner);
+		raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
+		owner = pi_state->owner;
+		if (owner) {
+			raw_spin_lock(&owner->pi_lock);
+			list_del_init(&pi_state->list);
+			raw_spin_unlock(&owner->pi_lock);
+		}
+		rt_mutex_proxy_unlock(&pi_state->pi_mutex, owner);
+		raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
 	}
 
-	if (current->pi_state_cache)
+	if (current->pi_state_cache) {
 		kfree(pi_state);
-	else {
+	} else {
 		/*
 		 * pi_state->list is already empty.
 		 * clear pi_state->owner.
@@ -903,14 +907,15 @@ void exit_pi_state_list(struct task_struct *curr)
 		raw_spin_unlock_irq(&curr->pi_lock);
 
 		spin_lock(&hb->lock);
-
-		raw_spin_lock_irq(&curr->pi_lock);
+		raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
+		raw_spin_lock(&curr->pi_lock);
 		/*
 		 * We dropped the pi-lock, so re-check whether this
 		 * task still owns the PI-state:
 		 */
 		if (head->next != next) {
-			raw_spin_unlock_irq(&curr->pi_lock);
+			raw_spin_unlock(&curr->pi_lock);
+			raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
 			spin_unlock(&hb->lock);
 			raw_spin_lock_irq(&curr->pi_lock);
 			continue;
@@ -920,9 +925,10 @@ void exit_pi_state_list(struct task_struct *curr)
 		WARN_ON(list_empty(&pi_state->list));
 		list_del_init(&pi_state->list);
 		pi_state->owner = NULL;
-		raw_spin_unlock_irq(&curr->pi_lock);
+		raw_spin_unlock(&curr->pi_lock);
 
 		get_pi_state(pi_state);
+		raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
 		spin_unlock(&hb->lock);
 
 		rt_mutex_futex_unlock(&pi_state->pi_mutex);
@@ -1204,6 +1210,10 @@ static int attach_to_pi_owner(u32 uval, union futex_key *key,
 
 	WARN_ON(!list_empty(&pi_state->list));
 	list_add(&pi_state->list, &p->pi_state_list);
+	/*
+	 * Assignment without holding pi_state->pi_mutex.wait_lock is safe
+	 * because there is no concurrency as the object is not published yet.
+	 */
 	pi_state->owner = p;
 	raw_spin_unlock_irq(&p->pi_lock);
 
-- 
2.18.0
