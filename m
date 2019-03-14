Return-Path: <SRS0=rL3Y=RR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7B6C10F06
	for <linux-rt-users@archiver.kernel.org>; Thu, 14 Mar 2019 18:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C69F21855
	for <linux-rt-users@archiver.kernel.org>; Thu, 14 Mar 2019 18:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfCNSHY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 14 Mar 2019 14:07:24 -0400
Received: from foss.arm.com ([217.140.101.70]:48258 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbfCNSHY (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 14 Mar 2019 14:07:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0378680D;
        Thu, 14 Mar 2019 11:07:24 -0700 (PDT)
Received: from [10.37.12.84] (unknown [10.37.12.84])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 779ED3F71D;
        Thu, 14 Mar 2019 11:07:21 -0700 (PDT)
Subject: Re: [RFC PATCH] arm64/fpsimd: Don't disable softirq when touching
 FPSIMD/SVE state
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190208165513.8435-1-julien.grall@arm.com>
 <20190213143029.ad2kzg7vtuo3zpjk@linutronix.de>
 <20190213153630.GK3567@e103592.cambridge.arm.com>
 <CAKv+Gu__0uy6Y-EJGSygSYH4RqpLDWMMNFE3yauF_x7-UNcgFQ@mail.gmail.com>
 <20190213165227.7ekekkxazhbaqxoe@linutronix.de>
 <20190214103449.GN3567@e103592.cambridge.arm.com>
 <32ba7e1e-37ce-c904-15e4-9c908e873479@arm.com>
 <20190304172535.v5pf7yboii7ayxnb@linutronix.de>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <abd861af-023f-2f9e-acee-4e1837aa8897@arm.com>
Date:   Thu, 14 Mar 2019 18:07:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190304172535.v5pf7yboii7ayxnb@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Sebastian,

On 3/4/19 5:25 PM, Sebastian Andrzej Siewior wrote:
> On 2019-02-18 15:07:51 [+0000], Julien Grall wrote:
>> Hi,
> Hi,
> 
>>> Wouldn't this arbitrarily increase softirq latency?  Unconditionally
>>> forbidding SIMD in softirq might make more sense.  It depends on how
>>> important the use cases are...
> 
> It would increase the softirq latency but the question is how bad would
> it be. It would continue once the SIMD section is done.

On Arm, the kernel may use either FPSIMD or SVE (if supported by the 
platform). While the FPSIMD context is fairly small (~4K), the SVE 
context can be up to ~64KB.

> If you allow it but made it impossible to use (and use the software
> fallback) then it would slow down the processing. So…

This is a fair point. However, the use of crypto in softirqs seem to be 
limited. So I am wondering whether disabling softirq in all the case is 
worth it.

Would it be possible to consider to forbid/warn about using crypto in 
softirqs?

> 
>> Looking at the commit message from cb84d11e1625 "arm64: neon: Remove support
>> for nested or hardirq kernel-mode NEON", one of the use case for crypto in
>> softirq is certain mac80211 drivers.
>>
>> Is there any other use case for use crypto in softirqs?
> 
> mac80211 does it for some wifi drivers. There used to be IPsec but I
> *think* this moved to the "parallel processing kthread".

I was able to find my way through mac80211 and confirm the use a taslket 
and therefore softirqs. However, I got lost in the ipsec code.

> During my FPU rework on x86 I didn't find anything that does the
> processing in softirq (on my machine) so I hacked something so that I
> could test that I didn't break anything…

This is the same on the platform I have been using for testing.

Cheers,

-- 
Julien Grall
