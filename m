From: Mike Galbraith <efault@gmx.de>
Subject: Re: [RT] lockdep munching nr_list_entries like popcorn
Date: Thu, 16 Feb 2017 10:27:04 +0100
Message-ID: <1487237224.5258.60.camel@gmx.de>
References: <1487224986.5258.45.camel@gmx.de>
         <alpine.DEB.2.20.1702160933420.3543@nanos>
         <1487235000.5258.48.camel@gmx.de>
         <alpine.DEB.2.20.1702161001100.3543@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.20.1702161001100.3543@nanos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2017-02-16 at 10:01 +0100, Thomas Gleixner wrote:
> On Thu, 16 Feb 2017, Mike Galbraith wrote:
> 
> > On Thu, 2017-02-16 at 09:37 +0100, Thomas Gleixner wrote:
> > > On Thu, 16 Feb 2017, Mike Galbraith wrote:
> > > 
> > ...
> > > > swapvec_lock?  Oodles of 'em?  Nope.
> > > 
> > > Well, it's a per cpu lock and the lru_cache_add() variants might be called
> > > from a gazillion of different call chains, but yes, it does not make a lot
> > > of sense. We'll have a look.
> > 
> > Adding explicit local_irq_lock_init() makes things heaps better, so
> > presumably we need better lockdep-foo in DEFINE_LOCAL_IRQ_LOCK().
> 
> Bah.

Hm, "bah" sounds kinda like it might be a synonym for -EDUMMY :)  Fair
enough, I know spit about about lockdep, so that's likely the case, but
the below has me down to ~17k (and climbing, but not as fast).

berio:/sys/kernel/debug/tracing/:[0]# grep -A 1 'stack trace' trace|grep '=>'|sort|uniq
 => ___slab_alloc+0x171/0x5c0
 => __percpu_counter_add+0x56/0xd0
 => __schedule+0xb0/0x7b0
 => __slab_free+0xd8/0x200
 => cgroup_idr_alloc.constprop.39+0x37/0x80
 => hrtimer_start_range_ns+0xe6/0x400
 => idr_preload+0x6c/0x300
 => jbd2_journal_extend+0x4c/0x310 [jbd2]
 => lock_hrtimer_base.isra.28+0x29/0x50
 => rcu_note_context_switch+0x2b8/0x5c0
 => rcu_report_unblock_qs_rnp+0x6e/0xa0
 => rt_mutex_slowunlock+0x25/0xc0
 => rt_spin_lock_slowlock+0x52/0x330
 => rt_spin_lock_slowlock+0x94/0x330
 => rt_spin_lock_slowunlock+0x3c/0xc0
 => swake_up+0x21/0x40
 => task_blocks_on_rt_mutex+0x42/0x1e0
 => try_to_wake_up+0x2d/0x920

berio:/sys/kernel/debug/tracing/:[0]# grep nr_list_entries: trace|tail -1
 irq/66-eth2-TxR-3670  [115] d....14  1542.321173: add_lock_to_list.isra.24.constprop.42+0x20/0x100: nr_list_entries: 17839

Got rid of the really pesky growth anyway.

--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5522,6 +5522,7 @@ static int __init init_workqueues(void)
 
 	pwq_cache = KMEM_CACHE(pool_workqueue, SLAB_PANIC);
 
+	local_irq_lock_init(pendingb_lock);
 	wq_numa_init();
 
 	/* initialize CPU pools */
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -1677,5 +1677,6 @@ void __init radix_tree_init(void)
 			SLAB_PANIC | SLAB_RECLAIM_ACCOUNT,
 			radix_tree_node_ctor);
 	radix_tree_init_maxnodes();
+	local_irq_lock_init(radix_tree_preloads_lock);
 	hotcpu_notifier(radix_tree_callback, 0);
 }
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5786,6 +5786,7 @@ static int __init mem_cgroup_init(void)
 	int cpu, node;
 
 	hotcpu_notifier(memcg_cpu_hotplug_callback, 0);
+	local_irq_lock_init(event_lock);
 
 	for_each_possible_cpu(cpu)
 		INIT_WORK(&per_cpu_ptr(&memcg_stock, cpu)->work,
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -681,6 +681,14 @@ static inline void remote_lru_add_drain(
 	local_unlock_on(swapvec_lock, cpu);
 }
 
+static int __init lru_init(void)
+{
+	local_irq_lock_init(swapvec_lock);
+	local_irq_lock_init(rotate_lock);
+	return 0;
+}
+early_initcall(lru_init);
+
 #else
 
 /*
--- a/net/netfilter/core.c
+++ b/net/netfilter/core.c
@@ -525,6 +525,7 @@ int __init netfilter_init(void)
 {
 	int ret;
 
+	local_irq_lock_init(xt_write_lock);
 	ret = register_pernet_subsys(&netfilter_net_ops);
 	if (ret < 0)
 		goto err;
