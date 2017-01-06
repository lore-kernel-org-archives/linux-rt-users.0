From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [rfc patch-rt] radix-tree: Partially disable memcg accounting
 in radix_tree_node_alloc()
Date: Fri, 06 Jan 2017 13:20:33 +0100
Message-ID: <1483705233.5727.11.camel@gmail.com>
References: <20161223163213.szj43nv7rnelkbty@linutronix.de>
         <1483690403.11478.8.camel@gmx.de> <20170106085548.GD5556@dhcp22.suse.cz>
         <1483699979.11478.21.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Michal Hocko <mhocko@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1483699979.11478.21.camel@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2017-01-06 at 11:52 +0100, Mike Galbraith wrote:
> On Fri, 2017-01-06 at 09:55 +0100, Michal Hocko wrote:
> > On Fri 06-01-17 09:13:23, Mike Galbraith wrote:
> > > radix-tree: Partially disable memcg accounting in radix_tree_node_alloc()
> > > 
> > > Having no preload, which turns accounting off for non-rt kernels, trying to
> > > allocate coming from shmem_fault() when memcg is full sends us scurrying off
> > > to pagefault_out_of_memory(), with dramatic (usually terminal) consequences.
> > > LTP's madvise06 testcase triggers this quite well, and per gitk, the below
> > > was the beginning of RT memcg woes.
> > > 
> > > 58e698af4c63 radix-tree: account radix_tree_node to memory cgroup
> > > 
> > > Turn memcg accounting off for RT in the problematic path.
> > 
> > I am really wondering why this is RT specific and the non RT kernels
> > doesn't have any problem.
> 
> For all I know, there may be a scenario for non-RT to explode, but the
> madvise06 testcase that thoroughly nails RT ain't it.

Unless you twiddle/apply the RT tree radix-tree patch.  So (as rashly
presumed), memcg woes are RT specific because RT disabled the preload
business.  madvise06 isn't as deadly to the twiddled PREEMPT kernel as
it is to PREEMPT_RT_FULL, but a very few runs attracted the oom beast.

('course there still may be a non-RT danger path lurking.. dunno)

[   81.376673] madvise06 invoked oom-killer: gfp_mask=0x0(), nodemask=0, order=0, oom_score_adj=-1000
[   81.376676] madvise06 cpuset=/ mems_allowed=0
[   81.376680] CPU: 5 PID: 4018 Comm: madvise06 Tainted: G            E   4.10.0-preempt #31
[   81.376681] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/23/2013
[   81.376682] Call Trace:
[   81.376687]  ? dump_stack+0x5c/0x7e
[   81.376690]  ? dump_header+0x7f/0x241
[   81.376692]  ? __do_fault+0x1d/0x70
[   81.376693]  ? handle_mm_fault+0x3f5/0xfe0
[   81.376696]  ? oom_kill_process+0x225/0x3f0
[   81.376697]  ? oom_badness+0x70/0x180
[   81.376699]  ? out_of_memory+0x103/0x4a0
[   81.376700]  ? pagefault_out_of_memory+0x43/0x60
[   81.376703]  ? do_page_fault+0x2b/0x70
[   81.376705]  ? page_fault+0x28/0x30

From: Thomas Gleixner <tglx@linutronix.de>
Date: Sun, 17 Jul 2011 21:33:18 +0200
Subject: radix-tree: Make RT aware

Disable radix_tree_preload() on -RT. This functions returns with
preemption disabled which may cause high latencies and breaks if the
user tries to grab any locks after invoking it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/radix-tree.h |   18 +++++++++++++++++-
 lib/radix-tree.c           |    5 ++++-
 2 files changed, 21 insertions(+), 2 deletions(-)

--- a/include/linux/radix-tree.h
+++ b/include/linux/radix-tree.h
@@ -318,9 +318,24 @@ unsigned int radix_tree_gang_lookup(stru
 unsigned int radix_tree_gang_lookup_slot(struct radix_tree_root *root,
 			void ***results, unsigned long *indices,
 			unsigned long first_index, unsigned int max_items);
+#ifdef CONFIG_PREEMPT
+static inline int radix_tree_preload(gfp_t gm) { return 0; }
+static inline int radix_tree_maybe_preload(gfp_t gfp_mask) { return 0; }
+static inline int radix_tree_maybe_preload_order(gfp_t gfp_mask, int order)
+{
+	return 0;
+}
+
+static inline int radix_tree_split_preload(unsigned old_order, unsigned new_order, gfp_t gfp_mask)
+{
+	return 0;
+}
+#else
 int radix_tree_preload(gfp_t gfp_mask);
 int radix_tree_maybe_preload(gfp_t gfp_mask);
 int radix_tree_maybe_preload_order(gfp_t gfp_mask, int order);
+int radix_tree_split_preload(unsigned old_order, unsigned new_order, gfp_t gfp_mask);
+#endif
 void radix_tree_init(void);
 void *radix_tree_tag_set(struct radix_tree_root *root,
 			unsigned long index, unsigned int tag);
@@ -342,10 +357,11 @@ int radix_tree_tagged(struct radix_tree_
 
 static inline void radix_tree_preload_end(void)
 {
+#ifndef CONFIG_PREEMPT
 	preempt_enable();
+#endif
 }
 
-int radix_tree_split_preload(unsigned old_order, unsigned new_order, gfp_t);
 int radix_tree_split(struct radix_tree_root *, unsigned long index,
 			unsigned new_order);
 int radix_tree_join(struct radix_tree_root *, unsigned long index,
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -318,13 +318,14 @@ radix_tree_node_alloc(struct radix_tree_
 		 * succeed in getting a node here (and never reach
 		 * kmem_cache_alloc)
 		 */
-		rtp = this_cpu_ptr(&radix_tree_preloads);
+		rtp = &get_cpu_var(radix_tree_preloads);
 		if (rtp->nr) {
 			ret = rtp->nodes;
 			rtp->nodes = ret->private_data;
 			ret->private_data = NULL;
 			rtp->nr--;
 		}
+		put_cpu_var(radix_tree_preloads);
 		/*
 		 * Update the allocation stack trace as this is more useful
 		 * for debugging.
@@ -368,6 +369,7 @@ radix_tree_node_free(struct radix_tree_n
 	call_rcu(&node->rcu_head, radix_tree_node_rcu_free);
 }
 
+#ifndef CONFIG_PREEMPT
 /*
  * Load up this CPU's radix_tree_node buffer with sufficient objects to
  * ensure that the addition of a single element in the tree cannot fail.  On
@@ -509,6 +511,7 @@ int radix_tree_maybe_preload_order(gfp_t
 
 	return __radix_tree_preload(gfp_mask, nr_nodes);
 }
+#endif
 
 static unsigned radix_tree_load_root(struct radix_tree_root *root,
 		struct radix_tree_node **nodep, unsigned long *maxindex)
