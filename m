Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E818C4338F
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Aug 2021 05:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 289416101E
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Aug 2021 05:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236977AbhHJFLL (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 10 Aug 2021 01:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234999AbhHJFLK (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 10 Aug 2021 01:11:10 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C26C0613D3
        for <linux-rt-users@vger.kernel.org>; Mon,  9 Aug 2021 22:10:48 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id m12so24498679wru.12
        for <linux-rt-users@vger.kernel.org>; Mon, 09 Aug 2021 22:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=Hd7NOrqIpmSCkRFu8mcUTkK9n/RdZ+vSpqiCbqnBfjs=;
        b=IAeCT7pTEDJe6osYNLQw+n/jVAKyp9RvGeoQh8YNyr24XXupxV3Ra8MmcdUCee3rRl
         rEbzOyPbk006QJC9EskwhmalnNxNUWzGYCXXKAaKGgz1MQ+1gT7eEicGvN4SgarABBhJ
         E677DZKAde+zMrcBsOfRmYKBU09RE+6itfMoQMrTGn/W5gTOrl0qHqLy9L4Lujb9ipwy
         uElY7o4tVZMgS9bLRv2HubZpdgYPqO5SR6/2QYoRLf8RyTr17nB+3ZTnefmXF/2UYpl/
         gvWXgzSSVRhdHtNNfLbVWTw2SApbVgOoJFM9Nm1eo6rjpUbOxX8aJoZDKLCUZWdNCI4/
         QukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=Hd7NOrqIpmSCkRFu8mcUTkK9n/RdZ+vSpqiCbqnBfjs=;
        b=TEKH7M+gneQ8wDw/QC+Qn8kr6RKfTWJ2PTEAf9HFJY5Rnv8s9FwyWx9D6zaxGugIXM
         0ZGxO2RZgpLdqe0U+VxBdhNbHlqi9bFbACMwqXMBwpQl/6H6TduEVFYJw6LVh8pDltc4
         JOrwJnexT/0QEb5yslg6HPx1CQTlW5ds2dZ8PPd5tb6aJH3TkIvI1wQPq2f+y3w8nOBQ
         npBrsVHYb7Xocz845KzTe7DvoykWiIAl0MY8+AGvBi/4nszqZ/rnlIxmxJhqZiqIeDPT
         pnAF5dgVm6JAn1cEfdqF5wmyvCZCUT8sJY+5hTlAZ/BVD+g2f2p22iWYx2hdrkQzFYMc
         9auQ==
X-Gm-Message-State: AOAM531AnAk3U46KRCG9k3e42J99eThUt9B5g2iqy5HVggaDWYMYo27n
        fSYp+TiqLTK5+kpRUTSLgMI=
X-Google-Smtp-Source: ABdhPJzI8UFHAYrdXazKDgQ3ppaYMB4vEYv2iDLFqM8TTDnpFditGMk0U4WX4uuKFYRDyJq8s/yAtg==
X-Received: by 2002:adf:9c8b:: with SMTP id d11mr15659856wre.43.1628572247393;
        Mon, 09 Aug 2021 22:10:47 -0700 (PDT)
Received: from LAPTOP43OUQQN0 (p200300c93f1b50003d1ab0056cef6745.dip0.t-ipconnect.de. [2003:c9:3f1b:5000:3d1a:b005:6cef:6745])
        by smtp.gmail.com with ESMTPSA id t8sm4522367wrx.27.2021.08.09.22.10.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Aug 2021 22:10:47 -0700 (PDT)
From:   "Jonathan Schwender" <schwenderjonathan@gmail.com>
To:     "'Alison Chaiken'" <achaiken@aurora.tech>,
        "'linux-rt-users'" <linux-rt-users@vger.kernel.org>
Cc:     "'Daniel Wagner'" <dwagner@suse.de>
References: <CAFzL-7sj+Y79UC-CnB+6qDRe7EgPnjb0be63CwEJOfkdCvJYVw@mail.gmail.com>
In-Reply-To: <CAFzL-7sj+Y79UC-CnB+6qDRe7EgPnjb0be63CwEJOfkdCvJYVw@mail.gmail.com>
Subject: AW: hyperthreading and RT latency
Date:   Tue, 10 Aug 2021 07:10:43 +0200
Message-ID: <002901d78da6$129f8250$37de86f0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKN5NcP9LqnaNkBMALNHz9v2Tbo+an/fSow
Content-Language: de
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Alison,

> Is the advice still current?   Should we RT-users all still turn =
hyperthreading off?

I ran some tests as a part of my master's thesis in the beginning of =
this year with the 5.10-rt kernel on an Intel Broadwell-EP 2-socket =
server.
If you are interested, I can dig up the graphs I made, but the jist =
regarding wake-up latencies measured by _cyclictest_ (24 hours each) is:
1. Task-isolation (placing the RT-task on a dedicated core) + Cache =
allocation + disabled Hyperthreading yields the best latencies. =
Something around 4-5us worst-case latencies were possibly with some =
optimizations.
2. Placing a load (rteval) together with cyclictest increases the =
latencies, but worst-case latencies of I think 16us are still okay for =
many applications
3. Isolating a task on a dedicated CPU and placing a load (rteval) on =
the neighbor CPU sharing the same core yields strictly worse latencies =
compared to 2). I think it was around 50us worst-case.
4. Isolating a task on a dedicated core (hyperthreading disabled), but =
enabling hyperthreading for the non-critical cores seems to have a =
rather small negative impact, as long as CAT is used to reserve cache =
for the isolated core. I'd have to look up the details though.

I don't think the situation has improved on more modern hardware, since =
AFAIK the SMT hardware has no knowledge of your tasks priority.

>Thanks,
>Alison Chaiken

Best Regards,

Jonathan Schwender

