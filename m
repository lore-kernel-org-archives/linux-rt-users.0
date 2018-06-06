Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from Galois.linutronix.de ([146.0.238.70]:50234 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751714AbeFFNb4 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 6 Jun 2018 09:31:56 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/6] futex: Fix more put_pi_state() vs. exit_pi_state_list() races
Date: Wed,  6 Jun 2018 15:31:27 +0200
Message-Id: <20180606133131.7747-3-bigeasy@linutronix.de>
In-Reply-To: <20180606133131.7747-1-bigeasy@linutronix.de>
References: <20180606133131.7747-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: julia@ni.com
Cc: linux-rt-users@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 51d00899f7e6ded15c89cb4e2cb11a35283bac81 ]

Dmitry (through syzbot) reported being able to trigger the WARN in
get_pi_state() and a use-after-free on:

	raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);

Both are due to this race:

  exit_pi_state_list()				put_pi_state()

  lock(&curr->pi_lock)
  while() {
	pi_state =3D list_first_entry(head);
	hb =3D hash_futex(&pi_state->key);
	unlock(&curr->pi_lock);

						dec_and_test(&pi_state->refcount);

	lock(&hb->lock)
	lock(&pi_state->pi_mutex.wait_lock)	// uaf if pi_state free'd
	lock(&curr->pi_lock);

	....

	unlock(&curr->pi_lock);
	get_pi_state();				// WARN; refcount=3D=3D0

The problem is we take the reference count too late, and don't allow it
being 0. Fix it by using inc_not_zero() and simply retrying the loop
when we fail to get a refcount. In that case put_pi_state() should
remove the entry from the list.

Reported-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Gratian Crisan <gratian.crisan@ni.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: dvhart@infradead.org
Cc: syzbot <bot+2af19c9e1ffe4d4ee1d16c56ae7580feaee75765@syzkaller.appspotm=
ail.com>
Cc: syzkaller-bugs@googlegroups.com
Cc: <stable@vger.kernel.org>
Fixes: c74aef2d06a9 ("futex: Fix pi_state->owner serialization")
Link: http://lkml.kernel.org/r/20171031101853.xpfh72y643kdfhjs@hirez.progra=
mming.kicks-ass.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/futex.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 19b016bbcc87..ff7f7a1d9eef 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -899,11 +899,27 @@ void exit_pi_state_list(struct task_struct *curr)
 	 */
 	raw_spin_lock_irq(&curr->pi_lock);
 	while (!list_empty(head)) {
-
 		next =3D head->next;
 		pi_state =3D list_entry(next, struct futex_pi_state, list);
 		key =3D pi_state->key;
 		hb =3D hash_futex(&key);
+
+		/*
+		 * We can race against put_pi_state() removing itself from the
+		 * list (a waiter going away). put_pi_state() will first
+		 * decrement the reference count and then modify the list, so
+		 * its possible to see the list entry but fail this reference
+		 * acquire.
+		 *
+		 * In that case; drop the locks to let put_pi_state() make
+		 * progress and retry the loop.
+		 */
+		if (!atomic_inc_not_zero(&pi_state->refcount)) {
+			raw_spin_unlock_irq(&curr->pi_lock);
+			cpu_relax();
+			raw_spin_lock_irq(&curr->pi_lock);
+			continue;
+		}
 		raw_spin_unlock_irq(&curr->pi_lock);
=20
 		spin_lock(&hb->lock);
@@ -914,10 +930,12 @@ void exit_pi_state_list(struct task_struct *curr)
 		 * task still owns the PI-state:
 		 */
 		if (head->next !=3D next) {
+			/* retain curr->pi_lock for the loop invariant */
 			raw_spin_unlock(&curr->pi_lock);
 			raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
 			spin_unlock(&hb->lock);
 			raw_spin_lock_irq(&curr->pi_lock);
+			put_pi_state(pi_state);
 			continue;
 		}
=20
@@ -925,9 +943,8 @@ void exit_pi_state_list(struct task_struct *curr)
 		WARN_ON(list_empty(&pi_state->list));
 		list_del_init(&pi_state->list);
 		pi_state->owner =3D NULL;
-		raw_spin_unlock(&curr->pi_lock);
=20
-		get_pi_state(pi_state);
+		raw_spin_unlock(&curr->pi_lock);
 		raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
 		spin_unlock(&hb->lock);
=20
--=20
2.17.1

