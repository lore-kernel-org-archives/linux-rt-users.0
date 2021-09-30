Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA4BC433EF
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Sep 2021 08:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 155F961528
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Sep 2021 08:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349116AbhI3IXl (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 30 Sep 2021 04:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348945AbhI3IXj (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 30 Sep 2021 04:23:39 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACAF5C06161C
        for <linux-rt-users@vger.kernel.org>; Thu, 30 Sep 2021 01:21:56 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id u18so21930095lfd.12
        for <linux-rt-users@vger.kernel.org>; Thu, 30 Sep 2021 01:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L+n28xbG8TAzO41/vIQ05sRXQWRwE7mJ0crWn3+2aNU=;
        b=mTBPJIIBjdY0HQLT67gwXviUEXrfDBAp3ZykMxhID9NWzMPh/zOJdEUXoWEqh1Yu8h
         GBC6/7GJwku6ZRrJcxuaSCSLjL3vlNJtW9nCouqH5yjNu/VH2cFQKiRmm7IvYPTT9P2H
         Hb5aZ3nMpwPC9uZpIhBhxP9qfVrV4wfB/p37kJp2qSBp9md2Koo3o8NAUr1iYlsMezZq
         ZMJtQ4p/yKMHsb8DulD+H+18Y76gRW/AtXnBtNFV+YSowa8g+Roo20e2mOITswAHGfJW
         a+Xy262iIOM0pORlmpwvFoTwdqHgu7+U1Htndc4inzwD8JaNgU/8eU4kdHPGPEFSrWdG
         hjxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L+n28xbG8TAzO41/vIQ05sRXQWRwE7mJ0crWn3+2aNU=;
        b=lRuju2QlxDBEtynu8jNT0Xoc9YCSiatqx4vbdJ2bLrutWP8311yWyv4/xoP8b2/h5E
         oF7uol87JeySmWOB/w/VnhCe9OWQYZStfdHYl18Y6P1iK2gKbNJnQlRmJ5oq8eh5Aggm
         JblVTSbA9gSpGfqMJ0eQd3BWoVPMsYH20WKTpu4JsNq8Y0QqewkvYawA2TO2zZK1y/8J
         xdMurDLNYl3RKQy2NFmpWQG82UZUKekrytB0oc2TNL9DMRlOdiHhfDQrUNSqmWmnvRo+
         mQ2w/b8WxyzHbRVAbR/cljQu6IEbu4Gn7z5r+WrcBBN1w4MeFgXxutJpUDmAKCufi/40
         js+w==
X-Gm-Message-State: AOAM530ikeb0hj9Vo3Jr4kdTazxgPw0SPkpM6KV6JrS48AJriCCmdRYH
        pw+uZ1Ds69iJxd/NnEF86xmo2nqYmIR6gtknKpAFH8zQtE9lPg==
X-Google-Smtp-Source: ABdhPJyEonhN5i6qHaU8+51BmlJ4ONjYtLIFKoHHolv0dB4N2il4K4SpJc09rE1uh23lmac5GlfJCgoFp9XX8Sumqt8=
X-Received: by 2002:a2e:501a:: with SMTP id e26mr4627092ljb.461.1632990114942;
 Thu, 30 Sep 2021 01:21:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAFc1U0sgMtKvcpTWkyjwXsq3Md_Huew7mSye_AratkM63D6K-Q@mail.gmail.com>
 <87y27e53a2.fsf@stealth>
In-Reply-To: <87y27e53a2.fsf@stealth>
From:   Pierre FICHEUX <pierre.ficheux@smile.fr>
Date:   Thu, 30 Sep 2021 10:21:44 +0200
Message-ID: <CAFc1U0ufOcT14+JpU60Xoe4D_oJoADwwWszPypT6Y=CLDX39dg@mail.gmail.com>
Subject: Re: Strange problem with PREEMPT_RT
To:     Punit Agrawal <punitagrawal@gmail.com>
Cc:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

Thx a lot for your help (I suspected such a thing).

I can see CONFIG_CPU_IDLE=3Dy in the config but as it's an old kernel
(3.10) there is no entry such as
/sys/devices/system/cpu/cpu?/cpuidle/state?/disable

Will take a look further.

regards

Le jeu. 30 sept. 2021 =C3=A0 02:13, Punit Agrawal <punitagrawal@gmail.com> =
a =C3=A9crit :
>
> Pierre FICHEUX <pierre.ficheux@smile.fr> writes:
>
> > Hi,
> >
> > I have a strange problem on a PREEMPT_RT system.
> >
> > I have a process with 2 threads,
> >
> > - 1 TR thread (10 ms period) which places 350 KB blocks in a fifo (1
> > block every 10 ms).
> > - 1 non-TR thread (SCHED_OTHER) which reads the block in the fifo and
> > writes it to the disk
> >
> > If I run this on a powerful machine (HP Z4-i9, 14 cores, NVME disk,
> > CentOS 7 with 3.10 PREEMPT_RT kernel, yes that's ooold), the max
> > jitter WITH hackbench remains around 20 to 30 =C2=B5s while the max jit=
ter
> > WITHOUT hackbench goes up to 350 =C2=B5s!
> >
> > -> hackbench -p -g 20 -l 10000000
> >
> > Running the program with  taskset 01 doesn't change anything
> > If I don't write the data to disk it doesn't change anything either.
> >
> > The important jitters appear rather at the beginning (but sometimes als=
o later).
> >
> > Any ideas ?
>
> Is power management (cpuidle, cpufreq) enabled on the system?
>
> One possible explanation -
>
> The load from the 10ms task, isn't high enough to keep the system at
> high-frequencies or prevent it from going into deeper sleep states. Both
> of these can impact latencies.
>
> With hackbench, the system is sufficiently busy to avoid the going into
> idle.
>
> >
> >
> > thanks by advance
> >
> > --
> > Pierre



--=20

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
