Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047A8C433DB
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Mar 2021 16:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA70E64F0F
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Mar 2021 16:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbhCQQWk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 17 Mar 2021 12:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbhCQQW3 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 17 Mar 2021 12:22:29 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2526C06174A
        for <linux-rt-users@vger.kernel.org>; Wed, 17 Mar 2021 09:22:28 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id f124so39434648qkj.5
        for <linux-rt-users@vger.kernel.org>; Wed, 17 Mar 2021 09:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=cF0KIXCdT+QliYU5hfHpDh8uRaHPQafZKq6hTdO/5Cc=;
        b=uXkCrlrPs47GAo3e3+sarl6cH9cSztgRTIuc0NBTcLa+pr2fn6zMU/hXHVPRNe4cf0
         wZZHVf46zu8mQexV4eubR+0rkLO1VB0i43qe6twuZrfCRPl44gYmlZnCy3M/6FZuAqzg
         XlvyFxrvrPxyDU1V0LHRc5DNl+YJaLgptikbbxp+Rsc9GQdYqrTbOjtdLzuvB0IWTIof
         ccCTUEyn5BDSoaV1ObpRc58ku15zf2Cm4yy9amEFnivFsIMa91lr2dfCiHfWVwS7etpe
         8CMOlliipXhA02pu4AhLF6htekVZSVIXkfBgLJxkUPE7Uah6NwkY+UYnRww88phgtLyv
         95ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=cF0KIXCdT+QliYU5hfHpDh8uRaHPQafZKq6hTdO/5Cc=;
        b=Ixfzw71q9kHNMknaXCp3n+QuanLrgFOYS5YB0cMWqHsfQKrw5s+IjMaM32W9HAcRv1
         pIWwP8HtcQ3efgo58L3X4Ka9Se4DeCkwC1BiA3Q79rK01N9ac9citWLsrCvzhTn2LWwG
         U5iKeAaQOslmjXwCc27PTGnjR+L6xqmZ6kzRotdh8kdNaK2srIVuu65khc2qV0jshOhn
         j9z9ULKBshFDWHFZvkGDPLu8b8i6REy4Vnx3o6tTL+NWDD/Q63hTErLAZEY28E5E1zMf
         ke7+uiFhU9ld2LP3CA2dvI3GU+6C4F4CoLOrDBylSOcv5ordtoO3B//VM2EErs+10X3g
         x8Yw==
X-Gm-Message-State: AOAM5331jKD0wM/IFC1JqYlv3dlj1KNTw/D8NBl9/pF4RkYKBuC9HgGE
        18k873YoIG3CyNULl5kTMwyDhyPBnkY=
X-Google-Smtp-Source: ABdhPJz7EEPdSe6MdAqkutK4zNmIuQwPvtJlbNuKHu1ZPVv7dcfDDaBxtMxT+inyyonINYozn10Fhw==
X-Received: by 2002:a37:a644:: with SMTP id p65mr5349463qke.20.1615993719955;
        Wed, 17 Mar 2021 08:08:39 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id i25sm7438276qka.38.2021.03.17.08.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 08:08:39 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Wed, 17 Mar 2021 11:08:31 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Peter Xu <peterx@redhat.com>
cc:     Daniel Wagner <wagi@monom.org>, linux-rt-users@vger.kernel.org,
        Clark Williams <williams@redhat.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH] rt-tests: Drop use_current_cpuset() check
In-Reply-To: <20210317125147.GH395976@xz-x1>
Message-ID: <7882bec5-be12-267f-94c1-3b7c21193686@redhat.com>
References: <20210315193707.359702-1-peterx@redhat.com> <20210316081826.bthxqja6shbcp36j@beryllium.lan> <20210316200705.GC395976@xz-x1> <20210317074903.5lskayjwylnvuhks@beryllium.lan> <20210317125147.GH395976@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 17 Mar 2021, Peter Xu wrote:

> Hi, Daniel,
> 
> On Wed, Mar 17, 2021 at 08:49:03AM +0100, Daniel Wagner wrote:
> > On Tue, Mar 16, 2021 at 04:07:05PM -0400, Peter Xu wrote:
> > > I think what I'm missing is why we had such a restriction.  Quotting from the
> > > commit ID:
> > 
> > IIRC, the current behavior allows the process to be placed into a cgroup
> > with a subset of CPUs and you just can do 'cyclictest -a -t'. Process
> > should not ignore external configuration. That's my whole point here.
> 
> In that case again I think a sane solution is not to check the cpu list in
> every single tool we use, because even if we do that for all tools in rt-teets
> repo, we can't guarantee to have this check for the rest tools to not ignore
> this restriction.
> 
> A simple example is: what if the user specified "taskset -c $CPU cyclictest -a
> $CPU -t 1 ..." where $CPU is not in the allowed list of current bash?  As long
> as the taskset would work the so-called "environment" will be changed before
> even loading cyclictest.
> 
> If you see that's the point I said we should fail at the same check point of
> sched_setaffinity() rather than checking it explicitly in the tool, because
> if we want a real-world restriction that's the only place I think it's possible..
> 
> But I'm not a cgroup/container guy, please correct me if I understood.
> 
> -- 
> Peter Xu
> 
> 

When cyclictest and friends were originally written, we had this view 
point that we "owned" the whole machine, and didn't have any restrictions 
on where to schedule. As machines grew in size, and we added numa 
awareness, and cgroups became more prominent we added this code that tried 
to schedule according to the ill-defined environment that we found 
ourselves in.

As Peter points out we may have restricted ourselves more than is 
necessary, and can rely a bit more on the operating system to restrict us. 
On the otherhand using taskset is an easy workaround if the current code 
is to restrictive.

Because we can use taskset and things are working well otherwise I don't 
see this as super urgent, but I am willing to revisit this code and make 
it less restrictive if that makes sense.

I also am not a cgroup / container person, and would like to play around 
with this a bit more before we make some decisions on which direction to 
go in.

Does that make sense to everyone?

John
