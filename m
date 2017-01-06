From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [rfc patch-rt] radix-tree: Partially disable memcg accounting in
 radix_tree_node_alloc()
Date: Fri, 6 Jan 2017 09:55:48 +0100
Message-ID: <20170106085548.GD5556@dhcp22.suse.cz>
References: <20161223163213.szj43nv7rnelkbty@linutronix.de>
 <1483690403.11478.8.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1483690403.11478.8.camel@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri 06-01-17 09:13:23, Mike Galbraith wrote:
> radix-tree: Partially disable memcg accounting in radix_tree_node_alloc()
> 
> Having no preload, which turns accounting off for non-rt kernels, trying to
> allocate coming from shmem_fault() when memcg is full sends us scurrying off
> to pagefault_out_of_memory(), with dramatic (usually terminal) consequences.
> LTP's madvise06 testcase triggers this quite well, and per gitk, the below
> was the beginning of RT memcg woes.
> 
> 58e698af4c63 radix-tree: account radix_tree_node to memory cgroup
> 
> Turn memcg accounting off for RT in the problematic path.

I am really wondering why this is RT specific and the non RT kernels
doesn't have any problem.
 
> Signed-off-by: Mike Galbraith <efault@gmx.de>
> Cc: stable-rt@vger.kernel.org # +v4.6-rt
> ---
>  lib/radix-tree.c |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> --- a/lib/radix-tree.c
> +++ b/lib/radix-tree.c
> @@ -303,6 +303,13 @@ radix_tree_node_alloc(struct radix_tree_
>  	if (!gfpflags_allow_blocking(gfp_mask) && !in_interrupt()) {
>  		struct radix_tree_preload *rtp;
>  
> +#if defined(CONFIG_PREEMPT_RT_FULL) && defined(CONFIG_MEMCG)
> +		/*
> +		 * Arriving here from shmem_fault() and meeting a full memcg
> +		 * will send us to pagefault_out_of_memory(), and a dead box.
> +		 */
> +		gfp_mask &= ~__GFP_ACCOUNT;
> +#endif
>  		/*
>  		 * Even if the caller has preloaded, try to allocate from the
>  		 * cache first for the new node to get accounted to the memory

-- 
Michal Hocko
SUSE Labs
