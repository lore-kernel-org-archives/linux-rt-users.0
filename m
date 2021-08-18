Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DB5C4320A
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Aug 2021 23:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F5D3610FA
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Aug 2021 23:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235230AbhHRXvQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 18 Aug 2021 19:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235064AbhHRXvQ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 18 Aug 2021 19:51:16 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31873C0613CF
        for <linux-rt-users@vger.kernel.org>; Wed, 18 Aug 2021 16:50:40 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id q11so6057915wrr.9
        for <linux-rt-users@vger.kernel.org>; Wed, 18 Aug 2021 16:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rtst-co-kr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aXGFpAohtr7Jx3FLUO9XNw93R4ybsxQzzRSO0NrNsL4=;
        b=RzwBkqL4Aaa9c0o6we2TKa77sYbMlzvqogc5hl+NMNqb+soLI8krvfRNCn82il6TeC
         QLvch9gAdb6IGFNXY2uie54SPaJg86aHiUPpZdm/mKzofSugkNxJdY3M0+XDRTOXRp+R
         NRVDx7UwvUHRLevAkbZwyhvMhxmKi0vyIHTO+Z0vkPdgX0Qt5qMF29RIV4GWhxolzWBG
         k1cZD/OsaEzuclkRm3lE8deno2Jxj9jH/nkWhv8O3rUGbeI+uYVnyEeZF5iBru8eK8UT
         j/z2FXtcEGK+KcLzoR9ZvnKqMfkEXHep1mdCZXYWd6W1lCMvgdXwUkr641Dv+Z++qmt7
         PB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aXGFpAohtr7Jx3FLUO9XNw93R4ybsxQzzRSO0NrNsL4=;
        b=j8/9qCkHEzJv1rhGZ6xnLJp9FUuTE6doG1dIMHcUMEUB+/y3cVJDoI11pcIeJxcMjU
         o8gSBsKBr45fkB/UnsdJx2NaS1Tfzx4240242ae3uWkwVlS7ni3Wo9fPU3EYA4PrJPLi
         1gdNM25tXHdwMehO65dQy5Kj2X4f9Oz2pQNtk+UzgWHc09HJECHZFMMYzOfOr6PYM5+T
         eJq+NuEASK0Ux7xwzkmd6YViBGGkUaeDk7Gn/Kkwh+CuF3GUt0tYadHgQ9Te9Mju4aex
         E1jztSA6XJTIYq3fdh1/yzbzxXbP8S1yu2wzSgzDzsY3n9GnXrozaiCFcxc5aGcrlQjq
         +/UA==
X-Gm-Message-State: AOAM531wUP1Ojy5FGvOchmdWPlsSRYKx0igBnlKga52MnBjTyN7NRdZe
        aIG276pK4uFwz0GmGH505BfBgqzk2jCV4tpMzwbf7w==
X-Google-Smtp-Source: ABdhPJzFi1PkfY/p1GvMB2zywZafXUhpSEBjWSAFeziGlmfo1nhcaTaz+BcDj0ASEwb09pJgixMGWbnRCjt9Rmw/0rY=
X-Received: by 2002:adf:9d92:: with SMTP id p18mr78529wre.20.1629330638667;
 Wed, 18 Aug 2021 16:50:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210817095313.GA671484@ubuntu> <20210818161752.vu6abfv3e6bfqz23@linutronix.de>
In-Reply-To: <20210818161752.vu6abfv3e6bfqz23@linutronix.de>
From:   Jeaho Hwang <jhhwang@rtst.co.kr>
Date:   Thu, 19 Aug 2021 08:50:27 +0900
Message-ID: <CAJk_X9h_GqUyir7oG33pFrLgknj7DZfd6esiKb07w7QWjZqX0g@mail.gmail.com>
Subject: Re: [PATCH v2] usb: chipidea: local_irq_save/restore added for hw_ep_prime
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org, Linux team <team-linux@rtst.co.kr>,
        =?UTF-8?B?67OA66y06rSRKEJ5ZW9uIE1vbyBLd2FuZykv7J6Q64+Z7ZmU7JewKUF1dG9tYXRpb24gUGxhdGZvcm0=?=
         =?UTF-8?B?7Jew6rWs7YyA?= <mkbyeon@lselectric.co.kr>,
        =?UTF-8?B?7LWc6riw7ZmNKENob2kgS2kgSG9uZykv7J6Q64+Z7ZmU7JewKUF1dG9tYXRpb24gUGxhdGZvcm3sl7A=?=
         =?UTF-8?B?6rWs7YyA?= <khchoib@lselectric.co.kr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

2021=EB=85=84 8=EC=9B=94 19=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 1:17, S=
ebastian Andrzej Siewior
<bigeasy@linutronix.de>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 2021-08-17 18:53:13 [+0900], Jeaho Hwang wrote:
> > hw_ep_prime sometimes fails if irq occurs while it rus on RT kernel.
>
> How/ why does it fail? Which IRQ occurs? Does it also occur without RT
> and with threadirqs enabled?
>

We experienced priming failure while trying cable connection to a
Windows RNDIS host.
And we found that a twd interrupt occurs during execution of
hw_ep_prime for failure cases.
According to the manual, checking ENDPTSETUPSTAT before/after priming
should be done immediately since the host could send a setup packet
which makes the priming invalidated. So we think that the twd (or any)
interrupt could make a timing issue between udc_irq and the RNDIS
host.
Without RT, udc_irq runs as a forced threaded irq handler, so it runs
without any interruption or preemption. NO similar case is found on
non-RT.

> > local_irq_save/restore is added inside the function to gurantee atomici=
ty.
> > only effective for preempt_rt since hw_ep_prime is called inside top ha=
lf
> > or spin_lock_irqsave. No effect is expected for standard linux.
>
> How is that helping?
> #1
>   udc_irq() -> isr_tr_complete_handler() -> isr_tr_complete_low ->
>    _hardware_dequeue() -> reprime_dtd() -> hw_ep_prime()
>
> udc_irq() acquires ci->lock.
>
> #2
>   ep_queue -> _ep_queue() ->_hardware_enqueue() -> hw_ep_prime()
>
> ep_queue acquires hwep->lock. Which is actually ci->lock.
>
> So if I read this right then hw_ep_prime() may not be interrupted in the
> middle of its operation (but preempted) because each path is protected
> by the lock.
>
> isr_tr_complete_low() drops hwep->lock and acquires it again so it that
> phase another thread may acquire it.
>
> > Signed-off-by: Jeaho Hwang <jhhwang@rtst.co.kr>
> >
> > diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
> > index 8834ca613721..a624eddb3e22 100644
> > --- a/drivers/usb/chipidea/udc.c
> > +++ b/drivers/usb/chipidea/udc.c
> > @@ -191,22 +191,31 @@ static int hw_ep_get_halt(struct ci_hdrc *ci, int=
 num, int dir)
> >  static int hw_ep_prime(struct ci_hdrc *ci, int num, int dir, int is_ct=
rl)
> >  {
> >       int n =3D hw_ep_bit(num, dir);
> > +     unsigned long flags;
> > +     int ret =3D 0;
> >
> >       /* Synchronize before ep prime */
> >       wmb();
> >
> > -     if (is_ctrl && dir =3D=3D RX && hw_read(ci, OP_ENDPTSETUPSTAT, BI=
T(num)))
> > +     /* irq affects this routine so irq should be disabled on RT.
> > +      * on standard kernel, irq is already disabled by callers.
>
> The important part is _how_ it is affected. If locking works then
> nothing should read/ write the HW register. If the lock is briefly
> dropped then another thread _may_ read/ write the registers but not
> within this function.
>
> If this function here is sensitive to timing (say the cpu_relax() loop
> gets interrupt for 1ms) then it has to be documented as such.

The controller sets ENDPTSETUPSTAT register if the host sent a setup packet=
.
yes it is a timing problem. I will document that and resubmit again if
you agree that local_irq_save could help from the timing problem.

Thanks for the advice.

>
> > +      */
> > +     local_irq_save(flags);
> > +     if (is_ctrl && dir =3D=3D RX && hw_read(ci, OP_ENDPTSETUPSTAT, BI=
T(num))) {
> > +             local_irq_restore(flags);
> >               return -EAGAIN;
> > +     }
> >
> >       hw_write(ci, OP_ENDPTPRIME, ~0, BIT(n));
> >
> >       while (hw_read(ci, OP_ENDPTPRIME, BIT(n)))
> >               cpu_relax();
> >       if (is_ctrl && dir =3D=3D RX && hw_read(ci, OP_ENDPTSETUPSTAT, BI=
T(num)))
> > -             return -EAGAIN;
> > +             ret =3D -EAGAIN;
> >
> > +     local_irq_restore(flags);
> >       /* status shoult be tested according with manual but it doesn't w=
ork */
> > -     return 0;
> > +     return ret;
> >  }
> >
> >  /**
>
> Sebastian



--=20
=ED=99=A9=EC=9E=AC=ED=98=B8, Jay Hwang, linux team manager of RTst
010-7242-1593
