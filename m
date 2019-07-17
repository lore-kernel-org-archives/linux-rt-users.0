Return-Path: <SRS0=uaKE=VO=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F402DC7618F
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Jul 2019 00:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD8742182B
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Jul 2019 00:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sfM/F4Jk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbfGQApI (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 16 Jul 2019 20:45:08 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35798 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbfGQApH (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 16 Jul 2019 20:45:07 -0400
Received: by mail-wr1-f65.google.com with SMTP id y4so22835120wrm.2
        for <linux-rt-users@vger.kernel.org>; Tue, 16 Jul 2019 17:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n0uCJBo++JsrvADGMMRn+NTcY07/65qMGSkIRUa45eQ=;
        b=sfM/F4JkOtYStXJ4492l4nMxSNysB0mhvgdzzCW/0Gjtt9Ysipn7MrMiBqzd6c4ofg
         cGNZcRAGQ9I4P+oe8TJdkbScnVxK29w0pJd5N6XtSjN5jlirLvgmMmRdGcxki4tCgU+J
         yAeTBYD9WuURNXlHVda2bO+9CXkFYTru2tttTEQ/K4xktUOq7kndNgK6KRFpAxLE7+2U
         4xXAm6o3Fz0xIf+wRdBloSJB8X1GbzNOYYpoACzBrp3vhOlThnksd48HRZzWaysyTlB2
         SNClJuKM7WqA2wU/Pxx/jUZAs7BKWBWOTVBiTXl1MtYZ81j3ep55OI/Bl+W9w2lV3tlo
         PSSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n0uCJBo++JsrvADGMMRn+NTcY07/65qMGSkIRUa45eQ=;
        b=ttWio3NjTdN7MQibg1kqLXHw+XvrVV/dzrpmtQ6U/k6X6KDkkYNdZirhIWMc0wCboM
         HXha4D6jEjV1U7r/lbBpjOJ1VKdlvw28LLjefXAVNs9N/FsBNBQBNkIYFFzIaOukTfNN
         eRfCTiX5U+0htD58176pOmxoPC2dNf9IR+4dLUZ0A8a7A4gBDmZW3SdZOkCLxwl8MaA/
         XIX/OcJauk9ZqwCDt5J5Ox/gkazrka60nhpn+SnIwPfR+C1ynHjlHJPRZ3O9tCCpNtlP
         rBN62eR8Q/vAWXJw014ElBbXB2TxOKOtOO9My+ES2b0MTOzBUQVWzQDEQ1sYLiRCDVJn
         pNZQ==
X-Gm-Message-State: APjAAAVcrkeQZiOB4aiOoi0ZlD/NTBROjSQorPfD5v1iLjBGS07IGDvJ
        9EYnpuIuXyxv8s9OXqkIjoLqb9iJG4zj4gQT920=
X-Google-Smtp-Source: APXvYqw0JhD7XByl/d7/fBeM4DgeJZkHwdGbEMbV+kMrKZEsgATdQ7VSxvBPEhnF3vxC2XGUWyKedVGZE2A63wk0dCo=
X-Received: by 2002:a5d:51c7:: with SMTP id n7mr11410083wrv.326.1563324305379;
 Tue, 16 Jul 2019 17:45:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAD56B7fdr5w0Pk5WHVWXa1ORyM=i+Ew66O+8buBwH0geeX+X0Q@mail.gmail.com>
 <alpine.DEB.2.21.1907162221350.1767@nanos.tec.linutronix.de>
 <CAD56B7eF_KhWvg=m6iy5YSJF-81v-zcmX7+8Kd0wGMrALHwU1A@mail.gmail.com> <alpine.DEB.2.21.1907170111160.1767@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1907170111160.1767@nanos.tec.linutronix.de>
From:   Paul Thomas <pthomas8589@gmail.com>
Date:   Tue, 16 Jul 2019 20:44:53 -0400
Message-ID: <CAD56B7eswTRxbeA8foXyVVZ7Bd+_y40dtOLkHxuAf4kVge7VDg@mail.gmail.com>
Subject: Re: poor cyclictest results with 5.0 series rt for arm64
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        dunc.mcphie@gmail.com, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Jul 16, 2019 at 7:14 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Tue, 16 Jul 2019, Paul Thomas wrote:
>
> > > > We do have trace data for a instance where cyclictest hit 5000 uS, but
> > > > the file is large 11MB, and I wasn't sure if I should directly attach
> > > > it to the email. What is the best way to post or send this?
> > >
> > > Can you upload the trace to some place? If you don't have storage, just use
> > > bugzilla.kernel.org and open a bug, attach it and post a reference.
> >
> > Hi Thomas,
> >
> > I've put the last 60k line of the trace on the bug report here:
> > https://bugzilla.kernel.org/show_bug.cgi?id=204189
> >
> > Just looking at the timestamp time of cyclicte-2778 I can see the last
> > two finish_task_switch calls are seperated by 5801 uS. Is just before
> > that the correct place to be looking?
>
> Right. If I'm reading it correctly, I think I know what's wrong. Can you
> please revert:
>
>        80e7f3b05365 ("arch/arm64: Add lazy preempt support")
>
> Either that patch is broken or it got broken on forward porting it from
> 4.19. Need to look with brain awake tomorrow.

Yes! this looks like it fixes it. The hash I see is slightly different:
b7f42e8fb48cbe38e4c2d0cab48309aadfa6d032

But the name was the same "arch/arm64: Add lazy preempt support"

I did a quick run with 5.0.19-rt11 with these results:
root@xu5:/opt/rt-tests# ./cyclictest -S -m -n -p 99 -i 200 -h 400 -D 900
# /dev/cpu_dma_latency set to 0us
policy: fifo: loadavg: 0.64 0.74 0.60 1/131 1931

T: 0 ( 1913) P:99 I:200 C:4499993 Min:      5 Act:    8 Avg:    7 Max:      20
T: 1 ( 1914) P:99 I:200 C:4499899 Min:      5 Act:    8 Avg:    7 Max:      16
T: 2 ( 1915) P:99 I:200 C:4499799 Min:      5 Act:    8 Avg:    7 Max:      17
T: 3 ( 1916) P:99 I:200 C:4499704 Min:      5 Act:    8 Avg:    7 Max:      16

We'll do some more testing tomorrow.

-Paul
