Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C91C4338F
	for <linux-rt-users@archiver.kernel.org>; Tue, 27 Jul 2021 19:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 959A360F59
	for <linux-rt-users@archiver.kernel.org>; Tue, 27 Jul 2021 19:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbhG0TpK (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 27 Jul 2021 15:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhG0TpJ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 27 Jul 2021 15:45:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01AB3C061757;
        Tue, 27 Jul 2021 12:45:09 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627415107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H8/IIU+aB1t6TDYNpxasWarmhkT94jFM3Vp8vz2AmpY=;
        b=T8aHoqTIldcfrnPdk4L9Tj9tc7CQmBgEoezkPhu55BKUewqL+/xxrx3PUWfJvpC2dCYVPk
        Zz2VNcpEU1SHgNsEXkSW/YV9fxF+/PeF2G42Z91jL+nhBJaV3Ub96G7LC6gQVhkmiVUiNf
        Yr14MgUhO0e3RdPGf5Al48z4GVu4zfDe2ELEULCy5WaN61T7co9h1o2+L3I0qZUhyFjLqC
        9LkXZ7pPqOcNDX6y78UB7mQQfGFyN4k1Y4ekpJcrJHEgP0Xn3idPabLXfxzItKobJ92Qfa
        SUWfIAgtucxVQr+rPWyl4XDENEOQlEHVmWr0b3/sZGcjJPEtDOZWTJZb6Y9RHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627415107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H8/IIU+aB1t6TDYNpxasWarmhkT94jFM3Vp8vz2AmpY=;
        b=lVhT3s25TqlbzgFLFU2veorcFeYbC2iFjLnzRAIfrxdIRPnACKriiPB2FthXsjzl7cbM9I
        YH2sWh6/ElS2PhCg==
To:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rt-users@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Steven Price <steven.price@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 0/3] sched: migrate_disable() vs per-CPU access safety checks
In-Reply-To: <20210721115118.729943-1-valentin.schneider@arm.com>
References: <20210721115118.729943-1-valentin.schneider@arm.com>
Date:   Tue, 27 Jul 2021 21:45:07 +0200
Message-ID: <87tukfpmm4.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Jul 21 2021 at 12:51, Valentin Schneider wrote:
> Hi folks,
>
> I've hit a few warnings when taking v5.13-rt1 out for a spin on my arm64
> Juno. Those are due to regions that become preemptible under PREEMPT_RT, but
> remain safe wrt per-CPU accesses due to migrate_disable() + a sleepable lock.
>
> This adds a helper that looks at not just preemptability but also affinity and
> migrate disable, and plasters the warning sites.

Nice!

I just pulled that into the RT queue and it will show up with the next
release.

Thanks,

        tglx
