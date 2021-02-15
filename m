Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF902C433E0
	for <linux-rt-users@archiver.kernel.org>; Mon, 15 Feb 2021 15:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98C0064E2B
	for <linux-rt-users@archiver.kernel.org>; Mon, 15 Feb 2021 15:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhBOPGV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 15 Feb 2021 10:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbhBOPEw (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 15 Feb 2021 10:04:52 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4960BC061574
        for <linux-rt-users@vger.kernel.org>; Mon, 15 Feb 2021 07:04:12 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id c16so6320830otp.0
        for <linux-rt-users@vger.kernel.org>; Mon, 15 Feb 2021 07:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=DPh5sV/2VPWUsDoxllswcRzHt8c+Tt1/BUAiOXcdrLI=;
        b=Apfg7rBGA2PmhnAPHvlGQUBBzcjqnvu4zj+95krF8QldaktgywiLCuiaB5I+oTce4S
         k/DSiUR0V49lJLWlna6mvM1dY6yrKZ2jfHBy8wbxP9pXrHD3Oz8K1Numa4SfRM5y4f3N
         AOdlI5851MQ4seYDHr3CZkiNrkns8KBtNauEw3mYEtJ6sBWPzE5NHyiNQTJzWSXE+i9S
         k4DWXwlX+xNK/oirM1AkIGfIACaI+XgeYh2Xm6n3B3mrM/Jy22WQZBv8lpwf13lA6LeR
         3K4fKA8b57Ci4trDRdbyr0RFi3m+rkurdu8i3Htxx9sEbLKcQ9bBLmGaPSTL80SOf57m
         OlgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=DPh5sV/2VPWUsDoxllswcRzHt8c+Tt1/BUAiOXcdrLI=;
        b=sDp+OK6gYpeY1q6GzS8mtEzcXnAOqvQlKEEVhlS9BXnljEb+DazYgvUUeI8pZqvuAK
         1mo2WMrw0tgvaQ563LFbYxmzur3RXkhhdaNdCdWymberZT+vyMmRmXBotQrpfpEIK7Z9
         vJbwGOz9lUI/wSUdZpJjU4lezEJFLngRGc0BdFA+agXu0rag/wwb2h84+0ZzXQ7VcggH
         Tx/O9+h/rD9PEZG2y51GgMGWn/E2h7spKCIxh0m/MoBlRA1ZPadpDzs1PriPYO7lIkm6
         ODcN0Z2lMDAbIWLOQ2ABY9y8umfOr2SjTUS0qq23jTgcD4LvBs0UBcUR6B4kRvwr5CvE
         Yj+A==
X-Gm-Message-State: AOAM533dE9LLB9s2bf3CA2r1KYT3CHrei7WGihGglR6bA5j2q0okW409
        d+mm+AwfWg7PTAI5VVQoXxfDd1EFA7fgK18+e0OKd6gEIeA=
X-Google-Smtp-Source: ABdhPJxD2dns6ziFna4rrO6EOSNIDXVP96cPhxr+nZRx5hwl2iaUzGRwuWz/5ayIbUBqZeRRl2uoMZ6TL0Nz5rAi96s=
X-Received: by 2002:a9d:65c2:: with SMTP id z2mr4806151oth.288.1613401450926;
 Mon, 15 Feb 2021 07:04:10 -0800 (PST)
MIME-Version: 1.0
From:   Kegl Rohit <keglrohit@gmail.com>
Date:   Mon, 15 Feb 2021 16:04:00 +0100
Message-ID: <CAMeyCbgqzz5MqOM-yXNxdcRSYquK4BtcmvFR6aug29Dgd0YGmw@mail.gmail.com>
Subject: 5.4.y softirq processing
To:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello!

May i ask some questions of the current state of softirq processing
with PREEMPT_RT.

In 4.19.173-rt72 timer softirq processing is split into its own thread
ktimersoftd.
patches\0124-softirq-split-timer-softirqs-out-of-ksoftirqd.patch
This timer split existed for years.

Since 5.0.19 its gone because of a softirq rework.
6f6ba7715a91877cf5fd2b357db3799baa331d9b

I only found this info about it:
https://lwn.net/ml/linux-rt-users/CAFzL-7tzwnBEnt_q2f0BPSAO3To_Zaxt4bLtfzKVOiyJTua45g@mail.gmail.com/
https://lwn.net/Articles/789761/
Can anyone give me a more detailed / simpler explanation why it was removed?

Others are also effected by this change:
https://www.spinics.net/lists/linux-rt-users/msg23051.html
https://bugzilla.redhat.com/show_bug.cgi?id=1303733

For our application it was necessary to increase the processing
priority of timer tasks by setting the ktimersoftd priority higher
than the ksoftirqd.
Now this is not possible anymore.
Does a method to increase timer task processing over the other not so
important ksoftirqd workloads still exist?

Another way to gain a lot more control over different system
components would be this patch, which split every softirq in its own
kthread.
https://lore.kernel.org/patchwork/patch/513177/
This patch is very outdated and I am not able to port it.

Do I miss something?
Is there any way to set different priorities for each softirq as of 5.4.y-rt?
e.g. to reduce the priority of NET_RX_SOFTIRQ / BLOCK_SOFTIRQ
Control over NET_RX_SOFTIRQ would help in network flood situations.

Thanks in advance!
