Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8834AC433E0
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Feb 2021 18:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B9AC64ED7
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Feb 2021 18:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbhBJSTI (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 10 Feb 2021 13:19:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:50324 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233966AbhBJSPp (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 10 Feb 2021 13:15:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 98444AF9C;
        Wed, 10 Feb 2021 18:15:04 +0000 (UTC)
Date:   Wed, 10 Feb 2021 19:15:04 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Peter Xu <peterx@redhat.com>
Cc:     John Kacur <jkacur@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests 1/2] oslat: Print version string
Message-ID: <20210210181504.z6ckihv5zghexrne@beryllium.lan>
References: <20210210165407.9770-1-dwagner@suse.de>
 <20210210165407.9770-2-dwagner@suse.de>
 <9c2916d8-14ab-3465-97fa-2a9b52c83b1e@redhat.com>
 <20210210173353.pqeu2sm33qs7hjna@beryllium.lan>
 <20210210175302.GP103365@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210175302.GP103365@xz-x1>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

> It's great idea to have JSON format for all the tools.  However I just don't
> see why "-v"/"--version" is related to your machine readable output work.
> Could you exlaborate?  Thanks,

I've added long options support to many rt-tests in the mentioned
series. I would like to base this fix on top of this work.
