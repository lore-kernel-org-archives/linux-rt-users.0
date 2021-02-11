Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6237BC433E0
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Feb 2021 04:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 254FE64E79
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Feb 2021 04:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbhBKEdf (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 10 Feb 2021 23:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhBKEde (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 10 Feb 2021 23:33:34 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B217EC061574
        for <linux-rt-users@vger.kernel.org>; Wed, 10 Feb 2021 20:32:54 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id e11so3330631qtg.6
        for <linux-rt-users@vger.kernel.org>; Wed, 10 Feb 2021 20:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=r18VjbhUIyuCdXZWH6YxFp+83+a9B0W6EYLNLmOVHnY=;
        b=TZxSIGiPpz4RHzZuZBOLBm2iqRaNBEnHTCZInR8ALrWMNLxaR9HBxcYuDv9Kq/yLPz
         1vK8dncAQNzC7JDtQzazKI+gwgABhkxBhxNLXMBGRE4s8FuRYOHPFd5OutRaTe1w5rPV
         pYJQdsBgdAzAi0OdHp+m1A9ZYxrfRr0kJ7vLz68DMSGDjae+mf+C0+T4B/TEiQK2MxXg
         2Ja1oVsWmi0TftfOHACASJEm1d9sbt3e4fxuiNU2Z0Jxpso8YcoViNQtnqFCrxLHGYiu
         KMY2c3a6h/rpr0c0tH3qZD30wcaJUcdbAvM/MmXRwg+TylL3HGv+zQYhJEWXRWSO3r5M
         5qbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=r18VjbhUIyuCdXZWH6YxFp+83+a9B0W6EYLNLmOVHnY=;
        b=mTGNNA0ApyGZ1SA0s0PyStiHLZY1qnMRVyI5kkG1Fuw6YYfjX54NCSXUOthNiEPN9o
         E6kFCcIucmhy0oyvxO+BfJemfqneANY1lk3zyjzOnjKI+nm6sY14sQNHTBSPNQ+E3jLZ
         mo7aLZMxLsb996YYCEDPMq8tsj3djKcCRK+oMZaMcvDSTnkiXcS6CflARS5knkS3F56X
         HE30EP5SGtaVENheDB6p+HPOdqiSxbiDxcTjxc9iYDjRzSU+kL+5/UROIzSwrI2neYM0
         BjKKE67VunjMNAclCUIwcHf9Nj7PURDne0ctsrOJdMMlzH0GWKdWuGLrVbNX/h1f9l6b
         lvvA==
X-Gm-Message-State: AOAM530HkjWacahXQAMYlodY1X3M+28fjM6BdFFTsid3pWMLlks5sYlO
        j04rnmTR/XBsV2HmSFGyWsc=
X-Google-Smtp-Source: ABdhPJy4Z2H/7Jx3ykkAjs28DYdek0oRS+6sSNTg0NIt2wV2ZsT94wPgmHWdy/VMuNAbyDZUSGLLrA==
X-Received: by 2002:a05:622a:254:: with SMTP id c20mr6106242qtx.387.1613017973925;
        Wed, 10 Feb 2021 20:32:53 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id 6sm3141951qkv.24.2021.02.10.20.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 20:32:53 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Wed, 10 Feb 2021 23:32:52 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH rt-tests 1/2] oslat: Print version string
In-Reply-To: <eaf911f6-1e4b-ce13-7b26-45b01854f7e7@redhat.com>
Message-ID: <cc83af39-8d37-4ece-d04c-77a415f705@redhat.com>
References: <20210210165407.9770-1-dwagner@suse.de> <20210210165407.9770-2-dwagner@suse.de> <9c2916d8-14ab-3465-97fa-2a9b52c83b1e@redhat.com> <20210210173353.pqeu2sm33qs7hjna@beryllium.lan> <7a61c0fd-90fe-69a4-5d26-4b688e2147b5@redhat.com>
 <20210210182114.xbxw62gj6n6ox6pt@beryllium.lan> <eaf911f6-1e4b-ce13-7b26-45b01854f7e7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 10 Feb 2021, John Kacur wrote:

> 
> 
> On Wed, 10 Feb 2021, Daniel Wagner wrote:
> 
> > On Wed, Feb 10, 2021 at 12:59:29PM -0500, John Kacur wrote:
> > > Are you really telling me you won't fix a problem you introduced unless
> > > I first take all the other code you would like to get in rt-tests?
> > 
> > I've already done the long option support in the JSON series. It would
> > make my life way simpler if those bits would be in the tree.
> > 
> > I think, the simplest fix for now is to temporarily a local fix for
> > oslat.
> > 
> 
> Just add a fix onto for the oslat problem on the end of your series
> I'll be done the review soon.
> 
> If we need to do any backporting then we'll do that.
> 
> Cheers, Thanks
> 
> John
> 


I rewound your patches in git, and applied the two oslat fixes and
reapplied your patches with a git interactive rebase, and then I pushed
them for others to try before I'm ready to push them upstream

Anyone who wants to try the new json stuff it's in a branch called

unstable/devel/rt-numa-json

The numa changes need more testing before integrate them, but 
this should make it easier for others to try it out.

John
