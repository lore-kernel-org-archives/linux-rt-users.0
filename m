Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2EBC433DB
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Feb 2021 16:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84C7C64E85
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Feb 2021 16:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbhBJQdQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 10 Feb 2021 11:33:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:53758 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232557AbhBJQbj (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 10 Feb 2021 11:31:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DCB6CB029;
        Wed, 10 Feb 2021 16:30:57 +0000 (UTC)
Date:   Wed, 10 Feb 2021 17:30:57 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Peter Xu <peterx@redhat.com>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v2 11/18] ptsematest: Streamline usage output and man
 page
Message-ID: <20210210163057.ts3zy274abnsnlvn@beryllium.lan>
References: <20201007085653.11961-1-dwagner@suse.de>
 <20201007085653.11961-12-dwagner@suse.de>
 <20210210160847.GI103365@xz-x1>
 <20210210162559.GJ103365@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210162559.GJ103365@xz-x1>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

So this is only about oslat, right? I ask because you respone to the
email for ptsematest.
