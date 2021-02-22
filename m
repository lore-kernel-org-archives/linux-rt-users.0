Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393C1C433E0
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Feb 2021 17:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F351664F03
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Feb 2021 17:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhBVRFs (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 22 Feb 2021 12:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbhBVRFp (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 Feb 2021 12:05:45 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920B4C061574
        for <linux-rt-users@vger.kernel.org>; Mon, 22 Feb 2021 09:05:05 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id q10so22969715edt.7
        for <linux-rt-users@vger.kernel.org>; Mon, 22 Feb 2021 09:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Q1S5/GzLEyqQxTUuSBmv43uwxFEwjjlpDUEy2V2f97A=;
        b=ttx1dAiltqdxzT1v2ZmkQb7GabBmNpF4dYHrhKq0vrjQ6ZruqPC3iMzh9k7LZ52gz/
         jDVsB1fjj3g6hd/oj6EyigHTMIUz7219wYqEAnpupExsN3ZIBtlFXaKsjaTxHSE6Y4VL
         AyYbnMTUQRDFOZ8qMXKcqcOUDy/RO4UfyOoiXndryaBxtqR25lmT53gQZ4R4PKgYDz5v
         USd8geQegq8EzRm199mD78BTqsjDCqttstzY9ncT2SN1wdyt0OEIABP+aCSDQgfI4iog
         ogTYvtLD02W0IAD44x9E+bnKHAlbBsq1cYIutx0cHlIyKkNtoCCW9EDSgM5qosq0omP+
         yg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Q1S5/GzLEyqQxTUuSBmv43uwxFEwjjlpDUEy2V2f97A=;
        b=pvBeytVSJUQIVtamAkOZ53iE34cVX5V2ufFRfQm6W/6T6AcINZjej0Qpx9nYZUeX99
         8arA88o4ilg6GM9ebCq3XTEkZXTN/nWmpJeE70r25aVOaThKhYcCzCiADKsMLmtM1UKG
         xa4Qzr8R9SSurLI5QLCjEtP6bSCUy3fLrRTsmxmZ0KoYDjwS3Bw08b6aLAMAgpZFPhwN
         kb2vvwHbdhOIpHjd4mDfosOnR8FFPiLUsx8YyK/m9FSQIPsDyFS9dbv9HRzm0gmx1ZoJ
         HFRK0P63/PP1gEVEdqbygHqRR7DBznesisRZl0fXRKpExLAtT4m52DRVHrZl50N+XH/y
         p0fQ==
X-Gm-Message-State: AOAM532lp3YWcNMjwhaExAAyRdxpExPZju20bHarpoxe/B8GbSlHh1il
        ThGU9SAXg/NZMnIlvwNWMTIcNdDLHd5lFA==
X-Google-Smtp-Source: ABdhPJwqWcNdoEQ+NuPDmNMtHxSIExiNuCJvpVBMECnDZlqxaE3g3tTxf1F4gKAjnk0coB0/lPKgoA==
X-Received: by 2002:aa7:c90f:: with SMTP id b15mr15128844edt.51.1614013504006;
        Mon, 22 Feb 2021 09:05:04 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c23-6c04-5000-dab0-26a8-91ef-23f9.c23.pool.telefonica.de. [2a01:c23:6c04:5000:dab0:26a8:91ef:23f9])
        by smtp.gmail.com with ESMTPSA id hd39sm10347154ejc.116.2021.02.22.09.05.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Feb 2021 09:05:03 -0800 (PST)
Subject: Re: rt-tests: cyclictest: Add option to specify main pid affinity
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     jkacur@redhat.com, williams@redhat.com,
        linux-rt-users@vger.kernel.org
References: <20210222152833.8758-1-schwenderjonathan@gmail.com>
 <YDPZ0xrEcsS5SfWh@lx-t490>
From:   Jonathan Schwender <schwenderjonathan@gmail.com>
Message-ID: <b29fdf4c-788f-d1c4-06bf-60f7f1bdef7b@gmail.com>
Date:   Mon, 22 Feb 2021 18:05:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YDPZ0xrEcsS5SfWh@lx-t490>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2/22/21 5:20 PM, Ahmed S. Darwish wrote:
> On Mon, Feb 22, 2021 at 04:28:30PM +0100, Jonathan Schwender wrote:
>> Hi John,
>>
>> This patch adds the option --mainaffinity to specify the affinity of
>> the main pid.
>> This is mainly useful if you want to bind the main thread to a
>> different (e.g. housekeeping ) CPU than the measurement threads.
>>
> Pardon my ignorance; can you please specify why is this important?
> The measurement threads have an RT priority while the main thread is
> SCHED_OTHER. So why would the cyclictest measurements really be affected
> by the main thread (unless there's a preempt_rt bug)?

The option is intended for measuring on isolated CPUs (via isolcpus or 
cpusets).

The RT wiki cyclictest FAQ entry "How can the influence of Cyclictest be 
minimized when evaluating latencies on an isolated set of CPUs?" [1]  
recommends to pin the main thread to a non-isolated CPU since
that reduces context switches.

[1] 
https://wiki.linuxfoundation.org/realtime/documentation/howto/tools/cyclictest/faq


> Do you also have any numbers showing different results with/without
> "--mainaffinity"?
  Sorry, I don't have any numbers, but I've put it on my todo-list.
>
> Thanks,
>
> --
> Ahmed S. Darwish
Jonathan
