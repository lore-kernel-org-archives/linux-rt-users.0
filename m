Return-Path: <SRS0=Ov4F=EG=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EF2C388F7
	for <linux-rt-users@archiver.kernel.org>; Sat, 31 Oct 2020 15:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3576C206E9
	for <linux-rt-users@archiver.kernel.org>; Sat, 31 Oct 2020 15:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="JyIEKdEG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgJaPAw (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 31 Oct 2020 11:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbgJaPAw (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 31 Oct 2020 11:00:52 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15962C0617A6
        for <linux-rt-users@vger.kernel.org>; Sat, 31 Oct 2020 08:00:52 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id j5so4464421plk.7
        for <linux-rt-users@vger.kernel.org>; Sat, 31 Oct 2020 08:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qXaMQL6RoCeR+mudIFA4Xtm/e3sImcS6WcNnwqQ0dQE=;
        b=JyIEKdEGhqyOfhEqPSLRNuZB7XXHSH0rNkqv4QqIlBz5yzReIz7XNaXfvOkSTLWaBJ
         vE72F4+6NuTwikbwzaODM/0HkPqs5OSknMRWm7/1CV+9T4Zvj8J1Tcx2HjykAN18H46T
         Pz+ItZKLEZkyjzWg2wVQVhW0OA0vqWSXZPFhsMRvN7GHQm/t3qIcb70xPqXj2YM0UWtC
         wgJbqbmHo+ukwJa3lq9s/i8BhBuhdQt0QYYGDQhVWOFh34KBmJ2oRTWjkLEZfRUo19zV
         g4bD1jOoiQHVUx+klABS1YrP5pEANXgBmfjW3HgZbDPg9yx5spX60a6oxnQ34npe4Njk
         6OJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qXaMQL6RoCeR+mudIFA4Xtm/e3sImcS6WcNnwqQ0dQE=;
        b=riOtCKGjdWJFhznlOSP2ZNTEvlCyFwAO20Rzi7Ho1lyXylFehS7s8KMFc3MU4U0dhF
         j9EqdkzXmiXoPedynTMlRlITMJCsiKkK4mugT7O/+xqq6HH5EF7+xInVpYuovLQrFH/I
         Mkttd/04ENcvSlZEB+i6G1bVd5wHBxkcTkZgsSMtC1lNCoMk32JUIsj7lUEsE6pf09/P
         y3tudnXaMKBi7EgDWZ6Z3HE47ck4ul4zEREi7fPLplOCBQ7AqdTDl0COMD3wkN/yiPjB
         VYA4evnzmUFc6LT+yVUaZJKsGoCeKCikPgmM1gUyAqS8E5UAQOtCBJZmB1eOg20ZNMe0
         /aEQ==
X-Gm-Message-State: AOAM530qo6tKc9srPsKMEDv2p+i84dzqs8d5MWhzO9rwTQvzhrov5hrz
        VI57eF2oXvpRzWWjTsj3bRxN3A==
X-Google-Smtp-Source: ABdhPJwm7j/1DXCTZ42mILmZXxrwO1Vmt4eM1S1RfrfM4xiATEqjowOfuHUe2DQE5Pprkfw/wropig==
X-Received: by 2002:a17:902:8548:b029:d6:ac0f:fe78 with SMTP id d8-20020a1709028548b02900d6ac0ffe78mr5919713plo.5.1604156451482;
        Sat, 31 Oct 2020 08:00:51 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id 128sm9054446pfd.110.2020.10.31.08.00.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2020 08:00:50 -0700 (PDT)
Subject: Re: [PATCH 3/3] blk-mq: Use llist_head for blk_cpu_done
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
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3bbfb5e1-c5d7-8f3b-4b96-6dc02be0550d@kernel.dk>
Date:   Sat, 31 Oct 2020 09:00:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201031104108.wjjdiklqrgyqmj54@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 10/31/20 4:41 AM, Sebastian Andrzej Siewior wrote:
> On 2020-10-29 14:07:59 [-0700], Sagi Grimberg wrote:
>>> in which context?
>>
>> Not sure what is the question.
> 
> The question is in which context do you complete your requests. My guess
> by now is "usually softirq/NAPI and context in rare error case".

There really aren't any rules for this, and it's perfectly legit to
complete from process context. Maybe you're a kthread driven driver and
that's how you handle completions. The block completion path has always
been hard IRQ safe, but possible to call from anywhere.

-- 
Jens Axboe

