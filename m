Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4F3C433EF
	for <linux-rt-users@archiver.kernel.org>; Sat, 16 Oct 2021 19:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EFE760EE9
	for <linux-rt-users@archiver.kernel.org>; Sat, 16 Oct 2021 19:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240925AbhJPTif (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 16 Oct 2021 15:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240917AbhJPTie (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 16 Oct 2021 15:38:34 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B31C061765
        for <linux-rt-users@vger.kernel.org>; Sat, 16 Oct 2021 12:36:25 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id a140-20020a1c7f92000000b0030d8315b593so5966155wmd.5
        for <linux-rt-users@vger.kernel.org>; Sat, 16 Oct 2021 12:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FZxVmwawHyslMtgo4HJIeZ00B+bo9BgIE7tFyO6sr4A=;
        b=ZSspUtIsLWnCH1wX9vItl/yJerRrBAjAnzOydxCRLAAwTmz3bUP6d87fajMuAml6Tk
         Tuhwkh2QI6lbUs+rNfDSheM8+AkWBEurQCaCmV4KmSlAF6Dv0HjhRMDzKdMaxDxXmLCH
         5rt7ODK9xTLEKV8OUbZv23KfTgDi24x4qifaQeLa6ZPHUxsBafPSau7vSVE0Jp12FNzU
         ap9cwBkR4TkRsrwnyCrNNQ6Nkyf0VxAsBXn0U7Y5XakknrKqSXmpZy+wknKCkcQwBrRT
         qtPRWLV60JXnMw0WEw5rBz/DxdJ8us9cJSSYnOwaY1iKJd0vc3retFjsaEDcL60x/CJ1
         r2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FZxVmwawHyslMtgo4HJIeZ00B+bo9BgIE7tFyO6sr4A=;
        b=G1+qD0ApQRf1kavywk73tIV9isPDNzivNBDLfn0v7qCOzASMmNNkwpwyyxPkfm33sx
         ti6sm3Ds+vSJCRr5k5V+6NO3pyt6HWy/Oso5Mk4cQdIxhQir5gm5/iSBcuO6MlnBSMGV
         5SkVHmTS4DaDtMESQ5QvANYCQYfZTEogYBFW9rE6lZnnCVhcBozftkYx0Hp1UCgPgvmY
         7xTsi9w9mDqedhxAI3USyl5Gs+tDElRZQhZUW+e+3iotVxNeakiwczFF36I0LZLrShsC
         nzH9AMfy9ycSHSsi7AsDsq5/v/UGDPCfN0D6Q90KdfDQKyVa98KDufb+yCUYD7KT1VYn
         3r+A==
X-Gm-Message-State: AOAM533lzyUga33az+aV95xPRiKG5Nwfpeh2VSu2lxUBM0A2lB5bDA4M
        29rZmZORQgKPkbh+rUYn5AwieiySDtg0g/bhE3f9nFWm
X-Google-Smtp-Source: ABdhPJxOst9lcBs4MVKOF0QEWz65Du0DE9GbJlmSQzoGXdP3qWy/pguPUKKufYEemBXlVJT2SXwsnFGQFJHuyLlajfY=
X-Received: by 2002:a1c:191:: with SMTP id 139mr20464489wmb.186.1634412984305;
 Sat, 16 Oct 2021 12:36:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAGHUO11bZYViip313Kid+yRyvF9pRU6ktuaqJB7XO=VFcHu_xQ@mail.gmail.com>
 <YWsdtdBZNQG1h7iF@lx-t490>
In-Reply-To: <YWsdtdBZNQG1h7iF@lx-t490>
From:   Joseph Salisbury <josephtsalisbury@gmail.com>
Date:   Sat, 16 Oct 2021 15:36:19 -0400
Message-ID: <CAGHUO118azBT8vQZ7L0guT1K+1dVVMOFobxnVxEELy70fOCArQ@mail.gmail.com>
Subject: Re: Question About Patch Set Tracking
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Sat, Oct 16, 2021 at 2:45 PM Ahmed S. Darwish
<a.darwish@linutronix.de> wrote:
>
> On Sat, Oct 16, 2021, Joseph Salisbury wrote:
> >
> >               Each section in the series file appears to have a title.
> > Is there a decoder ring or something similar to understand what the
> > section titles mean?  For example, '# Applied upstream' is pretty
> > obvious, and can be confirmed by looking at the mainline tree.
> > However, I see sections such as '# Posted an applied', '#Posted', '#
> > Post', etc.  How can one understand the meaning of these titles?
> >
>
> Well, 'Posted' is what it says.
>
> For example the printk work, or "[PATCH net-next 0/9] Try to simplify
> the gnet_stats and remove qdisc->running sequence counter.", at netdev,
> etc., etc.
>
> Maybe the mainline maintainers have no comments and it's merged as-is,
> maybe some additions are requested and some development is pending or
> in-progress, and so on.
>
> > The best way to learn may be to write some documentation about the
> > patch set.  I will search the wiki for some hints on activities in
> > that regard.
>
> The rate of change is really quite quick.
>
> AFAIK Sebastian already updates the quilt series file for each -rcX-rt
> development -rt release, so that's the latest "source of truth" you can
> follow.
>
> Any more details than what's in that series file, you can search the
> patch subject lines at https://lore.kernel.org, which can recently do a
> "global" search inside all subsystems mailing lists in one shot. This
> will usually give you all the nitty-gritty details.
>
> Good luck,
>
> --
> Ahmed S. Darwish
> Linutronix GmbH

Thanks so much for the details, Ahmed!
