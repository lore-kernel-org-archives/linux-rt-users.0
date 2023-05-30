Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B83C77B73
	for <linux-rt-users@archiver.kernel.org>; Tue, 30 May 2023 10:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjE3Kvs (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 30 May 2023 06:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjE3Kvq (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 30 May 2023 06:51:46 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBBA93
        for <linux-rt-users@vger.kernel.org>; Tue, 30 May 2023 03:51:45 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2af30d10d8fso44069791fa.0
        for <linux-rt-users@vger.kernel.org>; Tue, 30 May 2023 03:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685443904; x=1688035904;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aJPkt4mGErGxPZ93Ez9E3RLiXJiRBbb6NslbqNtnW8k=;
        b=PZo+bbvTyMSwDXFcXV4oHjzXKeMRdu3IbRvVU69Vcp4y1NRFGDKaJhjnwVyX8z60Io
         GSiJrePeWVqj07KZcUWuffZ9mtNn3JTATXKVIjn/JTjADhvXCFear9bOX1LJXy/Uv4tE
         ROSx98pSO9evmTHAbcQRlN/cMSQt92+iJXr34yfBGPaHjvzWFtBlBSy6+sYUTJrHKRxs
         hjCw3UsL0KTzThwMFREjZx1iyNoCbIircOND3G5kjkkJ0YbaYZtg/MuThb45Gs9rSQMr
         IVe4xcNgc6tXkzAWo8sLqCUHEQiqZcInpo+612+5JIf0zep1lTLyhgN90GCrnH3JDMHt
         EY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685443904; x=1688035904;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aJPkt4mGErGxPZ93Ez9E3RLiXJiRBbb6NslbqNtnW8k=;
        b=aNZrNqtGl8pIQNiNWKul9/4rAMC4nP6WYRg3lgl4yxyAXu+QRSHCx5ACsPKcoaNNN/
         C7FhkRA34q5TkUZ+SWfcgDX+GcVBg7GN53LyHI+ANlg4HGQhWhviGABFhQK0YquAlsDM
         k2yTGGcieUzDp/P2FYe1jHKlqjXasToGqe8X6oJrWpbbvgAM1V5z0P9pdUlDEuhhq9C8
         rMoHNEkQmUHomHuSZM6Aeca7xTG86EZMEnFishDLgt5D8U5yFnXFd88yf5yoxzHuj+kH
         nhj8jK4s0lelo5470ZSaVyBYj/IDvyDq43prO+qZ44/KN4fBcgXvtQ4Rva0rU3CrbXva
         hUpw==
X-Gm-Message-State: AC+VfDwN1DuwJatSMra0296koUu0Oe7/47ZXHu1cXVbjtmWQauOt3Rm5
        HSArf6YcpMbmFi/CxV8zsQoxGEGtVGyDuCsMUkjbtIS7074=
X-Google-Smtp-Source: ACHHUZ4Td1aFv78pTd0uwUQohsoAOwEEXWRnKTmBk7qphJLCNs30qsnzRXUawZJVEcFCYOiaDQRnl/coq0PcZScFU68=
X-Received: by 2002:a2e:9810:0:b0:2a7:853e:a43 with SMTP id
 a16-20020a2e9810000000b002a7853e0a43mr524223ljj.40.1685443903805; Tue, 30 May
 2023 03:51:43 -0700 (PDT)
MIME-Version: 1.0
From:   Kegl Rohit <keglrohit@gmail.com>
Date:   Tue, 30 May 2023 12:51:48 +0200
Message-ID: <CAMeyCbgGgxpF5Nk=dZXEBS92VxUBR_OcRQqdQdEJAAzqcbP+fQ@mail.gmail.com>
Subject: rcu stall caused by rt task with high minor page fault rate
To:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello!

Running  5.10.104-rt63 SMP PREEMPT_RT on dual core imx7d.

Currently I am debugging an rcu stall issue caused by an user-space rt task.

The test procedure to reproduce the issue is:
1. Bootup the system
2. initd starts rt task application (SCHED_FIFO, priority -13 and
affinity set to core0)
3. login via ssh and start e.g. memtester with the maximum amount of
free RAM available
4. memtester locks its memory with mlock successfully
5. After some time the rt task is stuck consuming 100% system time on core0.
6. Kernel produces rcu stall warnings because rcu kthread does not get
any CPU on core0.

Looking at the vm stats of the rt thread shows a minor page fault rate
 > 350k/s.
So the process is stuck in memory handling and because of the core
binding the rcu kthread does not get any core0 cpu time and produces
stall warnings.

Reading https://wiki.linuxfoundation.org/realtime/documentation/technical_details/rcu
CONFIG_RCU_BOOST=y, should be the solution for such issues.
But enabling RCU_BOOST did not change anything.

See link above:
> However, bugs can happen, including bugs involving infinite loops in high-priority real-time threads. Debugging these problems is more difficult if the system keeps hanging due to OOM. One way to ease debugging is to build with CONFIG_RCU_BOOST=y,

The main cause for the minor page faults is the missing mlock in the
application.
mlock is always necessary for rt apps.

But for my understanding RCU_BOOST should help here, even if the rt
app is not implemented correctly?

Thanks in advance!
