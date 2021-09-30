Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06751C433F5
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Sep 2021 13:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC73161555
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Sep 2021 13:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350855AbhI3NTP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 30 Sep 2021 09:19:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28993 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350848AbhI3NTO (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 30 Sep 2021 09:19:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633007851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nksoUTb9HNJfooe8yi3vZmBprxmLuSi5ma59gHTFWdI=;
        b=cwDPnf7tWKV4IGhaZDABDMkpXkwUwcchVGcz5lD2MbVtPW5e0wBQ1N+AHqphl7wcVmd/y9
        A6yg8gNdBC91yLfyERXvhmxRdC/LsTVHPtRGodaAMdUo4wTV3Jl2yIRErWPXyktnAbRZsD
        ubar9Wc//CUUTN4PnjH3/OI1s/Jd3Vc=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-AsQPEB1QMyC-_KXSGzJxOQ-1; Thu, 30 Sep 2021 09:17:27 -0400
X-MC-Unique: AsQPEB1QMyC-_KXSGzJxOQ-1
Received: by mail-lf1-f71.google.com with SMTP id e9-20020ac25469000000b003fcfe6c574fso5545898lfn.23
        for <linux-rt-users@vger.kernel.org>; Thu, 30 Sep 2021 06:17:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nksoUTb9HNJfooe8yi3vZmBprxmLuSi5ma59gHTFWdI=;
        b=jHDxRd4KjDtLse358zFloYcLWzZOJLgUVbc/Npqs4gTBPooJkkUDfHJExYuK0iLM2G
         tf6Stua77CiwH61oabXoEBGCALleEvNnh4Xy+ny1SFfshI6A2H92e7kCkKSN/ccB0VUx
         SZK4ZtS5F5CTAmw4yztebKw/4bVwELWY32TkF1gyU0Gc5MJzQ865Rp/5saNBM8twPeU2
         pWiGSAhn6WQaEQSA0w/1RJ71Dg09nelISEMUOFx+Gam6ztxW53RMms32gjw5n1MIb7TP
         095CU8/YFJfcSr/N53Nhw8KcBXkMcMqOICTnkj/YDEXZmQUYyndXIWjYbKC+Id9RSDiH
         M3CQ==
X-Gm-Message-State: AOAM533XmdzPUEZbcHL5/7R26nImQLHjoVngvRa6JnN1n/IjiM7oIScp
        TFZNIVZLPtkaVzzI6X8pd08mcrZcURltl0JVs2BCwr8+V05EAEq9aoi++w0bzzSSz/SZdby3vm8
        lBnFlQR/PXV6bC7pM0dNGOXzQIaE7VQCGZr0gQDQnmeg=
X-Received: by 2002:a19:5e0d:: with SMTP id s13mr5873339lfb.174.1633007845779;
        Thu, 30 Sep 2021 06:17:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyei9zEsNTHRvuxGu3DiJMPFk4zu9gftTelAccDHX+jurDGAgCuZ/XAmYEWBHycl/E3aF9lfkbIg4CeuD1l/QA=
X-Received: by 2002:a19:5e0d:: with SMTP id s13mr5873321lfb.174.1633007845571;
 Thu, 30 Sep 2021 06:17:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAFc1U0sgMtKvcpTWkyjwXsq3Md_Huew7mSye_AratkM63D6K-Q@mail.gmail.com>
 <87y27e53a2.fsf@stealth> <CAFc1U0ufOcT14+JpU60Xoe4D_oJoADwwWszPypT6Y=CLDX39dg@mail.gmail.com>
In-Reply-To: <CAFc1U0ufOcT14+JpU60Xoe4D_oJoADwwWszPypT6Y=CLDX39dg@mail.gmail.com>
From:   Luis Goncalves <lgoncalv@redhat.com>
Date:   Thu, 30 Sep 2021 10:17:12 -0300
Message-ID: <CAD8J--9SeyC7MsmNsNWvXgy9KX1i3hFB4MtCVXcAGK43y3Qp-w@mail.gmail.com>
Subject: Re: Strange problem with PREEMPT_RT
To:     Pierre FICHEUX <pierre.ficheux@smile.fr>
Cc:     Punit Agrawal <punitagrawal@gmail.com>,
        Linux RT Users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Sep 30, 2021 at 5:22 AM Pierre FICHEUX <pierre.ficheux@smile.fr> wr=
ote:
>
> Hi,
>
> Thx a lot for your help (I suspected such a thing).
>
> I can see CONFIG_CPU_IDLE=3Dy in the config but as it's an old kernel
> (3.10) there is no entry such as
> /sys/devices/system/cpu/cpu?/cpuidle/state?/disable
>
> Will take a look further.

You probably have tuned installed in your system. If so, you could run:

    tuned-adm profile realtime

That should set most of the required and suggested configurations, includin=
g
the ones Punit wisely mentioned.

Best regards,
Luis

>
> regards
>
> Le jeu. 30 sept. 2021 =C3=A0 02:13, Punit Agrawal <punitagrawal@gmail.com=
> a =C3=A9crit :
> >
> > Pierre FICHEUX <pierre.ficheux@smile.fr> writes:
> >
> > > Hi,
> > >
> > > I have a strange problem on a PREEMPT_RT system.
> > >
> > > I have a process with 2 threads,
> > >
> > > - 1 TR thread (10 ms period) which places 350 KB blocks in a fifo (1
> > > block every 10 ms).
> > > - 1 non-TR thread (SCHED_OTHER) which reads the block in the fifo and
> > > writes it to the disk
> > >
> > > If I run this on a powerful machine (HP Z4-i9, 14 cores, NVME disk,
> > > CentOS 7 with 3.10 PREEMPT_RT kernel, yes that's ooold), the max
> > > jitter WITH hackbench remains around 20 to 30 =C2=B5s while the max j=
itter
> > > WITHOUT hackbench goes up to 350 =C2=B5s!
> > >
> > > -> hackbench -p -g 20 -l 10000000
> > >
> > > Running the program with  taskset 01 doesn't change anything
> > > If I don't write the data to disk it doesn't change anything either.
> > >
> > > The important jitters appear rather at the beginning (but sometimes a=
lso later).
> > >
> > > Any ideas ?
> >
> > Is power management (cpuidle, cpufreq) enabled on the system?
> >
> > One possible explanation -
> >
> > The load from the 10ms task, isn't high enough to keep the system at
> > high-frequencies or prevent it from going into deeper sleep states. Bot=
h
> > of these can impact latencies.
> >
> > With hackbench, the system is sufficiently busy to avoid the going into
> > idle.
> >
> > >
> > >
> > > thanks by advance
> > >
> > > --
> > > Pierre
>
>
>
> --
>
> Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
>                              http://www.smile.fr
>                              https://smile.eu/fr/offres/embarque-iot
> I would love to change the world, but they won't give me the source code
>

