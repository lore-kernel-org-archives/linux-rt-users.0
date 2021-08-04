Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447D4C4320A
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Aug 2021 16:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E16360BD3
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Aug 2021 16:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239702AbhHDQ53 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 4 Aug 2021 12:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239699AbhHDQ52 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 4 Aug 2021 12:57:28 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C0DC061798
        for <linux-rt-users@vger.kernel.org>; Wed,  4 Aug 2021 09:57:15 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id s22-20020a17090a1c16b0290177caeba067so9694602pjs.0
        for <linux-rt-users@vger.kernel.org>; Wed, 04 Aug 2021 09:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n/ydrZoBnTnGVePnkLl67Uygiapkqd3aQOEpbd0KF1Q=;
        b=eCRQdH5apsetsVkiAmtu3sr/Ir5ypuLwjrJmExN+1AfyfcCL5tkENpCuUELQvR76UV
         /a4tBIT5VSaBmVDtXyqspVeHh/2JkwH1JqvFnr97JKlfTbJjutUYozHYFvUiNtNe4y7I
         oUBS5Ec7JN0Ygiv0ZbvaKxj9RAzk8i+QHgTsE/EEHZPAUnERtjUfab5cEiOh5Yo/eX8J
         wpOnI0JHH0ow1jgHA9xGygu02GzlRkLQo3Bb+2LJx3bUcJFquUoFsUN42b8G37pJz7Zk
         Jzk/RoH47YXFZqfImcTRy3H9dB3xGO1oTnq99LZMGcWGb9kTZCkDoobNqFTkNsJLYhZ7
         cLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n/ydrZoBnTnGVePnkLl67Uygiapkqd3aQOEpbd0KF1Q=;
        b=GbVVdf9UK6Bz5mMmdte82ezt9WtxZ4ZiEvJ8vmm3ZQ8eKvKc5xlzs7mRXra7UwWJ5k
         AUy6Uno71NaSeA2sdebms2yQ01GkVKw+F/TowdGKMprg2Fck8PgQnISGnRaQyFNBoErF
         O24uGIEczMS+BK5If/dttBDrl12jQsTzFLABBEAV3PZ/KLp45/X0ZDDxrOjiif+olANR
         0X82ZFV8RwjHHFk6VFsQfMV/DHLtX+qVwIuVI43+buJkRnxBUQWWP7q7AvNAnbIglPai
         rW/YXqpWe/InMSO2NAtWcEUtOSdqFGXVvbZAbSobw/ETp5YGIBkUVL9BB12qalPNgO8z
         VqRw==
X-Gm-Message-State: AOAM53246IxxWThZw3sWVhtpRAFXEyqgTYUvzriiJPn/u8Xn3q+D+bKM
        Z21u+Mds7IyW1+Ti4XCSYjHk2q0+cSyOCzLD
X-Google-Smtp-Source: ABdhPJwASPd1DN5CHX6YbOTJFLlYKFjsk0OLfbOytoFl/99XNsWjh2j7HqHE8qkJosCaZnHZ9sCB6g==
X-Received: by 2002:a17:90b:344:: with SMTP id fh4mr104771pjb.29.1628096234326;
        Wed, 04 Aug 2021 09:57:14 -0700 (PDT)
Received: from [192.168.1.116] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id 19sm3440765pfw.203.2021.08.04.09.57.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 09:57:13 -0700 (PDT)
Subject: Re: [ANNOUNCE] v5.14-rc4-rt4
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <wagi@monom.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org
References: <4f549344-1040-c677-6a6a-53e243c5f364@kernel.dk>
 <feebf183-2e33-36b5-4538-62a40b2a58b6@kernel.dk>
 <20210804153308.oasahcxjmcw7vivo@linutronix.de>
 <f2d0a028-fe85-28ff-9cea-8ab1d26a15d0@kernel.dk>
 <20210804154743.niogqvnladdkfgi2@linutronix.de>
 <7c946918-ae0d-6195-6a78-b019f9bc1fd3@kernel.dk>
 <20210804155747.cwayhjsdjc4zaubd@linutronix.de>
 <c3fa07d1-a3c4-6775-f419-4875eb41bc88@kernel.dk>
 <20210804122029.6c5c837a@oasis.local.home>
 <4ffb8f7c-085c-f6cc-e308-3f75b24b8e47@kernel.dk>
 <20210804164735.sq6sjejusa37abkw@linutronix.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <71d37a7d-af53-945e-0c49-3cb902487df4@kernel.dk>
Date:   Wed, 4 Aug 2021 10:57:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210804164735.sq6sjejusa37abkw@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 8/4/21 10:47 AM, Sebastian Andrzej Siewior wrote:
> On 2021-08-04 10:22:59 [-0600], Jens Axboe wrote:
>>
>> In that regard, I do still consider those patches out-of-tree, which
>> they are. And while I'm more sympathetic to them compared to other
>> out-of-tree code as there's a long term plan to get it all in, it's
>> still out-of-tree. Best solution here is probably to just carry that
>> particular change in the RT patchset for now.
> 
> So today in the morning I learned that there is a memory allocation in
> an IRQ-off section and now, a patch later, it is almost gone. So that
> makes me actually happy :)

1 out of 2 is better than 0 ;-)

> The spin_lock_irq() vs local_irq_disable() + spin_lock() is documented
> in Documentation/locking/locktypes.rst.
> That said I have no problem by carrying that patch in the RT-patchset
> and revisit it later.

Right, I suspect that was added as a pre RT patch dump at some point.
It's a newer thing. Is it actually possible to set PREEMPT_RT in the
mainline kernel? Looks like it depends on ARCH_SUPPORTS_RT and nobody
sets that.

So I agree that just carrying your solution in the RT patchset is fine
for now, we can revisit later.

-- 
Jens Axboe

