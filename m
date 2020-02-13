Return-Path: <SRS0=wfJr=4B=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C86C2BA83
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 Feb 2020 06:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E20E20848
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 Feb 2020 06:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=unikie-com.20150623.gappssmtp.com header.i=@unikie-com.20150623.gappssmtp.com header.b="capDLcHa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbgBMG6W (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 13 Feb 2020 01:58:22 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34820 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729702AbgBMG6W (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 13 Feb 2020 01:58:22 -0500
Received: by mail-ot1-f68.google.com with SMTP id r16so4609022otd.2
        for <linux-rt-users@vger.kernel.org>; Wed, 12 Feb 2020 22:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unikie-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xo9ln4ej8fhV1TjLoTXrGwhfhL45YpO/2Fozf/wYKws=;
        b=capDLcHaKKd8FulxDgStzaLLQTU8iB2xzEMm4w+7WXnAOoki7iUe3CaKyY+70NeJ/D
         ZjVCuNPaUqJ1KabVRLlVusfUXwR7oNpIkBY3WRLbZ59+/jmbeF3ApWL4y0n+YqO6I9T8
         AVq3HipJsdXGXpbyl0+eeI49vHC38/awAcccpidUgjD6qPkPVJfTy+lgCjb0OV4GahBI
         Z7InsKSW/amv08x0AfDnIYlklcgv+GR2JWOD4aRre6aq0gVO4JuQ/NtwtgFusHYPAd3w
         posvbHLeXtkssToQLM/64YeL44WueSpI/o1BrCt2lleCswcj8B18lj7ouu2eyY+xYt7p
         HtYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xo9ln4ej8fhV1TjLoTXrGwhfhL45YpO/2Fozf/wYKws=;
        b=G3Of9VwUNH/Y+s3A0g5oTOFTlbSx+cWbs0CPDG8d490jet1KD0EcdvdNaEGZkPfaYf
         r+9gqrIE8rXMk9phIBHVbG8CBEARZKb2m4nTrXOcSvcj3TxCtAb8UznMbW//j1d5pZmc
         kdD2DoPi/A75RuhVycdHX51htGVexMq9MBKSgrx/r9X+PV6vzw5C9i50T+0dvWd/qzhl
         pyB3P7J0nnVU8pdAja2FsaFXKo+FU5skArVvG7EPMN2q/CmMVxnSf4kW9E3MDSfV+hxf
         oSbTyi9DvKrGtFFryvk/BsFW79VMC8Sg6kmppmdv4plO9OcTr9cbnzez+t5td7XgsJa0
         /FuA==
X-Gm-Message-State: APjAAAW7f4+k96Ho9SOSSkD1bykqJAIh9rJxRfRcVoG5h45KGrSmqgZB
        Hrxa+feBEs3jChYUtX5D7xfpsg2VkxlcfEjx0N1sDRkOLTM=
X-Google-Smtp-Source: APXvYqw1HlXClF2iQWiqPLYO0qpE5sIxgXxMy5fn4BOxMTkOYD0V9KQYPnrlcoyqwVCPBPXu+1NmNB3ZK/sNLIhwVn0=
X-Received: by 2002:a9d:6e8e:: with SMTP id a14mr11724619otr.109.1581577101381;
 Wed, 12 Feb 2020 22:58:21 -0800 (PST)
MIME-Version: 1.0
References: <20191218165334.k4suur4gzlu62ibs@linutronix.de>
 <20191231100051.658-1-john.mathew@unikie.com> <20200114124732.mbw6lfrajmaxjkce@linutronix.de>
 <CAJz2qXntOC31LcfphJDdotQ2pMZjV8DPECMF-H7dDPWFZbw=VQ@mail.gmail.com>
 <20200211120443.tpb5feweflnjr72i@linutronix.de> <CAJz2qXn_bSF5iRKZLVfrMxQXYS8cfOs9GqJtrizzpiAXR4kzAg@mail.gmail.com>
 <20200211155925.ctrtxyxh3pfuo2os@linutronix.de> <CAJz2qXk=OXRFV8XGWbh+pMG3CLX6Htkwi+jR635U4sibNaGdxw@mail.gmail.com>
 <20200212170249.xhped3ohjcnwh52s@linutronix.de>
In-Reply-To: <20200212170249.xhped3ohjcnwh52s@linutronix.de>
From:   John Mathew <john.mathew@unikie.com>
Date:   Thu, 13 Feb 2020 08:58:10 +0200
Message-ID: <CAJz2qXkEZkY9PETja_wFkN26CD1o2J71h-BGhYEmBSDOM6mrSg@mail.gmail.com>
Subject: Re: [PATCH] crypto: only wait for completion once
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Feb 12, 2020 at 7:02 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2020-02-12 14:55:29 [+0200], John Mathew wrote:
> > On Tue, Feb 11, 2020 at 5:59 PM Sebastian Andrzej Siewior
> > <bigeasy@linutronix.de> wrote:
> > >
> > > On 2020-02-11 17:52:44 [+0200], John Mathew wrote:
> > > > > crypto/tcrypt.c
> > > > I ran the module in a loop with mode ranging from 0..200. The output
> > > > is the same (tcrypt: all tests passed ) with and without my patch.
> > >
> > > Try one of the modes which are not built-in but provided by a module.
> > > And the module must not be loaded before starting the test.
> >
> > I tried the mode 26 which tests the "anubis" module. The module is
> > loaded dynamically after starting the test.
> > Using traces in the code i confirmed that the algo lookup and tfm
> > creation works fine.
> > alg_test returns 0.
>
> Something isn't right. So when I took a look at it then the patch then
> every user that waited for a module to be loaded did not wait for the
> algorithm to become available but returned with an error instead.
> Now I'm curious why I had a regression here but you don't.

Thats strange. Below are a few questions, hope you can answer so that
we can check on our side.
Did you manage to reproduce the original problem :
https://lore.kernel.org/linux-rt-users/20191218165334.k4suur4gzlu62ibs@linutronix.de/T/#t
with the config file I send?
Can you share your config file?
Which root file system do you use?
Which test mode of trcrypt did you use when seeing user not waiting
for algorithm to become available?
Are you using qemu?


>
> Sebastian
