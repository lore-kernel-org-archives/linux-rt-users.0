Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9B4C3526B
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Dec 2020 16:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9377823A9F
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Dec 2020 16:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbgLRQny (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 18 Dec 2020 11:43:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:52858 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbgLRQnx (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 18 Dec 2020 11:43:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B5E19ACF1;
        Fri, 18 Dec 2020 16:43:12 +0000 (UTC)
Date:   Fri, 18 Dec 2020 17:43:12 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     John Kacur <jkacur@redhat.com>
Cc:     Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v1 0/6] libnuma cleanups for cyclictest
Message-ID: <20201218164312.g5cv7bdqizwatovx@beryllium.lan>
References: <20201218141935.24151-1-dwagner@suse.de>
 <f252ba74-46de-ced1-5e77-a64ec51510ba@monom.org>
 <6b1dcc20-9e68-e07-2892-60bcf2a0fdac@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b1dcc20-9e68-e07-2892-60bcf2a0fdac@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Dec 18, 2020 at 11:02:45AM -0500, John Kacur wrote:
> For the future, I'm okay with things evolving in steps, as long as what 
> you sent me works correctly, you can then add support to do the same kind of things
> in other programs in the suite later, as long as it gets done and not 
> neglected.

I am on the same side here. We should really try to unify the code base
match as possible. This series is just one small step into this
direction :)

> Since you told me to wait this time though, I will wait for v2

See your inbox. Happy testing.
