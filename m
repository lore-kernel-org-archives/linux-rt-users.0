Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23687C7EE26
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 May 2023 19:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjESTmj (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 May 2023 15:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjESTmi (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 May 2023 15:42:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E572198
        for <linux-rt-users@vger.kernel.org>; Fri, 19 May 2023 12:42:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13238617DC
        for <linux-rt-users@vger.kernel.org>; Fri, 19 May 2023 19:42:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70838C433EF
        for <linux-rt-users@vger.kernel.org>; Fri, 19 May 2023 19:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684525354;
        bh=gD4ohhbxFP5MCceNJ7/3zrkLalktwpnDuLphGOzua04=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Rj5JYAgtr5/wpjyxrQ3cPJkuxu35FfKxZptUbRc9KDo/onk85R5y0pk4Aa4OWbVw0
         wzFu673z/l7WF57dpe3VPf0f4DO4GjO9xJf1M8Tp5wXiMO746ZEMCPw1V0kd8mRX0Q
         CWfA5S7ZDPxfLjFvq1NnCLnllOwEeL0UHbjOYgY8gHNtai87/ZL1rj6et5+yb3kjtT
         xxWNu/Kl1ogOCVSi0vPHKXO1NRe/YYR1QBawV8aZicZKcfUzkUrhfALZeRn8b19bZT
         yZKgecES3p2byIHl/uKzLbNgXV24AvdNHxAh+I58o5UK53gOy5yL3aSeiKal7ScA31
         X/LkKmJMLu9Gw==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2af177f12a5so25992001fa.2
        for <linux-rt-users@vger.kernel.org>; Fri, 19 May 2023 12:42:34 -0700 (PDT)
X-Gm-Message-State: AC+VfDxqY6yP5V8DTVp0gNjREq35lA1B9/lBWsJPquLQIROyXLf/ftA6
        kQiuBTXYt3we0PSDDKyz9LBmLIAwCj1EriFB6tk=
X-Google-Smtp-Source: ACHHUZ653ZteBNmk4knGuCvy9rbRgI+/s/MSVSXDiiUJF5IfEnhxD20qbho+TJFg6ZZY3gu0YZGVDDFLcD7gmEXluic=
X-Received: by 2002:a2e:92cd:0:b0:2a7:a30e:d11b with SMTP id
 k13-20020a2e92cd000000b002a7a30ed11bmr1299057ljh.7.1684525352473; Fri, 19 May
 2023 12:42:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAMj1kXFVutgNLYWpsM1QvrLBWsoNoSSEAK-oJKGL6bEqrh=nDg@mail.gmail.com>
 <20230519145731.574867-1-bigeasy@linutronix.de> <CAMj1kXFGfmCNJGgCV+St7B--08moBF=QzbH=qELE6XKaKdA0RQ@mail.gmail.com>
 <20230519180616.JZIGG3C7@linutronix.de>
In-Reply-To: <20230519180616.JZIGG3C7@linutronix.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 19 May 2023 21:42:20 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEz6EOvcXyzk4tmifAGumti4XkdNKKgF+60+q=6FWDPAQ@mail.gmail.com>
Message-ID: <CAMj1kXEz6EOvcXyzk4tmifAGumti4XkdNKKgF+60+q=6FWDPAQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] ARM: vfp: Fixes for PREEMP_RT
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Pavel Pisa <pisa@cmp.felk.cvut.cz>, linux-rt-users@vger.kernel.org,
        Pavel Hronek <hronepa1@fel.cvut.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, 19 May 2023 at 20:06, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2023-05-19 18:14:38 [+0200], Ard Biesheuvel wrote:
> > This looks reasonable to me - thanks for taking the time.
> >
> > However, I was about to hit send on my PR to Russell for the following series:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=arm-vfp-softirq-fixes
> >
> > which moves all of the VFP processing to C, and so this is going to
> > conflict at the very least, but also provide a cleaner base for patch
> > #2 in this series.
>
> Okay. PR? Is this still the rmk's patch tracking system or did something
> change? Either way, please let me know once this get through so I can
> rebase accordingly. In the mean I throw this into -RT.
>

As I said, I am about to send it but I haven't yet, and it takes
Russell usually some time to catch up. So this won't be in -next for
another week or two.

> > Also, aren't there a few other places in the VFP code where BH are
> > disabled and enabled again? Do those need the same treatment?
>
> If so I haven't found them. A grep in arch/arm/ for bh_disable() has now
> hit and this is vfp_lock().
>

Apologies, I got myself confused.
