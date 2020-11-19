Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C20C2D0E4
	for <linux-rt-users@archiver.kernel.org>; Thu, 19 Nov 2020 08:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1D2C246BB
	for <linux-rt-users@archiver.kernel.org>; Thu, 19 Nov 2020 08:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgKSIV2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 19 Nov 2020 03:21:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:46342 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbgKSIV2 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 19 Nov 2020 03:21:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E56A6AA4F;
        Thu, 19 Nov 2020 08:21:26 +0000 (UTC)
Date:   Thu, 19 Nov 2020 09:21:26 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     John Kacur <jkacur@redhat.com>
Cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v1 4/6] rt-numa: Introduce NUMA helpers
Message-ID: <20201119082126.kyz2qr27fdso3g3x@beryllium.lan>
References: <20201113210910.21807-1-dwagner@suse.de>
 <20201113210910.21807-5-dwagner@suse.de>
 <c91d965d-2e3-d7e0-7416-9b6746d298d4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c91d965d-2e3-d7e0-7416-9b6746d298d4@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi John,

On Wed, Nov 18, 2020 at 04:09:18PM -0500, John Kacur wrote:
>     Adding my name to the copyright in the new file src/lib/rt-numa.c
>     as some of the functions moved here are ones that I've written or
>     modified / maintained etc.

Yes, please. I forgot to move the copyrights when I moved the code
around. Sorry about that. Was not intentionally.

>     Signed-off-by: John Kacur <jkacur@redhat.com>
> 
> Also, wondering if we should combine the two rt-numa.h files into one?

Yes, I think this makes sense.

Thanks,
Daniel
