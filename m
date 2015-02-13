From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH RT v2] kernel/res_counter.c: Change lock of struct
 res_counter to raw_spinlock_t
Date: Fri, 13 Feb 2015 14:19:11 -0500
Message-ID: <20150213191909.GA8299@windriver.com>
References: <1420745917-50747-1-git-send-email-tmac@hp.com>
 <1422644389-33074-1-git-send-email-tmac@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <rostedt@goodmis.org>, <linux-kernel@vger.kernel.org>,
	<mingo@redhat.com>, <tglx@linutronix.de>,
	<linux-rt-users@vger.kernel.org>
To: Thavatchai Makphaibulchoke <tmac@hp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1422644389-33074-1-git-send-email-tmac@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

[[PATCH RT v2] kernel/res_counter.c: Change lock of struct res_counter to raw_spinlock_t] On 30/01/2015 (Fri 11:59) Thavatchai Makphaibulchoke wrote:

> Since memory cgroups can be called from a page fault handler as shown
> by the stack dump here,
> 
> [12679.513255] BUG: scheduling while atomic: ssh/10621/0x00000002
> [12679.513305] Preemption disabled at:[<ffffffff811a20f7>] mem_cgroup_charge_common+0x37/0x60
> [12679.513305]
> [12679.513322] Call Trace:
> [12679.513331]  [<ffffffff81512f62>] dump_stack+0x4f/0x7c
> [12679.513333]  [<ffffffff8150f4f1>] __schedule_bug+0x9f/0xad
> [12679.513338]  [<ffffffff815155f3>] __schedule+0x653/0x720
> [12679.513340]  [<ffffffff815180ce>] ? _raw_spin_unlock_irqrestore+0x2e/0x70
> [12679.513343]  [<ffffffff81515784>] schedule+0x34/0xa0
> [12679.513345]  [<ffffffff81516fdb>] rt_spin_lock_slowlock+0x10b/0x250
> [12679.513348]  [<ffffffff815183a5>] rt_spin_lock+0x35/0x40
> [12679.513352]  [<ffffffff810ec1d9>] res_counter_uncharge_until+0x69/0xb0
> [12679.513354]  [<ffffffff810ec233>] res_counter_uncharge+0x13/0x20
> [12679.513358]  [<ffffffff8119c0be>] drain_stock.isra.38+0x5e/0x90
> [12679.513360]  [<ffffffff811a16a2>] __mem_cgroup_try_charge+0x3f2/0x8a0
> [12679.513363]  [<ffffffff811a20f7>] mem_cgroup_charge_common+0x37/0x60
> [12679.513365]  [<ffffffff811a3b06>] mem_cgroup_newpage_charge+0x26/0x30
> [12679.513369]  [<ffffffff8116c8d2>] handle_mm_fault+0x9b2/0xdb0
> [12679.513374]  [<ffffffff81400474>] ? sock_aio_read.part.11+0x104/0x130
> [12679.513379]  [<ffffffff8151c072>] __do_page_fault+0x182/0x4f0
> [12679.513381]  [<ffffffff814004c1>] ? sock_aio_read+0x21/0x30
> [12679.513385]  [<ffffffff811ab25a>] ? do_sync_read+0x5a/0x90
> [12679.513390]  [<ffffffff8108c981>] ? get_parent_ip+0x11/0x50
> [12679.513392]  [<ffffffff8151c41e>] do_page_fault+0x3e/0x80
> [12679.513395]  [<ffffffff81518e68>] page_fault+0x28/0x30
> 
> the lock member of struct res_counter should be of type raw_spinlock_t,
> not spinlock_t which can go to sleep.

I think there is more to this issue than just a lock conversion.
Firstly, if we look at the existing -rt patches, we've got the old
patch from ~2009 that is:

 From: Ingo Molnar <mingo@elte.hu>
 Date: Fri, 3 Jul 2009 08:44:33 -0500
 Subject: [PATCH] core: Do not disable interrupts on RT in res_counter.c

which changed the local_irq_save to local_irq_save_nort in order to
avoid such a raw lock conversion.

Also, when I test this patch on a larger machine with lots of cores, I
get boot up issues (general protection fault while trying to access the
raw lock) or RCU stalls that trigger broadcast NMI backtraces; both which
implicate the same code area, and they go away with a revert.

Stuff like the below. Figured I'd better mention it since Steve was
talking about rounding up patches for stable, and the solution to the
original problem reported here seems to need to be revisited.

Paul.
--


[   38.615736] NMI backtrace for cpu 15
[   38.615739] CPU: 15 PID: 835 Comm: ovirt-engine.py Not tainted 3.14.33-rt28-WR7.0.0.0_ovp+ #3
[   38.615740] Hardware name: Intel Corporation S2600CP/S2600CP, BIOS SE5C600.86B.02.01.0002.082220131453 08/22/2013
[   38.615742] task: ffff880faca80000 ti: ffff880f9d890000 task.ti: ffff880f9d890000
[   38.615751] RIP: 0010:[<ffffffff810820a1>]  [<ffffffff810820a1>] preempt_count_add+0x41/0xb0
[   38.615752] RSP: 0018:ffff880ffd5e3d00  EFLAGS: 00000097
[   38.615754] RAX: 0000000000010002 RBX: 0000000000000001 RCX: 0000000000000000
[   38.615755] RDX: 0000000000000000 RSI: 0000000000000100 RDI: 0000000000000001
[   38.615756] RBP: ffff880ffd5e3d08 R08: ffffffff82317700 R09: 0000000000000028
[   38.615757] R10: 000000000000000f R11: 0000000000017484 R12: 0000000000044472
[   38.615758] R13: 000000000000000f R14: 00000000c42caa68 R15: 0000000000000010
[   38.615760] FS:  00007effa30c2700(0000) GS:ffff880ffd5e0000(0000) knlGS:0000000000000000
[   38.615761] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   38.615762] CR2: 00007f19e3c29320 CR3: 0000000f9f9a3000 CR4: 00000000001407e0
[   38.615763] Stack:
[   38.615765]  00000000c42caa20 ffff880ffd5e3d38 ffffffff8140e524 0000000000001000
[   38.615767]  00000000000003e9 0000000000000400 0000000000000002 ffff880ffd5e3d48
[   38.615769]  ffffffff8140e43f ffff880ffd5e3d58 ffffffff8140e477 ffff880ffd5e3d78
[   38.615769] Call Trace:
[   38.615771]  <IRQ>
[   38.615779]  [<ffffffff8140e524>] delay_tsc+0x44/0xd0
[   38.615782]  [<ffffffff8140e43f>] __delay+0xf/0x20
[   38.615784]  [<ffffffff8140e477>] __const_udelay+0x27/0x30
[   38.615788]  [<ffffffff810355da>] native_safe_apic_wait_icr_idle+0x2a/0x60
[   38.615792]  [<ffffffff81036c80>] default_send_IPI_mask_sequence_phys+0xc0/0xe0
[   38.615798]  [<ffffffff8103a5f7>] physflat_send_IPI_all+0x17/0x20
[   38.615801]  [<ffffffff81036e80>] arch_trigger_all_cpu_backtrace+0x70/0xb0
[   38.615807]  [<ffffffff810b4d41>] rcu_check_callbacks+0x4f1/0x840
[   38.615814]  [<ffffffff8105365e>] ? raise_softirq_irqoff+0xe/0x40
[   38.615821]  [<ffffffff8105cc52>] update_process_times+0x42/0x70
[   38.615826]  [<ffffffff810c0336>] tick_sched_handle.isra.15+0x36/0x50
[   38.615829]  [<ffffffff810c0394>] tick_sched_timer+0x44/0x70
[   38.615835]  [<ffffffff8107598b>] __run_hrtimer+0x9b/0x2a0
[   38.615838]  [<ffffffff810c0350>] ? tick_sched_handle.isra.15+0x50/0x50
[   38.615842]  [<ffffffff81076cbe>] hrtimer_interrupt+0x12e/0x2e0
[   38.615845]  [<ffffffff810352c7>] local_apic_timer_interrupt+0x37/0x60
[   38.615851]  [<ffffffff81a376ef>] smp_apic_timer_interrupt+0x3f/0x50
[   38.615854]  [<ffffffff81a3664a>] apic_timer_interrupt+0x6a/0x70
[   38.615855]  <EOI>
[   38.615861]  [<ffffffff810dc604>] ? __res_counter_charge+0xc4/0x170
[   38.615866]  [<ffffffff81a34487>] ? _raw_spin_lock+0x47/0x60
[   38.615882]  [<ffffffff81a34457>] ? _raw_spin_lock+0x17/0x60
[   38.615885]  [<ffffffff810dc604>] __res_counter_charge+0xc4/0x170
[   38.615888]  [<ffffffff810dc6c0>] res_counter_charge+0x10/0x20
[   38.615896]  [<ffffffff81186645>] vm_cgroup_charge_shmem+0x35/0x50
[   38.615900]  [<ffffffff8113a686>] shmem_getpage_gfp+0x4b6/0x8e0
[   38.615904]  [<ffffffff8108201d>] ? get_parent_ip+0xd/0x50
[   38.615908]  [<ffffffff8113b626>] shmem_symlink+0xe6/0x210
[   38.615914]  [<ffffffff81195361>] ? __inode_permission+0x41/0xd0
[   38.615917]  [<ffffffff811961f0>] vfs_symlink+0x90/0xd0
[   38.615923]  [<ffffffff8119a762>] SyS_symlinkat+0x62/0xc0
[   38.615927]  [<ffffffff8119a7d6>] SyS_symlink+0x16/0x20
[   38.615930]  [<ffffffff81a359d6>] system_call_fastpath+0x1a/0x1f


> 
> Tested on a 2 node, 32 thread, plaform with cyclictest.
> 
> Kernel version 3.14.25 + patch-3.14.25-rt22
> 
> Signed-off-by: T Makphaibulchoke <tmac@hp.com>
> ---
> 
> Changed in v2:
> 	- Fixed Signed-off-by tag.
> 
>  include/linux/res_counter.h | 26 +++++++++++++-------------
>  kernel/res_counter.c        | 18 +++++++++---------
>  2 files changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/include/linux/res_counter.h b/include/linux/res_counter.h
> index 201a697..61d94a4 100644
> --- a/include/linux/res_counter.h
> +++ b/include/linux/res_counter.h
> @@ -47,7 +47,7 @@ struct res_counter {
>  	 * the lock to protect all of the above.
>  	 * the routines below consider this to be IRQ-safe
>  	 */
> -	spinlock_t lock;
> +	raw_spinlock_t lock;
>  	/*
>  	 * Parent counter, used for hierarchial resource accounting
>  	 */
> @@ -148,12 +148,12 @@ static inline unsigned long long res_counter_margin(struct res_counter *cnt)
>  	unsigned long long margin;
>  	unsigned long flags;
>  
> -	spin_lock_irqsave(&cnt->lock, flags);
> +	raw_spin_lock_irqsave(&cnt->lock, flags);
>  	if (cnt->limit > cnt->usage)
>  		margin = cnt->limit - cnt->usage;
>  	else
>  		margin = 0;
> -	spin_unlock_irqrestore(&cnt->lock, flags);
> +	raw_spin_unlock_irqrestore(&cnt->lock, flags);
>  	return margin;
>  }
>  
> @@ -170,12 +170,12 @@ res_counter_soft_limit_excess(struct res_counter *cnt)
>  	unsigned long long excess;
>  	unsigned long flags;
>  
> -	spin_lock_irqsave(&cnt->lock, flags);
> +	raw_spin_lock_irqsave(&cnt->lock, flags);
>  	if (cnt->usage <= cnt->soft_limit)
>  		excess = 0;
>  	else
>  		excess = cnt->usage - cnt->soft_limit;
> -	spin_unlock_irqrestore(&cnt->lock, flags);
> +	raw_spin_unlock_irqrestore(&cnt->lock, flags);
>  	return excess;
>  }
>  
> @@ -183,18 +183,18 @@ static inline void res_counter_reset_max(struct res_counter *cnt)
>  {
>  	unsigned long flags;
>  
> -	spin_lock_irqsave(&cnt->lock, flags);
> +	raw_spin_lock_irqsave(&cnt->lock, flags);
>  	cnt->max_usage = cnt->usage;
> -	spin_unlock_irqrestore(&cnt->lock, flags);
> +	raw_spin_unlock_irqrestore(&cnt->lock, flags);
>  }
>  
>  static inline void res_counter_reset_failcnt(struct res_counter *cnt)
>  {
>  	unsigned long flags;
>  
> -	spin_lock_irqsave(&cnt->lock, flags);
> +	raw_spin_lock_irqsave(&cnt->lock, flags);
>  	cnt->failcnt = 0;
> -	spin_unlock_irqrestore(&cnt->lock, flags);
> +	raw_spin_unlock_irqrestore(&cnt->lock, flags);
>  }
>  
>  static inline int res_counter_set_limit(struct res_counter *cnt,
> @@ -203,12 +203,12 @@ static inline int res_counter_set_limit(struct res_counter *cnt,
>  	unsigned long flags;
>  	int ret = -EBUSY;
>  
> -	spin_lock_irqsave(&cnt->lock, flags);
> +	raw_spin_lock_irqsave(&cnt->lock, flags);
>  	if (cnt->usage <= limit) {
>  		cnt->limit = limit;
>  		ret = 0;
>  	}
> -	spin_unlock_irqrestore(&cnt->lock, flags);
> +	raw_spin_unlock_irqrestore(&cnt->lock, flags);
>  	return ret;
>  }
>  
> @@ -218,9 +218,9 @@ res_counter_set_soft_limit(struct res_counter *cnt,
>  {
>  	unsigned long flags;
>  
> -	spin_lock_irqsave(&cnt->lock, flags);
> +	raw_spin_lock_irqsave(&cnt->lock, flags);
>  	cnt->soft_limit = soft_limit;
> -	spin_unlock_irqrestore(&cnt->lock, flags);
> +	raw_spin_unlock_irqrestore(&cnt->lock, flags);
>  	return 0;
>  }
>  
> diff --git a/kernel/res_counter.c b/kernel/res_counter.c
> index 3fbcb0d..59a7a62 100644
> --- a/kernel/res_counter.c
> +++ b/kernel/res_counter.c
> @@ -16,7 +16,7 @@
>  
>  void res_counter_init(struct res_counter *counter, struct res_counter *parent)
>  {
> -	spin_lock_init(&counter->lock);
> +	raw_spin_lock_init(&counter->lock);
>  	counter->limit = RES_COUNTER_MAX;
>  	counter->soft_limit = RES_COUNTER_MAX;
>  	counter->parent = parent;
> @@ -51,9 +51,9 @@ static int __res_counter_charge(struct res_counter *counter, unsigned long val,
>  	*limit_fail_at = NULL;
>  	local_irq_save_nort(flags);
>  	for (c = counter; c != NULL; c = c->parent) {
> -		spin_lock(&c->lock);
> +		raw_spin_lock(&c->lock);
>  		r = res_counter_charge_locked(c, val, force);
> -		spin_unlock(&c->lock);
> +		raw_spin_unlock(&c->lock);
>  		if (r < 0 && !ret) {
>  			ret = r;
>  			*limit_fail_at = c;
> @@ -64,9 +64,9 @@ static int __res_counter_charge(struct res_counter *counter, unsigned long val,
>  
>  	if (ret < 0 && !force) {
>  		for (u = counter; u != c; u = u->parent) {
> -			spin_lock(&u->lock);
> +			raw_spin_lock(&u->lock);
>  			res_counter_uncharge_locked(u, val);
> -			spin_unlock(&u->lock);
> +			raw_spin_unlock(&u->lock);
>  		}
>  	}
>  	local_irq_restore_nort(flags);
> @@ -106,11 +106,11 @@ u64 res_counter_uncharge_until(struct res_counter *counter,
>  	local_irq_save_nort(flags);
>  	for (c = counter; c != top; c = c->parent) {
>  		u64 r;
> -		spin_lock(&c->lock);
> +		raw_spin_lock(&c->lock);
>  		r = res_counter_uncharge_locked(c, val);
>  		if (c == counter)
>  			ret = r;
> -		spin_unlock(&c->lock);
> +		raw_spin_unlock(&c->lock);
>  	}
>  	local_irq_restore_nort(flags);
>  	return ret;
> @@ -164,9 +164,9 @@ u64 res_counter_read_u64(struct res_counter *counter, int member)
>  	unsigned long flags;
>  	u64 ret;
>  
> -	spin_lock_irqsave(&counter->lock, flags);
> +	raw_spin_lock_irqsave(&counter->lock, flags);
>  	ret = *res_counter_member(counter, member);
> -	spin_unlock_irqrestore(&counter->lock, flags);
> +	raw_spin_unlock_irqrestore(&counter->lock, flags);
>  
>  	return ret;
>  }
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
