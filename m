Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD31AC433E6
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 16:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BBA964E44
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 16:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhBSQga (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Feb 2021 11:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbhBSQg2 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Feb 2021 11:36:28 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCD4C061574
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Feb 2021 08:35:46 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id z128so1540911qkc.12
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Feb 2021 08:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=iDMQjhitiGzhk9xWW/eiIwIssS1KuMbpX1pCSfk6xAA=;
        b=SYRO949gT5Mmb7IzYicjLK3uP4ZcjPmp9K0/PXkpA8MWXJ/bL+ESTBu2ivZlnF4xPZ
         BfKLJEOpAPlt/FXX9SdCIVUrbbiPz2MxugAqWfDNpIX6AMpVwFga+6mUenUVyy4nUHIP
         sGI5OPmJQXzrS4lPAg6u5DQF8DnGLsxp+tbvIS23pQpLzWCOi2hh7QHubqmqTRPS3aCR
         DM6Kp7l954MnMMJZSK4oDMHYgLOOuIuzkaHCSfJlTFnpw5zjhmTGRUumy1Z1rcGxIQyH
         /7wi0t5OKCH3kpYGjvk0z3LWbvem5CyM/MkVsqu3ADiA+JHySLRwCCPjhlBOCwOrrfeO
         iWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=iDMQjhitiGzhk9xWW/eiIwIssS1KuMbpX1pCSfk6xAA=;
        b=EUD7mpsxQSNrKvYXuy4qfRiqa1Gm3hOvJ7FtFt6BgX0o5tSJdHM+SXcxdbt3w0Sw45
         9aIBYNvFw8xr+3oH8r26yYebUpObJrt4x8oq05jO9XWk/UKhtYgKeRS0p6AExvKra2Er
         RTUdOVj40YF6ONLZyqult1nK3mshK0gqtU3x9qAtSYYORTqfIbUHg46Jci0TySh2qRrJ
         XesXkEpq7xWhpBLtgUYiH47BfFPhuPBarpvuuZ4X4/zD3cGv8ID1X3y6smTs0GabENhO
         3v1FZU8cHAdFHyF8Sr2N3psQqEJ/77f6C7lCji0YYsiihDky72KW2PTBTn16LTJh8UQu
         1XOg==
X-Gm-Message-State: AOAM531CIDZIoS+sAEnHybSgk4Xq/ReVrwh8X/s9xPcl7NaHgaNC1OCt
        q8BfrQ2KFdbr2vJhtcveTbM=
X-Google-Smtp-Source: ABdhPJzzyhLXunDTq4+mIPZhaj7uqbzcfp07KLSmCLaXyAakuFgN6DOm0SCY4n0mdIaYqQ7eCAP2Ww==
X-Received: by 2002:a05:620a:485:: with SMTP id 5mr9835481qkr.461.1613752545549;
        Fri, 19 Feb 2021 08:35:45 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id 82sm6824921qkd.48.2021.02.19.08.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 08:35:45 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 19 Feb 2021 11:35:44 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Peter Xu <peterx@redhat.com>, linux-rt-users@vger.kernel.org,
        Clark Williams <williams@redhat.com>,
        Pradipta Kumar Sahoo <psahoo@redhat.com>,
        Mike Stowell <mstowell@redhat.com>
Subject: Re: [PATCH] oslat: Fix --cpu-list won't allow to schedule on all
 possible cores
In-Reply-To: <20210219081611.xsugonlz7dl4zhvx@beryllium.lan>
Message-ID: <acfe74c9-b629-6ca6-95bf-ab88fff7d92c@redhat.com>
References: <20210218192729.116427-1-peterx@redhat.com> <20210219081611.xsugonlz7dl4zhvx@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 19 Feb 2021, Daniel Wagner wrote:

> Hi Peter,
> 
> On Thu, Feb 18, 2021 at 02:27:29PM -0500, Peter Xu wrote:
> > parse_cpumask() is too strict for oslat, in that use_current_cpuset() will
> > filter out all the cores that are not allowed for current process to run.  This
> > seems to be unnecessary at least for oslat.  For example, the bash process that
> > runs the oslat program may have a sched affinity of 0-2, however it's still
> > legal to have it start a oslat thread running on the cores outside 0-2 as long
> > as the follow up sched_setaffinity() will succeed.
> > 
> > numa_parse_cpustring_all() suites exactly for this case, which should already
> > have considered sysconf(_SC_NPROCESSORS_ONLN) limit.  Use that instead.
> > 
> > Since at it, also remove initialization of cpu_set variable otherwise it's
> > leaked in previous parse_cpumask too: numa_parse_cpustring_all() will return a
> > newly allocated buffer already.  Quotting from manual:
> > 
> >     numa_parse_nodestring() parses a character string list of nodes into a bit
> >     mask.  The bit mask is allocated by numa_allocate_nodemask().
> > 
> >     numa_parse_nodestring_all() is similar to numa_parse_nodestring, but can
> >     parse all possible nodes, not only current nodeset.
> 
> My 2 cents: If parse_cpumask() is to strict fix parse_cpumask() so all

parse_cpumask() correctly examines the current environment and creates
an intersection between the requested cpus and the ones it has permission 
to use. Using taskset with the same parameters as passed to the tools gets 
around that.

I have a few comments

1. Make the programs in the suite work the same way where that makes 
sense, but let's not make a fetish of it, sometimes there are good reasons 
not to impose the conformity.

2. If the user intentionally wants to go outside of the constraints, we 
could use a --force option to make sure the user is aware they are doing 
so.

In private chats with Peter though, he pointed out that if you're always 
using the --force option, then maybe it makes sense for that to be the 
default, and in addition, should calls to setaffinity() be the test?


3. We need to think a little bit about whether and how cyclictest and 
friends should run in containers.

> tools do the same thing. Note parse_cpumask() contains a couple
> of bugs:
> 
> "rt-numa: Use mask size for iterator limit"
> "rt-numa: Remove max_cpus argument from parse_cpusmask"

Are those actually bug fixes or just a different way of doing things?

> 
> Thanks,
> Daniel
> 
