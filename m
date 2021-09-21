Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E551C433EF
	for <linux-rt-users@archiver.kernel.org>; Tue, 21 Sep 2021 14:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E7C26115A
	for <linux-rt-users@archiver.kernel.org>; Tue, 21 Sep 2021 14:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbhIUOGi (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 21 Sep 2021 10:06:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48892 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbhIUOGh (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 21 Sep 2021 10:06:37 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632233107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iRZkhuB3q8eWn+Q+IH85cvsi1BXsI2A4fpszlFgTJUU=;
        b=fNNNVdBGg+ZulgR/yTyHw3OPyblYrJkTcS+WFxAIGwuHX+/NhHihA1O68bezkykOCH6+rP
        aj+KRbIMVXK9+xwWRlXdETmYdGguenGbIWi31gR4OhHxo2zW+2VEp/jQgT8VyWV58ThUGY
        si7riMahz8V4dyLV6FikLL9e5gU0JO/7nPfRKywDNfUYHNmY8BkYgTmFmZXM9V6pPpAT+Y
        Qm6ZDXbTrrKF4vLUdhquYJWlJEX7F+p6Frt7rEKWjvw8eh0QXWIY3OTObCyZTihXAz1tyv
        RQwBUaTe8Qiw5Wy3Hf1RylvujyscQHgWKWfIXwSOOj92v2GGSG5taAmDGHqtRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632233107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iRZkhuB3q8eWn+Q+IH85cvsi1BXsI2A4fpszlFgTJUU=;
        b=/92k433iTx4+5yQA3qLenYPKHol2U3cD80NQ9hfx8ufaAt0X5/KFSHo2ByKulagfN2n12I
        p3DTEu1QJXtWH+BQ==
To:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rcu@vger.kernel.org, linux-rt-users@vger.kernel.org
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
Subject: Re: [PATCH v3 3/4] rcu/nocb: Protect NOCB state via local_lock()
 under PREEMPT_RT
In-Reply-To: <20210811201354.1976839-4-valentin.schneider@arm.com>
References: <20210811201354.1976839-1-valentin.schneider@arm.com>
 <20210811201354.1976839-4-valentin.schneider@arm.com>
Date:   Tue, 21 Sep 2021 16:05:07 +0200
Message-ID: <874kae6n3g.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Valentin,

On Wed, Aug 11 2021 at 21:13, Valentin Schneider wrote:
> Running v5.13-rt1 on my arm64 Juno board triggers:
>
> [    0.156302] =============================
> [    0.160416] WARNING: suspicious RCU usage
> [    0.172409] kernel/rcu/tree_plugin.h:69 Unsafe read of RCU_NOCB offloaded state!
> [    0.260328] rcu_rdp_is_offloaded (kernel/rcu/tree_plugin.h:69 kernel/rcu/tree_plugin.h:58)
> [    0.264537] rcu_core (kernel/rcu/tree.c:2332 kernel/rcu/tree.c:2398 kernel/rcu/tree.c:2777)
> [    0.267786] rcu_cpu_kthread (./include/linux/bottom_half.h:32 kernel/rcu/tree.c:2876)
>
> In this case, this is the RCU core kthread accessing the local CPU's
> rdp. Before that, rcu_cpu_kthread() invokes local_bh_disable().
>
> Under !CONFIG_PREEMPT_RT (and rcutree.use_softirq=0), this ends up
> incrementing the preempt_count, which satisfies the "local non-preemptible
> read" of rcu_rdp_is_offloaded().
>
> Under CONFIG_PREEMPT_RT however, this becomes
>
>   local_lock(&softirq_ctrl.lock)
>
> which, under the same config, is migrate_disable() + rt_spin_lock(). As
> pointed out by Frederic, this is not sufficient to safely access an rdp's
> offload state, as the RCU core kthread can be preempted by a kworker
> executing rcu_nocb_rdp_offload() [1].
>
> Introduce a local_lock to serialize an rdp's offload state while the rdp's
> associated core kthread is executing rcu_core().

Yes, sure. But I don't think that local_lock is required at all.

The point is that the two places where this actually matters invoke
rcu_rdp_is_offloaded() just at the top of the function outside of the
anyway existing protection sections. Moving it into the sections which
already provide the required protections makes it just work for both RT
and !RT.

Thanks,

        tglx
---

--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2278,13 +2278,13 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
 {
 	unsigned long flags;
 	unsigned long mask;
-	bool needwake = false;
-	const bool offloaded = rcu_rdp_is_offloaded(rdp);
+	bool offloaded, needwake = false;
 	struct rcu_node *rnp;
 
 	WARN_ON_ONCE(rdp->cpu != smp_processor_id());
 	rnp = rdp->mynode;
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
+	offloaded = rcu_rdp_is_offloaded(rdp);
 	if (rdp->cpu_no_qs.b.norm || rdp->gp_seq != rnp->gp_seq ||
 	    rdp->gpwrap) {
 
@@ -2446,7 +2446,7 @@ static void rcu_do_batch(struct rcu_data
 	int div;
 	bool __maybe_unused empty;
 	unsigned long flags;
-	const bool offloaded = rcu_rdp_is_offloaded(rdp);
+	bool offloaded;
 	struct rcu_head *rhp;
 	struct rcu_cblist rcl = RCU_CBLIST_INITIALIZER(rcl);
 	long bl, count = 0;
@@ -2472,6 +2472,7 @@ static void rcu_do_batch(struct rcu_data
 	rcu_nocb_lock(rdp);
 	WARN_ON_ONCE(cpu_is_offline(smp_processor_id()));
 	pending = rcu_segcblist_n_cbs(&rdp->cblist);
+	offloaded = rcu_rdp_is_offloaded(rdp);
 	div = READ_ONCE(rcu_divisor);
 	div = div < 0 ? 7 : div > sizeof(long) * 8 - 2 ? sizeof(long) * 8 - 2 : div;
 	bl = max(rdp->blimit, pending >> div);
