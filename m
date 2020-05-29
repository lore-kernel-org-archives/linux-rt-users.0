Return-Path: <SRS0=xga9=7L=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75FDC433E0
	for <linux-rt-users@archiver.kernel.org>; Fri, 29 May 2020 15:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85B4A20776
	for <linux-rt-users@archiver.kernel.org>; Fri, 29 May 2020 15:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYXSpijQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgE2Piw (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 29 May 2020 11:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbgE2Piv (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 29 May 2020 11:38:51 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CC0C03E969;
        Fri, 29 May 2020 08:38:51 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x6so4081070wrm.13;
        Fri, 29 May 2020 08:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1tEbznE7GPyi5vxGkUdkj2fXduM4GFl/YrBsPKCo9CA=;
        b=TYXSpijQp6tJoiJdhYEW4Jw3jvpk8DkeMWyyGdINQljk/2dgA76uZ2NP4J8puHM4Ma
         aFkbcLf9yZOLNbS/2YcCqd+QG7Fv/e9UEFn3IBIPdaeXx6kfMI/gzWgv4tmsU6kkGzND
         CyrvUnZUtaknH8RNFC1KWKnUgu5nigiIxPU37jGxN9rNha0skrECqjKQnKM7sa/kkxQ8
         9j2pgKjj7kqGJeqYO3E4pXhdIk397f7A9nGi0ySqynIZNUxqQvCf2VysJJ0Vul06Spty
         8cpGNa6q3HPBnVnB/ejHcKg1wtcdcBAd6AEIrfvAjqIb6E89befpUx5s14fIfkK0ClMu
         I14g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1tEbznE7GPyi5vxGkUdkj2fXduM4GFl/YrBsPKCo9CA=;
        b=cy/5PWjN6kTk+qiYnQHJatDvWYAxTKC2vGWagZQBheGaei9YbGXgzp/NK524ToiglS
         mV0opzPptVYH3T5oLotCQRI42qHfBvGG+61DrcpewRQnGQSctnkDiLQR0Xin7rnPcZGY
         DNhkrOYZUZv99SEaxCQNM1dvbJvAN9geolp+jloew59ia9MAliMlrj3X9EPo9gyle33Z
         50JJUQhmX2dTmCq16rZGJPK5B37Vvni1FwgmPtrMJjs5etA1KGakwwjHnXhKmjPlXAYP
         yjXvpPe+wZrQdIglRotb8Ws5nh/l3Q6V/t7MihAIWtlYa6ESd6JqBTnWOP29sKye6qcQ
         ovKA==
X-Gm-Message-State: AOAM530vQ8pCtu04UFYTqfMJblMv2IMziEEw3otsCUCFXXKgJqOjrOVE
        iPpb/NHH0loEI+CvDncdTmPcSYyEiWPgHq+lBmc=
X-Google-Smtp-Source: ABdhPJyZNIdABa6nkZrg1PC1bLAqdRPquIUr1n3qlF/UVjWLcB7D8TnBcdFc8Q5S672q2uJe2U6oGQSNOWkyQaoaIjY=
X-Received: by 2002:adf:f552:: with SMTP id j18mr8811605wrp.279.1590766730133;
 Fri, 29 May 2020 08:38:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAD4b4WK9W+dNZZ_WPt-9ZNpSHvyxdwPW86Rtq4AKOONuvyR37A@mail.gmail.com>
 <20200529131452.pgj7mx7xaz7n4kz3@linutronix.de>
In-Reply-To: <20200529131452.pgj7mx7xaz7n4kz3@linutronix.de>
From:   Mark Marshall <markmarshall14@gmail.com>
Date:   Fri, 29 May 2020 17:38:39 +0200
Message-ID: <CAD4b4WLS36JKepz31m98Z3Ve05d63GnfBGsuuWRXpjXZqPoBrA@mail.gmail.com>
Subject: Re: Kernel crash due to memory corruption with v5.4.26-rt17 and
 PowerPC e500
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Mark Marshall <mark.marshall@omicronenergy.com>,
        thomas.graziadei@omicronenergy.com,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Sebastian & list,

I had assumed that my e-mail had got lost or overlooked, I was meaning to
post a follow up message this week...

All I could find from the debugging and tracing that we added was that
something was going wrong with the mm data structures somewhere in the
exec code.  In the end I just spent a week or two pouring over the diffs
of this code between the versions that I new worked and didn't work.

I eventually found the culprit.  On the working kernel versions there is
a patch called "mm: Protect activate_mm() by preempt_[disable&enable]_rt()"=
.
This is commit f0b4a9cb253a on the V4.19.82-rt30 branch, for instance.
Although the commit message talks about ARM, it seems that we need this for
PowerPC too (I guess, any PowerPC with the "nohash" MMU?).

Could you please add this commit back to the RT branch?  I'm not sure how
to find out the history of this commit.  For instance, why has it been
removed from the RT patchset?  How are these things tracked, generally?

Best regards,
Mark

On Fri, 29 May 2020 at 15:14, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2020-05-04 11:40:08 [+0200], Mark Marshall wrote:
> > The easiest way we have found to reproduce the crash is to repeatedly
> > insert and then remove a module.  The crash then appears to be related
> > to either paging in the module or in exiting the mdev process.  (The
> > crash does also happen at other times, but it is hard to reproduce
> > reliably then).  This simple script will almost always crash:
> >
> >    for i in $(seq 1000) ; do echo $i ; modprobe crc7 ; rmmod crc7 ; don=
e
>
> So I tried that on 5.6.14-rt7 with the qemu version of e500 (the SMP and
> UP version). No luck. I don't have anything with real hardware.
> Could you share the .config in case this is related?
>
> > (The crc7 module is chosen as it is small and simple.  Any module will
> > work / crash).
> >
> > We have tried kernels v5.0, v5.2 and v5.6.  The v5.0 and v5.2 kernels
> > do not show the problem.  The v5.6 kernel does show the problem.
> > Switching of RT fixes the problem.
> >
> > I have reduced the functionality in the kernel to a bare minimum
> > (removing networking, USB and PCI, as we have some out-of-tree patches
> > in those areas) and we still get the crash.
> =E2=80=A6
> > I have added some debugging code where the mm_struct and
> > vma_area_struct have "poision" values at the start and the end, and
> > this seems to show that the vma_area_struct is getting corrupted, but
> > I'm not able to see where.
>
> oh.
>
> > We have switched on all of the debugging that we can, including
> > KASAN, and this shows nothing.
> >
> >
> > Can anyone help us?  What can we try next?  Is anyone using the e500
> > with the RT kernel?  Does anyone have any idea how to debug problems
> > related to the error message "Bad rss-counter state"?
> >
> > Any help or advice would be most gratefully received.
>
> I don't have any ideas. You could try to apply only a part of the RT
> patch and see if it problem is still there. If you are lucky you find
> the patch that introduces the problem. If not, the problem appears with
> the RT switch=E2=80=A6
>
> > Many thanks,
> > Mark Marshall and Thomas Graziadei
>
> Sebastian
