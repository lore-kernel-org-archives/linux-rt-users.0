Return-Path: <SRS0=sUiU=XF=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,WEIRD_PORT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57A1C3A5A2
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Sep 2019 12:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 743852089F
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Sep 2019 12:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=austad-us.20150623.gappssmtp.com header.i=@austad-us.20150623.gappssmtp.com header.b="t1TvqOqU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732449AbfIJMLW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 10 Sep 2019 08:11:22 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44367 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731790AbfIJMLW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 10 Sep 2019 08:11:22 -0400
Received: by mail-io1-f67.google.com with SMTP id j4so36861181iog.11
        for <linux-rt-users@vger.kernel.org>; Tue, 10 Sep 2019 05:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=austad-us.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=153IrZFi32qJIFqgjRYTE+/LSSFIYK3SMYszurBxOj0=;
        b=t1TvqOqUsWve9iMySAfB9CQNTlQXkms+GJUcyA+NGkQw0tVMY5U6284isAFvReE05/
         hzQLpZxYwd03ztKb7QMui6uDCA24/CeG0WLVeXTScwPrQa6UqkSTqlNKVHvA+U+jz4+z
         SplgAbWThAO10cUKWu2qxb4Yn31LExKWzik7whDitWwDYXkQtVy95UIbQhFHNQzy+JPL
         2/fuUtMwlDQaKUqZDJ2kfCwsu8lQgmfbdx4TfUgeVIeajsIm6FMeBKQHjpGRbJfBvFXj
         koggW4pt7dzPqfQWGaqVvhBECivUiyhSlaq3lWe3Rc195d6GW6RoKsaKsZmkJELzwu+P
         nR3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=153IrZFi32qJIFqgjRYTE+/LSSFIYK3SMYszurBxOj0=;
        b=BiCGkjCVt4D/EOfVKpU9tSERQ3uW6ts3Pxap88rImMahWIdwllCYnEigDiO9KWODPP
         HQ6JRODpOgAF4SMHv/45FRYu5Uf9jsWc9BQJbksihwj+YPqwcQI9RUmffXVvoqzzEN0n
         DcDITmarhy41LT4XEtxlJHcsQvTz9xIA/QwHRphzIP/aXtCZV5bxxezoUVn5CrRuI3Uj
         WPicIiNqudeklAQs5Neaws95WDSLg0fW6l+ZkTirzXmp0xcvqr0bAlK62bvJNJUH28AW
         b20VKmJRAWjmByXUEHAsUoATuTLLUFYBK27uotIBIeXZ9874m7x/Ox/j8qP/FWfvFEPL
         IiGQ==
X-Gm-Message-State: APjAAAWz+OVw8L5FoRM6seYzTvc6TE6wU5GS8CjGP1vxHsISV33yjv6h
        BzOqeLjEPj4Il7tfMF9SSNE36qjmu3817kzbiu3C8g==
X-Google-Smtp-Source: APXvYqyQR2bryj+r3LgtiIRE5TjcpLhY7L8rKHT3ACpyRg+ekX7THXrf+CEHyrRnNPFfk6Ecd4nm3daWssMvJtNsjF0=
X-Received: by 2002:a6b:e415:: with SMTP id u21mr504709iog.303.1568117480274;
 Tue, 10 Sep 2019 05:11:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190827105542.qxvtteirkh55i5ly@linutronix.de> <201909100733.16783.gheskett@shentel.net>
In-Reply-To: <201909100733.16783.gheskett@shentel.net>
From:   Henrik Austad <henrik@austad.us>
Date:   Tue, 10 Sep 2019 14:11:08 +0200
Message-ID: <CAM6o_m2Y0uZoBkiARFZP17W8zzHkQ1YOo7za2WBt1FdrbA_oYA@mail.gmail.com>
Subject: Re: [ANNOUNCE] v5.2.10-rt5
To:     Gene Heskett <gheskett@shentel.net>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Sep 10, 2019 at 1:50 PM Gene Heskett <gheskett@shentel.net> wrote:
>
> On Tuesday 27 August 2019 06:55:42 Sebastian Andrzej Siewior wrote:
>
> > Dear RT folks!
> >
> > I'm pleased to announce the v5.2.10-rt5 patch set.
> >
> > Changes since v5.2.10-rt4:
> >
> >   - Take care of compile issue within the timer-atmel-tcb driver on
> >     AT91. Reported by Alexander Dahl, patched by Alexandre Belloni.
> >
> >   - Fixes to the hrtimer code to finally avoiding warnings while
> >     canceling a running hrtimer in IRQ context. Patches by Julien
> > Grall.
> >
> > Known issues
> >      - rcutorture is currently broken on -RT. Reported by Juri Lelli.
> >
> > The delta patch against v5.2.10-rt4 is appended below and can be found
> > here:
> >
> >
> > https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.2/incr/patch-5.2
> >.10-rt4-rt5.patch.xz
> >
> > You can get this release via the git tree at:
> >
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git
> > v5.2.10-rt5
>
> No such file or directory?

Hi Gene!

This is the url used by git, ala

     git clone git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git

Which also gives the tag:

git tag -v v5.2.10-rt5
object 6ac137d628a9abbe574400424eba218e96ec5b7d
type commit
tag v5.2.10-rt5
tagger Sebastian Andrzej Siewior <bigeasy@linutronix.de> 1566902608 +0200

v5.2.10-rt5
gpg: Signature made Tue 27 Aug 2019 12:43:28 PM CEST
gpg:                using RSA key 57892E705233051337F6FDD105641F175712FA5B
gpg:                issuer "bigeasy@linutronix.de"
gpg: Can't check signature: No public key


If you want to browse the code via a browser, go here:

https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/

HTH

-Henrik
>
> Thanks for any clarification.
>
> Cheers, Gene Heskett
> --
> "There are four boxes to be used in defense of liberty:
>  soap, ballot, jury, and ammo. Please use in that order."
> -Ed Howdershelt (Author)
> If we desire respect for the law, we must first make the law respectable.
>  - Louis D. Brandeis
> Genes Web page <http://geneslinuxbox.net:6309/gene>



-- 
Henrik Austad
