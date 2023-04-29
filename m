Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B2FC77B61
	for <linux-rt-users@archiver.kernel.org>; Sat, 29 Apr 2023 01:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjD2BAx (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 28 Apr 2023 21:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjD2BAw (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 28 Apr 2023 21:00:52 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D200A1FDC
        for <linux-rt-users@vger.kernel.org>; Fri, 28 Apr 2023 18:00:49 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-94f6c285d22so80337366b.2
        for <linux-rt-users@vger.kernel.org>; Fri, 28 Apr 2023 18:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vmn-com-au.20221208.gappssmtp.com; s=20221208; t=1682730048; x=1685322048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rOnBh4d7baMiS6bryiNLQNtl+4UKgHje/t4KnbCrhvY=;
        b=fnF5DjlTLQH/+7rNrNek5mLPPZcLFZgmURQsDRz6qxHUV5fglhr2VHDU5Xv5D2qz6k
         gjb1fM/WTuyXVizkUlC+yAzoI0lry73Gd4804KBELxIBCsZnwa2P6tNr0Dkh97mA1e2c
         F+w3JQjfSo9ZUiWUMW0IXRbAZ1FKncGn+lCRuzShr9pHXqdT5cr2KddDN4DzXGQvt2pg
         vtVqMrOULmpZHVbQQ6PAhXKsfqjLBoyKmr417ca3WfKS/QKQ9zep6qqbfOXxCdpeouq/
         rNLkB42jGQTXL2WeQd3h4Z59J/jFBcjLlwkk7cn0vgOmBK93UEWzoyyTpBibowwIH5fW
         tmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682730048; x=1685322048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rOnBh4d7baMiS6bryiNLQNtl+4UKgHje/t4KnbCrhvY=;
        b=HgfCigXgmRIt3vskVLymp3n5ofqDKdLcTN3gdM+8ipQkWdFo9iNjlMcfiar3xpBHgG
         dwJBlhBY1C/HIu7LMmkjCxqXkYOGmgDdt+KaQ4AEwCJUsW3ejF4iUQz24QoW4wJE6kBJ
         rRFI26QVV3WLEtl97dy2s+HGK6sazzLQY1k0l1Mbu1LH+o4JajbIwo8B2x9rNmMUhGSv
         XxLL+IEVXEKXTWq7/tArFAF3vHUVBqdI/QbAsMR9L4vljVHcL3lf/RqN2Fnnhttm8xN3
         4+W2IYZRcoUCxtuCXc8Zzv4ZZWLmZomK5pDBbqaqoOB18F3Ah/IrzBXVuVDby54TJQLQ
         ZfLw==
X-Gm-Message-State: AC+VfDxSXV+dMEoRQWZoa42F+XZFCB69OaV83tijW3hHuN6PI62v14cS
        /qwCftGXA1eXzYa7e4NvY/9bQm1wDMF7pXGmuzKv4fF475LrukmzMMo=
X-Google-Smtp-Source: ACHHUZ5keaunMEyH3v2Ez+jIXpi5/Gjf+3l5lCA0hiCL+8d7bg857RRTPofJ6CeUk2DYgKn3DP5m9EKHsPepTeRgNlg=
X-Received: by 2002:a17:907:1ca8:b0:94a:9f9a:b3c4 with SMTP id
 nb40-20020a1709071ca800b0094a9f9ab3c4mr6762704ejc.49.1682730048193; Fri, 28
 Apr 2023 18:00:48 -0700 (PDT)
MIME-Version: 1.0
References: <CANV1gkc9KvkGNPkEsjXCiV4mUcdrrPcaQ1ueRri9ypjvJbU94g@mail.gmail.com>
 <20230428085123.HX02J4Ym@linutronix.de> <CANV1gkcr4jBUY-iH-iJJPdrVMp+1Nq1YrNPONferMC1AutJgkg@mail.gmail.com>
 <20230428131236.9MfVxN3s@linutronix.de> <CANV1gkdZWRu=g1yLBOC_=Y37H=9FEOHRCdAOBhf5j3+3T4_=qg@mail.gmail.com>
In-Reply-To: <CANV1gkdZWRu=g1yLBOC_=Y37H=9FEOHRCdAOBhf5j3+3T4_=qg@mail.gmail.com>
From:   Rod Webster <rod@vmn.com.au>
Date:   Sat, 29 Apr 2023 11:00:36 +1000
Message-ID: <CANV1gkctmK1x37tM4wQ1Xjg-ZjKGrFFAsc-Cau0gW9O0N+XCCA@mail.gmail.com>
Subject: Re: Excessive network latency when using Realtek R8168/R8111 et al NIC
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

I've had some feedback from a hardware supplier.
The Linuxcnc RT ethernet driver has a pin that reports ethernet packet
error count.
This increments when the ethernet response exceeds our real time servo
thread period (typically 1 ms)
We should be able to monitor this pin and stop the trace if it is >  0
without too much effort.
So let me know the next steps and I'll try and implement a trace test.

- Rod



Rod Webster

VMN=C2=AE

www.vmn.com.au

Ph: 1300 896 832

Mob: +61 435 765 611




On Sat, 29 Apr 2023 at 07:37, Rod Webster <rod@vmn.com.au> wrote:
>
> > Okay. Then it could be related to softirq rework which started in
> > v5.0.19-rt11 and updated in v5.9-rc6-rt9.
> v5.9 could also be significant as the R8125 driver support was added
> in that version
> I upgraded from Debian Buster to Bullseye (v5.10) on one PC for this reas=
on.
>
> > Are you able to recompile a kernel?
> Yes,
> I have attached a text file containing my 6.3 build steps.
> Note we had to git pull the kernel source as it was not available via
> http at that time
> I have not tried with your 6.3-rc11 patch yet.
>
> > However as per you Debian bug report v4.19-RT is fine, v5.10-RT isn't
> > and v6.1-RT is better or is it fine?
> I built v6.1-rc7-rt5 before Debian advanced to v6.1
> It was reported to be an improvement and it solved the Debian latency
> issue for some users.
> v6.3 was reported as being as good as the 4.x kernes by our hardware vend=
or
>
> > Where is the Intel ethernet coming from? You were saying it is the
> > realtek nic.
> Sorry, you mentioned coalesce but that's an Intel feature and does not
> exist with Realtek.
>
> > Is the vendor driver better than in the tree? This is not obvious from
> > what you are writing.
> I have been unable to compile the R8168 driver from source on the
> Realtek website.
> They are behind with supported kernels and the build process is
> invariably broken for me.
> On the Hardkernel Odroid forum, it has been reported that compilng the
> R8125 from Realtek source offers 15-35% improvement over the in-tree
> driver.
>  I have one of their  PC's (H2+). It's currently running v5.10 and the
> in-tree R8168 driver (which must be the Debian default).
>  It is affected and I plan to upgrade to v6.3 with the R8125-dkms driver
>
> > Two things you could do:
> > - enabling tracing to see what is causing the delays/ latency spike. Yo=
u
> >   will need a trigger to notice the latency and then stop the trace at
> >   this point. If so, I could provide additional steps unless you can do
> >   it yourself.
> Please advise additional steps to do this.
> We might  be able to modify our hardware device driver to stop the
> trace as it reports latency incursions if they occur.
>
> > - You could try to isolate the realtek driver on one CPU and moving
> >   everything else to another.
> This sounds interesting. Please advise how.
> On a 4 core machine we typically add isolcpus=3D2,3 for best RT performan=
ce.
>
> Thanks for your support.
>
> -end
> -Rod Webster
