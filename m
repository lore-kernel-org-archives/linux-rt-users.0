From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 5/7] fs: namespace: Use cpu_chill() instead of cpu_relax()
Date: Tue, 13 Mar 2012 22:27:03 -0400
Message-ID: <20120314022945.493350229@goodmis.org>
References: <20120314022658.783312660@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>, stable-rt@vger.kernel.org
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0005-fs-namespace-Use-cpu_chill-instead-of-cpu_relax.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Retry loops on RT might loop forever when the modifying side was
preempted. Use cpu_chill() instead of cpu_relax() to let the system
make progress.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable-rt@vger.kernel.org
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 fs/namespace.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index c563781..3270cde 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -31,6 +31,7 @@
 #include <linux/idr.h>
 #include <linux/fs_struct.h>
 #include <linux/fsnotify.h>
+#include <linux/delay.h>
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
 #include "pnode.h"
@@ -346,7 +347,7 @@ int mnt_want_write(struct vfsmount *mnt)
 	 */
 	while (mnt->mnt_flags & MNT_WRITE_HOLD) {
 		preempt_enable();
-		cpu_relax();
+		cpu_chill();
 		preempt_disable();
 	}
 	/*
-- 
1.7.8.3
