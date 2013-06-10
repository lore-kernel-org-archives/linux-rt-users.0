From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/2] Avoid more bit_spin_lock usage on RT kernels
Date: Mon, 10 Jun 2013 14:56:31 -0700
Message-ID: <20130610215631.GU5146@linux.vnet.ibm.com>
References: <1370900209-40769-1-git-send-email-paul.gortmaker@windriver.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: rostedt@goodmis.org, tglx@linutronix.de, bigeasy@linutronix.de,
	linux-rt-users@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:51702 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752907Ab3FJV4f (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 10 Jun 2013 17:56:35 -0400
Received: from /spool/local
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-rt-users@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Mon, 10 Jun 2013 15:56:35 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com [9.17.195.228])
	by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 093663E40042
	for <linux-rt-users@vger.kernel.org>; Mon, 10 Jun 2013 15:56:15 -0600 (MDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r5ALuXJq144990
	for <linux-rt-users@vger.kernel.org>; Mon, 10 Jun 2013 15:56:33 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r5ALws7f017919
	for <linux-rt-users@vger.kernel.org>; Mon, 10 Jun 2013 15:58:55 -0600
Content-Disposition: inline
In-Reply-To: <1370900209-40769-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Jun 10, 2013 at 05:36:47PM -0400, Paul Gortmaker wrote:
> The bit_spin_locks have been problematic on RT for a long time; dating
> at least back to 2.6.11 and their use in the journalling code[1].  We
> still have patches today that clobber them for cgroups and jbd/jbd2
> code on RT[2].  But there have been some newer users added.
> 
> In commit 4e35e6070b1c [2.6.38] ("kernel: add bl_list") we got
> the list heads with the zero'th bit reserved for locking.
> 
> It was shortly followed with ceb5bdc2d24 ("fs: dcache per-bucket
> dcache hash locking") that made it clear the bit was now being used
> in a bit_spin_lock context (e.g. in fs/dcache.c).
> 
> As of commit 1879fd6a265 [2.6.39] ("add hlist_bl_lock/unlock helpers")
> we got helper functions that combined the open coded bit locks into
> one place.  At the same time, it makes it more clear that bit_spin_lock
> is being used, and where.
> 
> Assuming that we still can not use the bit_spin_lock safely on RT,
> then users of these helpers will also result in unsafe usage.  Following
> the style of "fix" used for jbd code[2], I've done a similar thing here
> and introduce a stand-alone lock for the list head.  This may be less
> than ideal from a performance standpoint -- currently unclear to me.
> 
> I can't pin an actual failing on not having these patches present; I
> came by it simply by inspecting the jbd2 code while trying to diagnose
> another problem (one which these patches unfortunately don't fix) and
> ended up searching for users of bit_spin.
> 
> Noting the above, there is also another use case which may be
> undesireable for RT -- for the RT trees which now support SLUB,
> there is a bit_spin_lock used for slab_lock/slab_unlock....  I'll
> only mention it here and leave it for a separate thread/discussion.
> 
> I'm calling these RFC patches, meant to just start discussion.  The
> two patches could obviously be squashed into one, but I wanted the
> 2nd (rawlock) to remain separate since it shows why it becomes raw,
> and I'm not 100% convinced that my assumption that it is OK from a
> latency perspective to be raw is actually a valid one yet.
> 
> In addition, we probably want to be looking at Eric/PaulM's patch
> currently in net-next:  c87a124a5d ("net: force a reload of first
> item in hlist_nulls_for_each_entry_rcu") [3] -- as a candidate for
> cherry-pick onto RT, I think.  It will get there eventually via
> DaveM --> GregKH --> Steve path (for the rt-stable branches).
> 
> Patches attached here were from a v3.6.11.5-rt37 based tree.

They both look good to me:

Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

> Paul.
> --
> 
> [1] http://linux.kernel.narkive.com/octAmqz8/patch-real-time-preemption-rt-2-6-11-rc3-v0-7-38-01.4
> 
> [2] http://git.kernel.org/cgit/linux/kernel/git/paulg/3.6-rt-patches.git/tree/mm-cgroup-page-bit-spinlock.patch
>     http://git.kernel.org/cgit/linux/kernel/git/paulg/3.6-rt-patches.git/tree/fs-jbd-replace-bh_state-lock.patch
> 
> [3] http://patchwork.ozlabs.org/patch/247360/
>     http://git.kernel.org/cgit/linux/kernel/git/davem/net-next.git/commit/?id=c87a124a5d5e8cf8e21c4363c3372bcaf53ea190
> 
> Paul Gortmaker (2):
>   list_bl.h: make list head locking RT safe
>   list_bl: make list head lock a raw lock
> 
>  include/linux/list_bl.h | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
> 
> -- 
> 1.8.1.2
> 

