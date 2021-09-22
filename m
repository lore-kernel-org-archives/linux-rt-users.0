Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0CAC4332F
	for <linux-rt-users@archiver.kernel.org>; Wed, 22 Sep 2021 11:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1955361156
	for <linux-rt-users@archiver.kernel.org>; Wed, 22 Sep 2021 11:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235687AbhIVLcz (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 22 Sep 2021 07:32:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:45084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235653AbhIVLcz (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 22 Sep 2021 07:32:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9179961107;
        Wed, 22 Sep 2021 11:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632310280;
        bh=iJ4gFjba6VMQSTmcSmAOGGLCLhgvn3+9o9mo/NMTbAQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BQMqT049yHHdHUNbCF31bCFctTSI/QFHJ42DCvyAj7gzz1FXUKej2OZL6dkwaxY1P
         aqYoGsT+9RDD2ENpCtkK8MKO7sJIDnJXYlqPzdAW9l7xG7epl5wlPEPKrbzrfaT/jx
         mhsg/hx0MytptK8RBU6ovKplk9Ia1nPIgRFANZZD7P0NAf96OlvpaTYk1JPlr1HK0K
         XqfDNVk/XDGx2j3VPi4m818u10ljzFGxPdX8GI0EWEvvXwYA0/6RvDcTXc+11H4u80
         0fOged2Rff/k3rSAQbAbMJS3gAk0BCwfkKKHg2lxqrKpnJOIIVjq1O5NSMTRx028y6
         Q7pTDSe9YwOag==
Date:   Wed, 22 Sep 2021 13:31:17 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rcu@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
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
Message-ID: <20210922113117.GB106513@lothringen>
References: <20210811201354.1976839-1-valentin.schneider@arm.com>
 <20210811201354.1976839-4-valentin.schneider@arm.com>
 <874kae6n3g.ffs@tglx>
 <87pmt163al.ffs@tglx>
 <20210921233627.GA100318@lothringen>
 <20210922021837.GV880162@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922021837.GV880162@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Sep 21, 2021 at 07:18:37PM -0700, Paul E. McKenney wrote:
> On Wed, Sep 22, 2021 at 01:36:27AM +0200, Frederic Weisbecker wrote:
> > Doing the local_irq_save() before checking that the segcblist is offloaded
> > protect that state from being changed (provided we lock the local rdp). Then we
> > can safely manipulate cblist, whether locked or unlocked.
> > 
> > 2) The actual call to rcu_do_batch(). If we are preempted between
> > rcu_segcblist_completely_offloaded() and rcu_do_batch() with a deoffload in
> > the middle, we miss the callback invocation. Invoking rcu_core by the end of
> > deoffloading process should solve that.
> 
> Maybe invoke rcu_core() at that point?  My concern is that there might
> be an extended time between the missed rcu_do_batch() and the end of
> the deoffloading process.

Agreed!

> 
> > > Reported-by: Valentin Schneider <valentin.schneider@arm.com>
> > > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > > ---
> > >  kernel/rcu/tree.c |    7 ++++---
> > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > 
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -2278,13 +2278,13 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
> > >  {
> > >  	unsigned long flags;
> > >  	unsigned long mask;
> > > -	bool needwake = false;
> > > -	const bool offloaded = rcu_rdp_is_offloaded(rdp);
> > > +	bool offloaded, needwake = false;
> > >  	struct rcu_node *rnp;
> > >  
> > >  	WARN_ON_ONCE(rdp->cpu != smp_processor_id());
> > >  	rnp = rdp->mynode;
> > >  	raw_spin_lock_irqsave_rcu_node(rnp, flags);
> > > +	offloaded = rcu_rdp_is_offloaded(rdp);
> > >  	if (rdp->cpu_no_qs.b.norm || rdp->gp_seq != rnp->gp_seq ||
> > >  	    rdp->gpwrap) {
> > 
> > BTW Paul, if we happen to switch to non-NOCB (deoffload) some time after
> > rcu_report_qs_rdp(), it's possible that the rcu_accelerate_cbs()
> > that was supposed to be handled by nocb kthreads on behalf of
> > rcu_core() -> rcu_report_qs_rdp() would not happen. At least not until
> > we invoke rcu_core() again. Not sure how much harm that could cause.
> 
> Again, can we just invoke rcu_core() as soon as this is noticed?

Right. So I'm going to do things a bit differently. I'm going to add
a new segcblist state flag so that during the deoffloading process,
the first very step is an invoke_rcu_core() on the target after setting a
flag that requires handling all this things: accelerate/do_batch, etc...

Then will remain the "do we still have pending callbacks after do_batch?"
in which case we'll need to invoke the rcu_core again as long as we are in
the middle of deoffloading.

Ok, now to write the patches.
