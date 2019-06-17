Return-Path: <SRS0=AADZ=UQ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEDDC31E5C
	for <linux-rt-users@archiver.kernel.org>; Mon, 17 Jun 2019 15:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C85412084D
	for <linux-rt-users@archiver.kernel.org>; Mon, 17 Jun 2019 15:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMPWxjNr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbfFQPFt (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 17 Jun 2019 11:05:49 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44710 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfFQPFt (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 17 Jun 2019 11:05:49 -0400
Received: by mail-wr1-f67.google.com with SMTP id r16so10329555wrl.11
        for <linux-rt-users@vger.kernel.org>; Mon, 17 Jun 2019 08:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=nHoFqmXGhMooxq/cDChn2izH64hKLtgn535u4j/q9yQ=;
        b=XMPWxjNrD4731Usc1DZGEYM7XcSuxADjk27dlz5cWvy4xGNtKLH/J8XJ4UJYr5rRGe
         cXgnxr12/kFp2ek1dHnmrlw5rfrb1AgLWM3Q3Lhmi4lpQIN++rvEIFQW7d9Hx0QcFwTo
         1kyXPC6jltt91UK9I9CFADE/T9WhBswzhWKNBc1Iy/FOzEheU7JzbK25i2wVOq7/L8iH
         sTVCDcO0Q3LxyJCV1vgbIHUaquiOKv8vYwAnEXmW5HnArH3cK/I5/oxTUINn9OQ0MeYD
         DAwn28JUlAGbEHGrKLkCxRD+jY3v+eRsD9Nz1ydS8cEvQf+FQsevUGPrmnB/soSMmw6l
         YR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=nHoFqmXGhMooxq/cDChn2izH64hKLtgn535u4j/q9yQ=;
        b=HaVbE6t1Mb4UuyZuxPKq4kDe5jt7JsXBWHQHVUslSdn4hVPc3Fzx+MvoODjOtXqssU
         C/0TCpcJGrZtbfuVxS5MksL6Vh5g7hilOSW6h63ZUWb+VWnUAbBT5xuegahm1i45gLCY
         uwvho5RTwFLTRXlSAGciow8pb3Ddudc6GHWqhdyHuyE7nhUN3o5vqanV4g/7iU+EhNxJ
         Mw77TQ8ksRN5KlTKJ2mWw6nEtZclB2lluRNMwhByDYwkw16XM972FtqLvIsXwmorIVx3
         X1HnicT6Oii64sgKg5kgcjq7p7Gv6HmOLqYOa1dNWrOuzn9Cn6zd00u8M3nNNf+lEvVW
         P06A==
X-Gm-Message-State: APjAAAXKZ61oRrAPUt/2SZ+tfJmDV3KSIfA6mlQHMPSpcRT5E6GAfgL9
        BwaJ6U2s3WQvPnltHo0NmT0Tu6hSDGg=
X-Google-Smtp-Source: APXvYqygpGq9c2w4lIgmLsyqvXpCrSuOYzBgTK7s0815uGFqTM1SCBUfjneRouEeyCYAJq6OI5kJvA==
X-Received: by 2002:adf:b60f:: with SMTP id f15mr10744344wre.283.1560783947435;
        Mon, 17 Jun 2019 08:05:47 -0700 (PDT)
Received: from planxty ([2a02:8108:1700:1960:91dd:e2f9:ed05:ee2b])
        by smtp.gmail.com with ESMTPSA id u1sm11575780wml.14.2019.06.17.08.05.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 08:05:46 -0700 (PDT)
Date:   Mon, 17 Jun 2019 17:05:39 +0200 (CEST)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc:     Joe Korty <joe.korty@concurrent-rt.com>,
        rt-users <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH 1/1] rt-tests: ssdd: Add Licence information to ssdd
In-Reply-To: <20190614193442.wrsbby4jydcoet4c@linutronix.de>
Message-ID: <alpine.LFD.2.21.1906171705110.10931@planxty>
References: <20190614113747.11565-1-jkacur@redhat.com> <20190614113747.11565-2-jkacur@redhat.com> <20190614193442.wrsbby4jydcoet4c@linutronix.de>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 14 Jun 2019, Sebastian Andrzej Siewior wrote:

> On 2019-06-14 13:37:47 [+0200], John Kacur wrote:
> > Add License Information to ssdd
> 
> > Signed-off-by: John Kacur <jkacur@redhat.com>
> > ---
> >  src/ssdd/ssdd.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/src/ssdd/ssdd.c b/src/ssdd/ssdd.c
> > index 4e293586526e..2c3a779be9f1 100644
> > --- a/src/ssdd/ssdd.c
> > +++ b/src/ssdd/ssdd.c
> > @@ -15,6 +15,13 @@
> >   *
> >   * The tracer waits on each PTRACE_SINGLESTEP with a waitpid(2)
> >   * and checks that waitpid's return values for correctness.
> > + *
> > + * This program was originally written by
> > + * Joe Korty <joe.korty@concurrent-rt.com>
> > + * This program is free software; you can redistribute it and / or modify
> > + * it under the terms of the GNU General Public License Version 2
> > + * of the licence, or (at your option) any later version
> > + * see COPYING for more information
> 
> SPDX tags is not something that you have in rt-tests, right? Because a
> standard tag would be kind of better than having yet another unique
> version of text saying that it is GPLv2-or-later.
> 
> So you could reduce this to two lines:
> - // SPDX-License-Identifier: GPL-2.0-or-later
>   top
> 
> - Author: Joe Korty <joe.korty@concurrent-rt.com>
>   Somewhere at top where the comment starts.
> 
> >   */
> >  #include <stdio.h>
> >  #include <stdlib.h>
> 
> Sebastian
> 

Thanks for the tip Sebastian, looks good to me,
I'm looking into doing this.

John
