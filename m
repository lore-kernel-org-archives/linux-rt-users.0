Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7596C433EF
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Sep 2021 10:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8329A61994
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Sep 2021 10:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350175AbhI3KzZ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 30 Sep 2021 06:55:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:50964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350129AbhI3KzZ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 30 Sep 2021 06:55:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4036A6187A;
        Thu, 30 Sep 2021 10:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632999222;
        bh=Vp+UOmjo2TAmos1MjthOIfOMHBv+7U04bMTdFcbYhHo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=opOV9QNmIYkzLfJCVy2HEE20PLjIPp4qY32wypfQjSz3pljfWz965Sohz6o3uXht1
         1nxFni3apPDtVDpptkXitiHOn//qJsID+We7uqh84mBilEFapzgI4c1uEJER4NYcSU
         Np16+fwSfmZ2AF1CtJJr19juCj26PkVURrKkEOArtb3flrTTM3V9K1V9WLOCZHTEqe
         8tlQn/tq1HPuxdbuQ2reM+2BIp++InQE38DgK/D2VRztd/mW3poQUO3NE9ahYSQp9Q
         5BJSK37ary1nX7f/ntzvQJNmIHAJGVeaG09oKSxpN9bY8ty1vtavee7leHre0yErkQ
         w0a0UwU+nJCkA==
Date:   Thu, 30 Sep 2021 12:53:40 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, rcu@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
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
Message-ID: <20210930105340.GA232241@lothringen>
References: <20210811201354.1976839-1-valentin.schneider@arm.com>
 <20210811201354.1976839-4-valentin.schneider@arm.com>
 <874kae6n3g.ffs@tglx>
 <87pmt163al.ffs@tglx>
 <87h7e21lqg.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h7e21lqg.mognet@arm.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Sep 30, 2021 at 10:00:39AM +0100, Valentin Schneider wrote:
> Hi,
> 
> On 21/09/21 23:12, Thomas Gleixner wrote:
> > Valentin reported warnings about suspicious RCU usage on RT kernels. Those
> > happen when offloading of RCU callbacks is enabled:
> >
> >   WARNING: suspicious RCU usage
> >   5.13.0-rt1 #20 Not tainted
> >   -----------------------------
> >   kernel/rcu/tree_plugin.h:69 Unsafe read of RCU_NOCB offloaded state!
> >
> >   rcu_rdp_is_offloaded (kernel/rcu/tree_plugin.h:69 kernel/rcu/tree_plugin.h:58)
> >   rcu_core (kernel/rcu/tree.c:2332 kernel/rcu/tree.c:2398 kernel/rcu/tree.c:2777)
> >   rcu_cpu_kthread (./include/linux/bottom_half.h:32 kernel/rcu/tree.c:2876)
> >
> > The reason is that rcu_rdp_is_offloaded() is invoked without one of the
> > required protections on RT enabled kernels because local_bh_disable() does
> > not disable preemption on RT.
> >
> > Valentin proposed to add a local lock to the code in question, but that's
> > suboptimal in several aspects:
> >
> >   1) local locks add extra code to !RT kernels for no value.
> >
> >   2) All possible callsites have to audited and amended when affected
> >      possible at an outer function level due to lock nesting issues.
> >
> >   3) As the local lock has to be taken at the outer functions it's required
> >      to release and reacquire them in the inner code sections which might
> >      voluntary schedule, e.g. rcu_do_batch().
> >
> > Both callsites of rcu_rdp_is_offloaded() which trigger this check invoke
> > rcu_rdp_is_offloaded() in the variable declaration section right at the top
> > of the functions. But the actual usage of the result is either within a
> > section which provides the required protections or after such a section.
> >
> > So the obvious solution is to move the invocation into the code sections
> > which provide the proper protections, which solves the problem for RT and
> > does not have any impact on !RT kernels.
> >
> 
> Thanks for taking a look at this!
> 
> My reasoning for adding protection in the outer functions was to prevent
> impaired unlocks of rcu_nocb_{un}lock_irqsave(), as that too depends on the
> offload state. Cf. Frederic's writeup:
> 
>   http://lore.kernel.org/r/20210727230814.GC283787@lothringen

I was wrong about that BTW!
Because rcu_nocb_lock() always require IRQs to be disabled, which of course disables
preemption, so the offloaded state can't change between
rcu_nocb_lock[_irqsave]() and rcu_nocb_unlock[_irqrestore]() but anyway there
were many other issues to fix :-)


> 
> Anywho, I see Frederic has sent a fancy new series, let me go stare at it.
