Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78B2C433E0
	for <linux-rt-users@archiver.kernel.org>; Mon, 21 Dec 2020 05:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 887B222CB9
	for <linux-rt-users@archiver.kernel.org>; Mon, 21 Dec 2020 05:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgLUF1C (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 21 Dec 2020 00:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbgLUF1B (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 21 Dec 2020 00:27:01 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8C1C0613D3
        for <linux-rt-users@vger.kernel.org>; Sun, 20 Dec 2020 21:26:20 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id o17so20786450lfg.4
        for <linux-rt-users@vger.kernel.org>; Sun, 20 Dec 2020 21:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=byrpBCvV2Mo30UL5TxsnH0oAE8+BEWJNL9oAawt1w4c=;
        b=j6ePJHzo/IUtwD657RPfOjpHBMZjTu1Pc/u+UZ5BhBtEh3bOMskBucXvERewIKlY78
         y3UA41CydWyccocOO57jR/zlX6kY8bazs33EiTzEuSYYqLby2Cmm0ls8cJmhuyQdDby6
         NFKCF+sOznfYi/1BgPj1tvP1iutmQouO+mSyijLhY3LzLhqcQxxWr7XIBPrleLDkx+El
         P53SwFCSuLVuypbucRAuoO1hC34qkHk2/QpTJ15oITS230H9BYts+NcLdZgFFtCesYmN
         ZsQoKvEbk4z6KkKF37Skwp0RCXR4cTM+Qfn7yLN3VTJ4jdqRbuwUMf/NeIS4UWtUskyQ
         PzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=byrpBCvV2Mo30UL5TxsnH0oAE8+BEWJNL9oAawt1w4c=;
        b=jVrQaaDOd/ufia/VbsKDIJNER6GuH7aM1+yREJJSLU/PERVwUPbvhpicKyL1wVzlGy
         tA6A8i1mNkWt0Kqv9JwrhQYIKpkg/0jSC3cM30+gIQw+2jagzs00ZAMJ4XgM/SkHH6f1
         KZDIEROvACaom8knVLb01K5j5ZbBYg/KvLeAWFKQiMuY/uPjoUDcWFUXpyQlowo8bz46
         EetQ3ZOrRUyajVFtBYb0FkQQ9gCEtqeADx1xQSVQZOzdg5JbPXhr+qcYwsGuEgCoI2IR
         avi2mrzWg9UuFF7rXsTynFy+GNvAaNgTMh+nwwu7Je3FaOIl+98uehBI0FZxA2yDg3HN
         qxDw==
X-Gm-Message-State: AOAM533EcIMpVmOv8kn//Xl4b38fKaqwp+SUes8QREyKwkLztucrUcbn
        QXrc7gdFsfEeSSF/ZP3zCXDb4eDJZOOclUMslAa44I8EWaKOZA==
X-Google-Smtp-Source: ABdhPJxcemPdJ8K9OsJgQ7rHumnM1Rhj0rfHAtaVuwANlOVIJfPcp51KL4VVaTEVitDScRm8ARZ/RoBJW5ZQSnN2ylk=
X-Received: by 2002:a2e:b8cd:: with SMTP id s13mr5894976ljp.26.1608509348450;
 Sun, 20 Dec 2020 16:09:08 -0800 (PST)
MIME-Version: 1.0
References: <CAD56B7dKyiUBQctrrpLYU6XM5cjfXD10E1fFMU5GpAe00g_TZQ@mail.gmail.com>
 <20201218135230.hb25ii2a3sbqrucw@linutronix.de> <CAFzL-7ujcJ4KDbgVoq-N6GRTWfemCA6hfqOzBGwcaDzt=0rGzQ@mail.gmail.com>
 <20201218164919.nklchwwxzzoi36bt@linutronix.de>
In-Reply-To: <20201218164919.nklchwwxzzoi36bt@linutronix.de>
From:   Paul Thomas <pthomas8589@gmail.com>
Date:   Sun, 20 Dec 2020 19:08:57 -0500
Message-ID: <CAD56B7eRTKdAktuJNSuV4rfYTQCMYMBFuCzwxEzPCtx4R4gwwA@mail.gmail.com>
Subject: Re: net latency, long wait for softirq_entry
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Alison Chaiken <achaiken@aurora.tech>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Dec 18, 2020 at 11:49 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2020-12-18 08:18:05 [-0800], Alison Chaiken wrote:
> > > Having a thread to run the tick-timer would avoid that scenario.
> > >
> >
> > Didn't ktimersoftd used to be such a thread?   It's still not entirely
> > clear to me at least why it was removed.
>
> Yes, ktimersoftd was such a thread that is why I am suggesting it. It
> would be probably just a quick duct tape.
>
> All of the reasons why it has been introduced disappeared in the
> previous softirq rework. The NAPI handover works, posixtimer need no
> additional love and so on (the original motivation to have it).
>
> The problem, that Paul reported, should also exist for !RT with the
> `threadirqs' switch (untested but it is the same code).
> It is worth noting that in his report the latency was increased because
> the timer-tick woke the ksoftirqd thread. Rightfully you could say that
> this would not have happen with the timer thread.
> However, the usb-storage driver (just to pick an easy to trigger
> scenario for my case) also wakes the ksoftirqd if a transfer completes.
> If the ethernet interrupt fires before ksoftirqd completes its task then
> we have the same situation without the involvement of the timer :)
>
> > -- Alison Chaiken
> >    Aurora Innovation
>
> Sebastian

Hi Everyone,

Thanks for taking the time to look at this, it's appreciated! For now,
setting the ksoftirqd priority high on the same core as the interrupt
seems to greatly improve things, thanks for the suggestion Grygorii.

A few of other notes on items that seem to affect latency in a related
use case. First, if a sibling thread of an application calls clone
(e.g. a system() call) then this seems to prevent all the threads of
the application from being scheduled temporarily. Second, I saw a
couple of instances where one thread seemed to get migrated to another
core, alternating with the migration thread (~40 times) and then
ultimately running on a different core. Using taskset to set the CPU
affinity of the offending thread helped this. Third, the PHC tx
timestamping (but not the rx) can cause latency issues (using the macb
driver), but this is the least investigated of the group.

thanks,
Paul
