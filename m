Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1F5C43334
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 Jun 2022 12:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245469AbiFIMgO (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 9 Jun 2022 08:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245198AbiFIMgI (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 9 Jun 2022 08:36:08 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A5B22BCF
        for <linux-rt-users@vger.kernel.org>; Thu,  9 Jun 2022 05:36:03 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id g6so4142668vsb.2
        for <linux-rt-users@vger.kernel.org>; Thu, 09 Jun 2022 05:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eiMHAFjn0WwgYtz792y0NtUfQdsIHCoaQzB4us4jNRQ=;
        b=iLq8XV+Y9Fd5qJ2vYC93yCNBMth+L7qpHfgrGQmHP/QQVz5HJLDyD4o3JtBijeEcNd
         epN0nyRCPYtxD57MTApYgw+OJcjXuYLxFc0T4Ft3F0cBK1g8w1nY7EArCEk26tt0mGCN
         hrM91i9jEQ7SFbInMolNhFWwybvbWiVmx74gotxEwFh9wn1R9DewZvNhoLFlJC7gHcff
         ReVJya8AyZpKeY0BjhwVGoqYsf7h/E/zopEj8KqxgwHOsxttCYrwaiICdAgTDjWLXJ4a
         ReiquFOulrC0kKcdPLuOCkMW25o2Xke6A/zYtTsXS6Ku3nCtzy5Ed4xLWEwX92dpajg8
         Wz5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eiMHAFjn0WwgYtz792y0NtUfQdsIHCoaQzB4us4jNRQ=;
        b=aIrDoBlmNLzAZu8zhHRE35E/Fwo30+vskgQ9N+pRxpUtN0lfcosipejcBQWUpFWE0H
         Dp1yVl6iJtXITp/L4Sh1/yl21tQNuLCDCHN8Or5XCW8eq97zELAi6Kus3n0UD/dtZrF8
         GQI+kwfMx9loAoryGmA/BKMK4sM5sTDB5JaGv0+UZnqILBQeT1g6boL/na2JJv651awA
         bQPRnhpFnJsoK6ti5rhUvc9PeMSF5bDkEjhsqL1ix77m95KKOHyzFrp0fs+h+4+aWdP7
         P1x+NrzVPzoUdpvKmmCmqunrieOZkEkgNGp+Ecm6+d0LS7rXDgbFQFjkn+7j9bd49w8i
         ucYg==
X-Gm-Message-State: AOAM530Wmds9a2gQ+okqZRqR0IMn5/vz/38MeLwSqhMJEJirGYIWL3j4
        JWhT+jGcyR0OPiJFfYg8PTN/trQawEFpQVWrHLADlwUlkKmJjw==
X-Google-Smtp-Source: ABdhPJwIzOfmq4QVsMgdHdRTGV7DNxZuHshFlSdTBjO2pYY1oKrvd2w8uIvr4+jI4bbUDpDk7/T0qX91AK9RHDU6xh4=
X-Received: by 2002:a67:1985:0:b0:33b:b447:8094 with SMTP id
 127-20020a671985000000b0033bb4478094mr17980410vsz.5.1654778162195; Thu, 09
 Jun 2022 05:36:02 -0700 (PDT)
MIME-Version: 1.0
References: <CA+1+E3Wj9Aw7VP1955XhxNd7YOXO+4VM0tQ_z+z8n08GKirwSg@mail.gmail.com>
 <CA+1+E3WHxbcZtHLPueffS1B4K3W3=_dcvg1PYfR5sY3To2YXOQ@mail.gmail.com> <YqHMbD6AKwNZBGvc@linutronix.de>
In-Reply-To: <YqHMbD6AKwNZBGvc@linutronix.de>
From:   Gautam Thaker <ghthaker@gmail.com>
Date:   Thu, 9 Jun 2022 08:35:51 -0400
Message-ID: <CA+1+E3WvT04GKtntMH2XaSUBmPQ6_4M+sNs6iy4u_YDucr36LQ@mail.gmail.com>
Subject: Re: using a "-M" option on cyclictest defeats the "-D 30" option
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

My apologies. I was using "cyclictest" from git repository:

node-0> git remote -vv
origin git://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git (fetch)
origin git://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git (push)

And I was on stable/1.0   branch!!  (I had thought pointing to repo in
kernel.org I would be current, but I should have checked.)

I compiled version 2.3  (tip of "main" branch) and it works as expected.

GHT

On Thu, Jun 9, 2022 at 6:33 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2022-06-04 10:48:21 [-0400], Gautam Thaker wrote:
> > I have noticed that
> >
> > sudo time ./cyclictest -S -D 30
> >
> > properly completes the test and exits in 30 seconds. However,
> >
> > doing:
> >
> > sudo time ./cyclictest -S -D 30 -M
> >
> > the test never stops, I have to control-C out of it. Is this intended
> > behavior? The man page did not say anything about this. I would like
> > to use both -D <many_hours>   and -M together.
>
> It works for v2.2. What version do you have? I tested it with 5 secs but
> I would expect that it behaves the same way for 30 secs.
>
> > Thanks for any comments.
>
> Sebastian
