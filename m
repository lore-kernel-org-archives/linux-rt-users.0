Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB852C433E6
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 16:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B7EA64E60
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 16:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhBSQlE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Feb 2021 11:41:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36647 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229947AbhBSQlA (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Feb 2021 11:41:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613752774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wfduUC+PAUbNGKV9ed1nYdOucl4vC6YthALNnfO4m7o=;
        b=SROdWD9M6lKva4KWDvp0jqMSboixMwzBefm4DouNA649B61x3wJbh34KwRrIYA2jAfQmTE
        G/gVylP1lMDqqLMCoHKScfmlq6oykIztsDVV+EZMO2285wsNEkI3wCKXNo5v6jF+8foSC5
        Cs4OMU/HAaTJwzfXnUIKAV4j44Ourpw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-RNcSMBw6Pa265wTED0UB-A-1; Fri, 19 Feb 2021 11:39:32 -0500
X-MC-Unique: RNcSMBw6Pa265wTED0UB-A-1
Received: by mail-qv1-f69.google.com with SMTP id j6so3519548qvo.11
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Feb 2021 08:39:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wfduUC+PAUbNGKV9ed1nYdOucl4vC6YthALNnfO4m7o=;
        b=oo/5sBR3zJB9z7y6SlID5jjEFiypwAlnoGm95ZGA+ZPXnAPxMqcpYfuYPksxlkMr06
         UTJ6iGWSUe2rJWzZmtJAdlXTzVd1nmGv+gxiRI/H88EzGKJB0W8TDBOUhM0PzGekeXcM
         v6kxTkpmL+PwkwXizOkYvWqEm0Aq1eM7CXwnwOpiKKi4KiRhXpMDNNO1nlpNsy2mQddN
         /l51YTV9YEAKfppjT3hf0SgFaQVey4tU9KBjU3mbdiBLGTQKC62Leb3NqevZYgwm+4rl
         J5wKHnr7tx4n0ksFODb1f/DYzBfKglRJQJFdbZPEfo6jL0n0biYOpycQWb84Hs8ypojA
         eZnQ==
X-Gm-Message-State: AOAM533mHIenzpZogAIF/iEqgJpg4xkJUOjeEskZrquaAjMYkqUaE86N
        AUwPMeBPIJPgTlF7s3uoHgeY+DTk6qZEgb8FqxRFjsPitPdq0EpTS6QC0/RmtdH3grPD8dxnDsc
        UqSwn+MWl94FTh2l1nKAypZyW5aQ=
X-Received: by 2002:a0c:c193:: with SMTP id n19mr2265553qvh.3.1613752772287;
        Fri, 19 Feb 2021 08:39:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzNDdWBPvA3RSAa0bkwaYUTBE5SrYfW70K03Ng/P1+fMil7EAjy1o1Z14CX8rRiLyAoHvRCMg==
X-Received: by 2002:a0c:c193:: with SMTP id n19mr2265535qvh.3.1613752772117;
        Fri, 19 Feb 2021 08:39:32 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-25-174-95-95-253.dsl.bell.ca. [174.95.95.253])
        by smtp.gmail.com with ESMTPSA id z28sm6789773qkj.72.2021.02.19.08.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 08:39:31 -0800 (PST)
Date:   Fri, 19 Feb 2021 11:39:30 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-rt-users@vger.kernel.org,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Pradipta Kumar Sahoo <psahoo@redhat.com>,
        Mike Stowell <mstowell@redhat.com>
Subject: Re: [PATCH] oslat: Fix --cpu-list won't allow to schedule on all
 possible cores
Message-ID: <20210219163930.GG6669@xz-x1>
References: <20210218192729.116427-1-peterx@redhat.com>
 <20210219081611.xsugonlz7dl4zhvx@beryllium.lan>
 <20210219152417.GE6669@xz-x1>
 <20210219162019.giw2yy25vjuzc56f@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210219162019.giw2yy25vjuzc56f@beryllium.lan>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Daniel,

On Fri, Feb 19, 2021 at 05:20:19PM +0100, Daniel Wagner wrote:
> On Fri, Feb 19, 2021 at 10:24:17AM -0500, Peter Xu wrote:
> > Yes I explicitly avoided touching parse_cpumask because I don't want to change
> > behavior of other tools if I'm not confident with that.  Would above two
> > patches fix oslat too (which I didn't check)?  If so, I'll be fine to have this
> > patch dropped.  Otherwise I tend to prefer fixing oslat first.  We can further
> > rework the common code, but if existing tools are fine, then I don't think it's
> > a bugfix, so no need to rush.  While I'll count this patch as a real bugfix, so
> > I'd hope we could consider merging it earlier.
> 
> As I said, I would really appreciated if all tools behave the same
> way. Having oslat be special is going to be pain in the long run. Just
> update parse_cpumask, it's not that difficult :)

Oslat is broken now after the numa rework.  Frankly I'm surprised it's broken
so quickly with just a few commits and actually with no new feature at all but
pure cleanups.  Again I still appreciate all your work on this but I don't
really appreciate a lot for having it broken..

Now I tried to fix it but it seems you don't really like my fix.

Would you propose yours instead?  I would be more than glad if your version is
better then I'm happy to drop mine.  Otherwise I'll still prefer to have this
patch merged to unbreak it first.

Thanks,

-- 
Peter Xu

