Return-Path: <SRS0=TWee=3D=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,WEIRD_PORT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C282FC33C9E
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Jan 2020 17:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89FED24656
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Jan 2020 17:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WX2wfvHN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgANRPx (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 14 Jan 2020 12:15:53 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42708 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgANRPw (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 14 Jan 2020 12:15:52 -0500
Received: by mail-lf1-f68.google.com with SMTP id y19so10419415lfl.9
        for <linux-rt-users@vger.kernel.org>; Tue, 14 Jan 2020 09:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VOIdniaZZ5s1TG7Znl9QFsbhDTSAj6K/c7hAWL3svpI=;
        b=WX2wfvHNX1dWPqPSusZxV0YjAurTWrmnzLokmFQvJ8QidIaLVk4abo/DxSKOBJvxJK
         o81/+HcaNPtHte6ZpXlR3N4R/UlYGwLnrZmu407di1oZFzw+WuJQcAetNcwCHSjN2EVy
         31hLrJsCA2uMYmdi2a5x0sBV5AN2+ydlDpfGEEcYf3XPO1890B7XUw+3os0T0d9b12F4
         DV7TdcGKHzD4aM7v3rzEHjfLeaXsQZB2yF5Dp7yciLuUjMjjb8dzD8DzvaHW95+I/XpJ
         +HmQnAxddRaG9v81AM0/wHSqE2GR3uyX8SFbD6LqjOdfs5BT147epzKIgMbLKrweW/d2
         6/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VOIdniaZZ5s1TG7Znl9QFsbhDTSAj6K/c7hAWL3svpI=;
        b=XoSOTat0TF7f2L2EsNRtssApF5RkjvOixVo0WzksMeKv9tbzRIzhXpBwTKpwzdCQu4
         /0nKDNew3fyENvzzAvxnuInaQtvJiveAMgYnh7y4Y5n2KA4kjS1R5eY9zuoX+u0IMlps
         lKtEmD5dRAKKk1dzpdtQZNbW+/Ja0v6uv/D5jmm+IMjrH1CW3KXF+cPf/CWrytqkgzqF
         /cGKJgHxIj451r957vCGTAc5ALC8toPgYgZ8stATncOpowGlDCbQ1WZFZs3devAe2G2C
         fy11K4FTJYk/cO8E1NfE2LrXf39ixn81fc2OBVhVOV9hKzwdcO2rcms6BJZ2Ht9gFmrV
         PLPA==
X-Gm-Message-State: APjAAAUYldZn4VCqp/Iaauf0v5xL8mmsH81ApZOpZ5NFDOLGkQqqcdYu
        UJfbR90O4dqnIYtHPcaa1MY+Y/cSeXxywo+MTgM=
X-Google-Smtp-Source: APXvYqwf0abLxvfoJ+rthvXVdW7s4ZRU79d42RuFpkl/6Uuly2Pt0nHVauST4dx8kfo4a3NFvuTkDbu1ioVyXSfVdC4=
X-Received: by 2002:a19:e30b:: with SMTP id a11mr2479114lfh.48.1579022149694;
 Tue, 14 Jan 2020 09:15:49 -0800 (PST)
MIME-Version: 1.0
References: <20200110201430.vl3sxiwntj5o4z74@linutronix.de>
 <202001122122.10938.gheskett@shentel.net> <CAD56B7cgPfbcx8MNtYosOwhPi6fy+fqdauLsayR65dAg1yaYSg@mail.gmail.com>
 <202001141123.29884.gheskett@shentel.net>
In-Reply-To: <202001141123.29884.gheskett@shentel.net>
From:   Paul Thomas <pthomas8589@gmail.com>
Date:   Tue, 14 Jan 2020 12:15:37 -0500
Message-ID: <CAD56B7dJiZmHHe8AEabXhVq+ugChHgDPqo4YToJr0iycL090jA@mail.gmail.com>
Subject: Re: [ANNOUNCE] v5.4.10-rt5
To:     Gene Heskett <gheskett@shentel.net>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Jan 14, 2020 at 11:24 AM Gene Heskett <gheskett@shentel.net> wrote:
>
> On Tuesday 14 January 2020 08:54:30 Paul Thomas wrote:
>
> > On Sun, Jan 12, 2020 at 9:44 PM Gene Heskett <gheskett@shentel.net>
> wrote:
> > > On Friday 10 January 2020 15:14:30 Sebastian Andrzej Siewior wrote:
> > > > Dear RT folks!
> > > >
> > > > I'm pleased to announce the v5.4.10-rt5 patch set.
> > > >
> > > > Changes since v5.4.10-rt4:
> > > >
> > > >   - Dick Hollenbeck reported that the printk rework had a negative
> > > >     impact on the 8250 driver if not used as a console. Patch by
> > > > John Ogness.
> > > >
> > > > Known issues
> > > >      - None
> > > >
> > > > The delta patch against v5.4.10-rt4 is appended below and can be
> > > > found here:
> > > >
> > > >
> > > > https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.4/incr/patch
> > > >-5.4 .10-rt4-rt5.patch.xz
> > > >
> > > > You can get this release via the git tree at:
> > > >
> > > >
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.gi
> > > >t v5.4.10-rt5
> > >
> > > I grabbed a copy of this, then turned off anything not needed to run
> > > LinuxCNC on an rpi4 in armhf config.  Then I noted its make had a
> > > make deb-pkg option.  But it isn't making what I told it to make as
> > > I'm sitting here watching it ALL go by. Did I miss something in  a
> > > make menuconfig that triggered a make all? It was supposedly set for
> > > armhf. But I'm even seeing x86 stuff go by. Obviously I know just
> > > enough to screw it up. Point me at the right docs for arm builds
> > > please.
> > >
> > > Hi Gene,
> >
> > I recently stumbled into deb-pkg, and it's awesome building up the
> > source and standard debian packages all in one command, but it takes
> > the same arguments as a standard make. For rpi4 this is arm64 not
> > armhf so you probably want something like below to configure for
> > arm64
>
> armhf (32 bit) runs fine in on an RPI4, been doing it for a couple months
> now. With a 32 bit stack frame, context switch latencies are several
> microseconds better which linuxcnc loves. However with mesa interface
> cards handling all the sub-millisecond stuffs and using preempt-rt
> running in userspace, it all works quite well as the  max latency stays
> below 200 microseconds 99.99% of the time. Thats well within the
> servo-thread time of 1 millisecond the mesa cards need.
Ah, makes sense.

>
> > If you are doing this on the rpi4 you don't need the
> > CROSS_COMPILE= option.[1][2] make -j4 ARCH=arm64
> > CROSS_COMPILE=aarch64-elf- defconfig
> > Or if the kernel you're already running has a /proc/config.gz you can
> > use that directly (zcat /proc/config.gz > .config).
> > Then you can use the main make.
>
> The kernel I an running was built, by me (queue the raspberry noises),
> with only the ondemand governer so while its working, its stuck in low
> gear. And the pi has plenty of cooling.
>
> that kernel running now is a 4.19.71-rt24-v7l+ #1 SMP PREEMPT RT, but
> there has since been added another video speedup option, so ATM I am
> trying to build a 4.19.94-rt38 announced last week. But the git clone I
> pulled doesn't have the rt patch. And pulling that patch with curl today
> fails:
>
> pi@rpi4:/media/pi/workspace $ curl
> http://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.94-rt38.patch.xz
Hmm, this seems fine for me:
 wget https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.19.94.tar.xz
 tar -xf linux-4.19.94.tar.xz
 cd linux-4.19.94/
 wget http://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.94-rt38.patch.xz
 unxz patch-4.19.94-rt38.patch.xz
 patch -p1 < patch-4.19.94-rt38.patch
 make ARCH=armhf defconfig

-Paul

> <html>
> <head><title>301 Moved Permanently</title></head>
> <body>
> <center><h1>301 Moved Permanently</h1></center>
> <hr><center>nginx</center>
> </body>
> </html>
>
> But firefox pulled it, I've unpacked it, but the usual patch -p1
> <../patches/* syntax fails, ambiguous redirect

>
> Obviously a greenhorn at work, been running a linux only house since '98.
> And the wet ram is 85 yo.
>
> Next? & thank you a bunch
>
> > make -j4 ARCH=arm64 CROSS_COMPILE=aarch64-elf- deb-pkg
> > Keep in mind that even with the debian package this may not be enough
> > to install the kernel for u-boot correctly, You'll have to see if all
> > the scripts in /etc/kernel/postinst.d/ are doing everything that is
> > needed, but it should give you at least a /boot/vmlinuz... When I use
> > this I have to extract the compressed Image to where u-boot grabs the
> > kernel.
> >
> > Hope this helps.
> >
> > thanks,
> > Paul
> >
> I have a recipe that installs to a u-boot already.
>
> Cheers, Gene Heskett
> --
> "There are four boxes to be used in defense of liberty:
>  soap, ballot, jury, and ammo. Please use in that order."
> -Ed Howdershelt (Author)
> If we desire respect for the law, we must first make the law respectable.
>  - Louis D. Brandeis
> Genes Web page <http://geneslinuxbox.net:6309/gene>
