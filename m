Return-Path: <SRS0=yCAb=37=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FADCC352A3
	for <linux-rt-users@archiver.kernel.org>; Tue, 11 Feb 2020 11:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1515520842
	for <linux-rt-users@archiver.kernel.org>; Tue, 11 Feb 2020 11:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=unikie-com.20150623.gappssmtp.com header.i=@unikie-com.20150623.gappssmtp.com header.b="Zwkrrrop"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbgBKLtL (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 11 Feb 2020 06:49:11 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40372 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbgBKLtK (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 11 Feb 2020 06:49:10 -0500
Received: by mail-ot1-f67.google.com with SMTP id i6so9742160otr.7
        for <linux-rt-users@vger.kernel.org>; Tue, 11 Feb 2020 03:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unikie-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CdQ8uyZJp0H7HbBqHOaqMySCKidw3JNLf1nTYreWAoA=;
        b=ZwkrrropDfUnMaAkHpB/8lbQ7/ApCwfc1qVmd15m9wopEoMrjMQ4BysvAahcRhNR4F
         nIh9zAgqGwTydNB/Ad58JBorwlVtwPSC5eVhS4Kw0wQDy/SofcWLwBUx1E+KMej0Jj6J
         sUh5LXNwaIyvAOL9HaUkTq2eorbCxHM8+VG0U04QZBkIQxRggD1KHlnhJL4jLtrwrl87
         tPrloRjjzVTOD1hbQzdw/xX2LfIq0XzvyzYqUO5NZN/EO5NNB1VNaC0b/GsyiuzTV7bc
         nZC4S47cm30eAN+I/wXyTOvC4QhEIIFqoQR+de29zWwVnClVuPpWjmIcD387PbO9g7S6
         KEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CdQ8uyZJp0H7HbBqHOaqMySCKidw3JNLf1nTYreWAoA=;
        b=e2EH1WqqbqwRGzoEdJf0ec6LFBw75SpSDX+bH9f0Bo+zDhiTGqte0xokwlavagaaL9
         ACOyfLb9S/j/akUfQhCu1voAWp7kMOGeptvCGOmxBetx7XNSxoO2TsbjdzCkhGAS4NRJ
         iPOydbYbEZ7WGUnS0MLl84LUlzS0+/1uYKVqDBASg9qLsjMP9gKY7r6GNEjDaEMTRir2
         kR+jLHKUtyhlv9YMVFoNZIUsejLthcpfqtTqm4mcgF7V/xQRp1Mqw7d77Q4qV+C9KzzX
         8c73pf2wBG+/iNqyM3sb8cdpyEkX/OatrOa+4U2KG1qd9vAw7Qm8Muwrk9rUHQvd7F69
         AttA==
X-Gm-Message-State: APjAAAUswIRGmoBqj3ROl7oA2jzQ+mYaWJP0RFYDFgBENaEgvyTy7QIB
        OkG7AI+tQbQ2huAWSPFXdbZHvUDHw/7t9Jy9rYsePg==
X-Google-Smtp-Source: APXvYqygYZuegxVllpAZHMft6m/x995VLdmrte/RWq+SC/H1vlKTgF61aBGvOwmPyrmZmLkunBc5VhVfI20jOIIdQtw=
X-Received: by 2002:a9d:6b03:: with SMTP id g3mr4886263otp.200.1581421750056;
 Tue, 11 Feb 2020 03:49:10 -0800 (PST)
MIME-Version: 1.0
References: <20191218165334.k4suur4gzlu62ibs@linutronix.de>
 <20191231100051.658-1-john.mathew@unikie.com> <20200114124732.mbw6lfrajmaxjkce@linutronix.de>
In-Reply-To: <20200114124732.mbw6lfrajmaxjkce@linutronix.de>
From:   John Mathew <john.mathew@unikie.com>
Date:   Tue, 11 Feb 2020 13:48:59 +0200
Message-ID: <CAJz2qXntOC31LcfphJDdotQ2pMZjV8DPECMF-H7dDPWFZbw=VQ@mail.gmail.com>
Subject: Re: [PATCH] crypto: only wait for completion once
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Jan 14, 2020 at 2:47 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2019-12-31 12:00:51 [+0200], John Mathew wrote:
> > Proposed fix for the swake_up_all_locked warnings issue discussed in
> > Link: https://lore.kernel.org/linux-rt-users/20191218165334.k4suur4gzlu62ibs@linutronix.de/T/#t
> > Currently multiple wait for completions are scheduled for the same algo.
> > Only one completes and the rest are returned with ENOENT. This patch
> > checks for the name of the algorithm going to be waited up on, and if
> > the algorithm is already being waited for completion return EAGAIN ,
> > without accumulating completions and returning ENOENT.
>
> Have you tested this patch and if so how?
I ran the syzkaller for many days and was not able to reproduce the
hang, also no new issues were found.
Do you know any more tests for the crypto functionality?

>
> > Signed-off-by: John Mathew <john.mathew@unikie.com>
> > ---
> >  crypto/api.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/crypto/api.c b/crypto/api.c
> > index d8ba54142620..1c6004e7ab6c 100644
> > --- a/crypto/api.c
> > +++ b/crypto/api.c
> > @@ -234,8 +234,12 @@ static struct crypto_alg *crypto_larval_lookup(const char *name, u32 type,
> >               alg = crypto_alg_lookup(name, type, mask);
> >       }
> >
> > -     if (!IS_ERR_OR_NULL(alg) && crypto_is_larval(alg))
> > -             alg = crypto_larval_wait(alg);
> > +     if (!IS_ERR_OR_NULL(alg) && crypto_is_larval(alg))      {
> > +             if (!strcmp(alg->cra_name, name))
> > +                     alg = ERR_PTR(-EAGAIN);
> > +             else
> > +                     alg = crypto_larval_wait(alg);
> > +     }
> >       else if (!alg)
> >               alg = crypto_larval_add(name, type, mask);
> >
> Sebastian
