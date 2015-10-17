From: Thomas Gleixner <tglx@linutronix.de>
Subject: [ANNOUNCE] v4.1.10-rt10
Date: Sat, 17 Oct 2015 18:08:17 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1510171807160.4212@nanos>
References: <alpine.DEB.2.11.1510171235210.4212@nanos>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Sebastian Sewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.11.1510171235210.4212@nanos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

With proper subject line this time!

Dear RT folks!

I'm pleased to announce the v4.1.10-rt10 patch set. v4.1.10-rt9 is a
non-announced update to incorporate the linux-4.1.y stable tree
changes.

Changes since v4.1.10-rt9:

 Ben Hutchings (1):
      work-simple: Add missing #include <linux/export.h>

 Grygorii Strashko (1):
      net/core/cpuhotplug: Drain input_pkt_queue lockless

 Thomas Gleixner (2):
      arm64/xen: Make XEN depend on !RT
      v4.1.10-rt10

 Yang Shi (2):
      arm64: Convert patch_lock to raw lock
      arm64: Replace read_lock to rcu lock in call_break_hook

Known issues:

 - bcache stays disabled

 - CPU hotplug is not better than before

 - The netlink_release() OOPS, reported by Clark, is still on the
   list, but unsolved due to lack of information

The delta patch against 4.1.10-rt10 is appended below and can be found here:

   https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.1/incr/patch-4.1.10-rt9-rt10.patch.xz

You can get this release via the git tree at:

   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.1.10-rt10

The RT patch against 4.1.10 can be found here:

   https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.1/patch-4.1.10-rt10.patch.xz

The split quilt queue is available at:

   https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.1/patches-4.1.10-rt10.tar.xz
   
Enjoy!
    
 	tglx
    
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 2cc65a6f4bbd..09a41259b984 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -601,7 +601,7 @@ config XEN_DOM0
 
 config XEN
 	bool "Xen guest support on ARM64"
-	depends on ARM64 && OF
+	depends on ARM64 && OF && !PREEMPT_RT_FULL
 	select SWIOTLB_XEN
 	help
 	  Say Y if you want to run Linux in a Virtual Machine on Xen on ARM64.
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index b056369fd47d..70654d843d9b 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -271,20 +271,21 @@ static int single_step_handler(unsigned long addr, unsigned int esr,
  * Use reader/writer locks instead of plain spinlock.
  */
 static LIST_HEAD(break_hook);
-static DEFINE_RWLOCK(break_hook_lock);
+static DEFINE_SPINLOCK(break_hook_lock);
 
 void register_break_hook(struct break_hook *hook)
 {
-	write_lock(&break_hook_lock);
-	list_add(&hook->node, &break_hook);
-	write_unlock(&break_hook_lock);
+	spin_lock(&break_hook_lock);
+	list_add_rcu(&hook->node, &break_hook);
+	spin_unlock(&break_hook_lock);
 }
 
 void unregister_break_hook(struct break_hook *hook)
 {
-	write_lock(&break_hook_lock);
-	list_del(&hook->node);
-	write_unlock(&break_hook_lock);
+	spin_lock(&break_hook_lock);
+	list_del_rcu(&hook->node);
+	spin_unlock(&break_hook_lock);
+	synchronize_rcu();
 }
 
 static int call_break_hook(struct pt_regs *regs, unsigned int esr)
@@ -292,11 +293,11 @@ static int call_break_hook(struct pt_regs *regs, unsigned int esr)
 	struct break_hook *hook;
 	int (*fn)(struct pt_regs *regs, unsigned int esr) = NULL;
 
-	read_lock(&break_hook_lock);
-	list_for_each_entry(hook, &break_hook, node)
+	rcu_read_lock();
+	list_for_each_entry_rcu(hook, &break_hook, node)
 		if ((esr & hook->esr_mask) == hook->esr_val)
 			fn = hook->fn;
-	read_unlock(&break_hook_lock);
+	rcu_read_unlock();
 
 	return fn ? fn(regs, esr) : DBG_HOOK_ERROR;
 }
diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
index 924902083e47..30eb88e5b896 100644
--- a/arch/arm64/kernel/insn.c
+++ b/arch/arm64/kernel/insn.c
@@ -77,7 +77,7 @@ bool __kprobes aarch64_insn_is_nop(u32 insn)
 	}
 }
 
-static DEFINE_SPINLOCK(patch_lock);
+static DEFINE_RAW_SPINLOCK(patch_lock);
 
 static void __kprobes *patch_map(void *addr, int fixmap)
 {
@@ -124,13 +124,13 @@ static int __kprobes __aarch64_insn_write(void *addr, u32 insn)
 	unsigned long flags = 0;
 	int ret;
 
-	spin_lock_irqsave(&patch_lock, flags);
+	raw_spin_lock_irqsave(&patch_lock, flags);
 	waddr = patch_map(addr, FIX_TEXT_POKE0);
 
 	ret = probe_kernel_write(waddr, &insn, AARCH64_INSN_SIZE);
 
 	patch_unmap(FIX_TEXT_POKE0);
-	spin_unlock_irqrestore(&patch_lock, flags);
+	raw_spin_unlock_irqrestore(&patch_lock, flags);
 
 	return ret;
 }
diff --git a/kernel/sched/work-simple.c b/kernel/sched/work-simple.c
index c996f755dba6..e57a0522573f 100644
--- a/kernel/sched/work-simple.c
+++ b/kernel/sched/work-simple.c
@@ -10,6 +10,7 @@
 #include <linux/kthread.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/export.h>
 
 #define SWORK_EVENT_PENDING     (1 << 0)
 
diff --git a/localversion-rt b/localversion-rt
index 22746d6390a4..d79dde624aaa 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt9
+-rt10
diff --git a/net/core/dev.c b/net/core/dev.c
index 4969c0d3dd67..f8c23dee5ae9 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -7217,7 +7217,7 @@ static int dev_cpu_callback(struct notifier_block *nfb,
 		netif_rx_ni(skb);
 		input_queue_head_incr(oldsd);
 	}
-	while ((skb = skb_dequeue(&oldsd->input_pkt_queue))) {
+	while ((skb = __skb_dequeue(&oldsd->input_pkt_queue))) {
 		netif_rx_ni(skb);
 		input_queue_head_incr(oldsd);
 	}
