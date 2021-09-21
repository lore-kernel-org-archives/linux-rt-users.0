Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82235C433EF
	for <linux-rt-users@archiver.kernel.org>; Tue, 21 Sep 2021 23:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AA6F61178
	for <linux-rt-users@archiver.kernel.org>; Tue, 21 Sep 2021 23:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbhIUXqu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 21 Sep 2021 19:46:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:40514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229824AbhIUXqu (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 21 Sep 2021 19:46:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 73FB460F6D;
        Tue, 21 Sep 2021 23:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632267921;
        bh=4Bdk7t7Ff4sxxY+JAbnfv4+PRj6aM+D+XVagYS8TOp0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LFrEbKVQKJl47R1ka/rgx6b6MDMPN0zdxTWT50HGMGD8V7B3FQ4iZBqvyz7SAIy0E
         YfoXQNGfQvipOuROtu5wwEUgve5Wk0HLb7JBYekEFGpHA/tdnkdXKEyzGLNF51lwQ3
         g9zdycLNbYgwUJZFgxzGv3wKDCwWZrS8iFnQgogx2238RiAfXz3azwCHiBfLgpKyZU
         P94utw1KHIZW3stUoWYDe/uJBX3l/VG5yf9X1TKiFqJDZcDLyytABkapFcypcUtPV1
         x45rwCx7gP1Qs/+v75EXbl0HkS2RqnsdpbJ9+ziQnM2NE4JIlHZCcZ9ep4MAqkC3TV
         rR2zwqmzebsEw==
Date:   Wed, 22 Sep 2021 01:45:18 +0200
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
Message-ID: <20210921234518.GB100318@lothringen>
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

Also while at it, I'm asking again: traditionally softirqs could assume that
manipulating a local state was safe against !irq_count() code fiddling with
the same state on the same CPU.

Now with preemptible softirqs, that assumption can be broken anytime. RCU was
fortunate enough to have a warning for that. But who knows how many issues like
this are lurking?

Thanks.
