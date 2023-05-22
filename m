Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB227C7EE26
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 May 2023 10:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbjEVKG4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 22 May 2023 06:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjEVKGz (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 May 2023 06:06:55 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC89B8E
        for <linux-rt-users@vger.kernel.org>; Mon, 22 May 2023 03:06:53 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-510d8d7f8eeso10465997a12.0
        for <linux-rt-users@vger.kernel.org>; Mon, 22 May 2023 03:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vmn-com-au.20221208.gappssmtp.com; s=20221208; t=1684750012; x=1687342012;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbXuS9rWzrCKv1tySZtviKkIiB2x22D+Mt5UgWiWCV8=;
        b=PTVLhqA4nBBzcrYFwnUX0Z0I4h3y1b20A7h92WduxPvVHPBg4tPJRzk5SmVjVIBDTb
         xJ6mS38/dKhC5+J7AoAUIG+8rurWN5yz202fJlPDn3OAz3H6Yib/Mi4u5mEAKVzFasZf
         Hccn6CvqGN5JJfroPgPElURBUfI7IcaKTy9wyUMnOF4uGDZWK57cX3T1LJHb/jJnkRKK
         fcWe768q7vVDvmhGPte/O3ImZsh9rtygoSCVbFPA6OoghSTWzkFfMIqKXrArCNI3MZck
         tumeGX9JBsk7PqO+tG0UQ2g+9SD1+OyWOtXi1w87HrbTX5oaK8ahVaDSXObjj+mrEoYM
         8FsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684750012; x=1687342012;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zbXuS9rWzrCKv1tySZtviKkIiB2x22D+Mt5UgWiWCV8=;
        b=E5A6zTlXW/bku7Zg+SNv0w6nSRbV5bc9MdmuM4BgoeVX2AOSjQ7KoEZmb0LLVJlYK3
         Snbd/LhXGu6nYx/SgV4nZS7xp9Yd9B+lHIr6Tk20EdSerAtXbbiloLLsodAvDBLqNIgu
         wJKGsRxD1DgII/YpW3hbpfkUp7gdZC3RQ6W9TYjA//NIcDbKBnn/Qz94k7eCSOHhRyX6
         NqDW9FxYimJPhHFImFg8IPlU/PcHbCNcMh9KSpLk4cUdRV/FHLuVRuEh3pxk0u9yyoS4
         V6yLxA9IBEH/ktyW71AJtiwsU1xIvzs1Azh98EldLSTxoEf5f+ViOxdsuwu0TNCYrHRC
         0sEw==
X-Gm-Message-State: AC+VfDyYVj69fLph0LH9xrgXviE78Uic3rB9mG/JvrcYmzZ/L+lKpHcL
        evbJovVEmKSNszHWHXdLKA3sY/pZAktDd71YN8uwaQ==
X-Google-Smtp-Source: ACHHUZ67TkHujB0EUbLjO19j2bsETJ7hepC1NvgEytXUXKuTpsNNf47JbGulezFkH8JI9u/hh1nQZlQCBqlA67/4QCs=
X-Received: by 2002:aa7:d316:0:b0:50b:d30c:c595 with SMTP id
 p22-20020aa7d316000000b0050bd30cc595mr7748125edq.7.1684750011882; Mon, 22 May
 2023 03:06:51 -0700 (PDT)
MIME-Version: 1.0
References: <CANV1gkc9KvkGNPkEsjXCiV4mUcdrrPcaQ1ueRri9ypjvJbU94g@mail.gmail.com>
 <20230428085123.HX02J4Ym@linutronix.de> <CANV1gkcr4jBUY-iH-iJJPdrVMp+1Nq1YrNPONferMC1AutJgkg@mail.gmail.com>
 <20230428131236.9MfVxN3s@linutronix.de> <CANV1gkdZWRu=g1yLBOC_=Y37H=9FEOHRCdAOBhf5j3+3T4_=qg@mail.gmail.com>
 <20230516105950.kSgA5y-v@linutronix.de> <CANV1gkftrZvhUhXV-mJ-mYmsue3ER33cXCNmVD1bGAc6TmTHuA@mail.gmail.com>
 <CANV1gkfsAfDt76=STFrekQA4M6sfVKyq7bujA=Tu+S6k+EGYcg@mail.gmail.com>
 <20230519083745.AB0-5kD9@linutronix.de> <CANV1gkcah59yVOMZ-s_0TMeMEgpwOaDKSWbdL3Y2Y86RQ+UsKA@mail.gmail.com>
 <20230522093208.NtKNYiYn@linutronix.de>
In-Reply-To: <20230522093208.NtKNYiYn@linutronix.de>
From:   Rod Webster <rod@vmn.com.au>
Date:   Mon, 22 May 2023 20:06:39 +1000
Message-ID: <CANV1gkf+m1n3bLdBg3vP3pzSxiQ1Na53TSbUvLrNNqmKVZvgQQ@mail.gmail.com>
Subject: Re: Excessive network latency when using Realtek R8168/R8111 et al NIC
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Yes, I won't be using a DKMS driver and will test with the in-tree driver.
I rolled a PC back to the Debian 6.1 RT kernel and the default in-tree
R8169 driver yesterday with isolcpus=3D2,3.

I had a shot at it last night with the napi thread but was confused by
the trace results so will try again.
I could not see our PacketErrorTest script appearing in the trace but
it stopped the trace when it should.
Also our RT process did not appear to be on an isolated thread which
seemed odd. I did not get as far as setting the affinity for napi.

I've also installed  Bookworm RC3 on another PC with the default RT
kernel on a Gigabyte Brix N3160 with an R8111/R8168 NIC and the
in-tree R8169 driver.
This PC historically had max latency of about 130000 ns  back with
kernel 4.x and now its reporting 23000 ns with the 6.1 kernel over 24
hours testing with the linuxcnc tools. Quite amazing what you guys
have achieved! It will be a few days before I can lug my hardware to
work to test on it as well for another data point.

I really appreciate your willingness to help. This remains a
frustrating issue for many Linuxcnc users who are using my compiled
6.3 kernel to get out of jail.
Bear with me as I bumble my way through!

Rod Webster





Rod Webster

VMN=C2=AE

www.vmn.com.au

Ph: 1300 896 832

Mob: +61 435 765 611




On Mon, 22 May 2023 at 19:32, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2023-05-19 21:41:30 [+1000], Rod Webster wrote:
> > I will do some testing tomorrow now I know what's going on but I
> > wonder how relevant it will be given this turnaround?
>
> I'm not going to look at the dkms/OOT driver. If there is an actual
> problem or something odd with mainline and RT and I will look into it.
> I managed to find an older box which is using the r8169 and I'm going to
> boot and see if there the driver is doing something odd what I didn't
> see earlier=E2=80=A6
>
> Please make sure that you are using the in-tree driver. If you
> experience high latencies then I'm willing to help investigate.
>
> > Rod Webster
>
> Sebastian
