From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 3.2.83-rt121
Date: Tue, 8 Nov 2016 18:01:48 -0500
Message-ID: <20161108180148.096f2b03@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Dear RT Folks,

I'm pleased to announce the 3.2.83-rt121 stable release.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v3.2-rt
  Head SHA1: 761b76bd5e59d1320f0e66d8d86b583c9a5854a0


Or to build 3.2.83-rt121 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.2.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.2.83.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.2/patch-3.2.83-rt121.patch.xz



You can also build from 3.2.83-rt120 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.2/incr/patch-3.2.83-rt120-rt121.patch.xz



Enjoy,

-- Steve


Changes from v3.2.83-rt120:

---

Ben Hutchings (2):
      genirq: Fix pointer cast warning for randomness on 32-bit architectures
      work-simple: Add missing #include <linux/export.h>

Steven Rostedt (Red Hat) (1):
      Linux 3.2.83-rt121

----
 kernel/irq/manage.c  | 3 ++-
 kernel/work-simple.c | 1 +
 localversion-rt      | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)
---------------------------
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index c4677795d7c8..b1683ba80c88 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -897,7 +897,8 @@ static int irq_thread(void *data)
 #ifdef CONFIG_PREEMPT_RT_FULL
 			migrate_disable();
 			add_interrupt_randomness(action->irq, 0,
-						 desc->random_ip ^ (u64) action);
+						 desc->random_ip ^
+						 (unsigned long) action);
 			migrate_enable();
 #endif
 		}
diff --git a/kernel/work-simple.c b/kernel/work-simple.c
index c996f755dba6..e57a0522573f 100644
--- a/kernel/work-simple.c
+++ b/kernel/work-simple.c
@@ -10,6 +10,7 @@
 #include <linux/kthread.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/export.h>
 
 #define SWORK_EVENT_PENDING     (1 << 0)
 
diff --git a/localversion-rt b/localversion-rt
index fff72aad59ab..8188d85cffe0 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt120
+-rt121
