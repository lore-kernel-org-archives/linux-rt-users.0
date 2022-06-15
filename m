Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F0AC43334
	for <linux-rt-users@archiver.kernel.org>; Wed, 15 Jun 2022 15:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349219AbiFOPTT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 15 Jun 2022 11:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349140AbiFOPTS (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 15 Jun 2022 11:19:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3FF3C24956
        for <linux-rt-users@vger.kernel.org>; Wed, 15 Jun 2022 08:19:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1959A153B;
        Wed, 15 Jun 2022 08:19:17 -0700 (PDT)
Received: from [10.57.5.38] (unknown [10.57.5.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF7313F7F5;
        Wed, 15 Jun 2022 08:19:15 -0700 (PDT)
Message-ID: <13ae4a81-8bac-0ece-f970-44ca7ddcbf7a@arm.com>
Date:   Wed, 15 Jun 2022 17:18:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] cyclictest: Delay setting of main_affinity_mask after
 creating threads.
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org,
        Clark Williams <williams@redhat.com>
References: <YqnExv0GkIKTSwoI@linutronix.de>
 <19f21e80-ce44-07f0-2361-ece8e6a60ad4@arm.com>
 <YqnqcQmELgKYlwWA@linutronix.de>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <YqnqcQmELgKYlwWA@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On 6/15/22 16:19, Sebastian Andrzej Siewior wrote:
> On 2022-06-15 14:24:31 [+0200], Pierre Gondois wrote:
>> Hello Sebastian,
> Hi Pierre,
> 
>> Since starting the threads represents some work that can disturb
>> the threads, shouldn't the main thread be migrated to the
>> 'mainaffinity' mask early as it is right now ?
> 
> I doubt this such a huge impact given that once the threads are created,
> they do rt_numa_set_numa_run_on_node() and pthread_setaffinity_np()
> among other things.
> 
>> I think it would be better to:
>> 1. Save the initial mask of the main thread somewhere
>> 2. Set the affinity of the main thread
>> 3. Use the initial mask when setting the affinity of the threads
> 
> If this is *that* important I would lean towards always doing the
> globalt_barr so all threads start once everything is set up. If I
> remember correctly, the first few cycles are not counted and just fill
> the cache.

Ok yes, I didn't see the globalt_barr barrier. FWIW I tested
the patch and it works well.

> 
>> Regards,
>> Pierre
> 
> Sebastian
