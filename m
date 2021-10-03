Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912AFC433F5
	for <linux-rt-users@archiver.kernel.org>; Sun,  3 Oct 2021 11:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77F1561350
	for <linux-rt-users@archiver.kernel.org>; Sun,  3 Oct 2021 11:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbhJCLNm (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 3 Oct 2021 07:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbhJCLNm (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 3 Oct 2021 07:13:42 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F30C0613EC
        for <linux-rt-users@vger.kernel.org>; Sun,  3 Oct 2021 04:11:55 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id z5so31012562ybj.2
        for <linux-rt-users@vger.kernel.org>; Sun, 03 Oct 2021 04:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A7caJp8dSXyEJw4akMMu8Oa0MlTuvoSbhx46WydcWPI=;
        b=d8ZE0A9zilHi87UcLOFkVicnhhadEuYrXT2vNQ5I/6SZkYlFv1sTu+X9FJs4TpuazB
         XfJJA16pKGE6QiqRISwvhq+IWM0r3XhUKkej3Gvmt2V/tEgjXB2jYr9asqFWWaozw5GU
         xr3mzmhOWdf3ITxj3IfC0amnxMRDcFjyGC1It6iM1iJLWL9hYddlJpw5jigZGHRJ4okT
         nryfrJ6karN35ib+Bn1mViMkCImEXfSajIDfaGVcqD1MCjlpnnYcRuCuqskiSDJmwXDM
         hMdy/NeBLc4/g9OaGiqoucGVwaT8tSTHhnF6Cld0CO688v5ESXgv9xq9buJVOA3wP+X/
         OnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A7caJp8dSXyEJw4akMMu8Oa0MlTuvoSbhx46WydcWPI=;
        b=lZRpzPDtSLy8yidfjpvrZ7MviCVR/UvvclykuTvf9QzPkM/ghxrSZQPPJVWtQWDJoO
         uTfATDvJASYoZCu44wG3CYF+2aooFHqdkMHFUqA6jghK15qlWXNZjHL8ISM4ppSYD6sW
         I420V/HIGKcZNo4YUF1B9fmAyeGei1W/bFCgtTqDUNxwboQM9KQ2wIlwpPh6DYMNuQUP
         bdR+ZK4te10Qy9+aSd7EyJr8Nw9/5EWtRZqBqgFg12kIX9aKvKAEoOysBzTCPR3Lo459
         1WRTECvaSlAZ9dt0WKxH4DWnuFqMNLJxpxH7vzAjNws/4dNedkjscP5CfREyC9oSfEq5
         XUug==
X-Gm-Message-State: AOAM533eeRnZu9fFGIx932kPfPO0kGfgjwUDwiulvzhByUrEaMpDIix3
        xB6fjzKp/4N8uGuPjFUwkJZllz8EeRQ4lIxUSnOeBWf+gRM=
X-Google-Smtp-Source: ABdhPJyYlHA5o4xIDoPGA8FJYJ0BnNkcVq5xMZhrUUppNWTrrjUWiwowt3kPnfSWE2HpowhnUbpysnlIFrEt7syPmWM=
X-Received: by 2002:a25:217:: with SMTP id 23mr8150877ybc.510.1633259513902;
 Sun, 03 Oct 2021 04:11:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAFc1U0sgMtKvcpTWkyjwXsq3Md_Huew7mSye_AratkM63D6K-Q@mail.gmail.com>
 <87y27e53a2.fsf@stealth> <20210930132319.eixnv6rb66ui6x6j@linutronix.de>
 <CAFc1U0uMuj1PPmxPQTTVqscYsnKfOE+sjtasK9KqadkgaUgLSg@mail.gmail.com>
 <20210930135145.mdlzzwp64yykixhx@linutronix.de> <CAFc1U0sYdJQWkeLgPjiR1Y1CnafV22zgS4AW0Yf6+h7CO03u+g@mail.gmail.com>
 <871r554opi.fsf@stealth>
In-Reply-To: <871r554opi.fsf@stealth>
From:   Jack Winch <sunt.un.morcov@gmail.com>
Date:   Sun, 3 Oct 2021 12:11:43 +0100
Message-ID: <CAFhCfDa5TQaEO_ZZwa0Y4v2Uy-B6=9B767gWw3z036bxz6Wsbw@mail.gmail.com>
Subject: Re: Strange problem with PREEMPT_RT
To:     Punit Agrawal <punitagrawal@gmail.com>
Cc:     Pierre FICHEUX <pierre.ficheux@smile.fr>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Punit Agrawal <punitagrawal@gmail.com> writes:

> > If I remove this default we're going to get a slew of reports from people
> > using cyclictest wondering why they aren't getting good realtime
> > performance.
>
> Perhaps, this is a change best done with a major version bump. Not that
> it'll stop users queries completely but hopefully more people will pay
> attention to the changelog.

Regrettably, I know quite a few RT Linux users who are neither party
to this mailing list (due to company IT policy), nor do they pay
attention to the changelog.  Even less read the source code of the
rt-tests suite of tools.

Regardless of these sorrowful facts, as this is such a fundamental
matter, perhaps it would be useful to highlight this behaviour of
cyclictest in the tool's documentation - specifically the program's
help output, manual page, and related content on the RT Linux wiki.  I
see additional information going into the first two forms of
documentation as a required step.  However, I believe that adding
information on this behaviour to the relevant pages of the RT Linux
wiki would also be greatly beneficial.  This is because many
developers who are new to RT Linux development, in my experience, tend
to make use of the wiki to 'orientate' themselves when first starting
out, etc, and the omission of information regarding this behaviour
could lead to wrong assessments and conclusions being made when using
this tool.

Jack
