Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9111FC433F5
	for <linux-rt-users@archiver.kernel.org>; Tue, 25 Jan 2022 05:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391568AbiAYFIf (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 25 Jan 2022 00:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388270AbiAYEFN (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 24 Jan 2022 23:05:13 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47641C06F8C6
        for <linux-rt-users@vger.kernel.org>; Mon, 24 Jan 2022 18:34:24 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id ka4so26797475ejc.11
        for <linux-rt-users@vger.kernel.org>; Mon, 24 Jan 2022 18:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=osoCHaTJqFFi3fVF3PdZpffZ/qvak6h568y2spsfMyM=;
        b=G6uxd2TDl+yvCa/WixMvHNqx/TBjcO4IHoAs8W5ZJhMF6Ga5H+b+vfl1+7nqz8V3UW
         OPx/9dJIPbE/Jyck/jExDjS04B0x+AFfiVRol6ZZP1Pip1xMcCSqwXfpO5oUht999SkX
         CKVzdz5d9AbuzeevI1ZT21F26fd6LPbKE3fhiNp+HikUEzc01Cq3gDVzxphSX3jaymlX
         eR9Og16azdNPvqZ6eoXCfEI2mrMveW91FLR7ZhPEHsCrp7DhsZBiQYwW//ilWP8yUcDh
         45auUKUx9ql0Ig3/aI8Y5NIl8LMMjO4FO0zu/Fw0Pqx/QuuebimGBFqf0Ha5RqJDs8sZ
         wbAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=osoCHaTJqFFi3fVF3PdZpffZ/qvak6h568y2spsfMyM=;
        b=dfTUrrE3CX6j08gmQjCle2C2cLr70xJP/vEYXiyWKLjBktzsNeDY6mi9iq9Xcmjtfh
         9yMujlVerHJ9BN/1iMZK/Xpqu6XE2+iUYk0Y0xr+xarabx6D0yDbWwrTFfNW8+lb5oAe
         Dsy7lOX8t2K8c2iY1G65QF/0j5BI6y7L9s/t+TkBSVssAe2gXefOcpRu3UrIpNkeAFzx
         H6ZZDH2SrwmFiQ5DrMJAu5AukZlPJmW3VCcQKcVmCHOWpQFwvtBAvJJudKrJuaRzVygF
         3bTQu2vjGZaqOL+AbV3V+KuMoPnXWqKAVB20/dRJwmdlcQIg/qnoCeg6LexFQ9aNElo2
         bHeA==
X-Gm-Message-State: AOAM530arpnoLbAqwbS8ERcIXdBs+mFydvi5Y3gT1Q3iKleF6HKTEJ5T
        yi0vXtXptJDrfMiAhPOkVnXl7SOnnca9QLEnX2wpYUq+g0o=
X-Google-Smtp-Source: ABdhPJyB2ToUrmYYm5c5IQnPwGt9RPyOyi+WW8o58/Db3s1Mzrr0/wUo7pHZeYk1iibF5KVdyYOTbSJ1CWLTTX4VOxQ=
X-Received: by 2002:a17:907:7b8d:: with SMTP id ne13mr4427621ejc.440.1643078062662;
 Mon, 24 Jan 2022 18:34:22 -0800 (PST)
MIME-Version: 1.0
References: <YcSgQY8lzb6MkQPx@linutronix.de> <64294bf40ace6be86a295099b895a7d1f6a5c49f.camel@gmx.de>
 <8448352.jqPtiG1ysD@coyote> <b34a560ceeb3bf29f20169f6201b941c64f3d20a.camel@gmx.de>
In-Reply-To: <b34a560ceeb3bf29f20169f6201b941c64f3d20a.camel@gmx.de>
From:   Austin Schuh <austin.linux@gmail.com>
Date:   Mon, 24 Jan 2022 18:34:11 -0800
Message-ID: <CABsbf=G5obCHFrYbuj6d4ehRr+pUVb6=aP_6ggDG5LB9bMPXnQ@mail.gmail.com>
Subject: Re: [ANNOUNCE] v5.16-rc6-rt12
To:     Mike Galbraith <efault@gmx.de>
Cc:     gene heskett <gheskett@shentel.net>, linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, Jan 24, 2022 at 7:04 AM Mike Galbraith <efault@gmx.de> wrote:
>
> On Sun, 2022-01-23 at 09:40 -0500, gene heskett wrote:
> > On Friday, December 24, 2021 9:16:57 PM EST you wrote:
> > > On Thu, 2021-12-23 at 17:13 +0100, Sebastian Andrzej Siewior wrote:
> > > > Dear RT folks!
> > > >
> > > > I'm pleased to announce the v5.16-rc6-rt12 patch set.
> > >
> > > > Changes since v5.16-rc6-rt11:
> > > ...
> > >
> > > >   - The "Memory controller" (CONFIG_MEMCG) can be enabled again.
> > >
> > > FWIW, LTP testcases pass on rpi4 and x86_64 boxen with no gripeage.
> > > Full LTP with maximally bloated config was as uninteresting as one can
> > > hope for.
> > > .
> >
> > Unforch and after many try's, I can't get it to reboot when installed,
> > sorta, on an rpi4b.
> >
> > I say sorta, because no matter how many times I rebuild it, the build
> > does not generate an arch/arm/boot/dts/overlays directory.  The build
> > itself is error free.
> >
> > The raspi kernel build instructions from their somewhat dated wiki also
> > say to use the bcm2711_defconfig, but it does not now exist in a git
> > clone. And a hwinfo of the rpi4b says I should use the bcm2835_defconfig
> > for a starter .config.
> >
> > Is there any hope of making this work?
>
> Sure.  Given bcm2711_defconfig is missing, sounds like you're trying to
> build patched up kernel.org source.  You can do that, works fine for
> me, and I know jack diddly spit about cute little arm gizmos ;-) but
> you're better off patching up source from...
>
>         git clone https://github.com/raspberrypi/linux.git
>
> ...instead, which has a large pile of not yet upstreamed rpi patches.
> Just checkout the rpi-5.16.y branch and apply the 5.16-rt patch set.
> There you'll find that bcm2711_defconfig you were looking for.
>
> I build on my desktop box, rpi4 being every bit as fast as you'd expect
> something that dinky to be, then nfs mount from rpi4 and sudo make
> modules_install dtbs_install install.  Edit /boot/config.txt, reboot,
> and presto, you too will be ready to have any unrealistic x86_64 based
> expectations you may have thoroughly dashed by cyclictest numbers :)
>
>         -Mike

Based on Mike's excellent advice earlier this month, I got 5.10
running nicely on a pi 4 with the RT patchset.
https://github.com/frc971/linux/tree/frc971-5.10-pi4-rt is our tree.
We are using it for running 2 khz estimation algorithms for robots.  I
picked the current stable kernel version in the released rootfs
instead of being as adventurous as Mike and running a newer kernel.

There's a pretty good howto from the raspberry pi folks about how to
build a kernel which I used to deploy it.
https://www.raspberrypi.com/documentation/computers/linux_kernel.html#cross-compiling-the-kernel

Austin
