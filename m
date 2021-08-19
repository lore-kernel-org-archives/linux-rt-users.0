Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D3BC4320A
	for <linux-rt-users@archiver.kernel.org>; Thu, 19 Aug 2021 15:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA303610A6
	for <linux-rt-users@archiver.kernel.org>; Thu, 19 Aug 2021 15:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240362AbhHSPgT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 19 Aug 2021 11:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238729AbhHSPgT (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 19 Aug 2021 11:36:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71CCC061756;
        Thu, 19 Aug 2021 08:35:42 -0700 (PDT)
Date:   Thu, 19 Aug 2021 17:35:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629387339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iPrswfhW1Ilwsn0guUcI0tUC1c5/UDFDCujLK0mMiEE=;
        b=Ja5u2LhGeB0TqKkQfPsnxVJUDuy6veXYHEjk30JcbPxnRSMXhbI8qfKN/T4kn9Io9SMuBu
        A0qOWit45beq7JYzBzKJuyHxFk7Mf11ev4M8cxtVzX39BC5aSdVlu05yZBxQtFO7pfcfQB
        Cq0DAltD4q4IK6lyiNNF1gze/frHh1tF0Zd52FKcoWy1RNS7ZZ4LClETs5ALwRX8aSJqeb
        LhxxrpQ/q3qT3F3TDqIWRtjnezyBrmy7Zs+OUqZ8dNPLchsGmFtk06Khdkdn65ghKuvLlD
        N3cPBxtY7Q6N9FKFA071Ugb3KeEkIarEI42/bE4mfgU6gNqrRNkg0LLAnJHE0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629387339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iPrswfhW1Ilwsn0guUcI0tUC1c5/UDFDCujLK0mMiEE=;
        b=wKe0mK+nyhpcZv0h+r4sNQUVMkb/nO153sUzsVpfaahuTn63171tiz9P1+crD5k4HAWFwk
        8ExR8kHckc57U+Aw==
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
Message-ID: <20210819153537.4vxr54rjrj7x5tzt@linutronix.de>
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
=E2=80=A6
> > +	/*
> > +	 * Ideally these sequences would be detected in debug builds
> > +	 * (regardless of RT), but until then don't stop testing
> > +	 * them on non-RT.
> > +	 */
> > +	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> > +		/*
> > +		 * Can't disable bh in atomic context if bh was already
> > +		 * disabled by another task on the same CPU. Instead of
> > +		 * attempting to track this, just avoid disabling bh in atomic
> > +		 * context.
> > +		 */
> > +		mask &=3D ~atomic_bhs;
>=20
> At some point, we will need to test disabling bh in atomic context,
> correct?  Or am I missing something here?

Ideally there is no disabling bh in atomic context (on RT). Having it
breaks some fundamental rules how softirq handling and the bh related
synchronisation is implemented. Given that the softirq handler is
invoked in thread context and preemption is not disabled as part of
spin_lock(), rcu_read_lock(), and interrupts are in general not disabled
in the interrupt handler or spin_lock_irq() there is close to zero
chance of disabling bh in atomic context on RT.

In reality there is (of course) something that needs to disable bh in
atomic context and it happens only during boot up (or from idle unless
I'm mistaken).
It is required that bh disable and its enable part (later) happens in
the same context that is if bh has been disabled in preemptible context
it must not be enabled in atomic context (and vice versa).

The bottom line is that there must not be a local_bh_disable() in atomic
context if another (preempted) task already did a local_bh_disable() on
the same CPU, like in the following scenario on one CPU:

TASK A                      TASK B
 local_bh_disable();
 =E2=80=A6 preempted
                           preempt_disable();
			   local_bh_disable();

Then this breaks the synchronisation that is otherwise provided by
local_bh_disable(). Without that preempt_disable() TASK B would block
(and wait) until TASK A completes its BH section. In atomic context it
is not possible and therefore not allowed.

Sebastian
