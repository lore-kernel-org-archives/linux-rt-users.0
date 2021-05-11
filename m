Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1ECC433B4
	for <linux-rt-users@archiver.kernel.org>; Tue, 11 May 2021 19:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E701961376
	for <linux-rt-users@archiver.kernel.org>; Tue, 11 May 2021 19:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbhEKTvg (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 11 May 2021 15:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbhEKTv2 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 11 May 2021 15:51:28 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0207C061574
        for <linux-rt-users@vger.kernel.org>; Tue, 11 May 2021 12:50:20 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id j10so4474315ejb.3
        for <linux-rt-users@vger.kernel.org>; Tue, 11 May 2021 12:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=zFdRi+JcQXMLUvHeiOf5oF71WE5nwWbz/byLlhDQ9UY=;
        b=ACLPkt1+a/AXRsLX7L6Lnd0YX/C82FRYTURLgD1T9E04h1zXISkDs43fySZJHJ2o4q
         dWMR889iOC7Dl3K/7SzVIQr/hScIxB2iXfrBHdKC2uE+URnv13hsQS+lTJQPj3+xnJ9k
         rj10WcUxAA/5RPI0x6rx710Sqxfpj6e5Gj4a2W01DChRAsFNa/sOF5j2P0d8EOO6KROn
         rqycOeGnRqVNRc8mcq3hQktl9SI+/twQq8k5bosRmEgSm6DQz4dVsbfdhAxZN1RVxgKP
         XtalkJTx9iljW1yvMpsZdmutkYm5L4eTus3JObC43Eu5Ng3o5/tjyoT1zFzZb3vP4M4r
         GJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=zFdRi+JcQXMLUvHeiOf5oF71WE5nwWbz/byLlhDQ9UY=;
        b=CSZDRwphggW0FN7hNPRFTY2W5bhS5xSdFj1sawMMpa36gkYMSFAJHwOnZ5vICfODog
         NVmd0b3YvzJjGnsl79j+ORGQPvPb658YtieIH9nENQ6mX8+nOVU6ctwxd6+z+IFEoLqk
         3+kqh6SA05Qz5TKANkRZEXthRJBgBSK22RKjh4AHovieL6wP39IaZIz5ptSNkn4x1AxS
         pzW/XYK9wrRN2kaLyLVsO9G1L9NnjY79xyBWidv+pQ+Ch+0xdNmU0byHzyOUyEcVYFAR
         SoyrOxZSQ/EJ5Kotkkw7i1l9L2Sw2WyKjc9yraqaK3XO5c8A/g1t357SeUUJ5c5ge6sJ
         /NaA==
X-Gm-Message-State: AOAM533n6J08fZrpLU6N/aygAocE6jjDMehzdhBuLGMLkVVAZR5tYvn/
        X8GZjP5w2wIjriOadCB9crMm6MS8zCk=
X-Google-Smtp-Source: ABdhPJxM+FnA/272H1xzHnEv1KctCs7xo6DiVBTFKpjmCSnQCgMRmPmPKTZlsfS0oB7+E1+2z1vQdQ==
X-Received: by 2002:a17:906:b315:: with SMTP id n21mr33424283ejz.219.1620762619328;
        Tue, 11 May 2021 12:50:19 -0700 (PDT)
Received: from ?IPv6:2a01:c23:7094:5a00:c90f:e684:6fe8:2cfb? (dynamic-2a01-0c23-7094-5a00-c90f-e684-6fe8-2cfb.c23.pool.telefonica.de. [2a01:c23:7094:5a00:c90f:e684:6fe8:2cfb])
        by smtp.gmail.com with ESMTPSA id p25sm1033088eja.35.2021.05.11.12.50.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 12:50:18 -0700 (PDT)
Subject: Re: big rt latencies compared to non rt
To:     Angelo Dureghello <angelo@kernel-space.org>,
        linux-rt-users@vger.kernel.org
References: <736a53fb-d80e-3faa-1a66-d40538e0fe26@kernel-space.org>
From:   Jonathan Schwender <schwenderjonathan@gmail.com>
Message-ID: <80987725-41e4-017c-5e20-dbd886726ee9@gmail.com>
Date:   Tue, 11 May 2021 21:50:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <736a53fb-d80e-3faa-1a66-d40538e0fe26@kernel-space.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Angelo,

>
> Average is near 16uS but there are some outside
> values near 40000, as
You are reading the table wrong. The leftmost column is the microsecond 
bucket. The other columns give the amount of times a latency was inside 
that microsecond bucket for each measurement thread.
> 000017 040537    015000    033773    041092  <-----

For example, in this line CPU 0 had 40537 latencies in the 17 us bucket, 
while CPU 1 had 15000 measured latencies of 17 us (and so forth).

You should also check the line at the End `# Max Latencies: xxxxx`, 
which will give you the maximum latency, and the line below which shows 
you how often the histogram overflowed.

> Thanks a lot,
>
> Regards,
> angelo
>
Hope I could help,


Jonathan
