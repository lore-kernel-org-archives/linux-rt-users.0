Return-Path: <SRS0=vtwn=A3=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C847AC433E1
	for <linux-rt-users@archiver.kernel.org>; Thu, 16 Jul 2020 20:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DEEC20787
	for <linux-rt-users@archiver.kernel.org>; Thu, 16 Jul 2020 20:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bvi+5exY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgGPUkw (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 16 Jul 2020 16:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgGPUkv (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 16 Jul 2020 16:40:51 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982D4C061755
        for <linux-rt-users@vger.kernel.org>; Thu, 16 Jul 2020 13:40:51 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id ga4so8006088ejb.11
        for <linux-rt-users@vger.kernel.org>; Thu, 16 Jul 2020 13:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YttRkf/Cv3W7Q/XwTsI5H1pjr6Lne0gcaju5wXePcR8=;
        b=Bvi+5exYTgnozEwI6JeJGLR4vCwFln30yDa9AfghiF8oACV68iUH6Er0FAxMj4qiDg
         DSpXaaPNW9OXxfTmCV7JU2NFEr3ofGDK6bygX+U6pT/jd5HhMjjJ+zcnVAWHEJ3RBOZV
         QS/HNvKCsyGcXbShkx1+M4fxVagzW1a5vf5JG3UxBAvhZ1MIunyffUcAzjuQMIda5832
         UxWwqxJKmbY2EAYeNE1WWkUMmioSJ25QRKK0zMGCh+Bez3XLotWNSVRHj4oGStk2Djv/
         z0EnQZYF6PJ2RlPJiducFpHqW3m7mixV5tMmmBk2uCb/JqrfimrUK7Fmxx+sP65zKljn
         QVVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YttRkf/Cv3W7Q/XwTsI5H1pjr6Lne0gcaju5wXePcR8=;
        b=pXrRrpt08fhQUKROkjmWLky0AZN9OwE3a3TkodSCQeVm7EHVrq3znkSxK0ontz9oLR
         pl+iOs60SlxM98GkIT2hmFtPalF36zthF0iVfSFABnlH+dNtFnBm9f/efiHAgTzYxBDy
         lpyl0aT6nr2uFdNiyE4+oIQhl/w8H88ZFo6rWOCYBB8gO8bKqOjNaj8NnFOzLS87BZKx
         0e4VEpIJIDPdHhXPPIFuL+rNgZDLE/hQVXmQJFUhz3l5mHc5GrMOyG+8MowprKW6ntgH
         Bg6pAQ/8W4m9C7TZkLo2b2sBgTI7laMfoNStRLmTpxVRRxclFgDkFWd4Ao0yu3cId7bc
         nZyA==
X-Gm-Message-State: AOAM532IWC7PhNOEXptdyEJ79uAi3ARkOy7liHxLuIqlFPv9HZm7ujQ+
        jKriQylzP4XJJu1x6M3vJnS2/g5EzFDvqkrsPoo=
X-Google-Smtp-Source: ABdhPJyOzFUMf2bxGT6sRrTe2Yhjz/XPFCp66Z03u8zvBLXEZLmDQ7/Xa9Ucn8MruAjENKqhs50RGcT30w4fCeuLdbM=
X-Received: by 2002:a17:906:1d5b:: with SMTP id o27mr5780733ejh.367.1594932050219;
 Thu, 16 Jul 2020 13:40:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAKkbJ-yB4XGuexzmwfkR8g76HR8iCkXaHsXaLaS6V+Wfy86bvg@mail.gmail.com>
 <CAFpOueQm5MhbrV53=kAcw=ES2LzsZPkmX2SqTVKuYTf0QDt=7w@mail.gmail.com> <CAKkbJ-wDsGO+ZHKZFkPfUL113ONc=NNNeShQkLf+ZH82iaBTEQ@mail.gmail.com>
In-Reply-To: <CAKkbJ-wDsGO+ZHKZFkPfUL113ONc=NNNeShQkLf+ZH82iaBTEQ@mail.gmail.com>
From:   Austin Schuh <austin.linux@gmail.com>
Date:   Thu, 16 Jul 2020 13:40:39 -0700
Message-ID: <CABsbf=E9D_NvXHZ5z1aLFN4Jcg+s+ADVFZVJi=jkpPOknTN7cA@mail.gmail.com>
Subject: Re: Serial port driver usage and status
To:     Michel Macena Oliveira <michel@austral-dynamics.com>
Cc:     Itai Handler <itai.handler@gmail.com>,
        linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Jul 16, 2020 at 1:21 PM Michel Macena Oliveira
<michel@austral-dynamics.com> wrote:
>
> Em qui., 16 de jul. de 2020 =C3=A0s 16:26, Itai Handler
> <itai.handler@gmail.com> escreveu:
> >
> > Hi Michel,
> >
> > On 7/16/20, Michel Macena Oliveira <michel@austral-dynamics.com> wrote:
> > > Hi, sorry for my newbie question,
> > > What is the status of the serial port driver?
> > > I've written some code to use serial ports  for the generic kernel li=
nux,
> > > And now I want to write something similar for the real time kernel, d=
o
> > > I have to use some specific library, flags or something or is it just
> > > the same settings?
> > >
> > > I'm asking because now I need to take into account the serial access
> > > in the scheduler to ensure a real time behavior .
> > >
> > > Any help, advice, hint or tips would be appreciated.
> > >
> >
> > Do you mean that you wrote some code that works with a /dev/tty* serial=
 port?
> >
> > In some kernel versions (e.g 4.19) we saw high latencies in the rx
> > path of serial drivers.
> > I think that this is due to rx handled in the context of a workqueue
> > which also handles other system activities.
> > We found a workaround to this problem. If I remember correctly we
> > create a dedicated thread for the port and assign it a high priority.
> >
> > Itai Handler
>
> Thanks for the answer,
> Yes I wrote a code that works with  /dev/tty* serial using termios.h.
> I thought exactly what you suggested, to use a dedicated thread, but
> how to properly implement it?
> I mean in a simple way, just need to put open and write calls inside
> the high priority (RT) thread?
>
> Current kernel: 4.4.208-rt198 #1 SMP PREEMPT RT

Itai is talking about the kernel work to handle the serial data, not
the userspace work.  We found the same thing, that the work goes
through a work queue in the kernel, which adds unbounded latency.

https://www.spinics.net/lists/linux-serial/msg07341.html looks
relevant and matches my memory of what we did to solve this.  There's
either a flag in userspace or patch to apply to the kernel (and then a
flag) to skip the work queue.

Austin
