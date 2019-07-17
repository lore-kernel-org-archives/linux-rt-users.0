Return-Path: <SRS0=uaKE=VO=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C22C7618F
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Jul 2019 22:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF49F208C0
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Jul 2019 22:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpPvbPh3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbfGQW3F (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 17 Jul 2019 18:29:05 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:36521 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbfGQW3F (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 17 Jul 2019 18:29:05 -0400
Received: by mail-wm1-f45.google.com with SMTP id g67so19530930wme.1
        for <linux-rt-users@vger.kernel.org>; Wed, 17 Jul 2019 15:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=de9+v3xnL5wbBXqX93C2jnJCO4G5iK3dItsqUWPN7Ks=;
        b=TpPvbPh3iguqHrMOzjk6nWepmyqVsrQXe4HIDSwD6HCTg/QMET8KKWGxjU+pT9qTy7
         usnE1RxQhDlI9aSrNTD7kaS0lQTZcyyhBHZIqazgIjLEaM/KCzQ9S1Jgo4hIH89nt81W
         Ry+ZqUvF/oIJ1OKTqswS95xPW0PB0yoO4BASUAeNSqKz3DCGpFVgdkY0qORM2/IffpmW
         8+2ECbctUJK4vb82mLDJgNoFiAQ7MT/ISodU9Sqtgn6kp94hTo0PnIUwut7QYsz9+gkp
         B73qhNoOeTAgoIXRqq2Ycglp3SjvtSXlR/cfvCvAoBvd3+kUNR89SeGi6nMrGF1qR2KN
         RHgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=de9+v3xnL5wbBXqX93C2jnJCO4G5iK3dItsqUWPN7Ks=;
        b=ZOS2iBr0S3jRUYIs6iMF3hsKS2HIZM+zMON4BR+LObgm1UNt0lZg7wvjHNHmBiQIAp
         jwcIGeNKwc9PDkmazfQaLRimEHGA6Bk0SZesgkwuRJvIybEflSLoS7Fp964ydi8+EpZF
         FvR9quZ5Wr7nUwd/1DqqGasAoeCdziAAK8otdG0wnkMMtOTframm9y1dmckUvH2R+AUC
         +hBW+V7tKJybWrx52ybC50bWkIoHjFgZE+sGuW7p5oBfhUZMChcwSdZq8cWWZtPQxH4E
         gMRTqghAoJ1NuJLVlSawg8cWNL+sxk5aKCqa/T8PK/gruW7f4ULt83FDXeRqWWWMl7Nx
         simg==
X-Gm-Message-State: APjAAAX0PD2XEifen/CC0MrPHPdQEvrPkc//hhinFg0c3uwbwJIfPQ+M
        7EXDHdTjU7YsBV52cZrm6m9RzVbQ7jxhLssC0w4=
X-Google-Smtp-Source: APXvYqxAng2wQ14xlyV94PznP2LZUy7CIICpMcG8i7CyEs6bkKjLfsjqUa+GcEZfxkNkoZXdCfh62Hv13nXCVDIidtE=
X-Received: by 2002:a7b:c74a:: with SMTP id w10mr36372569wmk.99.1563402543195;
 Wed, 17 Jul 2019 15:29:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAD56B7fdr5w0Pk5WHVWXa1ORyM=i+Ew66O+8buBwH0geeX+X0Q@mail.gmail.com>
 <alpine.DEB.2.21.1907162221350.1767@nanos.tec.linutronix.de>
 <CAD56B7eF_KhWvg=m6iy5YSJF-81v-zcmX7+8Kd0wGMrALHwU1A@mail.gmail.com>
 <alpine.DEB.2.21.1907170111160.1767@nanos.tec.linutronix.de>
 <CAD56B7eswTRxbeA8foXyVVZ7Bd+_y40dtOLkHxuAf4kVge7VDg@mail.gmail.com>
 <alpine.DEB.2.21.1907171001150.1767@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907171009280.1767@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907171101150.1767@nanos.tec.linutronix.de> <alpine.DEB.2.21.1907171220400.1767@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1907171220400.1767@nanos.tec.linutronix.de>
From:   Paul Thomas <pthomas8589@gmail.com>
Date:   Wed, 17 Jul 2019 18:28:51 -0400
Message-ID: <CAD56B7eomeb5Lr2juFWtZmtqSx3SkPijW03QZz8xv39He26PrA@mail.gmail.com>
Subject: Re: poor cyclictest results with 5.0 series rt for arm64
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        dunc.mcphie@gmail.com, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Jul 17, 2019 at 6:21 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Wed, 17 Jul 2019, Thomas Gleixner wrote:
> > On Wed, 17 Jul 2019, Thomas Gleixner wrote:
> >
> > The one below should fix it for real.
>
> That still has an issue which needs deeper investigation. Just keep the
> offending patch reverted for now.

OK, sounds good.

-Paul
