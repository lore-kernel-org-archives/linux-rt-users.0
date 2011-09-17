From: Maarten Lankhorst <m.b.lankhorst@gmail.com>
Subject: sleeping function called from invalid context with memory cgroups
Date: Sat, 17 Sep 2011 10:42:53 +0200
Message-ID: <4E745D8D.1090207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f45.google.com ([209.85.215.45]:33013 "EHLO
	mail-ew0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751735Ab1IQIus (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 17 Sep 2011 04:50:48 -0400
Received: by ewy28 with SMTP id 28so104648ewy.4
        for <linux-rt-users@vger.kernel.org>; Sat, 17 Sep 2011 01:50:47 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Anyone else seeing warnings like this with memory cgroups used?

I triggered it with running some tasks and stuffing this in my .bashrc
if [ "$PS1" ] ; then  
    mkdir -m 0700 /sys/fs/cgroup/memory/user/$$
    echo $$ > /sys/fs/cgroup/memory/user/$$/tasks
    echo $((4096 * 1024 * 1024)) >>  /sys/fs/cgroup/memory/user/$$/memory.soft_limit_in_bytes
    echo $((6144 * 1024 * 1024)) >> /sys/fs/cgroup/memory/user/$$/memory.limit_in_bytes
fi

BUG: sleeping function called from invalid context at kernel/rtmutex.c:645
in_atomic(): 1, irqs_disabled(): 0, pid: 5276, name: bash
Pid: 5276, comm: bash Tainted: P        WC  3.0.4-rt14-patser+ #40
Call Trace:
 [<ffffffff8103fe2a>] __might_sleep+0xca/0xf0
 [<ffffffff815dcfc4>] rt_spin_lock+0x24/0x40
 [<ffffffff810ab611>] res_counter_uncharge+0x31/0x60
 [<ffffffff811438d0>] drain_stock+0x50/0x80
 [<ffffffff8114878e>] __mem_cgroup_try_charge.constprop.29+0x33e/0x5a0
 [<ffffffff81148a46>] mem_cgroup_charge_common+0x56/0x90
 [<ffffffff815e06ed>] ? sub_preempt_count+0x9d/0xd0
 [<ffffffff81149746>] mem_cgroup_newpage_charge+0x46/0x50
 [<ffffffff811198a1>] do_wp_page+0x151/0x730
 [<ffffffff8111b3f4>] handle_pte_fault+0x2d4/0x9c0
 [<ffffffff81049171>] ? get_parent_ip+0x11/0x50
 [<ffffffff8111bd72>] handle_mm_fault+0x132/0x1e0
 [<ffffffff815dc115>] ? rt_mutex_trylock+0x75/0xc0
 [<ffffffff815e0311>] do_page_fault+0x221/0x560
 [<ffffffff815e06ed>] ? sub_preempt_count+0x9d/0xd0
 [<ffffffff8104bd87>] ? migrate_enable+0x87/0x280
 [<ffffffff81159fb2>] ? path_put+0x22/0x30
 [<ffffffff815dd94f>] page_fault+0x1f/0x30

Also fun in this one, I suspect the lock just has to be converted.

BUG: sleeping function called from invalid context at kernel/rtmutex.c:645
in_atomic(): 1, irqs_disabled(): 0, pid: 5726, name: steam
Pid: 5726, comm: steam Tainted: P        WC  3.0.4-rt14-patser+ #40
Call Trace:
 [<ffffffff8103fe2a>] __might_sleep+0xca/0xf0
 [<ffffffff815dcfc4>] rt_spin_lock+0x24/0x40
 [<ffffffff810ab611>] res_counter_uncharge+0x31/0x60
 [<ffffffff811438d0>] drain_stock+0x50/0x80
 [<ffffffff8114878e>] __mem_cgroup_try_charge.constprop.29+0x33e/0x5a0
 [<ffffffff815dd488>] ? _raw_spin_unlock+0x18/0x40
 [<ffffffff81049171>] ? get_parent_ip+0x11/0x50
 [<ffffffff81049171>] ? get_parent_ip+0x11/0x50
 [<ffffffff8114996c>] mem_cgroup_cache_charge+0x14c/0x190
 [<ffffffff810f5a2a>] add_to_page_cache_locked+0x4a/0x130
 [<ffffffff810f5b3f>] add_to_page_cache_lru+0x2f/0x80
 [<ffffffff81188d82>] mpage_readpages+0xc2/0x140
 [<ffffffff811cf5c0>] ? noalloc_get_block_write+0x30/0x30
 [<ffffffff81045761>] ? find_busiest_group+0x171/0xbd0
 [<ffffffff810fe88a>] ? __alloc_pages_nodemask+0xfa/0x7d0
 [<ffffffff810ee6d0>] ? __perf_event_task_sched_out+0x40/0x290
 [<ffffffff81043d9c>] ? check_preempt_curr+0x9c/0xb0
 [<ffffffff8104270e>] ? perf_event_task_sched_out+0x2e/0xa0
 [<ffffffff811ca73d>] ext4_readpages+0x1d/0x20
 [<ffffffff81100ee2>] __do_page_cache_readahead+0x1d2/0x270
 [<ffffffff812f1fbb>] ? radix_tree_lookup+0xb/0x10
 [<ffffffff8110148f>] ondemand_readahead+0x19f/0x260
 [<ffffffff81101634>] page_cache_sync_readahead+0x34/0x50
 [<ffffffff810f72a8>] generic_file_aio_read+0x458/0x7c0
 [<ffffffff8114ea52>] do_sync_read+0xd2/0x110
 [<ffffffff81049171>] ? get_parent_ip+0x11/0x50
 [<ffffffff8104bd87>] ? migrate_enable+0x87/0x280
 [<ffffffff8106aaac>] ? set_current_blocked+0x5c/0x70
 [<ffffffff8106ab0a>] ? sigprocmask+0x4a/0x90
 [<ffffffff8114f253>] vfs_read+0xb3/0x180
 [<ffffffff8114f36d>] sys_read+0x4d/0x90
 [<ffffffff815e51b9>] sysenter_dispatch+0x7/0x27

Convert res_counter lock to raw spinlock.

Signed-off-by: Maarten Lankhorst <m.b.lankhorst@gmail.com>

diff --git a/include/linux/res_counter.h b/include/linux/res_counter.h
index c9d625c..7612284 100644
--- a/include/linux/res_counter.h
+++ b/include/linux/res_counter.h
@@ -46,7 +46,7 @@ struct res_counter {
 	 * the lock to protect all of the above.
 	 * the routines below consider this to be IRQ-safe
 	 */
-	spinlock_t lock;
+	raw_spinlock_t lock;
 	/*
 	 * Parent counter, used for hierarchial resource accounting
 	 */
@@ -141,9 +141,9 @@ static inline unsigned long long res_counter_margin(struct res_counter *cnt)
 	unsigned long long margin;
 	unsigned long flags;
 
-	spin_lock_irqsave(&cnt->lock, flags);
+	raw_spin_lock_irqsave(&cnt->lock, flags);
 	margin = cnt->limit - cnt->usage;
-	spin_unlock_irqrestore(&cnt->lock, flags);
+	raw_spin_unlock_irqrestore(&cnt->lock, flags);
 	return margin;
 }
 
@@ -160,12 +160,12 @@ res_counter_soft_limit_excess(struct res_counter *cnt)
 	unsigned long long excess;
 	unsigned long flags;
 
-	spin_lock_irqsave(&cnt->lock, flags);
+	raw_spin_lock_irqsave(&cnt->lock, flags);
 	if (cnt->usage <= cnt->soft_limit)
 		excess = 0;
 	else
 		excess = cnt->usage - cnt->soft_limit;
-	spin_unlock_irqrestore(&cnt->lock, flags);
+	raw_spin_unlock_irqrestore(&cnt->lock, flags);
 	return excess;
 }
 
@@ -173,18 +173,18 @@ static inline void res_counter_reset_max(struct res_counter *cnt)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&cnt->lock, flags);
+	raw_spin_lock_irqsave(&cnt->lock, flags);
 	cnt->max_usage = cnt->usage;
-	spin_unlock_irqrestore(&cnt->lock, flags);
+	raw_spin_unlock_irqrestore(&cnt->lock, flags);
 }
 
 static inline void res_counter_reset_failcnt(struct res_counter *cnt)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&cnt->lock, flags);
+	raw_spin_lock_irqsave(&cnt->lock, flags);
 	cnt->failcnt = 0;
-	spin_unlock_irqrestore(&cnt->lock, flags);
+	raw_spin_unlock_irqrestore(&cnt->lock, flags);
 }
 
 static inline int res_counter_set_limit(struct res_counter *cnt,
@@ -193,12 +193,12 @@ static inline int res_counter_set_limit(struct res_counter *cnt,
 	unsigned long flags;
 	int ret = -EBUSY;
 
-	spin_lock_irqsave(&cnt->lock, flags);
+	raw_spin_lock_irqsave(&cnt->lock, flags);
 	if (cnt->usage <= limit) {
 		cnt->limit = limit;
 		ret = 0;
 	}
-	spin_unlock_irqrestore(&cnt->lock, flags);
+	raw_spin_unlock_irqrestore(&cnt->lock, flags);
 	return ret;
 }
 
@@ -208,9 +208,9 @@ res_counter_set_soft_limit(struct res_counter *cnt,
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&cnt->lock, flags);
+	raw_spin_lock_irqsave(&cnt->lock, flags);
 	cnt->soft_limit = soft_limit;
-	spin_unlock_irqrestore(&cnt->lock, flags);
+	raw_spin_unlock_irqrestore(&cnt->lock, flags);
 	return 0;
 }
 
diff --git a/kernel/res_counter.c b/kernel/res_counter.c
index 21e9ec4..acaa932 100644
--- a/kernel/res_counter.c
+++ b/kernel/res_counter.c
@@ -16,7 +16,7 @@
 
 void res_counter_init(struct res_counter *counter, struct res_counter *parent)
 {
-	spin_lock_init(&counter->lock);
+	raw_spin_lock_init(&counter->lock);
 	counter->limit = RESOURCE_MAX;
 	counter->soft_limit = RESOURCE_MAX;
 	counter->parent = parent;
@@ -43,11 +43,11 @@ int res_counter_charge(struct res_counter *counter, unsigned long val,
 	struct res_counter *c, *u;
 
 	*limit_fail_at = NULL;
-	local_irq_save_nort(flags);
+	local_irq_save(flags);
 	for (c = counter; c != NULL; c = c->parent) {
-		spin_lock(&c->lock);
+		raw_spin_lock(&c->lock);
 		ret = res_counter_charge_locked(c, val);
-		spin_unlock(&c->lock);
+		raw_spin_unlock(&c->lock);
 		if (ret < 0) {
 			*limit_fail_at = c;
 			goto undo;
@@ -57,12 +57,12 @@ int res_counter_charge(struct res_counter *counter, unsigned long val,
 	goto done;
 undo:
 	for (u = counter; u != c; u = u->parent) {
-		spin_lock(&u->lock);
+		raw_spin_lock(&u->lock);
 		res_counter_uncharge_locked(u, val);
-		spin_unlock(&u->lock);
+		raw_spin_unlock(&u->lock);
 	}
 done:
-	local_irq_restore_nort(flags);
+	local_irq_restore(flags);
 	return ret;
 }
 
@@ -79,13 +79,13 @@ void res_counter_uncharge(struct res_counter *counter, unsigned long val)
 	unsigned long flags;
 	struct res_counter *c;
 
-	local_irq_save_nort(flags);
+	local_irq_save(flags);
 	for (c = counter; c != NULL; c = c->parent) {
-		spin_lock(&c->lock);
+		raw_spin_lock(&c->lock);
 		res_counter_uncharge_locked(c, val);
-		spin_unlock(&c->lock);
+		raw_spin_unlock(&c->lock);
 	}
-	local_irq_restore_nort(flags);
+	local_irq_restore(flags);
 }
 
 
@@ -132,9 +132,9 @@ u64 res_counter_read_u64(struct res_counter *counter, int member)
 	unsigned long flags;
 	u64 ret;
 
-	spin_lock_irqsave(&counter->lock, flags);
+	raw_spin_lock_irqsave(&counter->lock, flags);
 	ret = *res_counter_member(counter, member);
-	spin_unlock_irqrestore(&counter->lock, flags);
+	raw_spin_unlock_irqrestore(&counter->lock, flags);
 
 	return ret;
 }
@@ -183,9 +183,9 @@ int res_counter_write(struct res_counter *counter, int member,
 		if (*end != '\0')
 			return -EINVAL;
 	}
-	spin_lock_irqsave(&counter->lock, flags);
+	raw_spin_lock_irqsave(&counter->lock, flags);
 	val = res_counter_member(counter, member);
 	*val = tmp;
-	spin_unlock_irqrestore(&counter->lock, flags);
+	raw_spin_unlock_irqrestore(&counter->lock, flags);
 	return 0;
 }


