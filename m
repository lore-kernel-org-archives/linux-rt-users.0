Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C9BC4320A
	for <linux-rt-users@archiver.kernel.org>; Mon,  9 Aug 2021 01:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 816EE61002
	for <linux-rt-users@archiver.kernel.org>; Mon,  9 Aug 2021 01:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbhHIBpy (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 8 Aug 2021 21:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbhHIBpt (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 8 Aug 2021 21:45:49 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849EAC0613CF
        for <linux-rt-users@vger.kernel.org>; Sun,  8 Aug 2021 18:45:28 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id x17so9494797wmc.5
        for <linux-rt-users@vger.kernel.org>; Sun, 08 Aug 2021 18:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rtst-co-kr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rDSSFuRHAqlduTyD3s/sFnLYXwNiPitqreRt4wVmrLQ=;
        b=PPNk3esc06rpcy60qU0BMnxbcfxelQ6BeRLzBHoTR7h75DojUInfos1jCEMiYeAcKk
         1bQ3AwQnZP6JeyxoWKfCdJYF7QlVKmwYl2ORaTmj51HnDLmG3BHMtAqpNlJzmbiX6jMc
         nzsGNvykOyNpZ5CnLwBdoxeb4S1vq3yAjV7At1H3hMrPJL1MGxCxUIANJRQDLn+0ppIY
         DbG+IxI2I4dVg/JXgWRBfoxPaz+Cwe/38vehIBMVnvzzDjOUEToAnHoajSorP/WlCVQJ
         CKrWwgp1m11FM5mV15oCpj7Rrv6HrtT4ABCVaF1qDIPSJXFk3tKfckPljrDmsZOi+GYN
         SP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rDSSFuRHAqlduTyD3s/sFnLYXwNiPitqreRt4wVmrLQ=;
        b=BLWwKvHZpEshsu4HZNPiwj8OsPccGKjZO/OstLrpryyqJQiseMY8WoocRNVbUnae9f
         2LqglXFMkkP02SaQ570aOb0wkytIRrFUAHT8BK+euEsV27jlTCpfqSmAeAapVwgb17Hz
         yXskb99ta4WyS+gbkAlsiqVN0HeZjXR8jzkrDt9WJXsPiktVQqOghJCRRCMyx3+0aVXF
         D/9FQgAxwTcb4GOAJKFtldXCnh16SKZp4bvArQNg0lxe9YpZs/AK2qufXyNT0uGOoZL9
         wHZVSIz6ewZ9hSATsXnip3g13rSwCKToKbweCwVsiAAYJ+9NWWmWwlMoT1I/i2rfVBgm
         /TfA==
X-Gm-Message-State: AOAM530vYCTyFLjOWmEckV/Ut73QH3opwj036A1o9ICh+1Y0ieC5Xa7R
        S7a/Ggozp9fFC75D7KM6bV1JysK5KoriSxW3h0ib4Q==
X-Google-Smtp-Source: ABdhPJzYahGrDWObkhBOzaVFdSHsevjGagoVWzVQuxcUBs0g1yqLlkDW99cpitAS8iS3a6uOoSTpLfDvryYV5oNM4SE=
X-Received: by 2002:a7b:ce0f:: with SMTP id m15mr1026737wmc.105.1628473526970;
 Sun, 08 Aug 2021 18:45:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAJk_X9hBB_edByfEvueSyWgKjpYGZbS2rPLPCSpRrPr+icFz_Q@mail.gmail.com>
 <20210804013252.GA16420@nchen> <CAJk_X9gwa+4CZRemKqW7XZzxd438EQHA-Ngp4MdmPVgHM0Q5fg@mail.gmail.com>
 <20210809012747.GA6814@nchen>
In-Reply-To: <20210809012747.GA6814@nchen>
From:   Jeaho Hwang <jhhwang@rtst.co.kr>
Date:   Mon, 9 Aug 2021 10:45:16 +0900
Message-ID: <CAJk_X9jT7bqLn-wb7AGF6onA2qE9_D_=f4pPpGDEoiCar2BWUw@mail.gmail.com>
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

2021=EB=85=84 8=EC=9B=94 9=EC=9D=BC (=EC=9B=94) =EC=98=A4=EC=A0=84 10:27, P=
eter Chen <peter.chen@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 21-08-04 11:03:44, Jeaho Hwang wrote:
> > Hi. linux-usb and linux-rt experts.
> > >
> > > On 21-08-02 17:35:01, Jeaho Hwang wrote:
> > > > Hi.
> > > >
> > > > We found an infinite loop inside the function hw_ep_set_halt
> > > > (drivers/usb/chipidea/udc.c) if a cablle is repeatedly
> > > > connnected/disconnected while ping through RNDIS with chipidea USB =
device.
> > > >
> > > > Using ftrace tracing, we found that hw_ep_set_halt is called due to=
 error
> > > > return of hw_ep_prime(drivers/usb/chipidea/udc.c:202) which is call=
ed from
> > > > isr_tr_complete_handler -> isr_setup_status_phase -> _ep_queue.
> > > >
> > > > The comment of function hw_ep_prime says (execute without interrupt=
ion) but
> > > > timer interrupt is occurred while hw_ep_prime is executing. We beli=
eve that
> > > > the interrupt causes an error return of hw_ep_prime. We tried to pr=
otect
> > > > hw_ep_prime from irqs and then no case of the infinite loop is occu=
rred.
> > > >
> > > > I want ask if it is appropriate way that turning off irq inside (th=
readed)
> > > > irq handlers. And should we explicitly turn off irqs before calling
> > > > hw_ep_prime?
> > > >
> > >
> > > Jeaho, do you use RT-Linux or standard Linux? The function hw_ep_prim=
e is
> > > only called at udc_irq which is registered as top-half irq handlers.
> > > Why the timer interrupt is occurred when hw_ep_prime is executing?
> >
> > We use preempt_RT so timer interrupt could be occurred. Now I found
> > out that forced threaded irq handler disables local irq on standard
> > linux so It is a linux-rt issue. Then should I make patch which
> > disables local irqs during hw_ep_prime for RT kernel and suggest it to
> > linux-rt maintainers?
> >
> > Thanks for a kind answer Peter.
> >
>

Thanks Peter.

> No, that will lead to deadlock since the normal request queue API functio=
n
> ep_queue disables irq which also calls into hw_ep_prime.

ep_queue disables irq by calling spin_lock_irqsave but it actually
does not disable irq for RT kernel.
Therefore local_irq_save at hw_ep_prime would not cause deadlock if
ep_queue calls it, i think.

Is it anything wrong?

>
> For RT kernel, you may try to disable local irq at isr_setup_status_phase=
.
>
> --
>
> Thanks,
> Peter Chen
>


--=20
=ED=99=A9=EC=9E=AC=ED=98=B8, Jay Hwang, linux team manager of RTst
010-7242-1593
