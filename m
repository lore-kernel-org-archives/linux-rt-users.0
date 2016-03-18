From: Rik van Riel <riel@redhat.com>
Subject: [PATCH -rt] kvm,rt: change async pagefault code locking for
 rt-preempt
Date: Fri, 18 Mar 2016 14:20:52 -0400
Message-ID: <20160318142052.0605524d@annuminas.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: williams@redhat.com, srostedt@redhat.com
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34919 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751260AbcCRSV0 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 18 Mar 2016 14:21:26 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id E122E804E0
	for <linux-rt-users@vger.kernel.org>; Fri, 18 Mar 2016 18:21:25 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The async pagefault wake code can run from the idle task in exception
context, so everything here needs to be made non-preemptible.

Conversion to a simple wait queue and raw spinlock does the trick.

Signed-off-by: Rik van Riel <riel@redhat.com>
---
 arch/x86/kernel/kvm.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 47190bd399e7..185404175acb 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -36,6 +36,7 @@
 #include <linux/kprobes.h>
 #include <linux/debugfs.h>
 #include <linux/nmi.h>
+#include <linux/wait-simple.h>
 #include <asm/timer.h>
 #include <asm/cpu.h>
 #include <asm/traps.h>
@@ -91,14 +92,14 @@ static void kvm_io_delay(void)
 
 struct kvm_task_sleep_node {
 	struct hlist_node link;
-	wait_queue_head_t wq;
+	struct swait_head wq;
 	u32 token;
 	int cpu;
 	bool halted;
 };
 
 static struct kvm_task_sleep_head {
-	spinlock_t lock;
+	raw_spinlock_t lock;
 	struct hlist_head list;
 } async_pf_sleepers[KVM_TASK_SLEEP_HASHSIZE];
 
@@ -122,17 +123,17 @@ void kvm_async_pf_task_wait(u32 token)
 	u32 key = hash_32(token, KVM_TASK_SLEEP_HASHBITS);
 	struct kvm_task_sleep_head *b = &async_pf_sleepers[key];
 	struct kvm_task_sleep_node n, *e;
-	DEFINE_WAIT(wait);
+	DEFINE_SWAITER(wait);
 
 	rcu_irq_enter();
 
-	spin_lock(&b->lock);
+	raw_spin_lock(&b->lock);
 	e = _find_apf_task(b, token);
 	if (e) {
 		/* dummy entry exist -> wake up was delivered ahead of PF */
 		hlist_del(&e->link);
 		kfree(e);
-		spin_unlock(&b->lock);
+		raw_spin_unlock(&b->lock);
 
 		rcu_irq_exit();
 		return;
@@ -141,13 +142,13 @@ void kvm_async_pf_task_wait(u32 token)
 	n.token = token;
 	n.cpu = smp_processor_id();
 	n.halted = is_idle_task(current) || preempt_count() > 1;
-	init_waitqueue_head(&n.wq);
+	init_swait_head(&n.wq);
 	hlist_add_head(&n.link, &b->list);
-	spin_unlock(&b->lock);
+	raw_spin_unlock(&b->lock);
 
 	for (;;) {
 		if (!n.halted)
-			prepare_to_wait(&n.wq, &wait, TASK_UNINTERRUPTIBLE);
+			swait_prepare(&n.wq, &wait, TASK_UNINTERRUPTIBLE);
 		if (hlist_unhashed(&n.link))
 			break;
 
@@ -166,7 +167,7 @@ void kvm_async_pf_task_wait(u32 token)
 		}
 	}
 	if (!n.halted)
-		finish_wait(&n.wq, &wait);
+		swait_finish(&n.wq, &wait);
 
 	rcu_irq_exit();
 	return;
@@ -178,8 +179,8 @@ static void apf_task_wake_one(struct kvm_task_sleep_node *n)
 	hlist_del_init(&n->link);
 	if (n->halted)
 		smp_send_reschedule(n->cpu);
-	else if (waitqueue_active(&n->wq))
-		wake_up(&n->wq);
+	else if (swaitqueue_active(&n->wq))
+		swait_wake(&n->wq);
 }
 
 static void apf_task_wake_all(void)
@@ -189,14 +190,14 @@ static void apf_task_wake_all(void)
 	for (i = 0; i < KVM_TASK_SLEEP_HASHSIZE; i++) {
 		struct hlist_node *p, *next;
 		struct kvm_task_sleep_head *b = &async_pf_sleepers[i];
-		spin_lock(&b->lock);
+		raw_spin_lock(&b->lock);
 		hlist_for_each_safe(p, next, &b->list) {
 			struct kvm_task_sleep_node *n =
 				hlist_entry(p, typeof(*n), link);
 			if (n->cpu == smp_processor_id())
 				apf_task_wake_one(n);
 		}
-		spin_unlock(&b->lock);
+		raw_spin_unlock(&b->lock);
 	}
 }
 
@@ -212,7 +213,7 @@ void kvm_async_pf_task_wake(u32 token)
 	}
 
 again:
-	spin_lock(&b->lock);
+	raw_spin_lock(&b->lock);
 	n = _find_apf_task(b, token);
 	if (!n) {
 		/*
@@ -225,17 +226,17 @@ void kvm_async_pf_task_wake(u32 token)
 			 * Allocation failed! Busy wait while other cpu
 			 * handles async PF.
 			 */
-			spin_unlock(&b->lock);
+			raw_spin_unlock(&b->lock);
 			cpu_relax();
 			goto again;
 		}
 		n->token = token;
 		n->cpu = smp_processor_id();
-		init_waitqueue_head(&n->wq);
+		init_swait_head(&n->wq);
 		hlist_add_head(&n->link, &b->list);
 	} else
 		apf_task_wake_one(n);
-	spin_unlock(&b->lock);
+	raw_spin_unlock(&b->lock);
 	return;
 }
 EXPORT_SYMBOL_GPL(kvm_async_pf_task_wake);
@@ -486,7 +487,7 @@ void __init kvm_guest_init(void)
 	paravirt_ops_setup();
 	register_reboot_notifier(&kvm_pv_reboot_nb);
 	for (i = 0; i < KVM_TASK_SLEEP_HASHSIZE; i++)
-		spin_lock_init(&async_pf_sleepers[i].lock);
+		raw_spin_lock_init(&async_pf_sleepers[i].lock);
 	if (kvm_para_has_feature(KVM_FEATURE_ASYNC_PF))
 		x86_init.irqs.trap_init = kvm_apf_trap_init;
 
