Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD6CC433DB
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 16:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F41564E44
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 16:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhBSQVC (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Feb 2021 11:21:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:49046 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229734AbhBSQVB (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Feb 2021 11:21:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 17DE5AC6E;
        Fri, 19 Feb 2021 16:20:20 +0000 (UTC)
Date:   Fri, 19 Feb 2021 17:20:19 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-rt-users@vger.kernel.org,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Pradipta Kumar Sahoo <psahoo@redhat.com>,
        Mike Stowell <mstowell@redhat.com>
Subject: Re: [PATCH] oslat: Fix --cpu-list won't allow to schedule on all
 possible cores
Message-ID: <20210219162019.giw2yy25vjuzc56f@beryllium.lan>
References: <20210218192729.116427-1-peterx@redhat.com>
 <20210219081611.xsugonlz7dl4zhvx@beryllium.lan>
 <20210219152417.GE6669@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219152417.GE6669@xz-x1>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Feb 19, 2021 at 10:24:17AM -0500, Peter Xu wrote:
> Yes I explicitly avoided touching parse_cpumask because I don't want to change
> behavior of other tools if I'm not confident with that.  Would above two
> patches fix oslat too (which I didn't check)?  If so, I'll be fine to have this
> patch dropped.  Otherwise I tend to prefer fixing oslat first.  We can further
> rework the common code, but if existing tools are fine, then I don't think it's
> a bugfix, so no need to rush.  While I'll count this patch as a real bugfix, so
> I'd hope we could consider merging it earlier.

As I said, I would really appreciated if all tools behave the same
way. Having oslat be special is going to be pain in the long run. Just
update parse_cpumask, it's not that difficult :)
