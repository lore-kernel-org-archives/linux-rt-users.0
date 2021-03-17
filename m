Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D12C4332D
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Mar 2021 17:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F3A564E0F
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Mar 2021 17:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbhCQRVY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 17 Mar 2021 13:21:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:49082 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232388AbhCQRUL (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 17 Mar 2021 13:20:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 11F81ACA8;
        Wed, 17 Mar 2021 17:20:10 +0000 (UTC)
Date:   Wed, 17 Mar 2021 18:20:09 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     John Kacur <jkacur@redhat.com>
Cc:     Peter Xu <peterx@redhat.com>, Daniel Wagner <wagi@monom.org>,
        linux-rt-users@vger.kernel.org,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH] rt-tests: Drop use_current_cpuset() check
Message-ID: <20210317172009.w4cbk5ypi2wtdev3@beryllium.lan>
References: <20210315193707.359702-1-peterx@redhat.com>
 <20210316081826.bthxqja6shbcp36j@beryllium.lan>
 <20210316200705.GC395976@xz-x1>
 <20210317074903.5lskayjwylnvuhks@beryllium.lan>
 <20210317125147.GH395976@xz-x1>
 <7882bec5-be12-267f-94c1-3b7c21193686@redhat.com>
 <20210317152100.GL395976@xz-x1>
 <dab375fb-b2df-fd6c-3931-cd24d4fa26a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dab375fb-b2df-fd6c-3931-cd24d4fa26a@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Mar 17, 2021 at 11:47:51AM -0400, John Kacur wrote:
> > > Does that make sense to everyone?
> > 
> > Sure thing on my side.  No bug reported so far this time, so I'll wait at least
> > until then :) I just don't know why it's not hit just like oslat since I don't
> > see a difference.  When I fixed the oslat thing, I thought cyclictest didn't
> > have such issue for some reason so I didn't consider to touch it at all.  But
> > when yesterday I rerun some tests I see this issue on rhel8, hence this patch.

Don't let me stop you ripping out the code. I am not agreeing with the
reasoning why it should go but it's a detail I don't care.
