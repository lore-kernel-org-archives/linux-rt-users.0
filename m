Return-Path: <SRS0=hjoW=WL=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADA2C3A589
	for <linux-rt-users@archiver.kernel.org>; Thu, 15 Aug 2019 15:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D20982133F
	for <linux-rt-users@archiver.kernel.org>; Thu, 15 Aug 2019 15:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRSyrxGY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732521AbfHOPMu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 15 Aug 2019 11:12:50 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36403 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732517AbfHOPMu (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 15 Aug 2019 11:12:50 -0400
Received: by mail-wr1-f66.google.com with SMTP id r3so2540051wrt.3
        for <linux-rt-users@vger.kernel.org>; Thu, 15 Aug 2019 08:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HE3JYg7tWPptBlzQNzHDgAoR/sWzoYd82rt7PMxR9uk=;
        b=FRSyrxGYUufbel4xaFKwUicLZCuosE39YQ4UXGm8J/Ca6EzgPfeUzzC65xHPR3eenR
         9MrZbUR9y3Ag9ruDUtBvUnUM4iry4Ld+YNYL7k6m3iiXsYYPj7tZHJkyK46cx+0czMWi
         kM5qnI53zGkU1HQP+B7YPt6CCZu/9sraTAM+pXE2G9l+Yf1gTPfXScN4PKRzVbpbPcoj
         nNJJp+ndMQN0J6kB7B4EifBer/0V52/iDf8I3JCsoGMVTGvMg2AEizEiuLEK3XiFZSCz
         HA1h8gHXxo14Wlpj9xeVD6oxY/ygL8vm4n9c6bI9VZM3gE+chSsix/G4Oare1z7K/Fgk
         0JEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HE3JYg7tWPptBlzQNzHDgAoR/sWzoYd82rt7PMxR9uk=;
        b=jkfysOCaOWRk9Hd/u6oPSVp/ioxmIc8kSZRsIfe2tHaxfsGDBHRoS/Q7PpwF2Q6Dvh
         hJdjQch+PChhj122kUmo11ucKpkE3RQxXkSvpUoFX2gs55kqVLLVUWwrQ1CjrwkIEERC
         1FE0ISUZCK0eBeJAWx/QoD5uheO4M+yaYpCpv+L/24mZPdRrCiEGWvGFDfs1EfeZ3r+y
         k6xKyCbqXkQ0QFNaUpYXnLxaYNBdxnuU+rcbXV2dskwhgmqCEXoJJgzrGSGNEpmZr8J9
         Pc89522MMW2wUnrJG55ufnIv/xln6Bh8LbHI4pDaLTYSJusOr06YzRuwZ7hNClg6bCGT
         zNZA==
X-Gm-Message-State: APjAAAX4DGLDlT3TEbVFSFI0ODpXmpxTj0x9iqrd5JorSoJenaXfhEuW
        4kbPYvUs3PIxEFDLx6CSYNi1h/vY7bpLc7onfeQ=
X-Google-Smtp-Source: APXvYqwXGEWes5qOVjKFH8wMVSUlfui5HPgCUA4noTu7VZpZXS+nMbUDMC31oe2U8MeHIRQXYvtoL2Yd9O7hUsZ7NCI=
X-Received: by 2002:a5d:5701:: with SMTP id a1mr6032182wrv.95.1565881967951;
 Thu, 15 Aug 2019 08:12:47 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1907171220400.1767@nanos.tec.linutronix.de>
 <CAD56B7eomeb5Lr2juFWtZmtqSx3SkPijW03QZz8xv39He26PrA@mail.gmail.com>
 <20190813095306.xqgq3uusdpj7dhy7@linutronix.de> <CAD56B7fqosJAhiCLikhcxv_3wY7ETOv++kmQcr-=9NKEGq7Agw@mail.gmail.com>
 <20190814112656.z3de2rgbqzpaquz5@linutronix.de> <CAD56B7ezpaONhXCddu6RTE33-iXG7+J=xf417xu_uT-YKPV6RQ@mail.gmail.com>
 <20190815082955.olo3phbqj6disk3q@linutronix.de> <87a7ca4nh6.fsf@linutronix.de>
 <20190815134248.abwbufgwh4zybj4g@linutronix.de> <CAD56B7eFQfvq6cWnT6um4M2Y7LAr5tz0=PvpeWM=QfwAU6pFyA@mail.gmail.com>
 <20190815141923.yu6obojglb2hjsia@linutronix.de>
In-Reply-To: <20190815141923.yu6obojglb2hjsia@linutronix.de>
From:   Paul Thomas <pthomas8589@gmail.com>
Date:   Thu, 15 Aug 2019 11:12:35 -0400
Message-ID: <CAD56B7d-nCs9am2Dh6LkawjL66V6Hmvw6XuCrzrfqU86csrFoQ@mail.gmail.com>
Subject: Re: poor cyclictest results with 5.0 series rt for arm64
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        dunc.mcphie@gmail.com, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

> so it seems to works but I *think* that at 610.156813 shouldn't be there
> and it should switch to cyclictest. But if it is the broken irq-exit
> path then this should fix it:
>
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 63c6960262861..27a16c2711981 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -649,13 +649,7 @@ alternative_if ARM64_HAS_IRQ_PRIO_MASKING
>  alternative_else_nop_endif
>
>         cbz     x24, 1f                                 // (need_resched + count) == 0
> -       cbnz    w24, 2f                                 // count != 0
> -
> -       ldr     w24, [tsk, #TSK_TI_PREEMPT_LAZY]        // get preempt lazy count
> -       cbnz    w24, 2f                                 // preempt lazy count != 0
> -
> -       ldr     x0, [tsk, #TSK_TI_FLAGS]                // get flags
> -       tbz     x0, #TIF_NEED_RESCHED_LAZY, 2f          // needs rescheduling?
> +       b       2f                                      // count != 0
>  1:
>         bl      preempt_schedule_irq            // irq en/disable is done inside
>  2:
This doesn't look like it's against 5.2.y-rt or 5.0.y-rt? I don't see
a (need_resched + count) == 0 line?

-Paul
