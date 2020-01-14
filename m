Return-Path: <SRS0=TWee=3D=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44781C33C9E
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Jan 2020 21:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14EED24656
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Jan 2020 21:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9FnNtLv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbgANV0Q (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 14 Jan 2020 16:26:16 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33827 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgANV0Q (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 14 Jan 2020 16:26:16 -0500
Received: by mail-lj1-f193.google.com with SMTP id z22so16100346ljg.1
        for <linux-rt-users@vger.kernel.org>; Tue, 14 Jan 2020 13:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YAuVAGz3/KLRrfprHZAo0CTOF7UNAZunNMyBIqPfgbk=;
        b=H9FnNtLvvodOJ6DxmhLzR/f/9OaZXwDxieI1Q2udLSyAqV5E99qX6VsbsKugl0SBzE
         uPlzVvMCB5UpTS6C81tPBHUfY4LY+wUCF8kHhNoVtTqlTUB44DEzmgh4Nj8vdhxacJOL
         K3sRyqsI+eQUeiAAhWF9H5eF5Xtclyab7UOSzJoJSPVuey8MctkVZbB8dE3MNx6O+wp4
         h63f4LyaBc3fr58+1eBz20vZYXK04FqpyXs2hctaZcbaG2KkdT1eHCXHuVraHE+A4K+f
         vgsxhVkGThUacyDwe4c5NQwDMwl3zzKlNkbl2tkizqPvxPqb50R4zXDn0MGSsdroMmlc
         r0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YAuVAGz3/KLRrfprHZAo0CTOF7UNAZunNMyBIqPfgbk=;
        b=uGfutrm3T8XfElTupjBELBD+gdmWJ+bn4iiHgioro3u+9pKOG91lj09jT5ADi1d6MN
         y1KoSMMVcJ0F/uW/2ThcgyhgzCXun3Zz+twG3eoEYHipDKsV1FCDSOW+NijTbGmnZjDy
         A56Vjz7aDGPFeI40+M3JlRndgJLkC/47+iLgC5SBmU8WTyWFz+6Y0j8LKNMQEbcvJ2H0
         r0P/u47pCHM57kWjGtvblloYCFFsqcrenEDy6URLy32kvR8MC9TOG/qkmb8f+cE4qGni
         U9yU/qqFqHUma7N0GMHHV8HksijTjPbiyEP4W+zNGDIbkodNSLBRFq/IUNPGwlyxxFks
         C2/Q==
X-Gm-Message-State: APjAAAWea7snIV6r8+aGeDpq1QrwvZBHel+5UKFwJTRlW6xladywHOoy
        SC2XMFyIqXRaenwNlWPIWjntOlmm9paOHbKLQk8=
X-Google-Smtp-Source: APXvYqyaZVx65Z6iGXcLhJHLRlRhAUiYbAyLMFWVHEtYb7fZLVwl0++wWea2rN+aGpN11PdMpsMwRyGO6vvmqMdcZVE=
X-Received: by 2002:a2e:87ca:: with SMTP id v10mr15878257ljj.253.1579037173813;
 Tue, 14 Jan 2020 13:26:13 -0800 (PST)
MIME-Version: 1.0
References: <20200110201430.vl3sxiwntj5o4z74@linutronix.de>
 <202001141123.29884.gheskett@shentel.net> <CAD56B7dJiZmHHe8AEabXhVq+ugChHgDPqo4YToJr0iycL090jA@mail.gmail.com>
 <202001141603.42585.gheskett@shentel.net>
In-Reply-To: <202001141603.42585.gheskett@shentel.net>
From:   Paul Thomas <pthomas8589@gmail.com>
Date:   Tue, 14 Jan 2020 16:26:02 -0500
Message-ID: <CAD56B7dVBuvrpVCz8ZCvc6GuY=W8rhg=Dmny1+j2ffrdz2SX4w@mail.gmail.com>
Subject: Re: [ANNOUNCE] v5.4.10-rt5
To:     Gene Heskett <gheskett@shentel.net>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Jan 14, 2020 at 4:04 PM Gene Heskett <gheskett@shentel.net> wrote:
>
> On Tuesday 14 January 2020 12:15:37 Paul Thomas wrote:
>
> > On Tue, Jan 14, 2020 at 11:24 AM Gene Heskett <gheskett@shentel.net>
> wrote:
> > > On Tuesday 14 January 2020 08:54:30 Paul Thomas wrote:
> > > > On Sun, Jan 12, 2020 at 9:44 PM Gene Heskett
> > > > <gheskett@shentel.net>
> > >
> > > wrote:
> > > > > On Friday 10 January 2020 15:14:30 Sebastian Andrzej Siewior
> wrote:
> > > > > > Dear RT folks!
> > > > > >
> > > > > > I'm pleased to announce the v5.4.10-rt5 patch set.
> > > > > >
> > > > > > Changes since v5.4.10-rt4:
> > > > > >
> > > > > >   - Dick Hollenbeck reported that the printk rework had a
> > > > > > negative impact on the 8250 driver if not used as a console.
> > > > > > Patch by John Ogness.
> > > > > >
> > > > > > Known issues
> > > > > >      - None
> > > > > >
> > > > > > The delta patch against v5.4.10-rt4 is appended below and can
> > > > > > be found here:
> > > > > >
> > > > > >
> > > > > > https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.4/incr/p
> > > > > >atch -5.4 .10-rt4-rt5.patch.xz
> > > > > >
> > > > > > You can get this release via the git tree at:
> > > > > >
> > > > > >
> > > > > > git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-deve
> > > > > >l.gi t v5.4.10-rt5
> > > > >
> > > > > I grabbed a copy of this, then turned off anything not needed to
> > > > > run LinuxCNC on an rpi4 in armhf config.  Then I noted its make
> > > > > had a make deb-pkg option.  But it isn't making what I told it
> > > > > to make as I'm sitting here watching it ALL go by. Did I miss
> > > > > something in  a make menuconfig that triggered a make all? It
> > > > > was supposedly set for armhf. But I'm even seeing x86 stuff go
> > > > > by. Obviously I know just enough to screw it up. Point me at the
> > > > > right docs for arm builds please.
> > > > >
> > > > > Hi Gene,
> > > >
> > > > I recently stumbled into deb-pkg, and it's awesome building up the
> > > > source and standard debian packages all in one command, but it
> > > > takes the same arguments as a standard make. For rpi4 this is
> > > > arm64 not armhf so you probably want something like below to
> > > > configure for arm64
> > >
> > > armhf (32 bit) runs fine in on an RPI4, been doing it for a couple
> > > months now. With a 32 bit stack frame, context switch latencies are
> > > several microseconds better which linuxcnc loves. However with mesa
> > > interface cards handling all the sub-millisecond stuffs and using
> > > preempt-rt running in userspace, it all works quite well as the  max
> > > latency stays below 200 microseconds 99.99% of the time. Thats well
> > > within the servo-thread time of 1 millisecond the mesa cards need.
> >
> > Ah, makes sense.
> >
> > > > If you are doing this on the rpi4 you don't need the
> > > > CROSS_COMPILE= option.[1][2] make -j4 ARCH=arm64
> > > > CROSS_COMPILE=aarch64-elf- defconfig
> > > > Or if the kernel you're already running has a /proc/config.gz you
> > > > can use that directly (zcat /proc/config.gz > .config).
> > > > Then you can use the main make.
> > >
> > > The kernel I an running was built, by me (queue the raspberry
> > > noises), with only the ondemand governer so while its working, its
> > > stuck in low gear. And the pi has plenty of cooling.
> > >
> > > that kernel running now is a 4.19.71-rt24-v7l+ #1 SMP PREEMPT RT,
> > > but there has since been added another video speedup option, so ATM
> > > I am trying to build a 4.19.94-rt38 announced last week. But the git
> > > clone I pulled doesn't have the rt patch. And pulling that patch
> > > with curl today fails:
> > >
> > > pi@rpi4:/media/pi/workspace $ curl
> > > http://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.9
> > >4-rt38.patch.xz
> >
> > Hmm, this seems fine for me:
> >  wget
> > https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.19.94.tar.xz
> > tar xf linux-4.19.94.tar.xz
> > cd linux-4.19.94/
> >  wget
> > http://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.94-
> >rt38.patch.xz
> > unxz patch-4.19.94-rt38.patch.xz
> > patch -p1 < patch-4.19.94-rt38.patch
> I blew away my git clone and followed this, which all worked to here,
> but:
> >  make ARCH=armhf defconfig
Sorry that was a cut/paste typo, there is no arch/armhf just arm, so you want
make ARCH=arm defconfig
I had tried the command that's why it was in my history and thus the
copy/paste mistake. I believe how this works is the kernel just has
CONFIG_AEABI=y as the ABI config, then userspace compilers have to
decide if they want to compile for a hardware floating point or not,
and what debian has decided is that they would have a special
architecture just for hardfloat:
https://wiki.debian.org/ArmHardFloatPort

thanks,
Paul
