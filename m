Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D21C433EF
	for <linux-rt-users@archiver.kernel.org>; Wed, 22 Jun 2022 11:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiFVLFn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 22 Jun 2022 07:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353631AbiFVLFc (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 22 Jun 2022 07:05:32 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5180C3BBD2
        for <linux-rt-users@vger.kernel.org>; Wed, 22 Jun 2022 04:05:28 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id EEC0F61F111A;
        Wed, 22 Jun 2022 13:05:26 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id JHIo7sj0P1jM; Wed, 22 Jun 2022 13:05:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 9DE0A61B8B69;
        Wed, 22 Jun 2022 13:05:24 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id AD_wxIbpFI-u; Wed, 22 Jun 2022 13:05:24 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 4EE5361B8B4F;
        Wed, 22 Jun 2022 13:05:24 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-rt-users@vger.kernel.org
Cc:     williams@redhat.com, bigeasy@linutronix.de,
        Michal Hocko <mhocko@kernel.org>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Richard Weinberger <richard@nod.at>
Subject: [v5.15 1/4] mm/memcg: Disable threshold event handlers on PREEMPT_RT
Date:   Wed, 22 Jun 2022 13:05:03 +0200
Message-Id: <20220622110506.10534-2-richard@nod.at>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220622110506.10534-1-richard@nod.at>
References: <20220622110506.10534-1-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

During the integration of PREEMPT_RT support, the code flow around
memcg_check_events() resulted in `twisted code'. Moving the code around
and avoiding then would then lead to an additional local-irq-save
section within memcg_check_events(). While looking better, it adds a
local-irq-save section to code flow which is usually within an
local-irq-off block on non-PREEMPT_RT configurations.

The threshold event handler is a deprecated memcg v1 feature. Instead of
trying to get it to work under PREEMPT_RT just disable it. There should
be no users on PREEMPT_RT. From that perspective it makes even less
sense to get it to work under PREEMPT_RT while having zero users.

Make memory.soft_limit_in_bytes and cgroup.event_control return
-EOPNOTSUPP on PREEMPT_RT. Make an empty memcg_check_events() and
memcg_write_event_control() which return only -EOPNOTSUPP on PREEMPT_RT.
Document that the two knobs are disabled on PREEMPT_RT. Shuffle the code around
so that all unused function are in on #ifdef block.

Suggested-by: Michal Hocko <mhocko@kernel.org>
Suggested-by: Michal Koutný <mkoutny@suse.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
[rw: backported to v5.15]
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 mm/memcontrol.c | 1120 ++++++++++++++++++++++++-----------------------
 1 file changed, 568 insertions(+), 552 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 971546bb99e0..10081957d525 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -169,7 +169,6 @@ struct mem_cgroup_event {
 	struct work_struct remove;
 };
 
-static void mem_cgroup_threshold(struct mem_cgroup *memcg);
 static void mem_cgroup_oom_notify(struct mem_cgroup *memcg);
 
 /* Stuffs for move charges at task migration. */
@@ -451,28 +450,12 @@ ino_t page_cgroup_ino(struct page *page)
 	return ino;
 }
 
-static struct mem_cgroup_per_node *
-mem_cgroup_page_nodeinfo(struct mem_cgroup *memcg, struct page *page)
-{
-	int nid = page_to_nid(page);
-
-	return memcg->nodeinfo[nid];
-}
-
 static struct mem_cgroup_tree_per_node *
 soft_limit_tree_node(int nid)
 {
 	return soft_limit_tree.rb_tree_per_node[nid];
 }
 
-static struct mem_cgroup_tree_per_node *
-soft_limit_tree_from_page(struct page *page)
-{
-	int nid = page_to_nid(page);
-
-	return soft_limit_tree.rb_tree_per_node[nid];
-}
-
 static void __mem_cgroup_insert_exceeded(struct mem_cgroup_per_node *mz,
 					 struct mem_cgroup_tree_per_node *mctz,
 					 unsigned long new_usage_in_excess)
@@ -543,43 +526,6 @@ static unsigned long soft_limit_excess(struct mem_cgroup *memcg)
 	return excess;
 }
 
-static void mem_cgroup_update_tree(struct mem_cgroup *memcg, struct page *page)
-{
-	unsigned long excess;
-	struct mem_cgroup_per_node *mz;
-	struct mem_cgroup_tree_per_node *mctz;
-
-	mctz = soft_limit_tree_from_page(page);
-	if (!mctz)
-		return;
-	/*
-	 * Necessary to update all ancestors when hierarchy is used.
-	 * because their event counter is not touched.
-	 */
-	for (; memcg; memcg = parent_mem_cgroup(memcg)) {
-		mz = mem_cgroup_page_nodeinfo(memcg, page);
-		excess = soft_limit_excess(memcg);
-		/*
-		 * We have to update the tree if mz is on RB-tree or
-		 * mem is over its softlimit.
-		 */
-		if (excess || mz->on_tree) {
-			unsigned long flags;
-
-			spin_lock_irqsave(&mctz->lock, flags);
-			/* if on-tree, remove it */
-			if (mz->on_tree)
-				__mem_cgroup_remove_exceeded(mz, mctz);
-			/*
-			 * Insert again. mz->usage_in_excess will be updated.
-			 * If excess is 0, no tree ops.
-			 */
-			__mem_cgroup_insert_exceeded(mz, mctz, excess);
-			spin_unlock_irqrestore(&mctz->lock, flags);
-		}
-	}
-}
-
 static void mem_cgroup_remove_from_trees(struct mem_cgroup *memcg)
 {
 	struct mem_cgroup_tree_per_node *mctz;
@@ -878,50 +824,6 @@ static void mem_cgroup_charge_statistics(struct mem_cgroup *memcg,
 	__this_cpu_add(memcg->vmstats_percpu->nr_page_events, nr_pages);
 }
 
-static bool mem_cgroup_event_ratelimit(struct mem_cgroup *memcg,
-				       enum mem_cgroup_events_target target)
-{
-	unsigned long val, next;
-
-	val = __this_cpu_read(memcg->vmstats_percpu->nr_page_events);
-	next = __this_cpu_read(memcg->vmstats_percpu->targets[target]);
-	/* from time_after() in jiffies.h */
-	if ((long)(next - val) < 0) {
-		switch (target) {
-		case MEM_CGROUP_TARGET_THRESH:
-			next = val + THRESHOLDS_EVENTS_TARGET;
-			break;
-		case MEM_CGROUP_TARGET_SOFTLIMIT:
-			next = val + SOFTLIMIT_EVENTS_TARGET;
-			break;
-		default:
-			break;
-		}
-		__this_cpu_write(memcg->vmstats_percpu->targets[target], next);
-		return true;
-	}
-	return false;
-}
-
-/*
- * Check events in order.
- *
- */
-static void memcg_check_events(struct mem_cgroup *memcg, struct page *page)
-{
-	/* threshold event is triggered in finer grain than soft limit */
-	if (unlikely(mem_cgroup_event_ratelimit(memcg,
-						MEM_CGROUP_TARGET_THRESH))) {
-		bool do_softlimit;
-
-		do_softlimit = mem_cgroup_event_ratelimit(memcg,
-						MEM_CGROUP_TARGET_SOFTLIMIT);
-		mem_cgroup_threshold(memcg);
-		if (unlikely(do_softlimit))
-			mem_cgroup_update_tree(memcg, page);
-	}
-}
-
 struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p)
 {
 	/*
@@ -3816,8 +3718,12 @@ static ssize_t mem_cgroup_write(struct kernfs_open_file *of,
 		}
 		break;
 	case RES_SOFT_LIMIT:
+#ifndef CONFIG_PREEMPT_RT
 		memcg->soft_limit = nr_pages;
 		ret = 0;
+#else
+		ret = -EOPNOTSUPP;
+#endif
 		break;
 	}
 	return ret ?: nbytes;
@@ -4122,82 +4028,6 @@ static int mem_cgroup_swappiness_write(struct cgroup_subsys_state *css,
 	return 0;
 }
 
-static void __mem_cgroup_threshold(struct mem_cgroup *memcg, bool swap)
-{
-	struct mem_cgroup_threshold_ary *t;
-	unsigned long usage;
-	int i;
-
-	rcu_read_lock();
-	if (!swap)
-		t = rcu_dereference(memcg->thresholds.primary);
-	else
-		t = rcu_dereference(memcg->memsw_thresholds.primary);
-
-	if (!t)
-		goto unlock;
-
-	usage = mem_cgroup_usage(memcg, swap);
-
-	/*
-	 * current_threshold points to threshold just below or equal to usage.
-	 * If it's not true, a threshold was crossed after last
-	 * call of __mem_cgroup_threshold().
-	 */
-	i = t->current_threshold;
-
-	/*
-	 * Iterate backward over array of thresholds starting from
-	 * current_threshold and check if a threshold is crossed.
-	 * If none of thresholds below usage is crossed, we read
-	 * only one element of the array here.
-	 */
-	for (; i >= 0 && unlikely(t->entries[i].threshold > usage); i--)
-		eventfd_signal(t->entries[i].eventfd, 1);
-
-	/* i = current_threshold + 1 */
-	i++;
-
-	/*
-	 * Iterate forward over array of thresholds starting from
-	 * current_threshold+1 and check if a threshold is crossed.
-	 * If none of thresholds above usage is crossed, we read
-	 * only one element of the array here.
-	 */
-	for (; i < t->size && unlikely(t->entries[i].threshold <= usage); i++)
-		eventfd_signal(t->entries[i].eventfd, 1);
-
-	/* Update current_threshold */
-	t->current_threshold = i - 1;
-unlock:
-	rcu_read_unlock();
-}
-
-static void mem_cgroup_threshold(struct mem_cgroup *memcg)
-{
-	while (memcg) {
-		__mem_cgroup_threshold(memcg, false);
-		if (do_memsw_account())
-			__mem_cgroup_threshold(memcg, true);
-
-		memcg = parent_mem_cgroup(memcg);
-	}
-}
-
-static int compare_thresholds(const void *a, const void *b)
-{
-	const struct mem_cgroup_threshold *_a = a;
-	const struct mem_cgroup_threshold *_b = b;
-
-	if (_a->threshold > _b->threshold)
-		return 1;
-
-	if (_a->threshold < _b->threshold)
-		return -1;
-
-	return 0;
-}
-
 static int mem_cgroup_oom_notify_cb(struct mem_cgroup *memcg)
 {
 	struct mem_cgroup_eventfd_list *ev;
@@ -4219,105 +4049,446 @@ static void mem_cgroup_oom_notify(struct mem_cgroup *memcg)
 		mem_cgroup_oom_notify_cb(iter);
 }
 
-static int __mem_cgroup_usage_register_event(struct mem_cgroup *memcg,
-	struct eventfd_ctx *eventfd, const char *args, enum res_type type)
+static int mem_cgroup_oom_control_read(struct seq_file *sf, void *v)
 {
-	struct mem_cgroup_thresholds *thresholds;
-	struct mem_cgroup_threshold_ary *new;
-	unsigned long threshold;
-	unsigned long usage;
-	int i, size, ret;
+	struct mem_cgroup *memcg = mem_cgroup_from_seq(sf);
 
-	ret = page_counter_memparse(args, "-1", &threshold);
-	if (ret)
-		return ret;
+	seq_printf(sf, "oom_kill_disable %d\n", memcg->oom_kill_disable);
+	seq_printf(sf, "under_oom %d\n", (bool)memcg->under_oom);
+	seq_printf(sf, "oom_kill %lu\n",
+		   atomic_long_read(&memcg->memory_events[MEMCG_OOM_KILL]));
+	return 0;
+}
 
-	mutex_lock(&memcg->thresholds_lock);
+static int mem_cgroup_oom_control_write(struct cgroup_subsys_state *css,
+	struct cftype *cft, u64 val)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
 
-	if (type == _MEM) {
-		thresholds = &memcg->thresholds;
-		usage = mem_cgroup_usage(memcg, false);
-	} else if (type == _MEMSWAP) {
-		thresholds = &memcg->memsw_thresholds;
-		usage = mem_cgroup_usage(memcg, true);
-	} else
-		BUG();
+	/* cannot set to root cgroup and only 0 and 1 are allowed */
+	if (mem_cgroup_is_root(memcg) || !((val == 0) || (val == 1)))
+		return -EINVAL;
 
-	/* Check if a threshold crossed before adding a new one */
-	if (thresholds->primary)
-		__mem_cgroup_threshold(memcg, type == _MEMSWAP);
+	memcg->oom_kill_disable = val;
+	if (!val)
+		memcg_oom_recover(memcg);
 
-	size = thresholds->primary ? thresholds->primary->size + 1 : 1;
+	return 0;
+}
 
-	/* Allocate memory for new array of thresholds */
-	new = kmalloc(struct_size(new, entries, size), GFP_KERNEL);
-	if (!new) {
-		ret = -ENOMEM;
-		goto unlock;
-	}
-	new->size = size;
+#ifdef CONFIG_CGROUP_WRITEBACK
 
-	/* Copy thresholds (if any) to new array */
-	if (thresholds->primary)
-		memcpy(new->entries, thresholds->primary->entries,
-		       flex_array_size(new, entries, size - 1));
+#include <trace/events/writeback.h>
 
-	/* Add new threshold */
-	new->entries[size - 1].eventfd = eventfd;
-	new->entries[size - 1].threshold = threshold;
+static int memcg_wb_domain_init(struct mem_cgroup *memcg, gfp_t gfp)
+{
+	return wb_domain_init(&memcg->cgwb_domain, gfp);
+}
 
-	/* Sort thresholds. Registering of new threshold isn't time-critical */
-	sort(new->entries, size, sizeof(*new->entries),
-			compare_thresholds, NULL);
+static void memcg_wb_domain_exit(struct mem_cgroup *memcg)
+{
+	wb_domain_exit(&memcg->cgwb_domain);
+}
 
-	/* Find current threshold */
-	new->current_threshold = -1;
-	for (i = 0; i < size; i++) {
-		if (new->entries[i].threshold <= usage) {
-			/*
-			 * new->current_threshold will not be used until
-			 * rcu_assign_pointer(), so it's safe to increment
-			 * it here.
-			 */
-			++new->current_threshold;
-		} else
+static void memcg_wb_domain_size_changed(struct mem_cgroup *memcg)
+{
+	wb_domain_size_changed(&memcg->cgwb_domain);
+}
+
+struct wb_domain *mem_cgroup_wb_domain(struct bdi_writeback *wb)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(wb->memcg_css);
+
+	if (!memcg->css.parent)
+		return NULL;
+
+	return &memcg->cgwb_domain;
+}
+
+/**
+ * mem_cgroup_wb_stats - retrieve writeback related stats from its memcg
+ * @wb: bdi_writeback in question
+ * @pfilepages: out parameter for number of file pages
+ * @pheadroom: out parameter for number of allocatable pages according to memcg
+ * @pdirty: out parameter for number of dirty pages
+ * @pwriteback: out parameter for number of pages under writeback
+ *
+ * Determine the numbers of file, headroom, dirty, and writeback pages in
+ * @wb's memcg.  File, dirty and writeback are self-explanatory.  Headroom
+ * is a bit more involved.
+ *
+ * A memcg's headroom is "min(max, high) - used".  In the hierarchy, the
+ * headroom is calculated as the lowest headroom of itself and the
+ * ancestors.  Note that this doesn't consider the actual amount of
+ * available memory in the system.  The caller should further cap
+ * *@pheadroom accordingly.
+ */
+void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
+			 unsigned long *pheadroom, unsigned long *pdirty,
+			 unsigned long *pwriteback)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(wb->memcg_css);
+	struct mem_cgroup *parent;
+
+	mem_cgroup_flush_stats();
+
+	*pdirty = memcg_page_state(memcg, NR_FILE_DIRTY);
+	*pwriteback = memcg_page_state(memcg, NR_WRITEBACK);
+	*pfilepages = memcg_page_state(memcg, NR_INACTIVE_FILE) +
+			memcg_page_state(memcg, NR_ACTIVE_FILE);
+
+	*pheadroom = PAGE_COUNTER_MAX;
+	while ((parent = parent_mem_cgroup(memcg))) {
+		unsigned long ceiling = min(READ_ONCE(memcg->memory.max),
+					    READ_ONCE(memcg->memory.high));
+		unsigned long used = page_counter_read(&memcg->memory);
+
+		*pheadroom = min(*pheadroom, ceiling - min(ceiling, used));
+		memcg = parent;
+	}
+}
+
+/*
+ * Foreign dirty flushing
+ *
+ * There's an inherent mismatch between memcg and writeback.  The former
+ * tracks ownership per-page while the latter per-inode.  This was a
+ * deliberate design decision because honoring per-page ownership in the
+ * writeback path is complicated, may lead to higher CPU and IO overheads
+ * and deemed unnecessary given that write-sharing an inode across
+ * different cgroups isn't a common use-case.
+ *
+ * Combined with inode majority-writer ownership switching, this works well
+ * enough in most cases but there are some pathological cases.  For
+ * example, let's say there are two cgroups A and B which keep writing to
+ * different but confined parts of the same inode.  B owns the inode and
+ * A's memory is limited far below B's.  A's dirty ratio can rise enough to
+ * trigger balance_dirty_pages() sleeps but B's can be low enough to avoid
+ * triggering background writeback.  A will be slowed down without a way to
+ * make writeback of the dirty pages happen.
+ *
+ * Conditions like the above can lead to a cgroup getting repeatedly and
+ * severely throttled after making some progress after each
+ * dirty_expire_interval while the underlying IO device is almost
+ * completely idle.
+ *
+ * Solving this problem completely requires matching the ownership tracking
+ * granularities between memcg and writeback in either direction.  However,
+ * the more egregious behaviors can be avoided by simply remembering the
+ * most recent foreign dirtying events and initiating remote flushes on
+ * them when local writeback isn't enough to keep the memory clean enough.
+ *
+ * The following two functions implement such mechanism.  When a foreign
+ * page - a page whose memcg and writeback ownerships don't match - is
+ * dirtied, mem_cgroup_track_foreign_dirty() records the inode owning
+ * bdi_writeback on the page owning memcg.  When balance_dirty_pages()
+ * decides that the memcg needs to sleep due to high dirty ratio, it calls
+ * mem_cgroup_flush_foreign() which queues writeback on the recorded
+ * foreign bdi_writebacks which haven't expired.  Both the numbers of
+ * recorded bdi_writebacks and concurrent in-flight foreign writebacks are
+ * limited to MEMCG_CGWB_FRN_CNT.
+ *
+ * The mechanism only remembers IDs and doesn't hold any object references.
+ * As being wrong occasionally doesn't matter, updates and accesses to the
+ * records are lockless and racy.
+ */
+void mem_cgroup_track_foreign_dirty_slowpath(struct page *page,
+					     struct bdi_writeback *wb)
+{
+	struct mem_cgroup *memcg = page_memcg(page);
+	struct memcg_cgwb_frn *frn;
+	u64 now = get_jiffies_64();
+	u64 oldest_at = now;
+	int oldest = -1;
+	int i;
+
+	trace_track_foreign_dirty(page, wb);
+
+	/*
+	 * Pick the slot to use.  If there is already a slot for @wb, keep
+	 * using it.  If not replace the oldest one which isn't being
+	 * written out.
+	 */
+	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++) {
+		frn = &memcg->cgwb_frn[i];
+		if (frn->bdi_id == wb->bdi->id &&
+		    frn->memcg_id == wb->memcg_css->id)
 			break;
+		if (time_before64(frn->at, oldest_at) &&
+		    atomic_read(&frn->done.cnt) == 1) {
+			oldest = i;
+			oldest_at = frn->at;
+		}
+	}
+
+	if (i < MEMCG_CGWB_FRN_CNT) {
+		/*
+		 * Re-using an existing one.  Update timestamp lazily to
+		 * avoid making the cacheline hot.  We want them to be
+		 * reasonably up-to-date and significantly shorter than
+		 * dirty_expire_interval as that's what expires the record.
+		 * Use the shorter of 1s and dirty_expire_interval / 8.
+		 */
+		unsigned long update_intv =
+			min_t(unsigned long, HZ,
+			      msecs_to_jiffies(dirty_expire_interval * 10) / 8);
+
+		if (time_before64(frn->at, now - update_intv))
+			frn->at = now;
+	} else if (oldest >= 0) {
+		/* replace the oldest free one */
+		frn = &memcg->cgwb_frn[oldest];
+		frn->bdi_id = wb->bdi->id;
+		frn->memcg_id = wb->memcg_css->id;
+		frn->at = now;
 	}
+}
+
+/* issue foreign writeback flushes for recorded foreign dirtying events */
+void mem_cgroup_flush_foreign(struct bdi_writeback *wb)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(wb->memcg_css);
+	unsigned long intv = msecs_to_jiffies(dirty_expire_interval * 10);
+	u64 now = jiffies_64;
+	int i;
+
+	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++) {
+		struct memcg_cgwb_frn *frn = &memcg->cgwb_frn[i];
+
+		/*
+		 * If the record is older than dirty_expire_interval,
+		 * writeback on it has already started.  No need to kick it
+		 * off again.  Also, don't start a new one if there's
+		 * already one in flight.
+		 */
+		if (time_after64(frn->at, now - intv) &&
+		    atomic_read(&frn->done.cnt) == 1) {
+			frn->at = 0;
+			trace_flush_foreign(wb, frn->bdi_id, frn->memcg_id);
+			cgroup_writeback_by_id(frn->bdi_id, frn->memcg_id,
+					       WB_REASON_FOREIGN_FLUSH,
+					       &frn->done);
+		}
+	}
+}
+
+#else	/* CONFIG_CGROUP_WRITEBACK */
+
+static int memcg_wb_domain_init(struct mem_cgroup *memcg, gfp_t gfp)
+{
+	return 0;
+}
+
+static void memcg_wb_domain_exit(struct mem_cgroup *memcg)
+{
+}
+
+static void memcg_wb_domain_size_changed(struct mem_cgroup *memcg)
+{
+}
+
+#endif	/* CONFIG_CGROUP_WRITEBACK */
+
+
+#ifndef CONFIG_PREEMPT_RT
+/*
+ * DO NOT USE IN NEW FILES.
+ *
+ * "cgroup.event_control" implementation.
+ *
+ * This is way over-engineered.  It tries to support fully configurable
+ * events for each user.  Such level of flexibility is completely
+ * unnecessary especially in the light of the planned unified hierarchy.
+ *
+ * Please deprecate this and replace with something simpler if at all
+ * possible.
+ */
+
+static struct mem_cgroup_tree_per_node *
+soft_limit_tree_from_page(struct page *page)
+{
+	int nid = page_to_nid(page);
+
+	return soft_limit_tree.rb_tree_per_node[nid];
+}
+
+static struct mem_cgroup_per_node *
+mem_cgroup_page_nodeinfo(struct mem_cgroup *memcg, struct page *page)
+{
+	int nid = page_to_nid(page);
+
+	return memcg->nodeinfo[nid];
+}
+
+static void mem_cgroup_update_tree(struct mem_cgroup *memcg, struct page *page)
+{
+	unsigned long excess;
+	struct mem_cgroup_per_node *mz;
+	struct mem_cgroup_tree_per_node *mctz;
+
+	mctz = soft_limit_tree_from_page(page);
+	if (!mctz)
+		return;
+	/*
+	 * Necessary to update all ancestors when hierarchy is used.
+	 * because their event counter is not touched.
+	 */
+	for (; memcg; memcg = parent_mem_cgroup(memcg)) {
+		mz = mem_cgroup_page_nodeinfo(memcg, page);
+		excess = soft_limit_excess(memcg);
+		/*
+		 * We have to update the tree if mz is on RB-tree or
+		 * mem is over its softlimit.
+		 */
+		if (excess || mz->on_tree) {
+			unsigned long flags;
+
+			spin_lock_irqsave(&mctz->lock, flags);
+			/* if on-tree, remove it */
+			if (mz->on_tree)
+				__mem_cgroup_remove_exceeded(mz, mctz);
+			/*
+			 * Insert again. mz->usage_in_excess will be updated.
+			 * If excess is 0, no tree ops.
+			 */
+			__mem_cgroup_insert_exceeded(mz, mctz, excess);
+			spin_unlock_irqrestore(&mctz->lock, flags);
+		}
+	}
+}
+
+static bool mem_cgroup_event_ratelimit(struct mem_cgroup *memcg,
+				       enum mem_cgroup_events_target target)
+{
+	unsigned long val, next;
+
+	val = __this_cpu_read(memcg->vmstats_percpu->nr_page_events);
+	next = __this_cpu_read(memcg->vmstats_percpu->targets[target]);
+	/* from time_after() in jiffies.h */
+	if ((long)(next - val) < 0) {
+		switch (target) {
+		case MEM_CGROUP_TARGET_THRESH:
+			next = val + THRESHOLDS_EVENTS_TARGET;
+			break;
+		case MEM_CGROUP_TARGET_SOFTLIMIT:
+			next = val + SOFTLIMIT_EVENTS_TARGET;
+			break;
+		default:
+			break;
+		}
+		__this_cpu_write(memcg->vmstats_percpu->targets[target], next);
+		return true;
+	}
+	return false;
+}
+
+static void __mem_cgroup_threshold(struct mem_cgroup *memcg, bool swap)
+{
+	struct mem_cgroup_threshold_ary *t;
+	unsigned long usage;
+	int i;
+
+	rcu_read_lock();
+	if (!swap)
+		t = rcu_dereference(memcg->thresholds.primary);
+	else
+		t = rcu_dereference(memcg->memsw_thresholds.primary);
+
+	if (!t)
+		goto unlock;
+
+	usage = mem_cgroup_usage(memcg, swap);
+
+	/*
+	 * current_threshold points to threshold just below or equal to usage.
+	 * If it's not true, a threshold was crossed after last
+	 * call of __mem_cgroup_threshold().
+	 */
+	i = t->current_threshold;
+
+	/*
+	 * Iterate backward over array of thresholds starting from
+	 * current_threshold and check if a threshold is crossed.
+	 * If none of thresholds below usage is crossed, we read
+	 * only one element of the array here.
+	 */
+	for (; i >= 0 && unlikely(t->entries[i].threshold > usage); i--)
+		eventfd_signal(t->entries[i].eventfd, 1);
+
+	/* i = current_threshold + 1 */
+	i++;
+
+	/*
+	 * Iterate forward over array of thresholds starting from
+	 * current_threshold+1 and check if a threshold is crossed.
+	 * If none of thresholds above usage is crossed, we read
+	 * only one element of the array here.
+	 */
+	for (; i < t->size && unlikely(t->entries[i].threshold <= usage); i++)
+		eventfd_signal(t->entries[i].eventfd, 1);
+
+	/* Update current_threshold */
+	t->current_threshold = i - 1;
+unlock:
+	rcu_read_unlock();
+}
+
+static void mem_cgroup_threshold(struct mem_cgroup *memcg)
+{
+	while (memcg) {
+		__mem_cgroup_threshold(memcg, false);
+		if (do_memsw_account())
+			__mem_cgroup_threshold(memcg, true);
 
-	/* Free old spare buffer and save old primary buffer as spare */
-	kfree(thresholds->spare);
-	thresholds->spare = thresholds->primary;
+		memcg = parent_mem_cgroup(memcg);
+	}
+}
 
-	rcu_assign_pointer(thresholds->primary, new);
+static int compare_thresholds(const void *a, const void *b)
+{
+	const struct mem_cgroup_threshold *_a = a;
+	const struct mem_cgroup_threshold *_b = b;
 
-	/* To be sure that nobody uses thresholds */
-	synchronize_rcu();
+	if (_a->threshold > _b->threshold)
+		return 1;
 
-unlock:
-	mutex_unlock(&memcg->thresholds_lock);
+	if (_a->threshold < _b->threshold)
+		return -1;
 
-	return ret;
+	return 0;
 }
 
-static int mem_cgroup_usage_register_event(struct mem_cgroup *memcg,
-	struct eventfd_ctx *eventfd, const char *args)
+/*
+ * Check events in order.
+ *
+ */
+static void memcg_check_events(struct mem_cgroup *memcg, struct page *page)
 {
-	return __mem_cgroup_usage_register_event(memcg, eventfd, args, _MEM);
-}
+	/* threshold event is triggered in finer grain than soft limit */
+	if (unlikely(mem_cgroup_event_ratelimit(memcg,
+						MEM_CGROUP_TARGET_THRESH))) {
+		bool do_softlimit;
 
-static int memsw_cgroup_usage_register_event(struct mem_cgroup *memcg,
-	struct eventfd_ctx *eventfd, const char *args)
-{
-	return __mem_cgroup_usage_register_event(memcg, eventfd, args, _MEMSWAP);
+		do_softlimit = mem_cgroup_event_ratelimit(memcg,
+						MEM_CGROUP_TARGET_SOFTLIMIT);
+		mem_cgroup_threshold(memcg);
+		if (unlikely(do_softlimit))
+			mem_cgroup_update_tree(memcg, page);
+	}
 }
 
-static void __mem_cgroup_usage_unregister_event(struct mem_cgroup *memcg,
-	struct eventfd_ctx *eventfd, enum res_type type)
+static int __mem_cgroup_usage_register_event(struct mem_cgroup *memcg,
+	struct eventfd_ctx *eventfd, const char *args, enum res_type type)
 {
 	struct mem_cgroup_thresholds *thresholds;
 	struct mem_cgroup_threshold_ary *new;
+	unsigned long threshold;
 	unsigned long usage;
-	int i, j, size, entries;
+	int i, size, ret;
+
+	ret = page_counter_memparse(args, "-1", &threshold);
+	if (ret)
+		return ret;
 
 	mutex_lock(&memcg->thresholds_lock);
 
@@ -4330,56 +4501,49 @@ static void __mem_cgroup_usage_unregister_event(struct mem_cgroup *memcg,
 	} else
 		BUG();
 
-	if (!thresholds->primary)
-		goto unlock;
+	/* Check if a threshold crossed before adding a new one */
+	if (thresholds->primary)
+		__mem_cgroup_threshold(memcg, type == _MEMSWAP);
 
-	/* Check if a threshold crossed before removing */
-	__mem_cgroup_threshold(memcg, type == _MEMSWAP);
+	size = thresholds->primary ? thresholds->primary->size + 1 : 1;
 
-	/* Calculate new number of threshold */
-	size = entries = 0;
-	for (i = 0; i < thresholds->primary->size; i++) {
-		if (thresholds->primary->entries[i].eventfd != eventfd)
-			size++;
-		else
-			entries++;
+	/* Allocate memory for new array of thresholds */
+	new = kmalloc(struct_size(new, entries, size), GFP_KERNEL);
+	if (!new) {
+		ret = -ENOMEM;
+		goto unlock;
 	}
+	new->size = size;
 
-	new = thresholds->spare;
-
-	/* If no items related to eventfd have been cleared, nothing to do */
-	if (!entries)
-		goto unlock;
+	/* Copy thresholds (if any) to new array */
+	if (thresholds->primary)
+		memcpy(new->entries, thresholds->primary->entries,
+		       flex_array_size(new, entries, size - 1));
 
-	/* Set thresholds array to NULL if we don't have thresholds */
-	if (!size) {
-		kfree(new);
-		new = NULL;
-		goto swap_buffers;
-	}
+	/* Add new threshold */
+	new->entries[size - 1].eventfd = eventfd;
+	new->entries[size - 1].threshold = threshold;
 
-	new->size = size;
+	/* Sort thresholds. Registering of new threshold isn't time-critical */
+	sort(new->entries, size, sizeof(*new->entries),
+			compare_thresholds, NULL);
 
-	/* Copy thresholds and find current threshold */
+	/* Find current threshold */
 	new->current_threshold = -1;
-	for (i = 0, j = 0; i < thresholds->primary->size; i++) {
-		if (thresholds->primary->entries[i].eventfd == eventfd)
-			continue;
-
-		new->entries[j] = thresholds->primary->entries[i];
-		if (new->entries[j].threshold <= usage) {
+	for (i = 0; i < size; i++) {
+		if (new->entries[i].threshold <= usage) {
 			/*
-			 * new->current_threshold will not be used
-			 * until rcu_assign_pointer(), so it's safe to increment
+			 * new->current_threshold will not be used until
+			 * rcu_assign_pointer(), so it's safe to increment
 			 * it here.
 			 */
 			++new->current_threshold;
-		}
-		j++;
+		} else
+			break;
 	}
 
-swap_buffers:
-	/* Swap primary and spare array */
+	/* Free old spare buffer and save old primary buffer as spare */
+	kfree(thresholds->spare);
 	thresholds->spare = thresholds->primary;
 
 	rcu_assign_pointer(thresholds->primary, new);
@@ -4387,318 +4551,160 @@ static void __mem_cgroup_usage_unregister_event(struct mem_cgroup *memcg,
 	/* To be sure that nobody uses thresholds */
 	synchronize_rcu();
 
-	/* If all events are unregistered, free the spare array */
-	if (!new) {
-		kfree(thresholds->spare);
-		thresholds->spare = NULL;
-	}
 unlock:
 	mutex_unlock(&memcg->thresholds_lock);
-}
-
-static void mem_cgroup_usage_unregister_event(struct mem_cgroup *memcg,
-	struct eventfd_ctx *eventfd)
-{
-	return __mem_cgroup_usage_unregister_event(memcg, eventfd, _MEM);
-}
 
-static void memsw_cgroup_usage_unregister_event(struct mem_cgroup *memcg,
-	struct eventfd_ctx *eventfd)
-{
-	return __mem_cgroup_usage_unregister_event(memcg, eventfd, _MEMSWAP);
+	return ret;
 }
 
-static int mem_cgroup_oom_register_event(struct mem_cgroup *memcg,
+static int mem_cgroup_usage_register_event(struct mem_cgroup *memcg,
 	struct eventfd_ctx *eventfd, const char *args)
 {
-	struct mem_cgroup_eventfd_list *event;
-
-	event = kmalloc(sizeof(*event),	GFP_KERNEL);
-	if (!event)
-		return -ENOMEM;
-
-	spin_lock(&memcg_oom_lock);
-
-	event->eventfd = eventfd;
-	list_add(&event->list, &memcg->oom_notify);
-
-	/* already in OOM ? */
-	if (memcg->under_oom)
-		eventfd_signal(eventfd, 1);
-	spin_unlock(&memcg_oom_lock);
-
-	return 0;
-}
-
-static void mem_cgroup_oom_unregister_event(struct mem_cgroup *memcg,
-	struct eventfd_ctx *eventfd)
-{
-	struct mem_cgroup_eventfd_list *ev, *tmp;
-
-	spin_lock(&memcg_oom_lock);
-
-	list_for_each_entry_safe(ev, tmp, &memcg->oom_notify, list) {
-		if (ev->eventfd == eventfd) {
-			list_del(&ev->list);
-			kfree(ev);
-		}
-	}
-
-	spin_unlock(&memcg_oom_lock);
-}
-
-static int mem_cgroup_oom_control_read(struct seq_file *sf, void *v)
-{
-	struct mem_cgroup *memcg = mem_cgroup_from_seq(sf);
-
-	seq_printf(sf, "oom_kill_disable %d\n", memcg->oom_kill_disable);
-	seq_printf(sf, "under_oom %d\n", (bool)memcg->under_oom);
-	seq_printf(sf, "oom_kill %lu\n",
-		   atomic_long_read(&memcg->memory_events[MEMCG_OOM_KILL]));
-	return 0;
-}
-
-static int mem_cgroup_oom_control_write(struct cgroup_subsys_state *css,
-	struct cftype *cft, u64 val)
-{
-	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
-
-	/* cannot set to root cgroup and only 0 and 1 are allowed */
-	if (mem_cgroup_is_root(memcg) || !((val == 0) || (val == 1)))
-		return -EINVAL;
-
-	memcg->oom_kill_disable = val;
-	if (!val)
-		memcg_oom_recover(memcg);
-
-	return 0;
-}
-
-#ifdef CONFIG_CGROUP_WRITEBACK
-
-#include <trace/events/writeback.h>
-
-static int memcg_wb_domain_init(struct mem_cgroup *memcg, gfp_t gfp)
-{
-	return wb_domain_init(&memcg->cgwb_domain, gfp);
-}
-
-static void memcg_wb_domain_exit(struct mem_cgroup *memcg)
-{
-	wb_domain_exit(&memcg->cgwb_domain);
-}
-
-static void memcg_wb_domain_size_changed(struct mem_cgroup *memcg)
-{
-	wb_domain_size_changed(&memcg->cgwb_domain);
+	return __mem_cgroup_usage_register_event(memcg, eventfd, args, _MEM);
 }
 
-struct wb_domain *mem_cgroup_wb_domain(struct bdi_writeback *wb)
+static int memsw_cgroup_usage_register_event(struct mem_cgroup *memcg,
+	struct eventfd_ctx *eventfd, const char *args)
 {
-	struct mem_cgroup *memcg = mem_cgroup_from_css(wb->memcg_css);
-
-	if (!memcg->css.parent)
-		return NULL;
-
-	return &memcg->cgwb_domain;
+	return __mem_cgroup_usage_register_event(memcg, eventfd, args, _MEMSWAP);
 }
 
-/**
- * mem_cgroup_wb_stats - retrieve writeback related stats from its memcg
- * @wb: bdi_writeback in question
- * @pfilepages: out parameter for number of file pages
- * @pheadroom: out parameter for number of allocatable pages according to memcg
- * @pdirty: out parameter for number of dirty pages
- * @pwriteback: out parameter for number of pages under writeback
- *
- * Determine the numbers of file, headroom, dirty, and writeback pages in
- * @wb's memcg.  File, dirty and writeback are self-explanatory.  Headroom
- * is a bit more involved.
- *
- * A memcg's headroom is "min(max, high) - used".  In the hierarchy, the
- * headroom is calculated as the lowest headroom of itself and the
- * ancestors.  Note that this doesn't consider the actual amount of
- * available memory in the system.  The caller should further cap
- * *@pheadroom accordingly.
- */
-void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
-			 unsigned long *pheadroom, unsigned long *pdirty,
-			 unsigned long *pwriteback)
+static void __mem_cgroup_usage_unregister_event(struct mem_cgroup *memcg,
+	struct eventfd_ctx *eventfd, enum res_type type)
 {
-	struct mem_cgroup *memcg = mem_cgroup_from_css(wb->memcg_css);
-	struct mem_cgroup *parent;
+	struct mem_cgroup_thresholds *thresholds;
+	struct mem_cgroup_threshold_ary *new;
+	unsigned long usage;
+	int i, j, size, entries;
 
-	mem_cgroup_flush_stats();
+	mutex_lock(&memcg->thresholds_lock);
 
-	*pdirty = memcg_page_state(memcg, NR_FILE_DIRTY);
-	*pwriteback = memcg_page_state(memcg, NR_WRITEBACK);
-	*pfilepages = memcg_page_state(memcg, NR_INACTIVE_FILE) +
-			memcg_page_state(memcg, NR_ACTIVE_FILE);
+	if (type == _MEM) {
+		thresholds = &memcg->thresholds;
+		usage = mem_cgroup_usage(memcg, false);
+	} else if (type == _MEMSWAP) {
+		thresholds = &memcg->memsw_thresholds;
+		usage = mem_cgroup_usage(memcg, true);
+	} else
+		BUG();
 
-	*pheadroom = PAGE_COUNTER_MAX;
-	while ((parent = parent_mem_cgroup(memcg))) {
-		unsigned long ceiling = min(READ_ONCE(memcg->memory.max),
-					    READ_ONCE(memcg->memory.high));
-		unsigned long used = page_counter_read(&memcg->memory);
+	if (!thresholds->primary)
+		goto unlock;
 
-		*pheadroom = min(*pheadroom, ceiling - min(ceiling, used));
-		memcg = parent;
+	/* Check if a threshold crossed before removing */
+	__mem_cgroup_threshold(memcg, type == _MEMSWAP);
+
+	/* Calculate new number of threshold */
+	size = entries = 0;
+	for (i = 0; i < thresholds->primary->size; i++) {
+		if (thresholds->primary->entries[i].eventfd != eventfd)
+			size++;
+		else
+			entries++;
 	}
-}
 
-/*
- * Foreign dirty flushing
- *
- * There's an inherent mismatch between memcg and writeback.  The former
- * tracks ownership per-page while the latter per-inode.  This was a
- * deliberate design decision because honoring per-page ownership in the
- * writeback path is complicated, may lead to higher CPU and IO overheads
- * and deemed unnecessary given that write-sharing an inode across
- * different cgroups isn't a common use-case.
- *
- * Combined with inode majority-writer ownership switching, this works well
- * enough in most cases but there are some pathological cases.  For
- * example, let's say there are two cgroups A and B which keep writing to
- * different but confined parts of the same inode.  B owns the inode and
- * A's memory is limited far below B's.  A's dirty ratio can rise enough to
- * trigger balance_dirty_pages() sleeps but B's can be low enough to avoid
- * triggering background writeback.  A will be slowed down without a way to
- * make writeback of the dirty pages happen.
- *
- * Conditions like the above can lead to a cgroup getting repeatedly and
- * severely throttled after making some progress after each
- * dirty_expire_interval while the underlying IO device is almost
- * completely idle.
- *
- * Solving this problem completely requires matching the ownership tracking
- * granularities between memcg and writeback in either direction.  However,
- * the more egregious behaviors can be avoided by simply remembering the
- * most recent foreign dirtying events and initiating remote flushes on
- * them when local writeback isn't enough to keep the memory clean enough.
- *
- * The following two functions implement such mechanism.  When a foreign
- * page - a page whose memcg and writeback ownerships don't match - is
- * dirtied, mem_cgroup_track_foreign_dirty() records the inode owning
- * bdi_writeback on the page owning memcg.  When balance_dirty_pages()
- * decides that the memcg needs to sleep due to high dirty ratio, it calls
- * mem_cgroup_flush_foreign() which queues writeback on the recorded
- * foreign bdi_writebacks which haven't expired.  Both the numbers of
- * recorded bdi_writebacks and concurrent in-flight foreign writebacks are
- * limited to MEMCG_CGWB_FRN_CNT.
- *
- * The mechanism only remembers IDs and doesn't hold any object references.
- * As being wrong occasionally doesn't matter, updates and accesses to the
- * records are lockless and racy.
- */
-void mem_cgroup_track_foreign_dirty_slowpath(struct page *page,
-					     struct bdi_writeback *wb)
-{
-	struct mem_cgroup *memcg = page_memcg(page);
-	struct memcg_cgwb_frn *frn;
-	u64 now = get_jiffies_64();
-	u64 oldest_at = now;
-	int oldest = -1;
-	int i;
+	new = thresholds->spare;
 
-	trace_track_foreign_dirty(page, wb);
+	/* If no items related to eventfd have been cleared, nothing to do */
+	if (!entries)
+		goto unlock;
 
-	/*
-	 * Pick the slot to use.  If there is already a slot for @wb, keep
-	 * using it.  If not replace the oldest one which isn't being
-	 * written out.
-	 */
-	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++) {
-		frn = &memcg->cgwb_frn[i];
-		if (frn->bdi_id == wb->bdi->id &&
-		    frn->memcg_id == wb->memcg_css->id)
-			break;
-		if (time_before64(frn->at, oldest_at) &&
-		    atomic_read(&frn->done.cnt) == 1) {
-			oldest = i;
-			oldest_at = frn->at;
-		}
+	/* Set thresholds array to NULL if we don't have thresholds */
+	if (!size) {
+		kfree(new);
+		new = NULL;
+		goto swap_buffers;
 	}
 
-	if (i < MEMCG_CGWB_FRN_CNT) {
-		/*
-		 * Re-using an existing one.  Update timestamp lazily to
-		 * avoid making the cacheline hot.  We want them to be
-		 * reasonably up-to-date and significantly shorter than
-		 * dirty_expire_interval as that's what expires the record.
-		 * Use the shorter of 1s and dirty_expire_interval / 8.
-		 */
-		unsigned long update_intv =
-			min_t(unsigned long, HZ,
-			      msecs_to_jiffies(dirty_expire_interval * 10) / 8);
+	new->size = size;
 
-		if (time_before64(frn->at, now - update_intv))
-			frn->at = now;
-	} else if (oldest >= 0) {
-		/* replace the oldest free one */
-		frn = &memcg->cgwb_frn[oldest];
-		frn->bdi_id = wb->bdi->id;
-		frn->memcg_id = wb->memcg_css->id;
-		frn->at = now;
+	/* Copy thresholds and find current threshold */
+	new->current_threshold = -1;
+	for (i = 0, j = 0; i < thresholds->primary->size; i++) {
+		if (thresholds->primary->entries[i].eventfd == eventfd)
+			continue;
+
+		new->entries[j] = thresholds->primary->entries[i];
+		if (new->entries[j].threshold <= usage) {
+			/*
+			 * new->current_threshold will not be used
+			 * until rcu_assign_pointer(), so it's safe to increment
+			 * it here.
+			 */
+			++new->current_threshold;
+		}
+		j++;
 	}
-}
 
-/* issue foreign writeback flushes for recorded foreign dirtying events */
-void mem_cgroup_flush_foreign(struct bdi_writeback *wb)
-{
-	struct mem_cgroup *memcg = mem_cgroup_from_css(wb->memcg_css);
-	unsigned long intv = msecs_to_jiffies(dirty_expire_interval * 10);
-	u64 now = jiffies_64;
-	int i;
+swap_buffers:
+	/* Swap primary and spare array */
+	thresholds->spare = thresholds->primary;
 
-	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++) {
-		struct memcg_cgwb_frn *frn = &memcg->cgwb_frn[i];
+	rcu_assign_pointer(thresholds->primary, new);
 
-		/*
-		 * If the record is older than dirty_expire_interval,
-		 * writeback on it has already started.  No need to kick it
-		 * off again.  Also, don't start a new one if there's
-		 * already one in flight.
-		 */
-		if (time_after64(frn->at, now - intv) &&
-		    atomic_read(&frn->done.cnt) == 1) {
-			frn->at = 0;
-			trace_flush_foreign(wb, frn->bdi_id, frn->memcg_id);
-			cgroup_writeback_by_id(frn->bdi_id, frn->memcg_id,
-					       WB_REASON_FOREIGN_FLUSH,
-					       &frn->done);
-		}
+	/* To be sure that nobody uses thresholds */
+	synchronize_rcu();
+
+	/* If all events are unregistered, free the spare array */
+	if (!new) {
+		kfree(thresholds->spare);
+		thresholds->spare = NULL;
 	}
+unlock:
+	mutex_unlock(&memcg->thresholds_lock);
 }
 
-#else	/* CONFIG_CGROUP_WRITEBACK */
-
-static int memcg_wb_domain_init(struct mem_cgroup *memcg, gfp_t gfp)
+static void mem_cgroup_usage_unregister_event(struct mem_cgroup *memcg,
+	struct eventfd_ctx *eventfd)
 {
-	return 0;
+	return __mem_cgroup_usage_unregister_event(memcg, eventfd, _MEM);
 }
 
-static void memcg_wb_domain_exit(struct mem_cgroup *memcg)
+static void memsw_cgroup_usage_unregister_event(struct mem_cgroup *memcg,
+	struct eventfd_ctx *eventfd)
 {
+	return __mem_cgroup_usage_unregister_event(memcg, eventfd, _MEMSWAP);
 }
 
-static void memcg_wb_domain_size_changed(struct mem_cgroup *memcg)
+static int mem_cgroup_oom_register_event(struct mem_cgroup *memcg,
+	struct eventfd_ctx *eventfd, const char *args)
 {
+	struct mem_cgroup_eventfd_list *event;
+
+	event = kmalloc(sizeof(*event),	GFP_KERNEL);
+	if (!event)
+		return -ENOMEM;
+
+	spin_lock(&memcg_oom_lock);
+
+	event->eventfd = eventfd;
+	list_add(&event->list, &memcg->oom_notify);
+
+	/* already in OOM ? */
+	if (memcg->under_oom)
+		eventfd_signal(eventfd, 1);
+	spin_unlock(&memcg_oom_lock);
+
+	return 0;
 }
 
-#endif	/* CONFIG_CGROUP_WRITEBACK */
+static void mem_cgroup_oom_unregister_event(struct mem_cgroup *memcg,
+	struct eventfd_ctx *eventfd)
+{
+	struct mem_cgroup_eventfd_list *ev, *tmp;
+
+	spin_lock(&memcg_oom_lock);
+
+	list_for_each_entry_safe(ev, tmp, &memcg->oom_notify, list) {
+		if (ev->eventfd == eventfd) {
+			list_del(&ev->list);
+			kfree(ev);
+		}
+	}
+
+	spin_unlock(&memcg_oom_lock);
+}
 
-/*
- * DO NOT USE IN NEW FILES.
- *
- * "cgroup.event_control" implementation.
- *
- * This is way over-engineered.  It tries to support fully configurable
- * events for each user.  Such level of flexibility is completely
- * unnecessary especially in the light of the planned unified hierarchy.
- *
- * Please deprecate this and replace with something simpler if at all
- * possible.
- */
 
 /*
  * Unregister event and free resources.
@@ -4910,6 +4916,16 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
 	return ret;
 }
 
+#else
+static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
+					 char *buf, size_t nbytes, loff_t off)
+{
+	return -EOPNOTSUPP;
+}
+
+static void memcg_check_events(struct mem_cgroup *memcg, struct page *page) { }
+#endif /* CONFIG_PREEMPT_RT */
+
 static struct cftype mem_cgroup_legacy_files[] = {
 	{
 		.name = "usage_in_bytes",
-- 
2.26.2



