From: John Kacur <jkacur@redhat.com>
Subject: [PATCH-rt] Revert "kprobes: adjust "fix a memory leak in function pre_handler_kretprobe()""
Date: Thu, 15 Mar 2012 18:00:38 +0100
Message-ID: <1331830838-28945-1-git-send-email-jkacur@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	lkml <linux-kernel@vger.kernel.org>,
	John Kacur <jkacur@redhat.com>
To: rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:34222 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161096Ab2CORAp (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 15 Mar 2012 13:00:45 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This reverts commit b8a0040ef7112439ad2efac6f1a79aa842b5924f.

Because rt pulls in 7b8d0e5, the above fix which comes from v3.0.24
should not be applied. kretprobe is a raw_spinlock_t for real-time.

Before the revert we get the following compile errors

kernel/kprobes.c:1664: warning: passing argument 1 of =E2=80=98rt_spin_=
lock=E2=80=99 from incompatible pointer type
kernel/kprobes.c:1666: warning: passing argument 1 of =E2=80=98rt_spin_=
unlock=E2=80=99 from incompatible pointer type

Note: This patch is for v3.0.24-rt42-rc1

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 kernel/kprobes.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index a7dcf06..9cdbf26 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1661,9 +1661,9 @@ static int __kprobes pre_handler_kretprobe(struct=
 kprobe *p,
 		ri->task =3D current;
=20
 		if (rp->entry_handler && rp->entry_handler(ri, regs)) {
-			spin_lock_irqsave(&rp->lock, flags);
+			raw_spin_lock_irqsave(&rp->lock, flags);
 			hlist_add_head(&ri->hlist, &rp->free_instances);
-			spin_unlock_irqrestore(&rp->lock, flags);
+			raw_spin_unlock_irqrestore(&rp->lock, flags);
 			return 0;
 		}
=20
--=20
1.7.2.3

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
