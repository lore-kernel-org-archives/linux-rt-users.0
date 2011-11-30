From: Thomas Schauss <schauss@tum.de>
Subject: Re: 3.2-rc1 and nvidia drivers
Date: Wed, 30 Nov 2011 10:06:52 +0100
Message-ID: <4ED5F22C.5010104@tum.de>
References: <CAOLSsAysHCVAHsSRMTXUpXm_qjK5D5DRagHCS0ZYrxGQ8mDkfw@mail.gmail.com> <4EC384FD.1040106@tum.de> <alpine.LFD.2.02.1111161605580.4902@ionos> <4ED35D9A.7090401@tum.de> <CAONaPpE7Jgz0GhFUB41ZKoa8dUKOqKVFKj6jHfi3EAnPX0SRbQ@mail.gmail.com> <alpine.LFD.2.00.1111291528590.5855@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailrelay1.lrz-muenchen.de ([129.187.254.106]:33784 "EHLO
	mailrelay1.lrz-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757206Ab1K3JHF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 30 Nov 2011 04:07:05 -0500
In-Reply-To: <alpine.LFD.2.00.1111291528590.5855@localhost6.localdomain6>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 11/29/2011 03:31 PM, John Kacur wrote:
>
> On Mon, 28 Nov 2011, John Kacur wrote:
>
> Could you try the following patch to see if it gets rid of your lockdep
> splat? (plan to neaten it up and send it to lkml if it works for you.)
>
>  From 29bf37fc62098bc87960e78f365083d9f52cf36a Mon Sep 17 00:00:00 2001
> From: John Kacur<jkacur@redhat.com>
> Date: Tue, 29 Nov 2011 15:17:54 +0100
> Subject: [PATCH] Drop lock in free_block before calling slab_destroy to prevent lockdep splats
>
> This prevents lockdep splats due to this call chain
> cache_flusharray()
> spin_lock(&l3->list_lock);
> free_block(cachep, ac->entry, batchcount, node);
>         slab_destroy()
>         kmem_cache_free()
>                 __cache_free()
>                 cache_flusharray()
>
> Signed-off-by: John Kacur<jkacur@redhat.com>
> ---
>   mm/slab.c |    2 ++
>   1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/mm/slab.c b/mm/slab.c
> index b615658..635e16a 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -3667,7 +3667,9 @@ static void free_block(struct kmem_cache *cachep, void **objpp, int nr_objects,
>   				 * a different cache, refer to comments before
>   				 * alloc_slabmgmt.
>   				 */
> +				spin_unlock(&l3->list_lock);
>   				slab_destroy(cachep, slabp, true);
> +				spin_lock(&l3->list_lock);
>   			} else {
>   				list_add(&slabp->list,&l3->slabs_free);
>   			}

Yes, that seems like the path that causes the warning. I can test this 
on friday if no other patch was proposed by then.

It should also solve a slightly different situation where I get the same 
warning, see below.

Btw., the subject of this thread is very misleading, sorry for that. 
Should be something like "Lockdep-warning in slab.c on 3.0.9-rt25".

I guess it is a bad idea to change the subject of an existing thread?

Nov 17 17:18:17 fix kernel: [   11.170313] 
=============================================
Nov 17 17:18:17 fix kernel: [   11.170315] [ INFO: possible recursive 
locking detected ]
Nov 17 17:18:17 fix kernel: [   11.170317] 3.0.9-25-rt #0
Nov 17 17:18:17 fix kernel: [   11.170319] 
---------------------------------------------
Nov 17 17:18:17 fix kernel: [   11.170321] kworker/0:1/20 is trying to 
acquire lock:
Nov 17 17:18:17 fix kernel: [   11.170323] 
(&parent->list_lock){+.+...}, at: [<ffffffff81613e63>] 
cache_flusharray+0x47/0xd6
Nov 17 17:18:17 fix kernel: [   11.170331]
Nov 17 17:18:17 fix kernel: [   11.170332] but task is already holding lock:
Nov 17 17:18:17 fix kernel: [   11.170333] 
(&parent->list_lock){+.+...}, at: [<ffffffff811682c2>] 
drain_array.part.43+0xc2/0x220
Nov 17 17:18:17 fix kernel: [   11.170339]
Nov 17 17:18:17 fix kernel: [   11.170340] other info that might help us 
debug this:
Nov 17 17:18:17 fix kernel: [   11.170342]  Possible unsafe locking 
scenario:
Nov 17 17:18:17 fix kernel: [   11.170342]
Nov 17 17:18:17 fix kernel: [   11.170343]        CPU0
Nov 17 17:18:17 fix kernel: [   11.170344]        ----
Nov 17 17:18:17 fix kernel: [   11.170345]   lock(&parent->list_lock);
Nov 17 17:18:17 fix kernel: [   11.170347]   lock(&parent->list_lock);
Nov 17 17:18:17 fix kernel: [   11.170349]
Nov 17 17:18:17 fix kernel: [   11.170349]  *** DEADLOCK ***
Nov 17 17:18:17 fix kernel: [   11.170350]
Nov 17 17:18:17 fix kernel: [   11.170351]  May be due to missing lock 
nesting notation
Nov 17 17:18:17 fix kernel: [   11.170352]
Nov 17 17:18:17 fix kernel: [   11.170354] 5 locks held by kworker/0:1/20:
Nov 17 17:18:17 fix kernel: [   11.170355]  #0:  (events){.+.+.+}, at: 
[<ffffffff810834ec>] process_one_work+0x12c/0x5a0
Nov 17 17:18:17 fix kernel: [   11.170360]  #1: 
((&(reap_work)->work)){+.+...}, at: [<ffffffff810834ec>] 
process_one_work+0x12c/0x5a0
Nov 17 17:18:17 fix kernel: [   11.170364]  #2: 
(cache_chain_mutex){+.+.+.}, at: [<ffffffff811689ae>] cache_reap+0x2e/0x1b0
Nov 17 17:18:17 fix kernel: [   11.170369]  #3:  (&per_cpu(slab_lock, 
__cpu).lock){+.+...}, at: [<ffffffff81168277>] 
drain_array.part.43+0x77/0x220
Nov 17 17:18:17 fix kernel: [   11.170374]  #4: 
(&parent->list_lock){+.+...}, at: [<ffffffff811682c2>] 
drain_array.part.43+0xc2/0x220
Nov 17 17:18:17 fix kernel: [   11.170378]
Nov 17 17:18:17 fix kernel: [   11.170379] stack backtrace:
Nov 17 17:18:17 fix kernel: [   11.170381] Pid: 20, comm: kworker/0:1 
Not tainted 3.0.9-25-rt #0
Nov 17 17:18:17 fix kernel: [   11.170383] Call Trace:
Nov 17 17:18:17 fix kernel: [   11.170388]  [<ffffffff810a0097>] 
print_deadlock_bug+0xf7/0x100
Nov 17 17:18:17 fix kernel: [   11.170392]  [<ffffffff810a1add>] 
validate_chain.isra.37+0x67d/0x720
Nov 17 17:18:17 fix kernel: [   11.170396]  [<ffffffff810a2478>] 
__lock_acquire+0x478/0x9c0
Nov 17 17:18:17 fix kernel: [   11.170399]  [<ffffffff8162ae19>] ? 
sub_preempt_count+0x29/0x60
Nov 17 17:18:17 fix kernel: [   11.170404]  [<ffffffff81627475>] ? 
_raw_spin_unlock+0x35/0x60
Nov 17 17:18:17 fix kernel: [   11.170407]  [<ffffffff81625f0b>] ? 
rt_spin_lock_slowlock+0x2eb/0x340
Nov 17 17:18:17 fix kernel: [   11.170410]  [<ffffffff8162ae19>] ? 
sub_preempt_count+0x29/0x60
Nov 17 17:18:17 fix kernel: [   11.170413]  [<ffffffff81613e63>] ? 
cache_flusharray+0x47/0xd6
Nov 17 17:18:17 fix kernel: [   11.170416]  [<ffffffff810a2f64>] 
lock_acquire+0x94/0x160
Nov 17 17:18:17 fix kernel: [   11.170419]  [<ffffffff81613e63>] ? 
cache_flusharray+0x47/0xd6
Nov 17 17:18:17 fix kernel: [   11.170422]  [<ffffffff81626999>] 
rt_spin_lock+0x39/0x40
Nov 17 17:18:17 fix kernel: [   11.170425]  [<ffffffff81613e63>] ? 
cache_flusharray+0x47/0xd6
Nov 17 17:18:17 fix kernel: [   11.170428]  [<ffffffff810a3a4d>] ? 
trace_hardirqs_on_caller+0x13d/0x180
Nov 17 17:18:17 fix kernel: [   11.170431]  [<ffffffff81613e63>] 
cache_flusharray+0x47/0xd6
Nov 17 17:18:17 fix kernel: [   11.170435]  [<ffffffff81167a41>] 
kmem_cache_free+0x221/0x300
Nov 17 17:18:17 fix kernel: [   11.170438]  [<ffffffff81167b8f>] 
slab_destroy+0x6f/0xa0
Nov 17 17:18:17 fix kernel: [   11.170441]  [<ffffffff81167d32>] 
free_block+0x172/0x190
Nov 17 17:18:17 fix kernel: [   11.170444]  [<ffffffff81168313>] 
drain_array.part.43+0x113/0x220
Nov 17 17:18:17 fix kernel: [   11.170448]  [<ffffffff81168455>] 
drain_array+0x35/0x40
Nov 17 17:18:17 fix kernel: [   11.170451]  [<ffffffff81168a36>] 
cache_reap+0xb6/0x1b0
Nov 17 17:18:17 fix kernel: [   11.170454]  [<ffffffff81168980>] ? 
drain_freelist+0x2c0/0x2c0
Nov 17 17:18:17 fix kernel: [   11.170457]  [<ffffffff81083554>] 
process_one_work+0x194/0x5a0
Nov 17 17:18:17 fix kernel: [   11.170459]  [<ffffffff810834ec>] ? 
process_one_work+0x12c/0x5a0
Nov 17 17:18:17 fix kernel: [   11.170462]  [<ffffffff81083d72>] 
worker_thread+0x182/0x380
Nov 17 17:18:17 fix kernel: [   11.170465]  [<ffffffff81083bf0>] ? 
rescuer_thread+0x250/0x250
Nov 17 17:18:17 fix kernel: [   11.170469]  [<ffffffff81088b81>] 
kthread+0xa1/0xb0
Nov 17 17:18:17 fix kernel: [   11.170472]  [<ffffffff81627411>] ? 
_raw_spin_unlock_irq+0x41/0x70
Nov 17 17:18:17 fix kernel: [   11.170476]  [<ffffffff8104adec>] ? 
finish_task_switch+0x7c/0x130
Nov 17 17:18:17 fix kernel: [   11.170480]  [<ffffffff8162fea4>] 
kernel_thread_helper+0x4/0x10
Nov 17 17:18:17 fix kernel: [   11.170483]  [<ffffffff81627411>] ? 
_raw_spin_unlock_irq+0x41/0x70
Nov 17 17:18:17 fix kernel: [   11.170486]  [<ffffffff81627898>] ? 
retint_restore_args+0x13/0x13
Nov 17 17:18:17 fix kernel: [   11.170490]  [<ffffffff81088ae0>] ? 
__init_kthread_worker+0xa0/0xa0
Nov 17 17:18:17 fix kernel: [   11.170492]  [<ffffffff8162fea0>] ? 
gs_change+0x13/0x13
