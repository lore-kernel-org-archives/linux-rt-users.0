From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 1/3] Revert "kprobes: adjust "fix a memory leak in function
 pre_handler_kretprobe()""
Date: Wed, 21 Mar 2012 22:33:10 -0400
Message-ID: <20120322023454.688981968@goodmis.org>
References: <20120322023309.083011587@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0001-Revert-kprobes-adjust-fix-a-memory-leak-in-function-.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Steven Rostedt <srostedt@redhat.com>

This reverts commit b8a0040ef7112439ad2efac6f1a79aa842b5924f.

As pointed out by John Kacur, the patch breaks 3.0-rt.

Because rt pulls in 7b8d0e5, the above fix which comes from v3.0.24
should not be applied. kretprobe is a raw_spinlock_t for real-time.

Before the revert we get the following compile errors

kernel/kprobes.c:1664: warning: passing argument 1 of 'rt_spin_lock' from incompatible pointer type
kernel/kprobes.c:1666: warning: passing argument 1 of 'rt_spin_unlock' from incompatible pointer type

Signed-off-by: John Kacur <jkacur@redhat.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/kprobes.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index a7dcf06..9cdbf26 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1661,9 +1661,9 @@ static int __kprobes pre_handler_kretprobe(struct kprobe *p,
 		ri->task = current;
 
 		if (rp->entry_handler && rp->entry_handler(ri, regs)) {
-			spin_lock_irqsave(&rp->lock, flags);
+			raw_spin_lock_irqsave(&rp->lock, flags);
 			hlist_add_head(&ri->hlist, &rp->free_instances);
-			spin_unlock_irqrestore(&rp->lock, flags);
+			raw_spin_unlock_irqrestore(&rp->lock, flags);
 			return 0;
 		}
 
-- 
1.7.8.3
