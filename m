From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 3.0.41-rt62
Date: Thu, 30 Aug 2012 14:24:57 -0400
Message-ID: <1346351097.3198.5.camel@acer.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Dear RT Folks,

I'm pleased to announce the 3.0.41-rt62 stable release.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  Head SHA1: 27770766f5425b466d3a61025350f9829840e5e9


Or to build 3.0.41-rt62 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.0/linux-3.0.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.0/patch-3.0.41.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.0/patch-3.0.41-rt62.patch.xz


You can also build from 3.0.41-rt61 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.0/incr/patch-3.0.41-rt61-rt62.patch.xz



Enjoy,

-- Steve


Changes from 3.0.41-rt61:

---

Frank Rowand (1):
      fix printk flush of messages

Steven Rostedt (1):
      Linux 3.0.41-rt62

----
 kernel/printk.c |    2 +-
 localversion-rt |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
---------------------------
diff --git a/kernel/printk.c b/kernel/printk.c
index 60f4290..f2c459f 100644
--- a/kernel/printk.c
+++ b/kernel/printk.c
@@ -835,7 +835,7 @@ static int console_trylock_for_printk(unsigned int cpu, unsigned long flags)
 {
 #ifdef CONFIG_PREEMPT_RT_FULL
 	int lock = (!early_boot_irqs_disabled && !irqs_disabled_flags(flags) &&
-		!preempt_count()) || sysrq_in_progress;
+		(preempt_count() <= 1)) || sysrq_in_progress;
 #else
 	int lock = 1;
 #endif
diff --git a/localversion-rt b/localversion-rt
index 9b7de93..40d81d8 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt61
+-rt62
