Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED5AC4338F
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Aug 2021 16:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8689D60F25
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Aug 2021 16:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbhHDQGF (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 4 Aug 2021 12:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbhHDQFy (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 4 Aug 2021 12:05:54 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D5BC06179A
        for <linux-rt-users@vger.kernel.org>; Wed,  4 Aug 2021 09:05:42 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id u16so3528263ple.2
        for <linux-rt-users@vger.kernel.org>; Wed, 04 Aug 2021 09:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oMkQQfev9jlBqzZwWyEcCECz55KoFmnaUQbMudWMFx8=;
        b=znhcKD9cKo2ZPI52KWTR8R6vPlHBm/Nqb8u+01DPcGHrOthz7TQH8HvTG6uswxjCGz
         vJ71fOVnzDD7M5Qn357c1t6/Th2XOpNySKuEnfLi0UsMA3l9MwX3TfXicytYqrU0DU/O
         HHTkx5X0PxgEqlppbo/I+U42zhae20yT0YTZCRek8uR2grkXTwS/IxTCKoT8LAQSXFoo
         2liU1Ty+aVDUFKb60ZGbzWT1tUdv1jZSJXK8m0kz86R7xCLwwGmMsaAZETgr5eMnlGSx
         yzysUmkOg9L1aD+W+h97pQ3Y0C8QEMEIWUf7JtiELl4ZL7cARdvzwvWWLuuHtAGsdUXu
         UAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oMkQQfev9jlBqzZwWyEcCECz55KoFmnaUQbMudWMFx8=;
        b=dhMNCifRs3b+ZTJ7jeEm0OyRPBx08be60VYG1RqyN/5KWfYCtKRGfaJ3e4viEqtJ/X
         0F2JrEfR1c98L7vEoXcU40yLPLvS2qKdZoRhjU7dtTa7Q1RVSc1IkIz7xxVtNKWSkqFR
         caeP1bMIYs5DFZ1xBa2CLXcNrxasfGX+hP++b/pQ8tBD9MVAToi8tNhI3E060DJo90Jn
         iynhaXBId4Cpr48oHM2IDJdsl/9zPYUjhVouJSsQOxccXrfRwk2KQllweZ0jCVSq+VNw
         kuiCdhVnQvo4gZxOdIbJT5KL4F1F/l+6VdYN/eiNiJGSGEIzE/v+vkceWSS98UaYw0KF
         W0gw==
X-Gm-Message-State: AOAM532ssXPTRoYfhQcziZtwuPJwIneZa0nJEctUokqgGmqmfWmfNwtA
        udtuuc7VMDnrq0nnszVckpfpvg==
X-Google-Smtp-Source: ABdhPJwju7zJRV9M9ON3FoQLkg/K2bxj5917bBVgN46rIkWv6Q688Q9h5LyCoCkwZfGRLmsHJLQ1hA==
X-Received: by 2002:a63:57:: with SMTP id 84mr221571pga.241.1628093141560;
        Wed, 04 Aug 2021 09:05:41 -0700 (PDT)
Received: from [192.168.1.116] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id f66sm3607733pfa.21.2021.08.04.09.05.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 09:05:41 -0700 (PDT)
Subject: Re: [ANNOUNCE] v5.14-rc4-rt4
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <wagi@monom.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
References: <20210804104340.fhdjwn3hruymu3ml@linutronix.de>
 <20210804104803.4nwxi74sa2vwiujd@linutronix.de>
 <20210804110057.chsvt7l5xpw7bo5r@linutronix.de>
 <20210804131731.GG8057@worktop.programming.kicks-ass.net>
 <4f549344-1040-c677-6a6a-53e243c5f364@kernel.dk>
 <feebf183-2e33-36b5-4538-62a40b2a58b6@kernel.dk>
 <20210804153308.oasahcxjmcw7vivo@linutronix.de>
 <f2d0a028-fe85-28ff-9cea-8ab1d26a15d0@kernel.dk>
 <20210804154743.niogqvnladdkfgi2@linutronix.de>
 <7c946918-ae0d-6195-6a78-b019f9bc1fd3@kernel.dk>
 <20210804155747.cwayhjsdjc4zaubd@linutronix.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c3fa07d1-a3c4-6775-f419-4875eb41bc88@kernel.dk>
Date:   Wed, 4 Aug 2021 10:05:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210804155747.cwayhjsdjc4zaubd@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 8/4/21 9:57 AM, Sebastian Andrzej Siewior wrote:
> On 2021-08-04 09:49:48 [-0600], Jens Axboe wrote:
>>
>> That'd work on non-RT as well, but it makes it worse on non-RT as well with
>> the irq enable/disable dance. While that's not the end of the world, would
>> be nice to have a solution that doesn't sacrifice anything, yet doesn't
>> make RT unhappy.
> 
> There were plans to make local_irq_disable() mostly a nop (similar to
> what ppc64 does). But I have no idea what happened. I hope that work
> gets picked up.

So what do you propose in the interim? As far as io_uring is concerned,
it's not a _huge_ deal to do the IRQ dance, but it does bother me that
we're making things slightly worse for the mainline kernel just to make
the out-of-tree patches happy.

-- 
Jens Axboe

