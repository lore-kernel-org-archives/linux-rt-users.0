Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91409C433E6
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 08:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6344522DFB
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 08:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390312AbhAZIi0 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 26 Jan 2021 03:38:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:56138 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390306AbhAZIiF (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 Jan 2021 03:38:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B33BFAC4F;
        Tue, 26 Jan 2021 08:37:22 +0000 (UTC)
Date:   Tue, 26 Jan 2021 09:37:22 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     John Kacur <jkacur@redhat.com>
Cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v1 4/6] cyclictest: Mimik --smp behavior with
 --affinity
Message-ID: <20210126083722.tpyy4jsv25sqzsnk@beryllium.lan>
References: <20201218141935.24151-1-dwagner@suse.de>
 <20201218141935.24151-5-dwagner@suse.de>
 <f273ca2-e80-7713-7caa-6dff464d388@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f273ca2-e80-7713-7caa-6dff464d388@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Jan 26, 2021 at 12:55:33AM -0500, John Kacur wrote:
> Well, --smp historically combined -a -t and threads at the same priority
> You could argue that it is reasonable for -a to automatically imply -t
> but I have had debates with people about this and we settled on -a just 
> specifies the affinity, and the default number of threads is one unless
> you use -t.

My thinking is if you set an affinity mask, you want also to assign a
thread to the CPUs. If not what's the point to set an affinity mask
without a thread on it. Though the user is able to overwrite this
by providing the -t options along side the -a option.

> I'm not sure what you mean by this makes cyclictest behave the way the 
> rest of rt-tests does, the rest of rt-tests should match what cyclitest 
> does.

As I wrote, make cyclictest behave the same way as the to other tools
when -a/-t is used.

> That said, I did some quick runs of signaltest and -a seems broken,
> sigh.

Is it broken without my patches or with my patches? What is broken?

