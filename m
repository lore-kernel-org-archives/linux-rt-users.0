Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7AAAC433F5
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Sep 2021 09:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE8EC61288
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Sep 2021 09:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349177AbhI3JCe (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 30 Sep 2021 05:02:34 -0400
Received: from foss.arm.com ([217.140.110.172]:50766 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348335AbhI3JCd (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 30 Sep 2021 05:02:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0AF56D6E;
        Thu, 30 Sep 2021 02:00:51 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.196.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 084F13F793;
        Thu, 30 Sep 2021 02:00:47 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, rcu@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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
        Mike Galbraith <efault@gmx.de>
Subject: Re: rcu/tree: Protect rcu_rdp_is_offloaded() invocations on RT
In-Reply-To: <87pmt163al.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
References: <20210811201354.1976839-1-valentin.schneider@arm.com> <20210811201354.1976839-4-valentin.schneider@arm.com> <874kae6n3g.ffs@tglx> <87pmt163al.ffs@tglx>
Date:   Thu, 30 Sep 2021 10:00:39 +0100
Message-ID: <87h7e21lqg.mognet@arm.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

On 21/09/21 23:12, Thomas Gleixner wrote:
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
>

Thanks for taking a look at this!

My reasoning for adding protection in the outer functions was to prevent
impaired unlocks of rcu_nocb_{un}lock_irqsave(), as that too depends on the
offload state. Cf. Frederic's writeup:

  http://lore.kernel.org/r/20210727230814.GC283787@lothringen

Anywho, I see Frederic has sent a fancy new series, let me go stare at it.
