Return-Path: <SRS0=BA5Y=SK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34749C10F13
	for <linux-rt-users@archiver.kernel.org>; Mon,  8 Apr 2019 20:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0031820855
	for <linux-rt-users@archiver.kernel.org>; Mon,  8 Apr 2019 20:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gu2v+YCM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfDHUf6 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 8 Apr 2019 16:35:58 -0400
Received: from mail-vs1-f44.google.com ([209.85.217.44]:33736 "EHLO
        mail-vs1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfDHUf6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 8 Apr 2019 16:35:58 -0400
Received: by mail-vs1-f44.google.com with SMTP id a190so1476711vsd.0
        for <linux-rt-users@vger.kernel.org>; Mon, 08 Apr 2019 13:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1vKcZuoTfrYO7aKufjUPYAPmdFMvJGiUThmABFV4mBA=;
        b=gu2v+YCMajcI0e1FuKT87vtOH2xg90eE2eX6DNw75UEBhbYSNjAfPqlG7kAsOIZZsr
         kmnDH1G7MfkdEhr58UenWeQTXSD2w+Zr1cuANbsBAE1MIMFd+2lN1mboXJzTJHBZbqbl
         BR6Vsh5JdCO+L0EHsFZf8zHF0nHafKOAB+FXOD8Mzed2xpDtxLxJmZTKnJM0cWlMXlUM
         uieRK5pV48sRaGF/pOcHjCAty42e/OUan3UHhKpQGSqSX7gt/Q/Hhg5GFrwcjA0fGH/W
         478Exi7QJ7d732Cy8bKKOpd+flGZkZDpz+XhF80sD0RrQLNJeYlm8F3BtBCALVhiqf2H
         JMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1vKcZuoTfrYO7aKufjUPYAPmdFMvJGiUThmABFV4mBA=;
        b=Rpf2ppupeQjDs1JNdzEQneCVRu1k49NGS5SgS2dJ3c+ldHAyxL+G1fCQnCCHbSboV/
         FTWK6i1GQ1pOXAyVnIr/mJ3uTTlgolIPbEbHaLkedMKLWYblQNr97ffB5UzJZ8y7+6m8
         YwOvpXzCfhuB0GEBpzvNJGhVkTOFs2Pz40hIjMVkVhXiy+GxgtBgCgtGgbIb7p2n2PbW
         Fpz42ZCVPklMjrX9j+EqcYiTyejstVM515SRoo3WQqmrL/p760YJHmhl5jomKrthczQq
         m+6DHvYd9lKbFm6wYGNSlD3IqBaXX6auzZwh34BfBT1f0qolzEoUNeScgtDQ/YUeFdyY
         iRxw==
X-Gm-Message-State: APjAAAVJbt/bYLmG93nMH9EltALxNz71vMwth5mrJouApczSUxz/L/2S
        BhRNuHLcSZHTgcb5TBPoUo8gbT59nsHA2nPHFQY=
X-Google-Smtp-Source: APXvYqxhRReIYWDbi5iE2FeTqd44sZn3c+k9aALyYf3lhqqPZs4xKZj/LnBges1bC5I77RiPSDJjd3GmZJV+9z3d3Q4=
X-Received: by 2002:a67:f505:: with SMTP id u5mr17471809vsn.159.1554755757131;
 Mon, 08 Apr 2019 13:35:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190328115559.275af3c3@archlinux> <f5d4ea60-aa23-a294-3850-42f35ca3d76d@manjaro.org>
 <20190328120022.bhwijbp2roizysiw@linutronix.de> <82482272-6912-c1d4-4a11-550a962f632c@manjaro.org>
 <1e1974c5-2ad3-98db-d160-577594a471e1@manjaro.org> <4ddfde7a-122b-5f18-f41a-b5e967217510@manjaro.org>
 <20190329083400.m4kx4spuvysoszlm@linutronix.de> <4f5db7b4-e129-075a-f5f7-81fc0c0a1d82@manjaro.org>
 <20190408153014.q5hnrz3dwphudeq2@linutronix.de> <CAA7rmPFHSgA04V3jhPgdxJOmKGBRMo6d7TUxwrfuXeW=xQUEBA@mail.gmail.com>
 <20190408195740.lxyiolx3xzypgoyx@linutronix.de>
In-Reply-To: <20190408195740.lxyiolx3xzypgoyx@linutronix.de>
From:   Daniel Vacek <neelx.g@gmail.com>
Date:   Mon, 8 Apr 2019 22:35:46 +0200
Message-ID: <CAA7rmPFTru+e2A8Uc04U+TExodJ=4pywWAC7cyfoncMCvKNg4A@mail.gmail.com>
Subject: Re: firefix core dump with linux 5.0.3_rt1-2
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Bernhard Landauer <bernhard@manjaro.org>,
        Ralf Mardorf <ralf.mardorf@alice-dsl.net>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, Apr 8, 2019 at 9:57 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2019-04-08 21:33:55 [+0200], Daniel Vacek wrote:
> > On Mon, Apr 8, 2019 at 7:31 PM Sebastian Andrzej Siewior
> > <bigeasy@linutronix.de> wrote:
> > >
> > > On 2019-03-29 09:38:33 [+0100], Bernhard Landauer wrote:
> > > >
> > > > > How do I reproduce this?
> > > >
> > > > For me this happens reliably when I launch a fresh instance of ff and it
> > > > automatically tries to restore tabs of the previous session.
> > > > Alternatively, when I select 'Restore Previous Session' from the menu.
> > >
> > > Does this help?
> >
> > >From an uninvolved lurker, how is this supposed to change a thing?
>
> on RT
>   local_irq_disable() + spin_lock() != spin_lock_irq()

Nah, the rt_mutex... I always fall into this trap :-/

> > Moreover, I'd say the original version is better readable.
>
> how so? You remove the irq/irq_save() from a lock and put a local_irq_()
> in front of it. Is the only purpose is to avoid enabling/disabling twice
> in a row?

What I meant is that it's two different locks so it's easier to see
that you a) disable interrupts and then b) do the work with the locks.
But yeah, you would have to change this to
local_irq_{dis,en}able_nort() to achieve what you did here. Still I'd
argue that doing this would be clearer to document the intention.
Anyways, please disregard. I'll back to lurking...

--nX

> > --nX
>
> Sebastian
