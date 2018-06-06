Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from Galois.linutronix.de ([146.0.238.70]:50238 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751921AbeFFNb5 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 6 Jun 2018 09:31:57 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 4/6] futex: Fix OWNER_DEAD fixup
Date: Wed,  6 Jun 2018 15:31:29 +0200
Message-Id: <20180606133131.7747-5-bigeasy@linutronix.de>
In-Reply-To: <20180606133131.7747-1-bigeasy@linutronix.de>
References: <20180606133131.7747-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: julia@ni.com
Cc: linux-rt-users@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit a97cb0e7b3f4c6297fd857055ae8e895f402f501 ]

Both Geert and DaveJ reported that the recent futex commit:

  c1e2f0eaf015 ("futex: Avoid violating the 10th rule of futex")

introduced a problem with setting OWNER_DEAD. We set the bit on an
uninitialized variable and then entirely optimize it away as a
dead-store.

Move the setting of the bit to where it is more useful.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reported-by: Dave Jones <davej@codemonkey.org.uk>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@us.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: c1e2f0eaf015 ("futex: Avoid violating the 10th rule of futex")
Link: http://lkml.kernel.org/r/20180122103947.GD2228@hirez.programming.kick=
s-ass.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/futex.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 925b5e005926..73814d9d0197 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2262,9 +2262,6 @@ static int fixup_pi_state_owner(u32 __user *uaddr, st=
ruct futex_q *q,
 	raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
=20
 	oldowner =3D pi_state->owner;
-	/* Owner died? */
-	if (!pi_state->owner)
-		newtid |=3D FUTEX_OWNER_DIED;
=20
 	/*
 	 * We are here because either:
@@ -2325,6 +2322,9 @@ static int fixup_pi_state_owner(u32 __user *uaddr, st=
ruct futex_q *q,
 	}
=20
 	newtid =3D task_pid_vnr(newowner) | FUTEX_WAITERS;
+	/* Owner died? */
+	if (!pi_state->owner)
+		newtid |=3D FUTEX_OWNER_DIED;
=20
 	if (get_futex_value_locked(&uval, uaddr))
 		goto handle_fault;
--=20
2.17.1

