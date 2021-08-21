Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D111C432BE
	for <linux-rt-users@archiver.kernel.org>; Sat, 21 Aug 2021 07:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B31F611CC
	for <linux-rt-users@archiver.kernel.org>; Sat, 21 Aug 2021 07:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbhHUHEy (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 21 Aug 2021 03:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbhHUHEx (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 21 Aug 2021 03:04:53 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1582BC061756
        for <linux-rt-users@vger.kernel.org>; Sat, 21 Aug 2021 00:04:14 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id x12so17350865wrr.11
        for <linux-rt-users@vger.kernel.org>; Sat, 21 Aug 2021 00:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rtst-co-kr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WgM87f7rpLd/jbOLyf9WZP12/bowR6IrwwDEu2GtuV8=;
        b=Pv336bT6BS8zVUAFL8pWU1CGoQdBEw/yAxLORZT8Cj/Ba0BPBttWUz+vdEQINtnec5
         q2RFdHep9cG1R6MfS7RuAsBAUf71QOvvsylwQVXcszxZWZLGdJfao5uT5J80KXdOtlu9
         SHtyBk5SWC/eZGBBjo+tV85udJiqv5I8QHTKOfnvsQMkqX7SlRtnfYau5O4uzOrkvo+l
         rMFJR4MAD1C3+4bzI0SoUQ3gTZd6u6nch6F4B+kxdf2ImkNJD5dIfgb1PX9TFJTZz2vf
         KbzOGeFnG9Mwqm9PfoEJXDhVxDOelhrZAmwoosSLEOPzfXQGSu5fxkL7R5sg5qkiGjhx
         WiHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WgM87f7rpLd/jbOLyf9WZP12/bowR6IrwwDEu2GtuV8=;
        b=F5JeVk2ssR/EBk3vRWg3uHynR+Ss9JnKbvM6OgMmTAzPQ3SKF+Th0p4MpAmWXjszxF
         3nYgAgMRiXsESS5WlWBL8+fqk50dEyhLeaZn5InFyB9cVpsjAzTIF7FZ17RaqWScNDZ1
         ftmTTvI4WTXf5AX7zX41QBd8YscDiZIvNhCPVv6chW1DzwSyhz9R3E090TGq2tehTIPk
         HfmiVRO/b0ieviSgECGuyDVx3CkNxx1/dAppUASkHGDV7/B/GO/4esfxB2buAwjg5Xim
         XtHRdoT+bL9/x6rzsYsF+IWTqOUVPmmRPrV1cBLgFqQH8afuw81aPAy4d82c7LVAaj1w
         tcrg==
X-Gm-Message-State: AOAM532MYINS++GUiKVv/8LPo/fuvETpWOtN/oDI1IRAl3IJEI1en1n9
        gpCdA6dAh9w/q9j9Hz/LxUxuYAZDbsnybWl6ZEWvuA==
X-Google-Smtp-Source: ABdhPJxcQ/ExlMzakQLKVKtgk8fM+2HQQTzsMvU9f1V4BSUasYqP11DQmXznbj5+lLlT6kQekSR6zYmUaeHXoLJb/44=
X-Received: by 2002:adf:e7d1:: with SMTP id e17mr2450792wrn.151.1629529452393;
 Sat, 21 Aug 2021 00:04:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210817095313.GA671484@ubuntu> <20210818161752.vu6abfv3e6bfqz23@linutronix.de>
 <CAJk_X9h_GqUyir7oG33pFrLgknj7DZfd6esiKb07w7QWjZqX0g@mail.gmail.com>
 <20210819084759.stnmit32vs2be46m@linutronix.de> <CAJk_X9gyWch6Z1=hbe2vvqGu61mdavAU62+6dSka0tZoMzxu5Q@mail.gmail.com>
 <20210821050511.GA14810@Peter>
In-Reply-To: <20210821050511.GA14810@Peter>
From:   Jeaho Hwang <jhhwang@rtst.co.kr>
Date:   Sat, 21 Aug 2021 16:04:01 +0900
Message-ID: <CAJk_X9gqBACA3O=4LdY3XJP5UzJe2p4bE72X_jNEHR1Cn=vDNQ@mail.gmail.com>
Subject: Re: [PATCH v2] usb: chipidea: local_irq_save/restore added for hw_ep_prime
To:     Peter Chen <peter.chen@kernel.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
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

2021=EB=85=84 8=EC=9B=94 21=EC=9D=BC (=ED=86=A0) =EC=98=A4=ED=9B=84 2:05, P=
eter Chen <peter.chen@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 21-08-20 14:15:55, Jeaho Hwang wrote:
> > 2021=EB=85=84 8=EC=9B=94 19=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 5:4=
8, Sebastian Andrzej Siewior
> > <bigeasy@linutronix.de>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> > >
> > > On 2021-08-19 08:50:27 [+0900], Jeaho Hwang wrote:
> > > > Without RT, udc_irq runs as a forced threaded irq handler, so it ru=
ns
> > > > without any interruption or preemption. NO similar case is found on
> > > > non-RT.
> > >
> > > I see only a devm_request_irq() so no force-threading here. Booting w=
ith
> > > threadirqs would not lead to the problem since commit
> > >    81e2073c175b8 ("genirq: Disable interrupts for force threaded hand=
lers")
> > >
> >
> > I was wrong. udc threaded irq handler allows twd interrupt even on
> > non-RT and with threaded irq.
> > I believed Chen's comment "The function hw_ep_prime is only called at
> > udc_irq which is registered as top-half irq handlers. Why the timer
> > interrupt is occurred when hw_ep_prime is executing?".
>
> Hi Jeaho,
>
> How could you let udc irq as threaded irq? The chipidea interrupt
> is registered using devm_request_irq.
>

HI Peter.

We configured the kernel as "low latency desktop" and added
"threadirqs" inside the cmdline parameter.
Then udc irq handler runs as a thread and shows no suspicious working.
I Hope It will help.

Thanks.

> > We have additional experiments and got the results like below. RNDIS
> > host was Windows.
> >
> > RT, 1ms delay between first ENDPTSETUPSTAT read and priming : error
> > case occurred
> > RT, 1ms delay + irq_save : no error case occurred.
> > non-RT, threaded irq, 1ms delay : no error case occurred even twd
> > fires inside the function execution.
>
> Again, how do you observe it?
>
> Peter
>
> >
> > It doesn't seem to be a timing issue. But irq definitely affects
> > priming on the RT kernel. Do you RT experts have any idea about the
> > causes?
> > If isr_tr_complete_handler fails ep priming it calls _ep_set_halt and
> > goes an infinite loop in hw_ep_set_halt. It was an actual problem we
> > experienced.
> > So we protect irqs inside hw_ep_priming not to make error cases and
> > also add a timeout inside the hw_ep_set_halt loop for a walkaround.
> > The timeout patch is submitted to linux-usb.
> > ( https://marc.info/?l=3Dlinux-usb&m=3D162918269024007&w=3D2 )
> >
> > We withdrew this patch since we don't know if disabling irq is the
> > best solution to solve the problem and udc would work fine with
> > hw_ep_set_halt walkaround even though hw_ep_prime fails.
> > But we are still trying to find out the cause of this symptom so We'd
> > so appreciate it if RT or USB experts share some ideas or ways to
> > report somewhere. Xilinx doesn't provide any support without their
> > official kernel :(
> >
> > Thanks for the discussion Sebastian.
> >
> > Jeaho Hwang.
> >
> > > =E2=80=A6
> > > > > If this function here is sensitive to timing (say the cpu_relax()=
 loop
> > > > > gets interrupt for 1ms) then it has to be documented as such.
> > > >
> > > > The controller sets ENDPTSETUPSTAT register if the host sent a setu=
p packet.
> > > > yes it is a timing problem. I will document that and resubmit again=
 if
> > > > you agree that local_irq_save could help from the timing problem.
> > > >
> > > > Thanks for the advice.
> > >
> > > If it is really a timing issue in the function as you describe below
> > > then disabling interrupts would help and it is indeed an RT only issu=
e.
> > >
> > > So you read OP_ENDPTSETUPSTAT, it is 0, all good.
> > > You write OP_ENDPTPRIME, wait for it to be cleared.
> > > Then you read OP_ENDPTSETUPSTAT again and if it is 0, all good.
> > >
> > > And the TWD interrupt could delay say the second read would read 1 an=
d
> > > it is invalidated. Which looks odd.
> > > However, it is "okay" if the TWD interrupt happens after the second
> > > read? Even if the host sends a setup packet, nothing breaks?
> > > Do you have numbers on how long irq-off section is here? It seems to
> > > depend on how long the HW needs to clear the OP_ENDPTPRIME bits.
> > >
> > > Sebastian
> >
> >
> >
> > --
> > =ED=99=A9=EC=9E=AC=ED=98=B8, Jay Hwang, linux team manager of RTst
> > 010-7242-1593
>
> --
>
> Thanks,
> Peter Chen
>


--=20
=ED=99=A9=EC=9E=AC=ED=98=B8, Jay Hwang, linux team manager of RTst
