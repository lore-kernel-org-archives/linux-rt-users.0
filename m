Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C7BC43334
	for <linux-rt-users@archiver.kernel.org>; Wed, 15 Jun 2022 15:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344643AbiFOPoD (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 15 Jun 2022 11:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233934AbiFOPoB (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 15 Jun 2022 11:44:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5A04527FD1
        for <linux-rt-users@vger.kernel.org>; Wed, 15 Jun 2022 08:44:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42FBC153B;
        Wed, 15 Jun 2022 08:44:00 -0700 (PDT)
Received: from [10.57.5.38] (unknown [10.57.5.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1FBF13F7F5;
        Wed, 15 Jun 2022 08:43:58 -0700 (PDT)
Message-ID: <288c4869-de0a-887f-9233-5fee809e4824@arm.com>
Date:   Wed, 15 Jun 2022 17:43:40 +0200
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
 <13ae4a81-8bac-0ece-f970-44ca7ddcbf7a@arm.com>
 <Yqn5SGdIHNwMREU/@linutronix.de>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <Yqn5SGdIHNwMREU/@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On 6/15/22 17:22, Sebastian Andrzej Siewior wrote:
> On 2022-06-15 17:18:55 [+0200], Pierre Gondois wrote:
>>> If this is *that* important I would lean towards always doing the
>>> globalt_barr so all threads start once everything is set up. If I
>>> remember correctly, the first few cycles are not counted and just fill
>>> the cache.
>>
>> Ok yes, I didn't see the globalt_barr barrier. FWIW I tested
>> the patch and it works well.
> 
> The globalt_barr isn't enabled by default. If that is important then I
> recommend doing this by default. I can post patch if you want me to.

Starting all the threads at the same time seems sensible to me,
but I don't have any numbers to prove this is useful.

> 
>>>
>>>> Regards,
>>>> Pierre
> 
> Sebastian
