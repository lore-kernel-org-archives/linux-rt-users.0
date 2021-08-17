Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F99C432BE
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Aug 2021 12:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E9816023F
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Aug 2021 12:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239771AbhHQMOX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 17 Aug 2021 08:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236113AbhHQMOW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 17 Aug 2021 08:14:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703ABC061764;
        Tue, 17 Aug 2021 05:13:49 -0700 (PDT)
Date:   Tue, 17 Aug 2021 14:13:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629202426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d+uxAWrK6C0K97c8hr+MoI9FmXO1BEDPSMGIWGczVk8=;
        b=yrlAYk9W1HkvijTPh6VaegiUXmmAdYVcDOkdESa0jH/HQYqih+P+5LqH2QRQOBCmjOCOvK
        oaK1y7xnAS2Fn3a+xQ9/iyH1hO+oNt4KyhK9u4nM7eukazdjM/Y+2NdJtOVddf/X87zihV
        G9b81Qk6himwgAR7xg4OSMbkrNMZsCHs0gXJq47wnSvB2vBr7nn16QnOE65lWLAgyQ4Zbz
        uKH2Hs4ksrRMk+oCuh9HWRkrF2GFcS78Y7ontWCgfSVwGslm/TGeoL/YLhtkwo3sk2KuZ3
        twe0CYOOhF+OoM/rizz4ljcQF39bk49m1+vE9Gkdiyzyh0YwAG7b+m/4gnvc8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629202427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d+uxAWrK6C0K97c8hr+MoI9FmXO1BEDPSMGIWGczVk8=;
        b=v/OZAm542MS2E32XiA5RqzfEd9kCCfdxNFDNsNISAfhDREJorL86wsOolhrmT5IlqkhX2m
        c9C0u9GW5DUbeGBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rcu@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
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
Subject: Re: [PATCH v3 1/4] rcutorture: Don't disable softirqs with
 preemption disabled when PREEMPT_RT
Message-ID: <20210817121345.5iyj5epemczn3a52@linutronix.de>
References: <20210811201354.1976839-1-valentin.schneider@arm.com>
 <20210811201354.1976839-2-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210811201354.1976839-2-valentin.schneider@arm.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-08-11 21:13:51 [+0100], Valentin Schneider wrote:
> Running RCU torture with CONFIG_PREEMPT_RT under v5.14-rc4-rt6 triggers:
>=20
> [    8.755472] DEBUG_LOCKS_WARN_ON(this_cpu_read(softirq_ctrl.cnt))
> [    8.755482] WARNING: CPU: 1 PID: 137 at kernel/softirq.c:172 __local_b=
h_disable_ip (kernel/softirq.c:172 (discriminator 31))
> [    8.755500] Modules linked in:
> [    8.755506] CPU: 1 PID: 137 Comm: rcu_torture_rea Not tainted 5.14.0-r=
c4-rt6 #171
> [    8.755514] Hardware name: ARM Juno development board (r0) (DT)
> [    8.755518] pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=3D--)
> [    8.755622] Call trace:
> [    8.755624] __local_bh_disable_ip (kernel/softirq.c:172 (discriminator=
 31))
> [    8.755633] rcutorture_one_extend (kernel/rcu/rcutorture.c:1453)
> [    8.755640] rcu_torture_one_read (kernel/rcu/rcutorture.c:1601 kernel/=
rcu/rcutorture.c:1645)
> [    8.755645] rcu_torture_reader (kernel/rcu/rcutorture.c:1737)
> [    8.755650] kthread (kernel/kthread.c:327)
> [    8.755656] ret_from_fork (arch/arm64/kernel/entry.S:783)
> [    8.755663] irq event stamp: 11959
> [    8.755666] hardirqs last enabled at (11959): __rcu_read_unlock (kerne=
l/rcu/tree_plugin.h:695 kernel/rcu/tree_plugin.h:451)
> [    8.755675] hardirqs last disabled at (11958): __rcu_read_unlock (kern=
el/rcu/tree_plugin.h:661 kernel/rcu/tree_plugin.h:451)
> [    8.755683] softirqs last enabled at (11950): __local_bh_enable_ip (./=
arch/arm64/include/asm/irqflags.h:85 kernel/softirq.c:261)
> [    8.755692] softirqs last disabled at (11942): rcutorture_one_extend (=
=2E/include/linux/bottom_half.h:19 kernel/rcu/rcutorture.c:1441)
>=20
> Per this warning, softirqs cannot be disabled in a non-preemptible region
> under CONFIG_PREEMPT_RT. Adjust RCU torture accordingly.
>=20
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  kernel/rcu/rcutorture.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index eecd1caef71d..4f3db1d3170d 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -1548,6 +1548,8 @@ rcutorture_extend_mask(int oldmask, struct torture_=
random_state *trsp)
>  	 * them on non-RT.
>  	 */
>  	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> +		/* Can't disable bh in atomic context under PREEMPT_RT */
> +		mask &=3D ~(RCUTORTURE_RDR_ATOM_BH | RCUTORTURE_RDR_ATOM_RBH);

Let me stare at this=E2=80=A6

>  		/*
>  		 * Can't release the outermost rcu lock in an irq disabled
>  		 * section without preemption also being disabled, if irqs
> --=20
> 2.25.1

Sebastian
