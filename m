From: =?UTF-8?B?U8OpYmFzdGllbiBEdWd1w6k=?= <sebastien.dugue@bull.net>
Subject: [PATCH RT] Fix RT balancing tasks pulling
Date: Tue, 24 Jul 2007 15:42:02 +0200
Message-ID: <20070724154202.224f12e8@frecb000686.frec.bull.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jean Pierre Dion <jean-pierre.dion@bull.net>,
	Darren Hart <dvhltc@us.ibm.com>,
	john stultz <johnstul@us.ibm.com>,
	Josh Triplett <josht@linux.vnet.ibm.com>
To: Linux RT Users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:53062 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758322AbXGXNoh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 Jul 2007 09:44:37 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



  Hi Ingo, Thomas,

  this one-liner fixes a bug in balance_rt_tasks() which sometimes mani=
fests by
having a lower prio task being scheduled while a higher prio task is si=
tting
waiting on another runqueue.

  This is pretty hard to reproduce on low cpu count machines, for examp=
le, I
had to have sched_football run in a loop for ~38h before it failed on a=
 dual HT
Xeon box.

  S=C3=A9bastien.

---


  In the CPU loop in balance_rt_tasks(), the 'next' task pointer is onl=
y ever
updated if this_rq->lock has been dropped in double_lock_balance().

  This sometimes lead to 'this_cpu' pulling tasks that are only garante=
ed to
have a higher priority than the 'next' picked before the loop.

  Fix this to update 'next' to the last picked RT task.


Signed-off-by: S=C3=A9bastien Dugu=C3=A9 <sebastien.dugue@bull.net>

---
 kernel/sched.c |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: linux-2.6.22.1-rt6/kernel/sched.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.22.1-rt6.orig/kernel/sched.c	2007-07-24 11:34:18.00000000=
0 +0200
+++ linux-2.6.22.1-rt6/kernel/sched.c	2007-07-24 11:34:35.000000000 +02=
00
@@ -1499,6 +1499,14 @@ static void balance_rt_tasks(struct rq *
 			 * in another runqueue. (low likelyhood
 			 * but possible)
 			 */
+
+			/*
+			 * Update next so that we won't pick a task
+			 * on another cpu with a priority lower (or equal)
+			 * than the one we just picked.
+			 */
+			next =3D p;
+
 		}
 		spin_unlock(&src_rq->lock);
 	}
