From: Gleb Natapov <gleb@redhat.com>
Subject: Re: [PATCH-next] kvm: don't try to take mmu_lock while holding the
 main raw kvm_lock
Date: Thu, 27 Jun 2013 14:09:11 +0300
Message-ID: <20130627110911.GH18508@redhat.com>
References: <1372199643-3936-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	linux-rt-users@vger.kernel.org, kvm@vger.kernel.org,
	Jan Kiszka <jan.kiszka@siemens.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:17182 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750843Ab3F0LJP (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 27 Jun 2013 07:09:15 -0400
Content-Disposition: inline
In-Reply-To: <1372199643-3936-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Jun 25, 2013 at 06:34:03PM -0400, Paul Gortmaker wrote:
> In commit e935b8372cf8 ("KVM: Convert kvm_lock to raw_spinlock"),
I am copying Jan, the author of the patch. Commit message says:
"Code under this lock requires non-preemptibility", but which code
exactly is this? Is this still true?

> the kvm_lock was made a raw lock.  However, the kvm mmu_shrink()
> function tries to grab the (non-raw) mmu_lock within the scope of
> the raw locked kvm_lock being held.  This leads to the following:
> 
> BUG: sleeping function called from invalid context at kernel/rtmutex.c:659
> in_atomic(): 1, irqs_disabled(): 0, pid: 55, name: kswapd0
> Preemption disabled at:[<ffffffffa0376eac>] mmu_shrink+0x5c/0x1b0 [kvm]
> 
> Pid: 55, comm: kswapd0 Not tainted 3.4.34_preempt-rt
> Call Trace:
>  [<ffffffff8106f2ad>] __might_sleep+0xfd/0x160
>  [<ffffffff817d8d64>] rt_spin_lock+0x24/0x50
>  [<ffffffffa0376f3c>] mmu_shrink+0xec/0x1b0 [kvm]
>  [<ffffffff8111455d>] shrink_slab+0x17d/0x3a0
>  [<ffffffff81151f00>] ? mem_cgroup_iter+0x130/0x260
>  [<ffffffff8111824a>] balance_pgdat+0x54a/0x730
>  [<ffffffff8111fe47>] ? set_pgdat_percpu_threshold+0xa7/0xd0
>  [<ffffffff811185bf>] kswapd+0x18f/0x490
>  [<ffffffff81070961>] ? get_parent_ip+0x11/0x50
>  [<ffffffff81061970>] ? __init_waitqueue_head+0x50/0x50
>  [<ffffffff81118430>] ? balance_pgdat+0x730/0x730
>  [<ffffffff81060d2b>] kthread+0xdb/0xe0
>  [<ffffffff8106e122>] ? finish_task_switch+0x52/0x100
>  [<ffffffff817e1e94>] kernel_thread_helper+0x4/0x10
>  [<ffffffff81060c50>] ? __init_kthread_worker+0x
> 
> Since we only use the lock for protecting the vm_list, once we've
> found the instance we want, we can shuffle it to the end of the
> list and then drop the kvm_lock before taking the mmu_lock.  We
> can do this because after the mmu operations are completed, we
> break -- i.e. we don't continue list processing, so it doesn't
> matter if the list changed around us.
> 
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
> 
> [Note1: do double check that this solution makes sense for the
>  mainline kernel; consider this an RFC patch that does want a
>  review from people in the know.]
> 
> [Note2: you'll need to be running a preempt-rt kernel to actually
>  see this.  Also note that the above patch is against linux-next.
>  Alternate solutions welcome ; this seemed to me the obvious fix.]
> 
>  arch/x86/kvm/mmu.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
> index 748e0d8..db93a70 100644
> --- a/arch/x86/kvm/mmu.c
> +++ b/arch/x86/kvm/mmu.c
> @@ -4322,6 +4322,7 @@ mmu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
>  {
>  	struct kvm *kvm;
>  	int nr_to_scan = sc->nr_to_scan;
> +	int found = 0;
>  	unsigned long freed = 0;
>  
>  	raw_spin_lock(&kvm_lock);
> @@ -4349,6 +4350,12 @@ mmu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
>  			continue;
>  
>  		idx = srcu_read_lock(&kvm->srcu);
> +
> +		list_move_tail(&kvm->vm_list, &vm_list);
> +		found = 1;
> +		/* We can't be holding a raw lock and take non-raw mmu_lock */
> +		raw_spin_unlock(&kvm_lock);
> +
>  		spin_lock(&kvm->mmu_lock);
>  
>  		if (kvm_has_zapped_obsolete_pages(kvm)) {
> @@ -4370,11 +4377,12 @@ unlock:
>  		 * per-vm shrinkers cry out
>  		 * sadness comes quickly
>  		 */
> -		list_move_tail(&kvm->vm_list, &vm_list);
>  		break;
>  	}
>  
> -	raw_spin_unlock(&kvm_lock);
> +	if (!found)
> +		raw_spin_unlock(&kvm_lock);
> +
>  	return freed;
>  
>  }
> -- 
> 1.8.1.2

--
			Gleb.
