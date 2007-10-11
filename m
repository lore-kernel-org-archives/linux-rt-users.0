From: =?UTF-8?B?U8OpYmFzdGllbiBEdWd1w6k=?= <sebastien.dugue@bull.net>
Subject: [PATCH] RT: fix spin_trylock_irq
Date: Thu, 11 Oct 2007 14:24:17 +0200
Message-ID: <20071011142417.1d965820@bull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux RT Users <linux-rt-users@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:60828 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754155AbXJKMYb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Oct 2007 08:24:31 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


  This patch fixes a bug in spin_trylock_irq() where __spin_trylock_irq=
() is
picked for regular (non-raw) spinlocks instead of _spin_trylock_irq().

  This results in systematic boot hangs and may have been going unnotic=
ed
for quite some time as it only manifests (aside from a compile warning)=
 when
booting with a NUMA config or when using the Chelsio T3 (cxgb3) driver =
as
these seems to be the sole users.


Signed-off-by: S=C3=A9bastien Dugu=C3=A9 <sebastien.dugue@bull.net>

---
 include/linux/spinlock.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.23-rc9-rt2/include/linux/spinlock.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23-rc9-rt2.orig/include/linux/spinlock.h
+++ linux-2.6.23-rc9-rt2/include/linux/spinlock.h
@@ -501,7 +501,7 @@ do {									\
=20
 #define spin_trylock_irq(lock)	\
 	__cond_lock(lock, PICK_SPIN_OP_RET(__spin_trylock_irq,		\
-		__spin_trylock_irq, lock))
+		_spin_trylock_irq, lock))
=20
 #define spin_trylock_irqsave(lock, flags) \
 	__cond_lock(lock, PICK_SPIN_OP_RET(__spin_trylock_irqsave, 	\
