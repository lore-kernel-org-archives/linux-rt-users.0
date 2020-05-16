Return-Path: <SRS0=oDCT=67=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DATE_IN_PAST_06_12,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537E3C433DF
	for <linux-rt-users@archiver.kernel.org>; Sun, 17 May 2020 02:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2496D206F4
	for <linux-rt-users@archiver.kernel.org>; Sun, 17 May 2020 02:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fz7GVc7/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgEQCA0 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 16 May 2020 22:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgEQCA0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 16 May 2020 22:00:26 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3013C061A0C
        for <linux-rt-users@vger.kernel.org>; Sat, 16 May 2020 19:00:25 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id w4so2047829oia.1
        for <linux-rt-users@vger.kernel.org>; Sat, 16 May 2020 19:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9dKpZdLO758qB++EPlsvTVLErds4Qhp2h3CCwo544ho=;
        b=Fz7GVc7/vEqOD2wFa9lWS1/rlFEhaNFyTVIKU1/XyLjUj7qcNgBo46vDireKWlpERa
         7ZbFTaVYT4AExWXapKR5kRBy5hxwmp0WKTXYeSEbrOMqnbWi6ZuEUvqbrZjc7c8hvMHT
         K7dRtdbV0zWZ0PNdXrTbkrBSFMrEenA4LoWZciktx7RJkxkyoLmHGwdpmJqQgqWEztDb
         ACf9WcZoJdnYB0RSUoFcRUSPz/xN/3B3J380l8R2xavuZWz5dI+VCGGqlpoaPydPIDpx
         M62d2B8auXQZyGO+FwF5ayv+KU8zLHLE6D3d2o/NbpOa2PNx+iYJwpSuNvTobMEZY7J1
         g+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9dKpZdLO758qB++EPlsvTVLErds4Qhp2h3CCwo544ho=;
        b=o9giZkz9ZPKx6JNoFziRKmewv/zNwdaSaBRLYBPJ5e9J8EUFZy1U9lZrV9Y4AaiFXm
         jUcS2c3wUoQ2hWelq/mlotB11mIEue7yHVqJpvMuzLzykCngs9o4Lwdbek66lnDFcZWs
         Ug/b5642S/6tCe1KgJy+z32/TFxBFvAqVQ2snTS5Mr31QeWZ8ntlj6LNfzmL1MBExoUM
         6NvzTRE36Qkjav0YOK/+zMPArKlJpg3ToJJBsF1dd5c4DSXL7Yb+hsrmz6H340Ggm3fr
         5EG89609myCo0AUCdmtXsY5Tgsj71fUGKxD6Ntx3iD9FB9Kk+p2BizJzsR/Y9kd7YCv1
         nbzg==
X-Gm-Message-State: AOAM530llWlg8wqXrsOPjJHa9crMfvrT/PcxL5D33vYf72o4zqLvKfe6
        J0EkA4CDP0t1HJzx0evqLtgFTLyWdDu4hT3eWyc=
X-Google-Smtp-Source: ABdhPJwUewYmnX/EmXyOfenAFRGTdglvs8DDxCSVlfuvTpnn+9aYmPcAM5uR+22gQOJluq2hxpOOjJLLd9QGj4SmO3I=
X-Received: by 2002:aca:ef44:: with SMTP id n65mr6147165oih.9.1589680825056;
 Sat, 16 May 2020 19:00:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-npu9MViEKYCNmTnGSAxngWhzevOH=T5rg+t+wVMShKagMCg@mail.gmail.com>
In-Reply-To: <CAN-npu9MViEKYCNmTnGSAxngWhzevOH=T5rg+t+wVMShKagMCg@mail.gmail.com>
From:   chen song <lhcs2008@gmail.com>
Date:   Sun, 17 May 2020 02:00:13 +0800
Message-ID: <CANAMpFTJ0YzXsnG_HEyCU-RiUgJimjPcfh=ZnCVPoNhr1-GPPA@mail.gmail.com>
Subject: Re: About RT patch can run kvm virtual machine?
To:     =?UTF-8?B?5byg5oms?= <andyzheung@gmail.com>
Cc:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

i found the same thing, didn't find any oops info.
5.4.40 + patch seems working fine, try it.

On Sun, May 17, 2020 at 12:36 AM =E5=BC=A0=E6=89=AC <andyzheung@gmail.com> =
wrote:
>
> Hi all:
>       I'm trying to run RT system with kvm on ARM architecture,based
> on the kernel of version 4.19.98. But I found that as soon as I start
> a guest OS(within around 1min), the host get restarted(maybe crashed,
> I'm not quite sure), no useful message found in/var/log/. So, I'm
> wondering whether it supports running KVM with RT patch on ARM?(It
> seems works well on x86)=EF=BC=8Cany suggestion?
>      Thanks!
>      BTW,   the patches  I'm applied are downloaded from:
>      https://mirrors.edge.kernel.org/pub/linux/kernel/v4.x/
>      https://mirrors.edge.kernel.org/pub/linux/kernel/projects/rt/4.19/ol=
der/
>
> yours
> Andy
