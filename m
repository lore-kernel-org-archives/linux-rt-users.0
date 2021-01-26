Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81958C433DB
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 08:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 471CE2065C
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 08:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390401AbhAZImn (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 26 Jan 2021 03:42:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:59686 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390369AbhAZIm1 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 Jan 2021 03:42:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EEB08ACF4;
        Tue, 26 Jan 2021 08:41:45 +0000 (UTC)
Date:   Tue, 26 Jan 2021 09:41:45 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     John Kacur <jkacur@redhat.com>
Cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v1 3/6] cyclictest: Use affinity_mask for stearing
 thread placement
Message-ID: <20210126084145.qrtcg6dsvbya3odd@beryllium.lan>
References: <20201218141935.24151-1-dwagner@suse.de>
 <20201218141935.24151-4-dwagner@suse.de>
 <2b7c33f3-6249-5ef4-94a3-957cb8cbb3bd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b7c33f3-6249-5ef4-94a3-957cb8cbb3bd@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Jan 26, 2021 at 12:39:02AM -0500, John Kacur wrote:
> Signed-off-by: John Kacur <jkacur@redhat.com>

Is there any reason why you picked this version of the patch? It was
also part of v2?
