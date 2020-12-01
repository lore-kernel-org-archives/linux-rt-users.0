Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767AFC71156
	for <linux-rt-users@archiver.kernel.org>; Tue,  1 Dec 2020 08:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C6FE2085B
	for <linux-rt-users@archiver.kernel.org>; Tue,  1 Dec 2020 08:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbgLAIVv (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 1 Dec 2020 03:21:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:57034 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbgLAIVt (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 1 Dec 2020 03:21:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B3979AD21;
        Tue,  1 Dec 2020 08:21:08 +0000 (UTC)
Date:   Tue, 1 Dec 2020 09:21:08 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     John Kacur <jkacur@redhat.com>
Cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v1 01/12] cyclicdeadline: Remove dead code
Message-ID: <20201201082108.mzx6oo2awmfgr4jx@beryllium.lan>
References: <20201118190642.16006-1-dwagner@suse.de>
 <20201118190642.16006-2-dwagner@suse.de>
 <9d9db38c-925b-b5e2-b273-2572f7bb7f3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d9db38c-925b-b5e2-b273-2572f7bb7f3@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Dec 01, 2020 at 01:30:04AM -0500, John Kacur wrote:
> Well, your git version is okay, but the version you posted here has 
> compare.py, which I assume is somekind of internal tooling you created.

I've updated the patch and resend it.

> My SOB refers to your git version

Yes, the git version is reflects the latest version (without the
compare.py junk)

> Signed-off-by: John Kacur <jkacur@redhat.com>
