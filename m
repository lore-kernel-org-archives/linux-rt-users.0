Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2E4C433E0
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Mar 2021 07:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDC3664F8B
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Mar 2021 07:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhCQHtc (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 17 Mar 2021 03:49:32 -0400
Received: from mail.monom.org ([188.138.9.77]:60044 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230352AbhCQHtF (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 17 Mar 2021 03:49:05 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id C1E4B50035A;
        Wed, 17 Mar 2021 08:49:03 +0100 (CET)
Received: from localhost (unknown [94.31.96.195])
        by mail.monom.org (Postfix) with ESMTPSA id 8DC9E500196;
        Wed, 17 Mar 2021 08:49:03 +0100 (CET)
Date:   Wed, 17 Mar 2021 08:49:03 +0100
From:   Daniel Wagner <wagi@monom.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, John Kacur <jkacur@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH] rt-tests: Drop use_current_cpuset() check
Message-ID: <20210317074903.5lskayjwylnvuhks@beryllium.lan>
References: <20210315193707.359702-1-peterx@redhat.com>
 <20210316081826.bthxqja6shbcp36j@beryllium.lan>
 <20210316200705.GC395976@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316200705.GC395976@xz-x1>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Mar 16, 2021 at 04:07:05PM -0400, Peter Xu wrote:
> I think what I'm missing is why we had such a restriction.  Quotting from the
> commit ID:

IIRC, the current behavior allows the process to be placed into a cgroup
with a subset of CPUs and you just can do 'cyclictest -a -t'. Process
should not ignore external configuration. That's my whole point here.

> So I'm not sure I understand the word "runtime environment".
>
> If it's defined as "the set of cores that this process is allowed to
> run",

I am trying to say is, the tests should not assume they have the full
control of the placement as this is not what I would expect. If I as
'admin' limits the sched mask then cyclictest should not overwrite it.

If you insist removing this code, please add a section in the
documentation explaining why the tools ignore it.

> John and I had some discussion offlist about this last time on oslat,

As I said, I think this behavior is wrong. Anyway, I stopped caring.
