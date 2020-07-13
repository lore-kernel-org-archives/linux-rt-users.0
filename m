Return-Path: <SRS0=nRUc=AY=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29912C433E1
	for <linux-rt-users@archiver.kernel.org>; Mon, 13 Jul 2020 14:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F226C2075D
	for <linux-rt-users@archiver.kernel.org>; Mon, 13 Jul 2020 14:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTUEv6dV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729758AbgGMO4R (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 13 Jul 2020 10:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729659AbgGMO4R (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 13 Jul 2020 10:56:17 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD08C061755
        for <linux-rt-users@vger.kernel.org>; Mon, 13 Jul 2020 07:56:17 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id x205so6723632vsc.11
        for <linux-rt-users@vger.kernel.org>; Mon, 13 Jul 2020 07:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=zNcjvlhzHZrjOTm3DmbAm2jgj78P4sf2lL3xnDyXDoU=;
        b=eTUEv6dVU0JyW6+pbHBt1utiQPFZyn8FHeEJ1zJSQbmf1zx4VV9zDOHAeUOxZLoWah
         qhnxy+8tXcmBsRg18/syuI9ib4xVG4dFQY8AgVJC0V03u8Q4y4ntXF4/rb9DHG7UOuBc
         Dkns9P1cGYrb/1sihDIR+HEpPs3reAAdGvrNSTAyrO0tXgjF4r6/sWRBCoWKoJGxRs0P
         JXdPq26gTdubnlg5V5duGFErfIMTXDLjBNSeXuow90X2pcQz6ZhWI5kNTDpPmfpb1CuD
         lrrbivZ0XUmqpjPePr8nEqpyJGQUQmJMwOM8JCIWi1r5cDAcgGcXaYPPQU9l7q+B/vxy
         RQtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=zNcjvlhzHZrjOTm3DmbAm2jgj78P4sf2lL3xnDyXDoU=;
        b=V4hwDsOqTrOYlTFVv93Cg89vSPxbQLtKIAWlj6FPNgkJcAVeztz2MKY3UbvMS5gHaD
         RwKg7EqlZZ6j8bpy+Y+HXN0DeuB1nfceJBpQZ/YaWQrcqYvsp6334f8+fobMy1LdXe4o
         9IsNJojGuHO4FVAzgM5kqPyOyEBJECrIRBGN+o+P2s/WSQIYprPqPrToGOlspvJGzx3Z
         YBrIZYygA9hKviDUJmOBLziNw5w/GfqmqYYJYOLT87J49xKyQadK8hLaFdEyeD+N7SoW
         /Kw8G+ZI2+AAvIg66G6iqCtHaj/fRVVQ7yulXalSa9ZRQHbv6gOu5MQ6Dw9I0tyTl6cD
         x6tA==
X-Gm-Message-State: AOAM533hbm5zF7zm0Zf2sXUTqpjWFYorm/1kN0hAZovFAaYcSbXPSZjQ
        AgVlG+WvE5Gie7IP7D1tEqLT3bx3pzWUnmRhXKAnu3nV
X-Google-Smtp-Source: ABdhPJzFIgukYvgTF3WCNp6lRFQE+sp/BNwn/zvIOj+mH13HoZQ05cI76NrtZ2bwE8MYslg1/h76E6+CD2XeZCaFIPU=
X-Received: by 2002:a67:2c89:: with SMTP id s131mr55708194vss.26.1594652176167;
 Mon, 13 Jul 2020 07:56:16 -0700 (PDT)
MIME-Version: 1.0
From:   Itai Handler <itai.handler@gmail.com>
Date:   Mon, 13 Jul 2020 17:56:05 +0300
Message-ID: <CAFpOueS0rvys4Q81D3HEYX2U1vM808qQ4w+z6QxCWi1KJBGXXQ@mail.gmail.com>
Subject: aarch64 boot time increases with rt
To:     linux-rt-users@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

I observed that aarch64 boot time increases considerably with rt
(PREEMPT_RT_FULL=y).
This is observable also in latest 4.19 rt (4.19.127-rt55).
Following is a fragment from kernel log (with rt) which shows that
bringing up 4 CPUs takes about 210 ms:

[    0.120951] smp: Bringing up secondary CPUs ...
[    0.184860] Detected VIPT I-cache on CPU1
[    0.187344] CPU1: Booted secondary processor 0x0000000001 [0x410fd034]
[    0.262931] Detected VIPT I-cache on CPU2
[    0.263390] CPU2: Booted secondary processor 0x0000000002 [0x410fd034]
[    0.329296] Detected VIPT I-cache on CPU3
[    0.329872] CPU3: Booted secondary processor 0x0000000003 [0x410fd034]
[    0.331557] smp: Brought up 1 node, 4 CPUs

Note that these times are from qemu, however the problem is also
noticeable on real hardware.

I traced the code and found that the slow down is caused in
workqueue_prepare_cpu().
This function creates the worker threads.

On real hardware, it takes about 8 ms to create each worker thread.
Before digging into it in more detail, I would like to hear your opinion.

Steven, what ftrace command line parameters do you recommend to use in
this case?

Thank you,
Itai Handler
