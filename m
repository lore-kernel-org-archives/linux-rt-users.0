Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60133C43333
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Mar 2021 15:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 309AD64F8F
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Mar 2021 15:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbhCQPvc (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 17 Mar 2021 11:51:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57041 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232422AbhCQPvN (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 17 Mar 2021 11:51:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615996272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DqKevBcNqMErCo+CTkM8Q0YiYoXuyCmX+2Pm0IgF2vw=;
        b=afKIVf/JJTEVRg+aGhE3C5AyKxCHxnq1OnPF2QnMX6eKZPEsfmG2UVtkcmF+cIIs3IuTad
        Wr0l6Qu18ZGYNh30vO8gOK7bu6Xqq95MkqvTFG7NDmtlB8O/iH0hx6GzIPA1Q7LdqLWi6B
        uk7MwxSWF4AFpmhjRWfYgvxCLXXXWIg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-aJXurqIdNMKDerc0aQ6vCg-1; Wed, 17 Mar 2021 11:21:03 -0400
X-MC-Unique: aJXurqIdNMKDerc0aQ6vCg-1
Received: by mail-qk1-f200.google.com with SMTP id k188so11484813qkb.5
        for <linux-rt-users@vger.kernel.org>; Wed, 17 Mar 2021 08:21:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DqKevBcNqMErCo+CTkM8Q0YiYoXuyCmX+2Pm0IgF2vw=;
        b=sTqO9VcT21moEs8G4BYryY81eJds3LER/1OaQZzyw0RQZot5F9FUB2V1YzzfRUpdZ7
         X1sLOdy9DuC+u/q5jkQtybfwogA1xCl06VJlhczjembM6RGTSLVLXu9HQtbLDaoklhgT
         adXRd8b0SgRT0IikRb0YSeY8XUvkIRRvAjALrVbJvmBQ4Irs/q202oTAIlZM5dOwDN8s
         1cF1/EeCzTLQOeS4lvjJ9B/9nkB9dY1CNIDOKbCUVr7IHKrRBEpNYdK9u50H6RWJjGop
         v6kC4cdZKUIg//bCW5yewrAb9rLUlIbpT1qnD3NpGGZSRbafHOckgpbIOit8h+Mcww9X
         g81Q==
X-Gm-Message-State: AOAM532We4x4cdtLZ0p6sN74M6ZyKDuRAyGiW3xY/NtUXFwvhH7XAlF8
        eR3BKozIGKKbdU850JrKdZMWmOUGzdh2akC13pHdFrV2cPX2A3GUiAkAJOL2nABXSSX9Sscj4YC
        DRfYN6fXQTjGYglY2IV0qLQIh+D8=
X-Received: by 2002:a05:620a:a8b:: with SMTP id v11mr5042463qkg.414.1615994463062;
        Wed, 17 Mar 2021 08:21:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw3LpkOT/SMeVNhaAz468aeZAH0nL5ViUnxGs4MN+LcumybNry+z3nWqz3CNY0ObWLTmbNPqQ==
X-Received: by 2002:a05:620a:a8b:: with SMTP id v11mr5042436qkg.414.1615994462740;
        Wed, 17 Mar 2021 08:21:02 -0700 (PDT)
Received: from xz-x1 ([142.126.89.138])
        by smtp.gmail.com with ESMTPSA id w6sm2015773qtt.96.2021.03.17.08.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 08:21:02 -0700 (PDT)
Date:   Wed, 17 Mar 2021 11:21:00 -0400
From:   Peter Xu <peterx@redhat.com>
To:     John Kacur <jkacur@redhat.com>
Cc:     Daniel Wagner <wagi@monom.org>, linux-rt-users@vger.kernel.org,
        Clark Williams <williams@redhat.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH] rt-tests: Drop use_current_cpuset() check
Message-ID: <20210317152100.GL395976@xz-x1>
References: <20210315193707.359702-1-peterx@redhat.com>
 <20210316081826.bthxqja6shbcp36j@beryllium.lan>
 <20210316200705.GC395976@xz-x1>
 <20210317074903.5lskayjwylnvuhks@beryllium.lan>
 <20210317125147.GH395976@xz-x1>
 <7882bec5-be12-267f-94c1-3b7c21193686@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7882bec5-be12-267f-94c1-3b7c21193686@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Mar 17, 2021 at 11:08:31AM -0400, John Kacur wrote:
> 
> 
> On Wed, 17 Mar 2021, Peter Xu wrote:
> 
> > Hi, Daniel,
> > 
> > On Wed, Mar 17, 2021 at 08:49:03AM +0100, Daniel Wagner wrote:
> > > On Tue, Mar 16, 2021 at 04:07:05PM -0400, Peter Xu wrote:
> > > > I think what I'm missing is why we had such a restriction.  Quotting from the
> > > > commit ID:
> > > 
> > > IIRC, the current behavior allows the process to be placed into a cgroup
> > > with a subset of CPUs and you just can do 'cyclictest -a -t'. Process
> > > should not ignore external configuration. That's my whole point here.
> > 
> > In that case again I think a sane solution is not to check the cpu list in
> > every single tool we use, because even if we do that for all tools in rt-teets
> > repo, we can't guarantee to have this check for the rest tools to not ignore
> > this restriction.
> > 
> > A simple example is: what if the user specified "taskset -c $CPU cyclictest -a
> > $CPU -t 1 ..." where $CPU is not in the allowed list of current bash?  As long
> > as the taskset would work the so-called "environment" will be changed before
> > even loading cyclictest.
> > 
> > If you see that's the point I said we should fail at the same check point of
> > sched_setaffinity() rather than checking it explicitly in the tool, because
> > if we want a real-world restriction that's the only place I think it's possible..
> > 
> > But I'm not a cgroup/container guy, please correct me if I understood.
> > 
> > -- 
> > Peter Xu
> > 
> > 
> 
> When cyclictest and friends were originally written, we had this view 
> point that we "owned" the whole machine, and didn't have any restrictions 
> on where to schedule. As machines grew in size, and we added numa 
> awareness, and cgroups became more prominent we added this code that tried 
> to schedule according to the ill-defined environment that we found 
> ourselves in.
> 
> As Peter points out we may have restricted ourselves more than is 
> necessary, and can rely a bit more on the operating system to restrict us. 
> On the otherhand using taskset is an easy workaround if the current code 
> is to restrictive.
> 
> Because we can use taskset and things are working well otherwise I don't 
> see this as super urgent, but I am willing to revisit this code and make 
> it less restrictive if that makes sense.
> 
> I also am not a cgroup / container person, and would like to play around 
> with this a bit more before we make some decisions on which direction to 
> go in.
> 
> Does that make sense to everyone?

Sure thing on my side.  No bug reported so far this time, so I'll wait at least
until then :) I just don't know why it's not hit just like oslat since I don't
see a difference.  When I fixed the oslat thing, I thought cyclictest didn't
have such issue for some reason so I didn't consider to touch it at all.  But
when yesterday I rerun some tests I see this issue on rhel8, hence this patch.

Thanks,

-- 
Peter Xu

