From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH-next] kvm: don't try to take mmu_lock while holding the
 main raw kvm_lock
Date: Wed, 26 Jun 2013 10:10:06 +0200
Message-ID: <51CAA1DE.2020307@redhat.com>
References: <1372199643-3936-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Gleb Natapov <gleb@redhat.com>, linux-rt-users@vger.kernel.org,
	kvm@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54241 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751309Ab3FZIKS (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 26 Jun 2013 04:10:18 -0400
In-Reply-To: <1372199643-3936-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Il 26/06/2013 00:34, Paul Gortmaker ha scritto:
> In commit e935b8372cf8 ("KVM: Convert kvm_lock to raw_spinlock"),
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

Since the shrinker code is asynchronous with respect to KVM, I think
that the kvm_lock here is also protecting against kvm_destroy_vm running
at the same time.

So the patch is almost okay; all that is missing is a
kvm_get_kvm/kvm_put_kvm pair, where the reference is added just before
releasing the kvm_lock.

Paolo
