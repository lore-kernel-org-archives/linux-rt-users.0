Return-Path: <SRS0=6U1w=RS=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847D9C43381
	for <linux-rt-users@archiver.kernel.org>; Fri, 15 Mar 2019 10:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E12F2186A
	for <linux-rt-users@archiver.kernel.org>; Fri, 15 Mar 2019 10:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbfCOKGl (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 15 Mar 2019 06:06:41 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56544 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728767AbfCOKGl (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 15 Mar 2019 06:06:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F498A78;
        Fri, 15 Mar 2019 03:06:41 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B892C3F71D;
        Fri, 15 Mar 2019 03:06:39 -0700 (PDT)
Date:   Fri, 15 Mar 2019 10:06:37 +0000
From:   Dave Martin <Dave.Martin@arm.com>
To:     Julien Grall <julien.grall@arm.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] arm64/fpsimd: Don't disable softirq when touching
 FPSIMD/SVE state
Message-ID: <20190315100634.GN3567@e103592.cambridge.arm.com>
References: <20190208165513.8435-1-julien.grall@arm.com>
 <20190213143029.ad2kzg7vtuo3zpjk@linutronix.de>
 <20190213153630.GK3567@e103592.cambridge.arm.com>
 <CAKv+Gu__0uy6Y-EJGSygSYH4RqpLDWMMNFE3yauF_x7-UNcgFQ@mail.gmail.com>
 <20190213165227.7ekekkxazhbaqxoe@linutronix.de>
 <20190214103449.GN3567@e103592.cambridge.arm.com>
 <32ba7e1e-37ce-c904-15e4-9c908e873479@arm.com>
 <20190304172535.v5pf7yboii7ayxnb@linutronix.de>
 <abd861af-023f-2f9e-acee-4e1837aa8897@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abd861af-023f-2f9e-acee-4e1837aa8897@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Mar 14, 2019 at 06:07:19PM +0000, Julien Grall wrote:
> Hi Sebastian,
> 
> On 3/4/19 5:25 PM, Sebastian Andrzej Siewior wrote:

[...]

> >It would increase the softirq latency but the question is how bad would
> >it be. It would continue once the SIMD section is done.
> 
> On Arm, the kernel may use either FPSIMD or SVE (if supported by the
> platform). While the FPSIMD context is fairly small (~4K), the SVE context
> can be up to ~64KB.

It's not quite as bad as that.  The FPSIMD state is ~0.5K, with the SVE
state size being up to ~8.5K (though for today's implementations ~2K may
be considered typical).

For comparision, I believe AVX-512 has ~2K of state.

Cheers
---Dave
