Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319EFC433DB
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Feb 2021 17:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F2C364ED4
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Feb 2021 17:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbhBJRgm (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 10 Feb 2021 12:36:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:48200 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232052AbhBJRee (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 10 Feb 2021 12:34:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ABFCFAB98;
        Wed, 10 Feb 2021 17:33:53 +0000 (UTC)
Date:   Wed, 10 Feb 2021 18:33:53 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     John Kacur <jkacur@redhat.com>
Cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH rt-tests 1/2] oslat: Print version string
Message-ID: <20210210173353.pqeu2sm33qs7hjna@beryllium.lan>
References: <20210210165407.9770-1-dwagner@suse.de>
 <20210210165407.9770-2-dwagner@suse.de>
 <9c2916d8-14ab-3465-97fa-2a9b52c83b1e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c2916d8-14ab-3465-97fa-2a9b52c83b1e@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Feb 10, 2021 at 12:28:09PM -0500, John Kacur wrote:
> It shouldn't be a fall through, we don't want to print the usage.

Ok. In this case I suggest we introduce for all tolls the long option
'--version' and print only the version string.

As I have already added the long parsing option in my series 'Generate
machine-readable output'. This was a lot of tedious work, so I would
like to avoid to do it split out for the '--version' option. Thus, could
you review the series and I could easily fix this problem.
