Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C38E1C433E0
	for <linux-rt-users@archiver.kernel.org>; Wed, 27 Jan 2021 03:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87F76206B5
	for <linux-rt-users@archiver.kernel.org>; Wed, 27 Jan 2021 03:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237570AbhA0Dyk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 26 Jan 2021 22:54:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:39580 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389306AbhAZRO1 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 Jan 2021 12:14:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EAE95AB92;
        Tue, 26 Jan 2021 17:13:45 +0000 (UTC)
Date:   Tue, 26 Jan 2021 18:13:45 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     John Kacur <jkacur@redhat.com>
Cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v1 3/6] cyclictest: Use affinity_mask for stearing
 thread placement
Message-ID: <20210126171345.ixrhkwquiktdly7h@beryllium.lan>
References: <20201218141935.24151-1-dwagner@suse.de>
 <20201218141935.24151-4-dwagner@suse.de>
 <2b7c33f3-6249-5ef4-94a3-957cb8cbb3bd@redhat.com>
 <20210126084145.qrtcg6dsvbya3odd@beryllium.lan>
 <9c62a2fb-59a3-d7d-6c42-30eccdab8779@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c62a2fb-59a3-d7d-6c42-30eccdab8779@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Jan 26, 2021 at 11:33:24AM -0500, John Kacur wrote:
> I reviewed the correct version of your patch, which I pulled from git,
> but when I went to reply to it, I replied to the wrong email, sorry for
> the confusion.

Ah, okay. I was very confused :)
