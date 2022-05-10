Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0C0C433FE
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 May 2022 20:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbiEJUAP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 10 May 2022 16:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiEJUAO (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 10 May 2022 16:00:14 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0ED29839E;
        Tue, 10 May 2022 13:00:10 -0700 (PDT)
Received: from [10.172.66.188] (1.general.jsalisbury.us.vpn [10.172.66.188])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 000B63FF5B;
        Tue, 10 May 2022 20:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1652212808;
        bh=wfd/Iv4n7C43DlH0WMQPRJb0BMEDuintQbqKw5+qCWM=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=Nmo4qLwvTH2BKvosJL6vHJgqc2U3VHQERKgn8NgwS0WcQwQ9MFL7NZXk5DBcYmDsp
         SkGJAUdtuxHThbIfSpPovckZvFhUytzwBMMBmATwYwAoHc60nObOGU32q4eZY7bJ8U
         5Ei7eouzB6wgMpfDFBRhHZBkq/S3hMGZYYCPbV/dEMjAw3DLaPeS61y9yZZrZUXrcq
         caDoOLJ23x1MvutURH3NZeVEMocdt3I9vesFIV92jEaXzBe9kS4+Mr8JTjd0eNEQ4t
         2BIkp6n6lm+JBZLqBeLrt1GwRNosYZsOO5RBXna4srg8cZfxRfimvr1gpYYYgPRktW
         Lyt0fnmOxaGhA==
Message-ID: <803fd13b-684c-0f58-48a1-06a7f4987c37@canonical.com>
Date:   Tue, 10 May 2022 16:00:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Issue With real-time patches on 5.15.y
Content-Language: en-US
To:     Mike Galbraith <efault@gmx.de>, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        linux-rt-users@vger.kernel.org
References: <bdb23fe5-51ae-8873-a3d7-85f377877c79@canonical.com>
 <35c5a001-61b0-09d7-393c-b46836d0b676@canonical.com>
 <c3d382759dac2e9b0927c0074d95e1b930e8e8dd.camel@gmx.de>
From:   Joseph Salisbury <joseph.salisbury@canonical.com>
In-Reply-To: <c3d382759dac2e9b0927c0074d95e1b930e8e8dd.camel@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On 5/9/22 06:14, Mike Galbraith wrote:
> On Thu, 2022-05-05 at 19:20 -0400, Joseph Salisbury wrote:
>> ...
>> Also, the following is the build failure that happens:
>> arch/x86/include/asm/pgtable.h:55:8: error: unknown type name 'spinlock_t'
>>      55 | extern spinlock_t pgd_lock;
>>         |        ^~~~~~~~~~
> 35fa745286ac4 was merged into mainline 5.17-rc1 to squash that buglet.
>
> 	-Mike
Thank you for the pointer, Mike!  This commit fixes the build issue I 
was seeing.

Thanks,

Joe

