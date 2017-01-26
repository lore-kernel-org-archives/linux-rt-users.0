From: Mike Galbraith <efault@gmx.de>
Subject: Re: [rfc patch-rt] radix-tree: Partially disable memcg accounting
 in radix_tree_node_alloc()
Date: Thu, 26 Jan 2017 04:42:51 +0100
Message-ID: <1485402171.4451.2.camel@gmx.de>
References: <20161223163213.szj43nv7rnelkbty@linutronix.de>
         <1483690403.11478.8.camel@gmx.de>
         <20170125150602.krsix5lmwh6h5yxf@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170125150602.krsix5lmwh6h5yxf@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2017-01-25 at 16:06 +0100, Sebastian Andrzej Siewior wrote:

> According to the to description of radix_tree_preload() the return code
> of 0 means that the following addition of a single element does not
> fail. But in RT's case this requirement is not fulfilled. There is more
> than just one user of that function. So instead adding an exception here
> and maybe later one someplace else, what about the following patch?
> That testcase you mentioned passes now:

Modulo missing EXPORT_SYMBOL(), yup, works fine.

> > testcases/kernel/syscalls/madvise/madvise06
> > tst_test.c:760: INFO: Timeout per run is 0h 05m 00s
> > madvise06.c:65: INFO: dropping caches
> > madvise06.c:139: INFO: SwapCached (before madvise): 304
> > madvise06.c:153: INFO: SwapCached (after madvise): 309988
> > madvise06.c:155: PASS: Regression test pass
> > 
> > Summary:
> > passed   1
> > failed   0
> > skipped  0
> > warnings 0
> 
> diff --git a/include/linux/radix-tree.h b/include/linux/radix-tree.h
> index f87f87dec84c..277295039c8f 100644
> --- a/include/linux/radix-tree.h
> +++ b/include/linux/radix-tree.h
> @@ -289,19 +289,11 @@ unsigned int radix_tree_gang_lookup(struct radix_tree_root *root,
>  unsigned int radix_tree_gang_lookup_slot(struct radix_tree_root *root,
>  > 	> 	> 	> void ***results, unsigned long *indices,
>  > 	> 	> 	> unsigned long first_index, unsigned int max_items);
> -#ifdef CONFIG_PREEMPT_RT_FULL
> -static inline int radix_tree_preload(gfp_t gm) { return 0; }
> -static inline int radix_tree_maybe_preload(gfp_t gfp_mask) { return 0; }
> -static inline int radix_tree_maybe_preload_order(gfp_t gfp_mask, int order)
> -{
> -> 	> return 0;
> -};
> -
> -#else
>  int radix_tree_preload(gfp_t gfp_mask);
>  int radix_tree_maybe_preload(gfp_t gfp_mask);
>  int radix_tree_maybe_preload_order(gfp_t gfp_mask, int order);
> -#endif
> +void radix_tree_preload_end(void);
> +
>  void radix_tree_init(void);
>  void *radix_tree_tag_set(struct radix_tree_root *root,
>  > 	> 	> 	> unsigned long index, unsigned int tag);
> @@ -324,11 +316,6 @@ unsigned long radix_tree_range_tag_if_tagged(struct radix_tree_root *root,
>  int radix_tree_tagged(struct radix_tree_root *root, unsigned int tag);
>  unsigned long radix_tree_locate_item(struct radix_tree_root *root, void *item);
>  
> -static inline void radix_tree_preload_end(void)
> -{
> -> 	> preempt_enable_nort();
> -}
> -
>  /**
>   * struct radix_tree_iter - radix tree iterator state
>   *
> diff --git a/lib/radix-tree.c b/lib/radix-tree.c
> index 881cc195d85f..e96c6a99f25c 100644
> --- a/lib/radix-tree.c
> +++ b/lib/radix-tree.c
> @@ -36,7 +36,7 @@
>  #include 
>  #include 
>  #include > 	> 	> /* in_interrupt() */
> -
> +#include 
>  
>  /* Number of nodes in fully populated tree of given height */
>  static unsigned long height_to_maxnodes[RADIX_TREE_MAX_PATH + 1] __read_mostly;
> @@ -68,6 +68,7 @@ struct radix_tree_preload {
>  > 	> struct radix_tree_node *nodes;
>  };
>  static DEFINE_PER_CPU(struct radix_tree_preload, radix_tree_preloads) = { 0, };
> +static DEFINE_LOCAL_IRQ_LOCK(radix_tree_preloads_lock);
>  
>  static inline void *node_to_entry(void *ptr)
>  {
> @@ -290,14 +291,14 @@ radix_tree_node_alloc(struct radix_tree_root *root)
>  > 	> 	>  * succeed in getting a node here (and never reach
>  > 	> 	>  * kmem_cache_alloc)
>  > 	> 	>  */
> -> 	> 	> rtp = &get_cpu_var(radix_tree_preloads);
> +> 	> 	> rtp = &get_locked_var(radix_tree_preloads_lock, radix_tree_preloads);
>  > 	> 	> if (rtp->nr) {
>  > 	> 	> 	> ret = rtp->nodes;
>  > 	> 	> 	> rtp->nodes = ret->private_data;
>  > 	> 	> 	> ret->private_data = NULL;
>  > 	> 	> 	> rtp->nr--;
>  > 	> 	> }
> -> 	> 	> put_cpu_var(radix_tree_preloads);
> +> 	> 	> put_locked_var(radix_tree_preloads_lock, radix_tree_preloads);
>  > 	> 	> /*
>  > 	> 	>  * Update the allocation stack trace as this is more useful
>  > 	> 	>  * for debugging.
> @@ -337,7 +338,6 @@ radix_tree_node_free(struct radix_tree_node *node)
>  > 	> call_rcu(&node->rcu_head, radix_tree_node_rcu_free);
>  }
>  
> -#ifndef CONFIG_PREEMPT_RT_FULL
>  /*
>   * Load up this CPU's radix_tree_node buffer with sufficient objects to
>   * ensure that the addition of a single element in the tree cannot fail.  On
> @@ -359,14 +359,14 @@ static int __radix_tree_preload(gfp_t gfp_mask, int nr)
>  > 	>  */
>  > 	> gfp_mask &= ~__GFP_ACCOUNT;
>  
> -> 	> preempt_disable();
> +> 	> local_lock(radix_tree_preloads_lock);
>  > 	> rtp = this_cpu_ptr(&radix_tree_preloads);
>  > 	> while (rtp->nr < nr) {
> -> 	> 	> preempt_enable();
> +> 	> 	> local_unlock(radix_tree_preloads_lock);
>  > 	> 	> node = kmem_cache_alloc(radix_tree_node_cachep, gfp_mask);
>  > 	> 	> if (node == NULL)
>  > 	> 	> 	> goto out;
> -> 	> 	> preempt_disable();
> +> 	> 	> local_lock(radix_tree_preloads_lock);
>  > 	> 	> rtp = this_cpu_ptr(&radix_tree_preloads);
>  > 	> 	> if (rtp->nr < nr) {
>  > 	> 	> 	> node->private_data = rtp->nodes;
> @@ -408,7 +408,7 @@ int radix_tree_maybe_preload(gfp_t gfp_mask)
>  > 	> if (gfpflags_allow_blocking(gfp_mask))
>  > 	> 	> return __radix_tree_preload(gfp_mask, RADIX_TREE_PRELOAD_SIZE);
>  > 	> /* Preloading doesn't help anything with this gfp mask, skip it */
> -> 	> preempt_disable();
> +> 	> local_lock(radix_tree_preloads_lock);
>  > 	> return 0;
>  }
>  EXPORT_SYMBOL(radix_tree_maybe_preload);
> @@ -424,7 +424,7 @@ int radix_tree_maybe_preload_order(gfp_t gfp_mask, int order)
>  
>  > 	> /* Preloading doesn't help anything with this gfp mask, skip it */
>  > 	> if (!gfpflags_allow_blocking(gfp_mask)) {
> -> 	> 	> preempt_disable();
> +> 	> 	> local_lock(radix_tree_preloads_lock);
>  > 	> 	> return 0;
>  > 	> }
>  
> @@ -457,7 +457,11 @@ int radix_tree_maybe_preload_order(gfp_t gfp_mask, int order)
>  
>  > 	> return __radix_tree_preload(gfp_mask, nr_nodes);
>  }
> -#endif
> +
> +void radix_tree_preload_end(void)
> +{
> +> 	> local_unlock(radix_tree_preloads_lock);
> +}
>  
>  /*
>   * The maximum index which can be stored in a radix tree
