Return-Path: <SRS0=Ov4F=EG=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF4CC388F7
	for <linux-rt-users@archiver.kernel.org>; Sat, 31 Oct 2020 15:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47C2D206E9
	for <linux-rt-users@archiver.kernel.org>; Sat, 31 Oct 2020 15:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vu/3i/BP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgJaPBt (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 31 Oct 2020 11:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgJaPBt (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 31 Oct 2020 11:01:49 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7668C061A04
        for <linux-rt-users@vger.kernel.org>; Sat, 31 Oct 2020 08:01:47 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id m17so865280pjz.3
        for <linux-rt-users@vger.kernel.org>; Sat, 31 Oct 2020 08:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IzdzW7HufeaWNcq+Kqm0Wpk1g85nxbZcO2U5e45enNI=;
        b=vu/3i/BP9eCcnXTJjhHOAFmdy2OsC058ht9JZa0i/iwnf9IV+D3eaQZNu0AGUqDBuW
         EEyhtz5fwAOxbg09p9KViAUHU0fuRdi/+H7X1xXSh4811GzEYCJhR7K9BuTjAyZS+/qX
         A+6pvLfjdb3NyezdZ7fKbAVZh1y2u3+9qHkRWFzgAmkpZhf0yq+jHGCIFXFfd+I0T+gb
         KQCI6Y+GMi63PMSs3kTS/AIZ9wwGlEm5DhQoRVV0zSefCmWJDnyjXiiYO+k7FVDZ0nKJ
         qLLEbpBxWtqpaZN/mvyuD3ILuJqw0ZdFVzRZ9xvzJBwrSs0en8ApBHP0l5FlaMLVl/Jz
         G//Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IzdzW7HufeaWNcq+Kqm0Wpk1g85nxbZcO2U5e45enNI=;
        b=W43Wai/2UFTTFzo9IAo67oXR1IEe1o4/luOxG0a9IiGhnFs+m+HjYeFGSx+l7AJQQK
         C/W2q7FDmO9cnxltidhFhMzL3al9Bi58/8Aa3Jv7+N92w5d+EvWkt1YZK23gJSFND/9a
         UexXauDM6N62YkX424H+z4/O7CqEycQYe4SQEXOaIdVwl9sTXbBAkenms1sI/IbUNtTk
         chD2f6xJFeKEq6C1knnYopVf6JBzjzq+9ySitmszhzIfa7CbqMQ4P8Z+DTFzti4S6ILN
         cdwUMHjKpc3BCTFyPeHYeCVge4KrA6/jXcCVBQw2+dwNvn627OmpMgvrh/4lcFxUQxB2
         9zMw==
X-Gm-Message-State: AOAM532tK4ZV29y07r5DAw4V/L0hia/ZcJnfCAGMNBXVe0z6zHBfaLFf
        VB0xoTI14aZ27Qx0PwASRHtPNw==
X-Google-Smtp-Source: ABdhPJxggFNgHxmkwNg2huq2Nl54NCr+NcjcHDy6RCTiJuk2PhrAcd5HI3wIQpdeZwrt3+si9bK/Mg==
X-Received: by 2002:a17:90a:c7c1:: with SMTP id gf1mr920814pjb.87.1604156507517;
        Sat, 31 Oct 2020 08:01:47 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id z3sm9140176pfk.159.2020.10.31.08.01.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2020 08:01:47 -0700 (PDT)
Subject: Re: [PATCH 3/3] blk-mq: Use llist_head for blk_cpu_done
From:   Jens Axboe <axboe@kernel.dk>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        David Runge <dave@sleepmap.de>, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <dwagner@suse.de>, Mike Galbraith <efault@gmx.de>
References: <20201028065616.GA24449@infradead.org>
 <20201028141251.3608598-1-bigeasy@linutronix.de>
 <20201028141251.3608598-3-bigeasy@linutronix.de>
 <20201029131212.dsulzvsb6pahahbs@linutronix.de>
 <20201029140536.GA6376@infradead.org>
 <20201029145623.3zry7o6nh6ks5tjj@linutronix.de>
 <20201029145743.GA19379@infradead.org>
 <d2c15411-5b21-535b-6e07-331ebe22f8c8@grimberg.me>
 <20201029210103.ocufuvj6i4idf5hj@linutronix.de>
 <deb40e55-d228-06c8-8719-fc8657a0a19b@grimberg.me>
 <20201031104108.wjjdiklqrgyqmj54@linutronix.de>
 <3bbfb5e1-c5d7-8f3b-4b96-6dc02be0550d@kernel.dk>
Message-ID: <76005875-1cfd-fb35-07f4-d35877d58b90@kernel.dk>
Date:   Sat, 31 Oct 2020 09:01:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3bbfb5e1-c5d7-8f3b-4b96-6dc02be0550d@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 10/31/20 9:00 AM, Jens Axboe wrote:
> On 10/31/20 4:41 AM, Sebastian Andrzej Siewior wrote:
>> On 2020-10-29 14:07:59 [-0700], Sagi Grimberg wrote:
>>>> in which context?
>>>
>>> Not sure what is the question.
>>
>> The question is in which context do you complete your requests. My guess
>> by now is "usually softirq/NAPI and context in rare error case".
> 
> There really aren't any rules for this, and it's perfectly legit to
> complete from process context. Maybe you're a kthread driven driver and
> that's how you handle completions. The block completion path has always
> been hard IRQ safe, but possible to call from anywhere.

A more recent example is polled IO, which will always complete from
process/task context and very much is fast path.

-- 
Jens Axboe

