Return-Path: <SRS0=lqhu=SH=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEC0C10F00
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Apr 2019 14:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47D4221855
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Apr 2019 14:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731167AbfDEOjs (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:39:48 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:48765 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfDEOjr (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 5 Apr 2019 10:39:47 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hCQ0N-0004qu-7m; Fri, 05 Apr 2019 16:39:43 +0200
Date:   Fri, 5 Apr 2019 16:39:43 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Julien Grall <julien.grall@arm.com>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rt-users@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] arm64/fpsimd: Don't disable softirq when touching
 FPSIMD/SVE state
Message-ID: <20190405143942.xtpq5443qbc4gziy@linutronix.de>
References: <20190208165513.8435-1-julien.grall@arm.com>
 <20190404105233.GD3567@e103592.cambridge.arm.com>
 <a46f9fd4-dd31-c892-aec1-ae69072be92d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a46f9fd4-dd31-c892-aec1-ae69072be92d@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-04-05 10:02:45 [+0100], Julien Grall wrote:
> RT folks already saw this corruption because local_bh_disable() does not
> preempt on RT. They are carrying a patch (see "arm64: fpsimd: use
> preemp_disable in addition to local_bh_disable()") to disable preemption
> along with local_bh_disable().
> 
> Alternatively, Julia suggested to introduce a per-cpu lock to protect the
> state. I am thinking to defer this for a follow-up patch. The changes in
> this patch should make it easier because we now have helper to mark the
> critical section.

A per-CPU lock? It has to be a raw_spinlock_t because a normal
spin_lock() / local_lock() would allow scheduling and might be taken as
part of the context switch or soon after.

Sebastian
