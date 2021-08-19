Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC79C4320A
	for <linux-rt-users@archiver.kernel.org>; Thu, 19 Aug 2021 15:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B79616101A
	for <linux-rt-users@archiver.kernel.org>; Thu, 19 Aug 2021 15:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239944AbhHSPkI (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 19 Aug 2021 11:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238460AbhHSPkH (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 19 Aug 2021 11:40:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDBBC061575;
        Thu, 19 Aug 2021 08:39:31 -0700 (PDT)
Date:   Thu, 19 Aug 2021 17:39:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629387569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iWpeLWxYnpcuyjwtgPJFLjuLWoaH9JdYuua0wtFLXGs=;
        b=azrGKy/kV/ay49uaHkTdVVen2UxrL+SvGtelaYSNYUV4Hmb1Q1cvdqLMEp9m6H8MAGMDOF
        6CNXJpnRNSRR1LEizhKFAXdsl97YHlaobVXVEVHNj24wXqvgYHRJzwsnaXJjL43Hnmx8aQ
        dP5sU2J2vwiBDLkJpsW2Sk+fWImvseYPd8Yf/+/6fsab512Q+eil1WGqMCAi+ZFRc6hyCV
        +ViL+A2GKIVlFqLYVpr1qQcOWfA+ijS/yEBnxjW3NgnVHcwRBSD4Vbyb0KyjYnp8DsDZUd
        mvSf15QhVWzvLa/+Bsj0ttHQkRYHAOLIHLzc88KoE4hClAr7uMDZq7lUqBgk6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629387569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iWpeLWxYnpcuyjwtgPJFLjuLWoaH9JdYuua0wtFLXGs=;
        b=ep66l36foTvFQ3VQw/MJeGJiBCXN3ghfNnsmtNo1DkPCcqNMNfGJ6p8BcJC1m9IPJfriH9
        /QL629z+BY5x3HAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rcu@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
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
        Mike Galbraith <efault@gmx.de>, Scott Wood <swood@redhat.com>
Subject: Re: [PATCH] rcutorture: Avoid problematic critical section nesting
 on RT
Message-ID: <20210819153927.clqxr4f7qegpflbr@linutronix.de>
References: <20210811201354.1976839-1-valentin.schneider@arm.com>
 <20210811201354.1976839-2-valentin.schneider@arm.com>
 <20210817121345.5iyj5epemczn3a52@linutronix.de>
 <20210817131741.evduh4fw7vyv2dzt@linutronix.de>
 <20210817144018.nqssoq475vitrqlv@linutronix.de>
 <20210818224651.GY4126399@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210818224651.GY4126399@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-08-18 15:46:51 [-0700], Paul E. McKenney wrote:
> > ---
> > --- a/kernel/rcu/rcutorture.c
> > +++ b/kernel/rcu/rcutorture.c
> > @@ -61,10 +61,13 @@ MODULE_AUTHOR("Paul E. McKenney <paulmck
=E2=80=A6
> > -	/* Next, remove old protection, irq first due to bh conflict. */
> > +	/*
> > +	 * Next, remove old protection, in decreasing order of strength
> > +	 * to avoid unlock paths that aren't safe in the stronger
> > +	 * context.  Disable preemption around the ATOM enables in
> > +	 * case the context was only atomic due to IRQ disabling.
> > +	 */
> > +	preempt_disable();
> >  	if (statesold & RCUTORTURE_RDR_IRQ)
> >  		local_irq_enable();
> > -	if (statesold & RCUTORTURE_RDR_BH)
> > +	if (statesold & RCUTORTURE_RDR_ATOM_BH)
> >  		local_bh_enable();
> > +	if (statesold & RCUTORTURE_RDR_ATOM_RBH)
> > +		rcu_read_unlock_bh();
> > +	preempt_enable();
>=20
> The addition of preempt_enable() here prevents rcutorture from covering
> an important part of the mainline RCU state space, namely when an RCU
> read-side section ends with just local_irq_enable().  This situation
> is a challenge for RCU because it must indirectly detect the end of the
> critical section.
>=20
> Would it work for RT if the preempt_enable() and preempt_disable()
> were executed only if either RT on the one hand or statesold has the
> RCUTORTURE_RDR_ATOM_BH or RCUTORTURE_RDR_ATOM_RBH bit set on the other?

Now that I stared at it some more (and it stared briefly back at me) I
couldn't explain why we need this and that piece of the patch so I came
up with following which I can explain:

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 40ef5417d9545..5c8b31b7eff03 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1432,28 +1432,34 @@ static void rcutorture_one_extend(int *readstate, i=
nt newstate,
 	/* First, put new protection in place to avoid critical-section gap. */
 	if (statesnew & RCUTORTURE_RDR_BH)
 		local_bh_disable();
+	if (statesnew & RCUTORTURE_RDR_RBH)
+		rcu_read_lock_bh();
 	if (statesnew & RCUTORTURE_RDR_IRQ)
 		local_irq_disable();
 	if (statesnew & RCUTORTURE_RDR_PREEMPT)
 		preempt_disable();
-	if (statesnew & RCUTORTURE_RDR_RBH)
-		rcu_read_lock_bh();
 	if (statesnew & RCUTORTURE_RDR_SCHED)
 		rcu_read_lock_sched();
 	if (statesnew & RCUTORTURE_RDR_RCU)
 		idxnew =3D cur_ops->readlock() << RCUTORTURE_RDR_SHIFT;
=20
-	/* Next, remove old protection, irq first due to bh conflict. */
+	/*
+	 * Next, remove old protection, in decreasing order of strength
+	 * to avoid unlock paths that aren't safe in the stronger
+	 * context. Namely: BH can not be enabled with disabled interrupts.
+	 * Additionally PREEMPT_RT requires that BH is enabled in preemptible
+	 * context.
+	 */
 	if (statesold & RCUTORTURE_RDR_IRQ)
 		local_irq_enable();
-	if (statesold & RCUTORTURE_RDR_BH)
-		local_bh_enable();
 	if (statesold & RCUTORTURE_RDR_PREEMPT)
 		preempt_enable();
-	if (statesold & RCUTORTURE_RDR_RBH)
-		rcu_read_unlock_bh();
 	if (statesold & RCUTORTURE_RDR_SCHED)
 		rcu_read_unlock_sched();
+	if (statesold & RCUTORTURE_RDR_BH)
+		local_bh_enable();
+	if (statesold & RCUTORTURE_RDR_RBH)
+		rcu_read_unlock_bh();
 	if (statesold & RCUTORTURE_RDR_RCU) {
 		bool lockit =3D !statesnew && !(torture_random(trsp) & 0xffff);
=20
@@ -1496,6 +1502,9 @@ rcutorture_extend_mask(int oldmask, struct torture_ra=
ndom_state *trsp)
 	int mask =3D rcutorture_extend_mask_max();
 	unsigned long randmask1 =3D torture_random(trsp) >> 8;
 	unsigned long randmask2 =3D randmask1 >> 3;
+	unsigned long preempts =3D RCUTORTURE_RDR_PREEMPT | RCUTORTURE_RDR_SCHED;
+	unsigned long preempts_irq =3D preempts | RCUTORTURE_RDR_IRQ;
+	unsigned long bhs =3D RCUTORTURE_RDR_BH | RCUTORTURE_RDR_RBH;
=20
 	WARN_ON_ONCE(mask >> RCUTORTURE_RDR_SHIFT);
 	/* Mostly only one bit (need preemption!), sometimes lots of bits. */
@@ -1503,11 +1512,37 @@ rcutorture_extend_mask(int oldmask, struct torture_=
random_state *trsp)
 		mask =3D mask & randmask2;
 	else
 		mask =3D mask & (1 << (randmask2 % RCUTORTURE_RDR_NBITS));
-	/* Can't enable bh w/irq disabled. */
-	if ((mask & RCUTORTURE_RDR_IRQ) &&
-	    ((!(mask & RCUTORTURE_RDR_BH) && (oldmask & RCUTORTURE_RDR_BH)) ||
-	     (!(mask & RCUTORTURE_RDR_RBH) && (oldmask & RCUTORTURE_RDR_RBH))))
-		mask |=3D RCUTORTURE_RDR_BH | RCUTORTURE_RDR_RBH;
+
+	/*
+	 * Can't enable bh w/irq disabled.
+	 */
+	if (mask & RCUTORTURE_RDR_IRQ)
+		mask |=3D oldmask & bhs;
+
+	/*
+	 * Ideally these sequences would be detected in debug builds
+	 * (regardless of RT), but until then don't stop testing
+	 * them on non-RT.
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		/*
+		 * Can't release the outermost rcu lock in an irq disabled
+		 * section without preemption also being disabled, if irqs
+		 * had ever been enabled during this RCU critical section
+		 * (could leak a special flag and delay reporting the qs).
+		 */
+		if ((oldmask & RCUTORTURE_RDR_RCU) &&
+		    (mask & RCUTORTURE_RDR_IRQ) &&
+		    !(mask & preempts))
+			mask |=3D RCUTORTURE_RDR_RCU;
+
+		/* Can't modify bh in atomic context */
+		if (oldmask & preempts_irq)
+			mask &=3D ~bhs;
+		if ((oldmask | mask) & preempts_irq)
+			mask |=3D oldmask & bhs;
+	}
+
 	return mask ?: RCUTORTURE_RDR_RCU;
 }
=20
