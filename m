Return-Path: <SRS0=TWee=3D=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7417EC33CB1
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Jan 2020 13:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 486C2214AF
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Jan 2020 13:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8KDZqYA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbgANN4u (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 14 Jan 2020 08:56:50 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42853 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbgANN4u (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 14 Jan 2020 08:56:50 -0500
Received: by mail-lj1-f196.google.com with SMTP id y4so14440868ljj.9
        for <linux-rt-users@vger.kernel.org>; Tue, 14 Jan 2020 05:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jpc8VyDQC8kpZkRHZi1wKUKTNY+akzOVfkD6tdj0Kn4=;
        b=f8KDZqYAMh7h8dIviYKX0wmifZbXflc5vkgRsV8X19jM61RP5HzXn89/m4bO92VA/p
         ygD0V7Ktrd6psXSiV4unxD59CpHBtTutqdar8WyEy93q3GJPy26zIoBlRXhgNWZTeqYX
         sZhHpshqkPiMmYE52MC0x/8HW6TR34IvSOzSYEi5gl1pAnkxYBClNwFdnpmSxbwxHR0b
         HGuWaUBmdqAhKiJYmeZXA6gZV1R01vdRcQ15r0WGLCZ5BJx7GN+mE3TEZaEePHSPQjPm
         6kOb+4HKBfftiomGxvPOjJFyA20iCzUQK8L4oR1U1SKpfnw5WUfb6I7HT2WCL/YTBF4D
         JK6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jpc8VyDQC8kpZkRHZi1wKUKTNY+akzOVfkD6tdj0Kn4=;
        b=OkcFaIBS4FWmDLbXEqY5Z8WYjzjEM+YnCYCvzSTuf2q1rRG5Of4SJtEFuDQBPMNKqU
         KRUqlgcPpAAvAa6GdCJtcZ9EqV3eBpT+jGqODgQQvauQxO/K7zg+Qr9+U7bZomnOkwfM
         pYmc4RJODlpjFxp5f9hCih8rimmZ93aKsipD/mmI1Hgs8OvuAh2uV6zuh8T7jEWXe+/i
         qraoL6Q8+oZw7R/ROTGi3WDQITRVEpqTAWnUWILoj0ZgxXOgjEMmnt6OLH5OZ92ikCYp
         GHO1jGEKCowdh0Nsp13ckOvepTDMFKJlRUaj8uIM1N3i/A7Lwkq4E6fkrcs/l63gOBgj
         grxg==
X-Gm-Message-State: APjAAAVQzQv6hc2p2KiqhKJIHZIhL8ilyc+rEeSI9M/U0SbKSNvkKooV
        iJVwkZt6EpVC8PcMTAgDHlxn2+pljUa+U9qtjss=
X-Google-Smtp-Source: APXvYqw3QuC9FtmGWVM8eox5p6f9ZbVduGArd3p+B/1GAXQtvFTAJqgz3G9qEa4Kq8lzk5yqiUqKFwPz3riB2bYemlw=
X-Received: by 2002:a2e:9691:: with SMTP id q17mr14256441lji.91.1579010208529;
 Tue, 14 Jan 2020 05:56:48 -0800 (PST)
MIME-Version: 1.0
References: <20200110201430.vl3sxiwntj5o4z74@linutronix.de> <202001122122.10938.gheskett@shentel.net>
In-Reply-To: <202001122122.10938.gheskett@shentel.net>
From:   Paul Thomas <pthomas8589@gmail.com>
Date:   Tue, 14 Jan 2020 08:56:37 -0500
Message-ID: <CAD56B7ddZSWqo1jz6W72FUu+u_ZJuM-b_CSuRRTaSzhQPJnHAA@mail.gmail.com>
Subject: Re: [ANNOUNCE] v5.4.10-rt5
To:     Gene Heskett <gheskett@shentel.net>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Sun, Jan 12, 2020 at 9:44 PM Gene Heskett <gheskett@shentel.net> wrote:
>
> On Friday 10 January 2020 15:14:30 Sebastian Andrzej Siewior wrote:
>
> > Dear RT folks!
> >
> > I'm pleased to announce the v5.4.10-rt5 patch set.
> >
> > Changes since v5.4.10-rt4:
> >
> >   - Dick Hollenbeck reported that the printk rework had a negative
> >     impact on the 8250 driver if not used as a console. Patch by John
> >     Ogness.
> >
> > Known issues
> >      - None
> >
> > The delta patch against v5.4.10-rt4 is appended below and can be found
> > here:
> >
> >
> > https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.4/incr/patch-5.4
> >.10-rt4-rt5.patch.xz
> >
> > You can get this release via the git tree at:
> >
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git
> > v5.4.10-rt5
>
> I grabbed a copy of this, then turned off anything not needed to run
> LinuxCNC on an rpi4 in armhf config.  Then I noted its make had a make
> deb-pkg option.  But it isn't making what I told it to make as I'm
> sitting here watching it ALL go by. Did I miss something in  a make
> menuconfig that triggered a make all? It was supposedly set for armhf.
> But I'm even seeing x86 stuff go by. Obviously I know just enough to
> screw it up. Point me at the right docs for arm builds please.

Hi Gene,

I recently stumbled into deb-pkg, and it's awesome building up the
source and standard debian packages all in one command, but it takes
the same arguments as a standard make. For rpi4 this is arm64 not
armhf so you probably want something like below to configure for
arm64. If you are doing this on the rpi4 you don't need the
CROSS_COMPILE= option.[1][2]
make -j4 ARCH=arm64 CROSS_COMPILE=aarch64-elf- defconfig
Or if the kernel you're already running has a /proc/config.gz you can
use that directly (zcat /proc/config.gz > .config).
Then you can use the main make.
make -j4 ARCH=arm64 CROSS_COMPILE=aarch64-elf- deb-pkg
Keep in mind that even with the debian package this may not be enough
to install the kernel for u-boot correctly, You'll have to see if all
the scripts in /etc/kernel/postinst.d/ are doing everything that is
needed, but it should give you at least a /boot/vmlinuz... When I use
this I have to extract the compressed Image to where u-boot grabs the
kernel.

Hope this helps.

thanks,
Paul

[1] The -j4 says to use up to 4 jobs which will speed up the compile
with a 4-core processor
[2] aarch64-elf- is you're cross-compiler prefix if you are
cross-compiling. If you don't have this, read up on cross-compilers
and check out Linaro (https://www.linaro.org/downloads/)
