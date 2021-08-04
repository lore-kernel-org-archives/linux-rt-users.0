Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30181C4338F
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Aug 2021 02:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EDEC60243
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Aug 2021 02:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234414AbhHDCEL (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 3 Aug 2021 22:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234230AbhHDCEK (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 3 Aug 2021 22:04:10 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A83C061764
        for <linux-rt-users@vger.kernel.org>; Tue,  3 Aug 2021 19:03:57 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id m19so298435wms.0
        for <linux-rt-users@vger.kernel.org>; Tue, 03 Aug 2021 19:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rtst-co-kr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zBi/4DyBrAJ54JI+6NAqWr7rfcLuXLpDmtkvpW0MEpg=;
        b=VxDyckCan+nlsyElYFpgIKhlFvfJGmh1LuwKJz4W6++ZOdvSj9BPr5P3TEqAGJR7WT
         S8V0yyRtbvkPce1pk2NlJIqFRImxTRTF738Az2uxnigUtcFsVzeb5qyk1L3HMViwo7C2
         wWKZZMGMDFJ3thdVsMyUykfojFTDnQ78QDGSPjROs4482uO0PTuPqDBye2t9IfRWCJTW
         n2lqMoMrW6HPPrxgRO3r/RFaQsKxtxeLXxoKTIGjo1T64wiWS+ufwnz3Iq3FOt0mZpq2
         AJaRlbejOeTlxBVy4Ip4RoRD0SwNXa6CEpuIuOk+77s41jFCazDd/OAH3NKGMwHg3LHa
         1uRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zBi/4DyBrAJ54JI+6NAqWr7rfcLuXLpDmtkvpW0MEpg=;
        b=Vxrw0srMxrtJB9BwzhbF6TkBYMlkqZf6z9wzVMzMYKi/8CzZsLv3r4U+E9miuPTwaC
         o7GMLP4ozb0Arh2t+DyraFagc/nLCvdRp9U5VaN76onVXoRAAs/OJ7gJ82LOA60p4eyF
         LxdehDIizncqaUZoY1dorm/hXw8UGau7I9XJM2/Cq2KRLrIIJ97MuBAKNyIRhbYZoo9P
         a6iGImnDRPNJDiPJoX2U24zq2ABXiZKakcX5RjRJBupt5o5cpqHJpu4roPcy5rWzqYUx
         MsQRAegKXD6xZsJty2C6aTk5uScY3GNqK66WqW+RG8u0Cdb5bzn31A4Gn6SwtiXjDq2y
         FbwQ==
X-Gm-Message-State: AOAM530H2bKNZ7wszSaDAZz88x0ABbxTYHYnx5LLU6itsJnU4YlFN6vt
        S3p/sM9xMjv4IS8tteou6+2fxlu/v2ZKBHUbXWxjOQ==
X-Google-Smtp-Source: ABdhPJxY3QjySiiv+DNCAckxM779d1JXngFScYhhyH3gGzgY6c3A8dX9XcgtDZyEc7ALNTMY2deeQ769daP3dbmKuII=
X-Received: by 2002:a7b:c094:: with SMTP id r20mr24399561wmh.107.1628042636306;
 Tue, 03 Aug 2021 19:03:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAJk_X9hBB_edByfEvueSyWgKjpYGZbS2rPLPCSpRrPr+icFz_Q@mail.gmail.com>
 <20210804013252.GA16420@nchen>
In-Reply-To: <20210804013252.GA16420@nchen>
From:   Jeaho Hwang <jhhwang@rtst.co.kr>
Date:   Wed, 4 Aug 2021 11:03:44 +0900
Message-ID: <CAJk_X9gwa+4CZRemKqW7XZzxd438EQHA-Ngp4MdmPVgHM0Q5fg@mail.gmail.com>
Subject: Re: Chipidea USB device goes infinite loop due to interrupt while hw_ep_prime
To:     Peter Chen <peter.chen@kernel.org>
Cc:     linux-usb@vger.kernel.org,
        =?UTF-8?B?67OA66y06rSRKEJ5ZW9uIE1vbyBLd2FuZykv7J6Q64+Z7ZmU7JewKUF1dG9tYXRpb24gUGxhdGZvcm0=?=
         =?UTF-8?B?7Jew6rWs7YyA?= <mkbyeon@lselectric.co.kr>,
        Linux team <team-linux@rtst.co.kr>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi. linux-usb and linux-rt experts.
>
> On 21-08-02 17:35:01, Jeaho Hwang wrote:
> > Hi.
> >
> > We found an infinite loop inside the function hw_ep_set_halt
> > (drivers/usb/chipidea/udc.c) if a cablle is repeatedly
> > connnected/disconnected while ping through RNDIS with chipidea USB devi=
ce.
> >
> > Using ftrace tracing, we found that hw_ep_set_halt is called due to err=
or
> > return of hw_ep_prime(drivers/usb/chipidea/udc.c:202) which is called f=
rom
> > isr_tr_complete_handler -> isr_setup_status_phase -> _ep_queue.
> >
> > The comment of function hw_ep_prime says (execute without interruption)=
 but
> > timer interrupt is occurred while hw_ep_prime is executing. We believe =
that
> > the interrupt causes an error return of hw_ep_prime. We tried to protec=
t
> > hw_ep_prime from irqs and then no case of the infinite loop is occurred=
.
> >
> > I want ask if it is appropriate way that turning off irq inside (thread=
ed)
> > irq handlers. And should we explicitly turn off irqs before calling
> > hw_ep_prime?
> >
>
> Jeaho, do you use RT-Linux or standard Linux? The function hw_ep_prime is
> only called at udc_irq which is registered as top-half irq handlers.
> Why the timer interrupt is occurred when hw_ep_prime is executing?

We use preempt_RT so timer interrupt could be occurred. Now I found
out that forced threaded irq handler disables local irq on standard
linux so It is a linux-rt issue. Then should I make patch which
disables local irqs during hw_ep_prime for RT kernel and suggest it to
linux-rt maintainers?

Thanks for a kind answer Peter.

>
> --
>
> Thanks,
> Peter Chen
>


--=20
=ED=99=A9=EC=9E=AC=ED=98=B8, Jay Hwang, linux team manager of RTst
010-7242-1593
