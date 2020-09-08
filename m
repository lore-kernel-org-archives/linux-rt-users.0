Return-Path: <SRS0=F8C2=CR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DFCC43461
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Sep 2020 19:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA58C20768
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Sep 2020 19:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oqfrOgtw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732473AbgIHTzD (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730637AbgIHPhg (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 8 Sep 2020 11:37:36 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA87C0612F5
        for <linux-rt-users@vger.kernel.org>; Tue,  8 Sep 2020 08:23:30 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id c18so1330187qtw.5
        for <linux-rt-users@vger.kernel.org>; Tue, 08 Sep 2020 08:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=iwbHfJoHiXM6iXxBEfFwyfhgP+5mNTO8+IO5bljLYwA=;
        b=oqfrOgtwEAjx3eqwkXvSAAydQEBUHNOPCaNoK6PFrz2ntPkXhq1tyH8PH0jh+7OxYx
         olUTifChrn9viSEVHvJUEyo0ub4iJHqm7Vorx4NMWDU900YCooZSXzMKBrUfk7Y7tVKt
         9dJSaLGWnRuSJ2mL9DLRtNwXNDQQi5Gb1d0jdF1vJhIktasIFd5vdB6pvw0HLCbggJXE
         zeS0Wes6DJ1zh7o+H/9LEeTXUtm/G1w7VzaJegQ62g0EX+UpC6GXMxgMDMB8fM5VPTM/
         Tavj5J/f2RoEdVwvN9i0z0MnCyQMC9QnPXJhn4EAxI7SJYEp+PKqBzhx1gQBWiWW78fs
         K/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=iwbHfJoHiXM6iXxBEfFwyfhgP+5mNTO8+IO5bljLYwA=;
        b=MJKweTnkHGuHdE1ENQUziVD9zeZuB5kX9gLBp5u5Q1Qe/7PV2rsd3iwB3O6xdru6pi
         Y/+lsqVEuHVTzNr+sDINCc7mEeofAPrJzGALe5JzGgEj8UujRkAzY8NvOmkx4x9eJjoI
         +FHjpunDCYXQP8zS9P0HMrAaxctp6dOAgDYnCZPTx94ZnZ5grBmiTuOlSoyw1uOoFQmR
         u+0jvarDW4Uxc/jtXVo2e5ATtobvJZY5Cevy+RjvG65nosXh8dnuVRbBP/C1vNc9iGc3
         dpTbGsoVxtNDAX0ndQZSiHlDIzAnh5xj5aVdJ+5n8s07sWYPGmu5ei34kmgPQPYgbuAk
         wWLQ==
X-Gm-Message-State: AOAM5322YPmIlFTX7KuUXI6Mh8fNUroO3SMLEZ9IdV6JRcjCT/UIoKxI
        YO2RzsL55x9/IWgbkpGuf2z5vQii4s4=
X-Google-Smtp-Source: ABdhPJwIoVdjd0liIwZJ1qAXbKsosNDtLmG9PqlnAIMmJXPg3QnpaFOo6vcmCw19tuGClv7JXsPQFQ==
X-Received: by 2002:ac8:4c8e:: with SMTP id j14mr610803qtv.340.1599578610171;
        Tue, 08 Sep 2020 08:23:30 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-180.dsl.bell.ca. [184.147.140.180])
        by smtp.gmail.com with ESMTPSA id g18sm14487193qtu.69.2020.09.08.08.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 08:23:29 -0700 (PDT)
Date:   Tue, 8 Sep 2020 11:23:21 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@fionn
To:     Daniel Wagner <wagi@monom.org>
cc:     Clark Williams <williams@redhat.com>,
        Daniel Wagner <dwagner@suse.de>, linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests 0/4] Streamlining code base?
In-Reply-To: <20200907081313.vyw2ykaio6abfxfx@beryllium.lan>
Message-ID: <alpine.LFD.2.23.451.2009081104480.3804@fionn>
References: <20200902082725.20037-1-dwagner@suse.de> <20200903203948.4d2e5370@tagon> <20200904063123.uu37gp4ipom64ao6@beryllium.lan> <alpine.LFD.2.23.451.2009041112370.4562@fionn> <20200907081313.vyw2ykaio6abfxfx@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Mon, 7 Sep 2020, Daniel Wagner wrote:

> On Fri, Sep 04, 2020 at 11:40:06AM -0400, John Kacur wrote:
> > I'm not saying this is the only legitimate approach, but I would like to 
> > keep the individual tools lightweight in rt-tests, so that you could run 
> > them individually in the embedded space as well as on large machines.
> 
> Sure, though I still think it would make sense to keep it flexible and
> have a compile switch if needed. I'd like to avoid additional steps
> between the measurement and interpretation. Any time we want to
> add/change a thing, we need to touch more places.
> 
> Furthermore, if you look at my implementation for the JSON output of
> jitterdebugger is really small:
> 
> https://github.com/igaw/jitterdebugger/blob/master/jitterdebugger.c#L158
> 
> Adding a XML version for this should be in the same size.
> 
> If you insist on a single format (XML) that's also okay for me. Python
> ships all the necessary libraries these days. Though the JSON format is
> simpler to transform into native data types such as dictionaries and
> lists, IMO.

If you just read a text stream like rteval does, and store in a native 
data type, then it is trivial to output any data format.

However, your implementation for your jitterdebugger is truly small,
I don't want to stomp on your creativity, so spin off a git branch and go 
to it. I can be persuaded.

John
