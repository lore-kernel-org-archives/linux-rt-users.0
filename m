Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF03C433EF
	for <linux-rt-users@archiver.kernel.org>; Tue, 21 Sep 2021 23:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3701604DC
	for <linux-rt-users@archiver.kernel.org>; Tue, 21 Sep 2021 23:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhIUXh7 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 21 Sep 2021 19:37:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:37422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230216AbhIUXh7 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 21 Sep 2021 19:37:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4CAAB6115A;
        Tue, 21 Sep 2021 23:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632267390;
        bh=SdAclgW8rsWgIlhdwVa7bbKYbLTEIxPOEyfgqzy5CLE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MLemCllyQAnw7VN1/IYQUh0a6/PfTrQSEnTc7763xoAw45YjX80FefVcxQMKsS+eV
         FUERvTNl4GCnO18raNIQ3xTud0NLBBeF4jIIXw2VZUybeNKZDwjcMNJLfgsZ3q7zmp
         zUPLsYgmtFl35liRWWbJVjaAcDoPVqdTzT0i5CrfR4K99NuvJWZTHj841jc4PX1Ih4
         zYteNPi8vWegtNE44UHsj4hyBT9AyBYDirRt+inhhm4wzF2nkoLOKzqbG4A5c0e5jY
         v9UtCo2JlBbHkVHfW+gNFd4o+AOuAzu4jU/pVNBkoAxUAbFkC9XB3aXGz5MMEAFYUF
         R0Yot4RbcGqmQ==
Date:   Wed, 22 Sep 2021 01:36:27 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rcu@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Steven Price <steven.price@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: rcu/tree: Protect rcu_rdp_is_offloaded() invocations on RT
Message-ID: <20210921233627.GA100318@lothringen>
References: <20210811201354.1976839-1-valentin.schneider@arm.com>
 <20210811201354.1976839-4-valentin.schneider@arm.com>
 <874kae6n3g.ffs@tglx>
 <87pmt163al.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pmt163al.ffs@tglx>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Sep 21, 2021 at 11:12:50PM +0200, Thomas Gleixner wrote:
> Valentin reported warnings about suspicious RCU usage on RT kernels. Those
> happen when offloading of RCU callbacks is enabled:
> 
>   WARNING: suspicious RCU usage
>   5.13.0-rt1 #20 Not tainted
>   -----------------------------
>   kernel/rcu/tree_plugin.h:69 Unsafe read of RCU_NOCB offloaded state!
> 
>   rcu_rdp_is_offloaded (kernel/rcu/tree_plugin.h:69 kernel/rcu/tree_plugin.h:58)
>   rcu_core (kernel/rcu/tree.c:2332 kernel/rcu/tree.c:2398 kernel/rcu/tree.c:2777)
>   rcu_cpu_kthread (./include/linux/bottom_half.h:32 kernel/rcu/tree.c:2876)
> 
> The reason is that rcu_rdp_is_offloaded() is invoked without one of the
> required protections on RT enabled kernels because local_bh_disable() does
> not disable preemption on RT.
> 
> Valentin proposed to add a local lock to the code in question, but that's
> suboptimal in several aspects:
> 
>   1) local locks add extra code to !RT kernels for no value.
> 
>   2) All possible callsites have to audited and amended when affected
>      possible at an outer function level due to lock nesting issues.
> 
>   3) As the local lock has to be taken at the outer functions it's required
>      to release and reacquire them in the inner code sections which might
>      voluntary schedule, e.g. rcu_do_batch().
> 
> Both callsites of rcu_rdp_is_offloaded() which trigger this check invoke
> rcu_rdp_is_offloaded() in the variable declaration section right at the top
> of the functions. But the actual usage of the result is either within a
> section which provides the required protections or after such a section.
> 
> So the obvious solution is to move the invocation into the code sections
> which provide the proper protections, which solves the problem for RT and
> does not have any impact on !RT kernels.

You also need to consider rcu_segcblist_completely_offloaded(). There
are two users:

1) The first chunk using it in rcu_core() checks if there is a need to
accelerate the callback and that can happen concurrently with nocb
manipulations on the cblist. Concurrent (de-)offloading could mess
up with the locking state but here is what we can do:

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index bce848e50512..3e56a1a4af03 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2728,9 +2728,10 @@ static __latent_entropy void rcu_core(void)
 
 	/* No grace period and unregistered callbacks? */
 	if (!rcu_gp_in_progress() &&
-	    rcu_segcblist_is_enabled(&rdp->cblist) && do_batch) {
+	    rcu_segcblist_is_enabled(&rdp->cblist)) {
 		rcu_nocb_lock_irqsave(rdp, flags);
-		if (!rcu_segcblist_restempty(&rdp->cblist, RCU_NEXT_READY_TAIL))
+		if (!rcu_segcblist_completely_offloaded(&rdp->cblist) &&
+		    !rcu_segcblist_restempty(&rdp->cblist, RCU_NEXT_READY_TAIL))
 			rcu_accelerate_cbs_unlocked(rnp, rdp);
 		rcu_nocb_unlock_irqrestore(rdp, flags);
 	}
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 305cf6aeb408..64d615be3346 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -449,10 +449,9 @@ static void rcu_lockdep_assert_cblist_protected(struct rcu_data *rdp);
 static void __init rcu_organize_nocb_kthreads(void);
 #define rcu_nocb_lock_irqsave(rdp, flags)				\
 do {									\
+	local_irq_save(flags);						\
 	if (!rcu_segcblist_is_offloaded(&(rdp)->cblist))		\
-		local_irq_save(flags);					\
-	else								\
-		raw_spin_lock_irqsave(&(rdp)->nocb_lock, (flags));	\
+		raw_spin_lock(&(rdp)->nocb_lock);			\
 } while (0)
 #else /* #ifdef CONFIG_RCU_NOCB_CPU */
 #define rcu_nocb_lock_irqsave(rdp, flags) local_irq_save(flags)


Doing the local_irq_save() before checking that the segcblist is offloaded
protect that state from being changed (provided we lock the local rdp). Then we
can safely manipulate cblist, whether locked or unlocked.

2) The actual call to rcu_do_batch(). If we are preempted between
rcu_segcblist_completely_offloaded() and rcu_do_batch() with a deoffload in
the middle, we miss the callback invocation. Invoking rcu_core by the end of
deoffloading process should solve that.

> 
> Reported-by: Valentin Schneider <valentin.schneider@arm.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/rcu/tree.c |    7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2278,13 +2278,13 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
>  {
>  	unsigned long flags;
>  	unsigned long mask;
> -	bool needwake = false;
> -	const bool offloaded = rcu_rdp_is_offloaded(rdp);
> +	bool offloaded, needwake = false;
>  	struct rcu_node *rnp;
>  
>  	WARN_ON_ONCE(rdp->cpu != smp_processor_id());
>  	rnp = rdp->mynode;
>  	raw_spin_lock_irqsave_rcu_node(rnp, flags);
> +	offloaded = rcu_rdp_is_offloaded(rdp);
>  	if (rdp->cpu_no_qs.b.norm || rdp->gp_seq != rnp->gp_seq ||
>  	    rdp->gpwrap) {

BTW Paul, if we happen to switch to non-NOCB (deoffload) some time after
rcu_report_qs_rdp(), it's possible that the rcu_accelerate_cbs()
that was supposed to be handled by nocb kthreads on behalf of
rcu_core() -> rcu_report_qs_rdp() would not happen. At least not until
we invoke rcu_core() again. Not sure how much harm that could cause.

> @@ -2446,7 +2446,7 @@ static void rcu_do_batch(struct rcu_data
>  	int div;
>  	bool __maybe_unused empty;
>  	unsigned long flags;
> -	const bool offloaded = rcu_rdp_is_offloaded(rdp);
> +	bool offloaded;
>  	struct rcu_head *rhp;
>  	struct rcu_cblist rcl = RCU_CBLIST_INITIALIZER(rcl);
>  	long bl, count = 0;
> @@ -2472,6 +2472,7 @@ static void rcu_do_batch(struct rcu_data
>  	rcu_nocb_lock(rdp);
>  	WARN_ON_ONCE(cpu_is_offline(smp_processor_id()));
>  	pending = rcu_segcblist_n_cbs(&rdp->cblist);
> +	offloaded = rcu_rdp_is_offloaded(rdp);

offloaded is also checked later in rcu_do_batch(), after irqrestore. In
fact that should even become a rcu_segcblist_completely_offloaded() check
there because if there are still pending callbacks while we are de-offloading,
rcu_core() should be invoked. Hmm but that might be a remote rcu_core...

Anyway I guess we could live with some of those races with invoking rcu core on the
target after deoffloading.

I guess I should cook a series to handle all these issues one by one, then
probably we can live without a local_lock().

Thanks.



>  	div = READ_ONCE(rcu_divisor);
>  	div = div < 0 ? 7 : div > sizeof(long) * 8 - 2 ? sizeof(long) * 8 - 2 : div;
>  	bl = max(rdp->blimit, pending >> div);
