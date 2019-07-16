Return-Path: <SRS0=4wEw=VN=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7E1C76192
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 Jul 2019 20:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EE4120665
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 Jul 2019 20:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388673AbfGPU34 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 16 Jul 2019 16:29:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51073 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728340AbfGPU34 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 16 Jul 2019 16:29:56 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hnU5B-0003QB-QZ; Tue, 16 Jul 2019 22:29:54 +0200
Date:   Tue, 16 Jul 2019 22:29:53 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Clark Williams <williams@redhat.com>
cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        RT <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PREEMPT_RT] bogus lockdep assert from i915 on v5.2-rt1
In-Reply-To: <20190716145043.1929f50e@torg>
Message-ID: <alpine.DEB.2.21.1907162228030.1767@nanos.tec.linutronix.de>
References: <20190716145043.1929f50e@torg>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Clark,

On Tue, 16 Jul 2019, Clark Williams wrote:

> Thomas,
> 
> When looking at a problem on v5.2-rt1, I turned on lockdep and started getting warnings
> from lockdep_assert_irqs_disabled() in the i915 driver. They're making these calls inside
> a spin_lock_irqsave/spin_lock_irqrestore block, which of course doesn't fiddle with IRQs
> when PREEMPT_RT is configured. The attached patch places the three calls inside
> if (!IS_ENABLED(CONFIG_PREEMPT_RT_FULL)) blocks, so should avoid the bogus warning on RT.

AFAICT, all three asserts are pointless because there are already the lock
held asserts and lockdep will warn anyway when these locks are taken with
interrupts enabled.

Thanks,

	tglx
