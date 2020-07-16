Return-Path: <SRS0=vtwn=A3=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15790C433E2
	for <linux-rt-users@archiver.kernel.org>; Thu, 16 Jul 2020 20:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D32B9207E8
	for <linux-rt-users@archiver.kernel.org>; Thu, 16 Jul 2020 20:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=austral-dynamics-com.20150623.gappssmtp.com header.i=@austral-dynamics-com.20150623.gappssmtp.com header.b="kHbKSR5J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbgGPUUW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 16 Jul 2020 16:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgGPUUW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 16 Jul 2020 16:20:22 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11ECBC061755
        for <linux-rt-users@vger.kernel.org>; Thu, 16 Jul 2020 13:20:22 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id x9so6240255ila.3
        for <linux-rt-users@vger.kernel.org>; Thu, 16 Jul 2020 13:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=austral-dynamics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DKaKbTbuLkT8QA7TX3bqJ/+bB1UfilX9I+k59JX1WOY=;
        b=kHbKSR5J+2xxw68h9U2HmUbVucqfs8qn+lv1zYkTGTV6fjwDV5szq2h4kapH+bSEWK
         FiPhdBJSioaJruLQIHu6JNyfAAmn9Ch5/OnOy2zPIS6JJ9EBlfia8R1PjzIQWaiw6ZWs
         Ojcetxn3C/iXgYMRRRcmCWaop+2FF4MsvrNuT8uomVcIjnJMRaol3+AJ2Jzz76EAPofi
         r0Gue8LjVYiRezqj4SmHKl2G2hnERlFiK/SLnkYLjDfysZHSnPJP0SCv93MoiLtOwvF0
         BmZP0H1+DLiTdcHuLwth+BLFqcGC528emwyOvGEs0WlawaRpbUrn1gL91xBnwL1khXMK
         aduQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DKaKbTbuLkT8QA7TX3bqJ/+bB1UfilX9I+k59JX1WOY=;
        b=WfzTtWVtOhh3kYOhnX1hCrN/gniZV1PxSjX3LM+CjTNpSSCIZYqXBPl04oBQk10rAx
         gxRXXf4dh57XDAMsqFPCm4hCibtRiP/0Qg9NLniXCKgOC47zaEPtxfgCEGOIOT1Wt2lp
         qxie1mSOdjxCOSS2buMwJaggB1yXHeU6QNe6QxXymB4SEdC2B/ad6izD+vdJ1NDtt18A
         CNTe1RETXVRzhDsaW/j1Zbvsiu4wuUVhY35bDgSrNTzLsWxO8Prck9ONuTDdXA5Q3b5X
         MsHrjp/Dn/BM7aOEsoky3tmbwlkHng6LmD9gY5WRQhwx1MNnnwywYTMJ7RTz8oPea+s4
         IO2w==
X-Gm-Message-State: AOAM533FkRml0LkKuJ6xJQx03nCDQRrh8Mu/YrxpJafnkJuf5RYZrdHD
        HUMf86m89rFOCWEOaW4cfQQPoWqxUXzpwcRJs9VT6TRKbqM=
X-Google-Smtp-Source: ABdhPJzpIh8nW3Mq6F6/iNcsorY3dxQgCuJhGkdwgAtH3+o4IOYL8oaqnigcx8YFpbNslZq7D9RyDmumNH40baHgKA4=
X-Received: by 2002:a05:6e02:8a8:: with SMTP id a8mr6597115ilt.52.1594930821327;
 Thu, 16 Jul 2020 13:20:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAKkbJ-yB4XGuexzmwfkR8g76HR8iCkXaHsXaLaS6V+Wfy86bvg@mail.gmail.com>
 <CAFpOueQm5MhbrV53=kAcw=ES2LzsZPkmX2SqTVKuYTf0QDt=7w@mail.gmail.com>
In-Reply-To: <CAFpOueQm5MhbrV53=kAcw=ES2LzsZPkmX2SqTVKuYTf0QDt=7w@mail.gmail.com>
From:   Michel Macena Oliveira <michel@austral-dynamics.com>
Date:   Thu, 16 Jul 2020 17:20:10 -0300
Message-ID: <CAKkbJ-wDsGO+ZHKZFkPfUL113ONc=NNNeShQkLf+ZH82iaBTEQ@mail.gmail.com>
Subject: Re: Serial port driver usage and status
To:     Itai Handler <itai.handler@gmail.com>
Cc:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Thanks for the answer,
Yes I wrote a code that works with  /dev/tty* serial using termios.h.
I thought exactly what you suggested, to use a dedicated thread, but
how to properly implement it?
I mean in a simple way, just need to put open and write calls inside
the high priority (RT) thread?

Current kernel: 4.4.208-rt198 #1 SMP PREEMPT RT

Em qui., 16 de jul. de 2020 =C3=A0s 16:26, Itai Handler
<itai.handler@gmail.com> escreveu:
>
> Hi Michel,
>
> On 7/16/20, Michel Macena Oliveira <michel@austral-dynamics.com> wrote:
> > Hi, sorry for my newbie question,
> > What is the status of the serial port driver?
> > I've written some code to use serial ports  for the generic kernel linu=
x,
> > And now I want to write something similar for the real time kernel, do
> > I have to use some specific library, flags or something or is it just
> > the same settings?
> >
> > I'm asking because now I need to take into account the serial access
> > in the scheduler to ensure a real time behavior .
> >
> > Any help, advice, hint or tips would be appreciated.
> >
>
> Do you mean that you wrote some code that works with a /dev/tty* serial p=
ort?
>
> In some kernel versions (e.g 4.19) we saw high latencies in the rx
> path of serial drivers.
> I think that this is due to rx handled in the context of a workqueue
> which also handles other system activities.
> We found a workaround to this problem. If I remember correctly we
> create a dedicated thread for the port and assign it a high priority.
>
> Itai Handler
