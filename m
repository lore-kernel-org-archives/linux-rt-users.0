Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F302CC4320A
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Aug 2021 16:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF2C460F41
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Aug 2021 16:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237332AbhHDQXQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 4 Aug 2021 12:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237304AbhHDQXP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 4 Aug 2021 12:23:15 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0C1C061798
        for <linux-rt-users@vger.kernel.org>; Wed,  4 Aug 2021 09:23:02 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id cl16-20020a17090af690b02901782c35c4ccso557747pjb.5
        for <linux-rt-users@vger.kernel.org>; Wed, 04 Aug 2021 09:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KDf4S7vuVJwPHUuA2uOwMFtaC8lnY+PpQtbeQuDG6qk=;
        b=K8xx7Gwt90YL5tpn+pg1F1XwRNwbg/3sOwmML189OUSTLCAYGybq+ezWdh+iW8rcur
         jJz+5jmiI4WtqT9rO/Ox5jJPUZmIo4I+de5jYIjia0crWrmcDYlpUcAbo6ejSCEU0LXG
         q0ePKUGqApxbGpTiYuHM5sulMlEyxPhPjWWoKVRLsRaJQ10l7JjqfNX4sw03aI3QWbmQ
         q7FirZt1qNIcqnK8sJA+0p5InRQwhMapXzGJZDoPjBxmB3BMorvwQ/5F+2Osx7c1qk5p
         gNdu7HZBN0GZl2CBND1eNJ0UIDjtudEh2aPeXj3FbmICOt0yS89jAxr5qekMhOGo/+aK
         wMRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KDf4S7vuVJwPHUuA2uOwMFtaC8lnY+PpQtbeQuDG6qk=;
        b=OHoRqzhArigsT/LpGw8oxtI/eEisBINr09oul+uLIKcVFhONK3Pvqjy4koEYI7HPc8
         1ouny4b7cAfUebPqlfJg56vMF0VMa5+xeuURkbKRQJdS10GK7HlaXDUcR6a2jYbJ1/1Q
         CBQdSqmXSGW4g8M1L7cAlOtehemiAhH8uw/SZVDyi0pBG5ea6lbi9eW4zRWO52H3YMbr
         3iekBXAKNxsJUvu0nrzVAzd5aJnwnObu356tzPC9l3z6ZZF2JMsMsGmIpkg5NMTK6xo8
         elsDsbDfNZyyLkRdqSE2szkALg3MTFMPsEHW5afnqOlo7LJ0pbkEdIP53Q2Ng0G0lAI4
         DuNQ==
X-Gm-Message-State: AOAM5323W0a+6eAEgOeqKXU/Tj2rdyELtck+nooWSrDoHB1352K59ws9
        KXhlWD8fF76FZEhtcHw7k8vA2ICBC/dHn1Vf
X-Google-Smtp-Source: ABdhPJxyQStlQynjCVKg8OadBGr6XpSuvMNaXEahcITQr5ZhH7KVkhFBSvVMx04csvIB9chzwdInTA==
X-Received: by 2002:a62:584:0:b029:32e:3b57:a1c6 with SMTP id 126-20020a6205840000b029032e3b57a1c6mr435156pff.13.1628094181407;
        Wed, 04 Aug 2021 09:23:01 -0700 (PDT)
Received: from [192.168.1.116] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id w2sm6685972pjt.14.2021.08.04.09.23.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 09:23:00 -0700 (PDT)
Subject: Re: [ANNOUNCE] v5.14-rc4-rt4
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <wagi@monom.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org
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
 <c3fa07d1-a3c4-6775-f419-4875eb41bc88@kernel.dk>
 <20210804122029.6c5c837a@oasis.local.home>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4ffb8f7c-085c-f6cc-e308-3f75b24b8e47@kernel.dk>
Date:   Wed, 4 Aug 2021 10:22:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210804122029.6c5c837a@oasis.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 8/4/21 10:20 AM, Steven Rostedt wrote:
> On Wed, 4 Aug 2021 10:05:39 -0600
> Jens Axboe <axboe@kernel.dk> wrote:
> 
>> So what do you propose in the interim? As far as io_uring is concerned,
>> it's not a _huge_ deal to do the IRQ dance, but it does bother me that
>> we're making things slightly worse for the mainline kernel just to make
>> the out-of-tree patches happy.
> 
> Note that the purpose of these patches are to be able to bring those
> out-of-tree patches into the kernel such that they are no longer
> out-of-tree.

Sure, I realize that. And I've always been accommodating to making
pieces of code more RT friendly, I just don't like doing it for cases
where we are making mainline worse.

In that regard, I do still consider those patches out-of-tree, which
they are. And while I'm more sympathetic to them compared to other
out-of-tree code as there's a long term plan to get it all in, it's
still out-of-tree. Best solution here is probably to just carry that
particular change in the RT patchset for now.

-- 
Jens Axboe

