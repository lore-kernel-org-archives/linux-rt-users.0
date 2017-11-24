From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] mm/slub: enable IRQs once scheduling is working
Date: Fri, 24 Nov 2017 10:35:12 +0100
Message-ID: <20171124093512.GA2564@linutronix.de>
References: <CADF-jezvVP2O++FR2KiRSSSJF7oObjy8LSP3-yj1HCmxyTzB_Q@mail.gmail.com>
 <20171102165009.u7a7ahmmywo2qugd@linutronix.de>
 <CADF-jexLs9vRuiuoRmcA+0L6Mp-XxW75okheWV+ipGf1b_Ua1w@mail.gmail.com>
 <59FC4393.8030005@mcst.ru>
 <5A01812F.7040406@mcst.ru>
 <20171116160837.hfpnq4vb4j2osbuz@linutronix.de>
 <20171117173820.GM872@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Pavel V. Panteleev" <panteleev_p@mcst.ru>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
To: Julia Cartwright <julia@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:46429 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752563AbdKXJfU (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 24 Nov 2017 04:35:20 -0500
Content-Disposition: inline
In-Reply-To: <20171117173820.GM872@jcartwri.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Pavel V. Panteleev reported that a WARN_ON_ONCE(p->migrate_disable <= 0)
triggered in 3.14.79-rt85 during boot from radix_tree_insert().
The problem is that radix_tree_insert() allocates memory and SLUB does
not enable interrupts in allocate_slab().
They can't be be enabled unconditionally because early in the boot
process they have to remain off. Enabling them at the "SYSTEM_RUNNING"
state is too late. The earliest point is once we have scheduling
working that is once the kthread is running.

In newer -RT (v4.11+) there is the check
	if (system_state > SYSTEM_BOOTING)

to enable interrupts in the allocator which is what this patch intends:
Once scheduling is working enable interrupts in the allocator path so we
can take sleeping locks.

Reported-by: "Pavel V. Panteleev" <panteleev_p@mcst.ru>
Tested-by: "Pavel V. Panteleev" <panteleev_p@mcst.ru>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 init/main.c | 2 ++
 mm/slub.c   | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/init/main.c b/init/main.c
index 6470deef01c9..362761effeac 100644
--- a/init/main.c
+++ b/init/main.c
@@ -379,6 +379,7 @@ static void __init setup_command_line(char *command_line)
  */
 
 static __initdata DECLARE_COMPLETION(kthreadd_done);
+extern bool slab_do_irq_on;
 
 static noinline void __ref rest_init(void)
 {
@@ -396,6 +397,7 @@ static noinline void __ref rest_init(void)
 	rcu_read_lock();
 	kthreadd_task = find_task_by_pid_ns(pid, &init_pid_ns);
 	rcu_read_unlock();
+	slab_do_irq_on = true;
 	complete(&kthreadd_done);
 
 	/*
diff --git a/mm/slub.c b/mm/slub.c
index 67eb368b9314..22ec805130e5 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1527,6 +1527,7 @@ static inline bool shuffle_freelist(struct kmem_cache *s, struct page *page)
 	return false;
 }
 #endif /* CONFIG_SLAB_FREELIST_RANDOM */
+bool slab_do_irq_on;
 
 static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 {
@@ -1543,7 +1544,7 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 	if (gfpflags_allow_blocking(flags))
 		enableirqs = true;
 #ifdef CONFIG_PREEMPT_RT_FULL
-	if (system_state == SYSTEM_RUNNING)
+	if (slab_do_irq_on)
 		enableirqs = true;
 #endif
 	if (enableirqs)
-- 
2.15.0

