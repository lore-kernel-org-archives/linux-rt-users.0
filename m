Return-Path: <SRS0=kQBB=2D=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5941EC43603
	for <linux-rt-users@archiver.kernel.org>; Fri, 13 Dec 2019 09:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A9C6206D8
	for <linux-rt-users@archiver.kernel.org>; Fri, 13 Dec 2019 09:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=unikie-com.20150623.gappssmtp.com header.i=@unikie-com.20150623.gappssmtp.com header.b="dINLbjLq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbfLMJIr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 13 Dec 2019 04:08:47 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42386 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfLMJIr (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 13 Dec 2019 04:08:47 -0500
Received: by mail-oi1-f195.google.com with SMTP id j22so663489oij.9
        for <linux-rt-users@vger.kernel.org>; Fri, 13 Dec 2019 01:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unikie-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w9a3SyeXscC+/eNp40AdJwoNa+fEoNsjHvpKHZ3wvcU=;
        b=dINLbjLqMc8M6k2dGSl9r9kATp2HLc2Dktm1tOAYNBtYnnQeP4eJE2wCFsfigp6iDL
         tT+ygL3uJDqIajcSs30zMsE4c0Vd5ZtUTQCOxdaI+rmu4YiON7W2csFs9NnN67VFhQRS
         GvKVaOZSOKrdQWkSIc4WQLDWoYgj0CTVd1RcuOUkgol4e0XqyAokrLwCchTc4ODIdFyT
         E9LdJ+baJqYjxWDFiIIrHirmxw+cygdbQZXcDolJFmeh2p98u1MP+7WGNhiz6CIZNBhU
         XRhC9rIXScRcUDjs8t7FXSIMz/mHcrHKQcnzJFLttdr9YTksdLSb87dB11uKDBHCprny
         AaTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w9a3SyeXscC+/eNp40AdJwoNa+fEoNsjHvpKHZ3wvcU=;
        b=crFdjT/ms347tOv/afQZ2719RQpwPwR+kN/Aq4BOQXjH6INDpk3hKITigGDn5T08M2
         Tm63PJCCkRTrTZlYu+8/Dr5H4VVFI6Dvk3OZ08MOB5l4kQVZBUztGX6L3m2z2AT/oyN/
         IkEpZs6YLDVp1z6IuwR+LQ6dvOcFsgDFO8WHhy7iogTXfQUPisKh3R9uQyvKt6CrIfj6
         ZHHWmYRwg22E58kX/WInf2pPxFKrDeCeZIoMIwjikIIjCfOApwq4GCj2nLNOzSs4qb43
         TxdwlUxfJehQc88tQXpMU5lOHzC4e2CNbVfHFdCnA7xjHqI9HBYW8BM0ZQhwJpi2l+J4
         4RyQ==
X-Gm-Message-State: APjAAAXlnOrKK45SrvSZCw/OHXqypIvDYoldg/yjgYvClWlGth1Kosdx
        nte/e0wbyk1GS/aDaAiaMMk9oyBQFjqpW9dF3E3jZw==
X-Google-Smtp-Source: APXvYqx5Sm8UxMNxDsk6Stg/SAQGa1o96E6tw7QlvRFXcbZNQiAudXOQgUCGmLunrNNGZtrtJmfotfBep0QbNZ0fKQA=
X-Received: by 2002:aca:4ad1:: with SMTP id x200mr6307758oia.104.1576228126543;
 Fri, 13 Dec 2019 01:08:46 -0800 (PST)
MIME-Version: 1.0
References: <CAJz2qXnHnw7Z9ftb6Oha5_0-R4YfUL+FhVZPNX1KKHyUkP6KNA@mail.gmail.com>
 <20191212171230.ygveclhr5xqurys7@linutronix.de>
In-Reply-To: <20191212171230.ygveclhr5xqurys7@linutronix.de>
From:   John Mathew <john.mathew@unikie.com>
Date:   Fri, 13 Dec 2019 11:08:35 +0200
Message-ID: <CAJz2qXnPquUZSeO9SWSmvLKcdhnT96KnD66F-oatdnotYkxS+A@mail.gmail.com>
Subject: Re: complete_all() with x waiters in swake_up_all_locked
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org, lukas.bulwahn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Dec 12, 2019 at 7:12 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2019-12-11 09:17:49 [+0200], John Mathew wrote:
> > Hi,
> Hi,
>
> > We are seeing the waring still appearing in the v5.0.3-rt1 tag of the
> > rt linux kernel.
>
> I didn't managed to reproduce it at the time. Now you say it works with
> 5.0-RT. I will try to give it a spin with the latest RT sometime next
> week.
>
> >
> > Has there been any further investigation in to this warning following
> > the previous discussion?
>
> Thanks for report. I didn't manage to reproduce it so no. The actual
> problem is that we are trying to figure out what a sane limit for
> complete_all() might be. Most users of complete_all() have one two
> waiters. Based on that report your max was 8 and that occurred a few
> times.

I was able to reproduce the warning on v5.2.21-rt14 which is the
latest tag on the rt-devel branch.
Here is my analysis.
What I see is that in crypto/algboss.c there is a probe being
scheduled when a notification arrives.
The probe will run a thread: cryptomgr_probe and wait for its completion.
The issue arises because a similar module is also issues a wait for
completion on the exactly same completion object (larval->completion).
The similar module is:  crypto_larval_wait in linux-rt-devel/crypto/api.c
It is casting a crypto_larval struct pointer from a crypto_alg struct
pointer which doesn't seem to have/init a completion object.
So it is actually the cryptomgr_probe thread that actually completes
both its own and the crypto_larval_wait waits and so the number of
completions exceeds the limit of 2.

This looks like an error to me.
So I created patch in the following email.
I don't think the issue is with the limit, rather a wrong usage of the
completion object.

>
> > -John
>
> Sebastian
