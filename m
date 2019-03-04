Return-Path: <SRS0=pHM8=RH=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817C0C4360F
	for <linux-rt-users@archiver.kernel.org>; Mon,  4 Mar 2019 17:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D311206BA
	for <linux-rt-users@archiver.kernel.org>; Mon,  4 Mar 2019 17:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfCDRZp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 4 Mar 2019 12:25:45 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:41982 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbfCDRZp (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 4 Mar 2019 12:25:45 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1h0rLL-0004j1-GK; Mon, 04 Mar 2019 18:25:35 +0100
Date:   Mon, 4 Mar 2019 18:25:35 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Julien Grall <julien.grall@arm.com>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] arm64/fpsimd: Don't disable softirq when touching
 FPSIMD/SVE state
Message-ID: <20190304172535.v5pf7yboii7ayxnb@linutronix.de>
References: <20190208165513.8435-1-julien.grall@arm.com>
 <20190213143029.ad2kzg7vtuo3zpjk@linutronix.de>
 <20190213153630.GK3567@e103592.cambridge.arm.com>
 <CAKv+Gu__0uy6Y-EJGSygSYH4RqpLDWMMNFE3yauF_x7-UNcgFQ@mail.gmail.com>
 <20190213165227.7ekekkxazhbaqxoe@linutronix.de>
 <20190214103449.GN3567@e103592.cambridge.arm.com>
 <32ba7e1e-37ce-c904-15e4-9c908e873479@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <32ba7e1e-37ce-c904-15e4-9c908e873479@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-02-18 15:07:51 [+0000], Julien Grall wrote:
> Hi,
Hi,

> > Wouldn't this arbitrarily increase softirq latency?  Unconditionally
> > forbidding SIMD in softirq might make more sense.  It depends on how
> > important the use cases are...

It would increase the softirq latency but the question is how bad would
it be. It would continue once the SIMD section is done.
If you allow it but made it impossible to use (and use the software
fallback) then it would slow down the processing. So…

> Looking at the commit message from cb84d11e1625 "arm64: neon: Remove support
> for nested or hardirq kernel-mode NEON", one of the use case for crypto in
> softirq is certain mac80211 drivers.
> 
> Is there any other use case for use crypto in softirqs?

mac80211 does it for some wifi drivers. There used to be IPsec but I
*think* this moved to the "parallel processing kthread".
During my FPU rework on x86 I didn't find anything that does the
processing in softirq (on my machine) so I hacked something so that I
could test that I didn't break anything…

> Cheers,
> 

Sebastian
