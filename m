Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088F3C433DB
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 08:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A663F61481
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 08:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbhBSIQ6 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Feb 2021 03:16:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:41568 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229766AbhBSIQz (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Feb 2021 03:16:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D2423ACCF;
        Fri, 19 Feb 2021 08:16:11 +0000 (UTC)
Date:   Fri, 19 Feb 2021 09:16:11 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-rt-users@vger.kernel.org,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Pradipta Kumar Sahoo <psahoo@redhat.com>,
        Mike Stowell <mstowell@redhat.com>
Subject: Re: [PATCH] oslat: Fix --cpu-list won't allow to schedule on all
 possible cores
Message-ID: <20210219081611.xsugonlz7dl4zhvx@beryllium.lan>
References: <20210218192729.116427-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218192729.116427-1-peterx@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Peter,

On Thu, Feb 18, 2021 at 02:27:29PM -0500, Peter Xu wrote:
> parse_cpumask() is too strict for oslat, in that use_current_cpuset() will
> filter out all the cores that are not allowed for current process to run.  This
> seems to be unnecessary at least for oslat.  For example, the bash process that
> runs the oslat program may have a sched affinity of 0-2, however it's still
> legal to have it start a oslat thread running on the cores outside 0-2 as long
> as the follow up sched_setaffinity() will succeed.
> 
> numa_parse_cpustring_all() suites exactly for this case, which should already
> have considered sysconf(_SC_NPROCESSORS_ONLN) limit.  Use that instead.
> 
> Since at it, also remove initialization of cpu_set variable otherwise it's
> leaked in previous parse_cpumask too: numa_parse_cpustring_all() will return a
> newly allocated buffer already.  Quotting from manual:
> 
>     numa_parse_nodestring() parses a character string list of nodes into a bit
>     mask.  The bit mask is allocated by numa_allocate_nodemask().
> 
>     numa_parse_nodestring_all() is similar to numa_parse_nodestring, but can
>     parse all possible nodes, not only current nodeset.

My 2 cents: If parse_cpumask() is to strict fix parse_cpumask() so all
tools do the same thing. Note parse_cpumask() contains a couple
of bugs:

"rt-numa: Use mask size for iterator limit"
"rt-numa: Remove max_cpus argument from parse_cpusmask"

Thanks,
Daniel
