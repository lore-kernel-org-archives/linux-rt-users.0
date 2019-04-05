Return-Path: <SRS0=lqhu=SH=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBCEC4360F
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Apr 2019 15:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECBD121852
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Apr 2019 15:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730587AbfDEPnF (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 5 Apr 2019 11:43:05 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49189 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbfDEPnF (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 5 Apr 2019 11:43:05 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hCQzb-000729-Py; Fri, 05 Apr 2019 17:42:59 +0200
Date:   Fri, 5 Apr 2019 17:42:59 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Julien Grall <julien.grall@arm.com>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rt-users@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] arm64/fpsimd: Don't disable softirq when touching
 FPSIMD/SVE state
Message-ID: <20190405154259.3g3fv72miizm64hc@linutronix.de>
References: <20190208165513.8435-1-julien.grall@arm.com>
 <20190404105233.GD3567@e103592.cambridge.arm.com>
 <a46f9fd4-dd31-c892-aec1-ae69072be92d@arm.com>
 <20190405143942.xtpq5443qbc4gziy@linutronix.de>
 <dabf5b36-d22e-e8a3-c01f-6b0f5b3be710@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dabf5b36-d22e-e8a3-c01f-6b0f5b3be710@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-04-05 16:17:50 [+0100], Julien Grall wrote:
> Hi,
Hi,

> > A per-CPU lock? It has to be a raw_spinlock_t because a normal
> > spin_lock() / local_lock() would allow scheduling and might be taken as
> > part of the context switch or soon after.
> raw_spinlock_t would not work here without disabling preemption. Otherwise
> you may end up to recurse on the lock and therefore deadlock. But then it
> raise the question of the usefulness of the lock here.
> 
> However, I don't really understand why allowing the scheduling would be a
> problem here. Is it a concern because we will waste cycle trying to
> restore/save a context that will be scratched as soon as we release the
> lock?

If you hold the lock within the kernel thread and every kernel thread
acquires it before doing any SIMD operations then you are good. It could
be a sleeping lock. What happens if you hold the lock, are scheduled out
and a user task is about to be scheduled? How do you force the kernel
thread out / give up the FPU registers?

That preempt_disable() + local_bh_disable() might not be the pretties
thing but how bad is it actually?
Latency wise you can't schedule(). From RT point of view you need to
enable preemption while going from page to page because of the possible
kmap() or kmalloc() (on baldy aligned src/dst) with the crypto's
page-walk code.
If that is not good enough latency wise you could do
kernel_fpu_resched() after a few iterations. Currently I'm trying to get
kernel_fpu_begin()/end() cheap on x86 so it doesn't always store/restore
the FPU context. Then kernel_fpu_resched() shouldn't be that bad.

> Cheers,

Sebastian
