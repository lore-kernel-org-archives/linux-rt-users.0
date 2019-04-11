Return-Path: <SRS0=sXU0=SN=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B45AC10F13
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Apr 2019 14:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 755452077C
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Apr 2019 14:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbfDKOKc (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 11 Apr 2019 10:10:32 -0400
Received: from foss.arm.com ([217.140.101.70]:43816 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbfDKOKc (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 11 Apr 2019 10:10:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D422980D;
        Thu, 11 Apr 2019 07:10:31 -0700 (PDT)
Received: from [10.37.12.69] (unknown [10.37.12.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4690D3F68F;
        Thu, 11 Apr 2019 07:10:30 -0700 (PDT)
Subject: Re: [RFC PATCH] arm64/fpsimd: Don't disable softirq when touching
 FPSIMD/SVE state
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, bigeasy@linutronix.de,
        linux-rt-users@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        linux-kernel@vger.kernel.org
References: <20190208165513.8435-1-julien.grall@arm.com>
 <20190404105233.GD3567@e103592.cambridge.arm.com>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <0f8d6b53-6834-7363-03fc-6fd47ea49b80@arm.com>
Date:   Thu, 11 Apr 2019 15:10:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190404105233.GD3567@e103592.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Dave,

On 4/4/19 11:52 AM, Dave Martin wrote:
> On Fri, Feb 08, 2019 at 04:55:13PM +0000, Julien Grall wrote:
> I'm not sure how this patch will affect context switch overhead, so it
> would be good to see hackbench numbers (or similar).

I finally have some numbers for this patch. The benchmark was ran using 
Linux 5.1-rc4 and defconfig.

On Juno2:
    * hackbench 100 process 1000 (10 times)
    * .7% quicker

On ThunderX 2:
    * hackbench 1000 process 1000 (20 times)
    * 3.4% quicker

I am happy to try other benchmark if you think it is useful.

Anyway, I will resend the series with the comments addressed.

Cheers,

-- 
Julien Grall
