Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F6FC433E0
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Mar 2021 13:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1781564F4D
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Mar 2021 13:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbhCKNja (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 11 Mar 2021 08:39:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233620AbhCKNjA (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 11 Mar 2021 08:39:00 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52DCC061574
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Mar 2021 05:38:59 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615469938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bh8+fVRWVu6QA566BHNaPq4+G+g8Z2tv1bXrSqk4Q+Y=;
        b=NAhI7/vIl2SknqQRYsdR54w5plsIE+fvQWN9X7009jD12GcM5OgG4bw2L/oOUIzFc6rFdq
        PKvUKBQs1Q+/fLT9SPw4cQ07Cn5NlfDLCPk235X7Sgz3U3fnAUxiZ/dkLfNULzO+lyyun6
        wPIGOcd9ABBlMR4SnFCiMGGllTG6K7kxzlPC8fRMmtzapHShbQdAZmQiTB1W/t6IMKXXpS
        ImvVHhKQf95KlE/EzoLkWX0aaOKO9az+HLPBZ5hOXzrxAkFPBUw0q3AfL96Gz8My3GRagN
        KR3bF63HGmKQFXovRqTdcRl16CLOCs/n2KvtGs/SCP781FHoqQpRz/Vq2caY4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615469938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bh8+fVRWVu6QA566BHNaPq4+G+g8Z2tv1bXrSqk4Q+Y=;
        b=xqEpp83t9zbiWHyAFTkU4vcwVSPPRyUT1hRM8U9qWY+/hhZe6C9jkp8Kd+1L8aYagydfFU
        88ZtV9zJz4zVlzBQ==
To:     Daniel Wagner <wagi@monom.org>,
        Michel Macena Oliveira <michel@austral-dynamics.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: PREEMPT_RT benchmark
In-Reply-To: <9be68ca5-9fec-161c-1b37-1b47c0a1d845@monom.org>
References: <CAKkbJ-ypaPZ5JKpXD+PykvO6oYzxEUdxXY2RbVJKWdGY3ALuLg@mail.gmail.com> <9be68ca5-9fec-161c-1b37-1b47c0a1d845@monom.org>
Date:   Thu, 11 Mar 2021 14:38:57 +0100
Message-ID: <87o8fpyfm6.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-03-11, Daniel Wagner <wagi@monom.org> wrote:
> On 10.03.21 21:07, Michel Macena Oliveira wrote:
>> At least that's what I expected, but my latencies are much bigger than
>> Cyclictest ones.
>>  From cyclictest I get an average in my computer of  something between
>> 2300 and 2500 nanoseconds.  However, in my application I'm having
>> something between 47000 and 55000 nanoseconds. As you can see it is
>> much higher!
>> 
>> I'm not sure of what I'm doing wrong, could you help or suggest something?
>
> Check if your system uses power managment. cyclictest disables the power 
> management by using the /dev/cpu_dma_latency API.

In addition, avoid file I/O in your real-time thread. Store your
calculations in a variable and let another thread read it and write to
disk. Then it would be more "equivalent to Cyclict test".

John Ogness
