Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from Galois.linutronix.de ([146.0.238.70]:50232 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751870AbeFFNb4 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 6 Jun 2018 09:31:56 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/6] futex: Fix pi_state->owner serialization
Date: Wed,  6 Jun 2018 15:31:26 +0200
Message-Id: <20180606133131.7747-2-bigeasy@linutronix.de>
In-Reply-To: <20180606133131.7747-1-bigeasy@linutronix.de>
References: <20180606133131.7747-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: julia@ni.com
Cc: linux-rt-users@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>

From: Peter Zijlstra <peterz@infradead.org>

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
Link: https://lkml.kernel.org/r/20170922154806.jd3ffltfk24m4o4y@hirez.progr=
amming.kicks-ass.net
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/futex.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 1e4c72447456..19b016bbcc87 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -819,8 +819,6 @@ static void get_pi_state(struct futex_pi_state *pi_stat=
e)
 /*
  * Drops a reference to the pi_state object and frees or caches it
  * when the last reference is gone.
- *
- * Must be called with the hb lock held.
  */
 static void put_pi_state(struct futex_pi_state *pi_state)
 {
@@ -835,16 +833,22 @@ static void put_pi_state(struct futex_pi_state *pi_st=
ate)
 	 * and has cleaned up the pi_state already
 	 */
 	if (pi_state->owner) {
-		raw_spin_lock_irq(&pi_state->owner->pi_lock);
-		list_del_init(&pi_state->list);
-		raw_spin_unlock_irq(&pi_state->owner->pi_lock);
+		struct task_struct *owner;
=20
-		rt_mutex_proxy_unlock(&pi_state->pi_mutex, pi_state->owner);
+		raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
+		owner =3D pi_state->owner;
+		if (owner) {
+			raw_spin_lock(&owner->pi_lock);
+			list_del_init(&pi_state->list);
+			raw_spin_unlock(&owner->pi_lock);
+		}
+		rt_mutex_proxy_unlock(&pi_state->pi_mutex, owner);
+		raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
 	}
=20
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
=20
 		spin_lock(&hb->lock);
-
-		raw_spin_lock_irq(&curr->pi_lock);
+		raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
+		raw_spin_lock(&curr->pi_lock);
 		/*
 		 * We dropped the pi-lock, so re-check whether this
 		 * task still owns the PI-state:
 		 */
 		if (head->next !=3D next) {
-			raw_spin_unlock_irq(&curr->pi_lock);
+			raw_spin_unlock(&curr->pi_lock);
+			raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
 			spin_unlock(&hb->lock);
 			raw_spin_lock_irq(&curr->pi_lock);
 			continue;
@@ -920,9 +925,10 @@ void exit_pi_state_list(struct task_struct *curr)
 		WARN_ON(list_empty(&pi_state->list));
 		list_del_init(&pi_state->list);
 		pi_state->owner =3D NULL;
-		raw_spin_unlock_irq(&curr->pi_lock);
+		raw_spin_unlock(&curr->pi_lock);
=20
 		get_pi_state(pi_state);
+		raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
 		spin_unlock(&hb->lock);
=20
 		rt_mutex_futex_unlock(&pi_state->pi_mutex);
@@ -1204,6 +1210,10 @@ static int attach_to_pi_owner(u32 uval, union futex_=
key *key,
=20
 	WARN_ON(!list_empty(&pi_state->list));
 	list_add(&pi_state->list, &p->pi_state_list);
+	/*
+	 * Assignment without holding pi_state->pi_mutex.wait_lock is safe
+	 * because there is no concurrency as the object is not published yet.
+	 */
 	pi_state->owner =3D p;
 	raw_spin_unlock_irq(&p->pi_lock);
=20
--=20
2.17.1

