Return-Path: <SRS0=lqhu=SH=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4A9C4360F
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Apr 2019 15:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 847BA218D4
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Apr 2019 15:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfDEPRy (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 5 Apr 2019 11:17:54 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51486 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbfDEPRy (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 5 Apr 2019 11:17:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CAD0316A3;
        Fri,  5 Apr 2019 08:17:53 -0700 (PDT)
Received: from [10.1.196.50] (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 710453F68F;
        Fri,  5 Apr 2019 08:17:52 -0700 (PDT)
Subject: Re: [RFC PATCH] arm64/fpsimd: Don't disable softirq when touching
 FPSIMD/SVE state
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rt-users@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        linux-kernel@vger.kernel.org
References: <20190208165513.8435-1-julien.grall@arm.com>
 <20190404105233.GD3567@e103592.cambridge.arm.com>
 <a46f9fd4-dd31-c892-aec1-ae69072be92d@arm.com>
 <20190405143942.xtpq5443qbc4gziy@linutronix.de>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <dabf5b36-d22e-e8a3-c01f-6b0f5b3be710@arm.com>
Date:   Fri, 5 Apr 2019 16:17:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190405143942.xtpq5443qbc4gziy@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

On 05/04/2019 15:39, Sebastian Andrzej Siewior wrote:
> On 2019-04-05 10:02:45 [+0100], Julien Grall wrote:
>> RT folks already saw this corruption because local_bh_disable() does not
>> preempt on RT. They are carrying a patch (see "arm64: fpsimd: use
>> preemp_disable in addition to local_bh_disable()") to disable preemption
>> along with local_bh_disable().
>>
>> Alternatively, Julia suggested to introduce a per-cpu lock to protect the
>> state. I am thinking to defer this for a follow-up patch. The changes in
>> this patch should make it easier because we now have helper to mark the
>> critical section.
> 
> A per-CPU lock? It has to be a raw_spinlock_t because a normal
> spin_lock() / local_lock() would allow scheduling and might be taken as
> part of the context switch or soon after.
raw_spinlock_t would not work here without disabling preemption. Otherwise you 
may end up to recurse on the lock and therefore deadlock. But then it raise the 
question of the usefulness of the lock here.

However, I don't really understand why allowing the scheduling would be a 
problem here. Is it a concern because we will waste cycle trying to restore/save 
a context that will be scratched as soon as we release the lock?

Cheers,

-- 
Julien Grall
