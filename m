Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781C9C433ED
	for <linux-rt-users@archiver.kernel.org>; Wed, 12 May 2021 07:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5860C6192B
	for <linux-rt-users@archiver.kernel.org>; Wed, 12 May 2021 07:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhELHb4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 12 May 2021 03:31:56 -0400
Received: from mail.monom.org ([188.138.9.77]:37082 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230211AbhELHbu (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 12 May 2021 03:31:50 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 123BC50064E;
        Wed, 12 May 2021 09:30:41 +0200 (CEST)
Received: from localhost (unknown [94.31.99.148])
        by mail.monom.org (Postfix) with ESMTPSA id D4DFD5001DD;
        Wed, 12 May 2021 09:30:40 +0200 (CEST)
Date:   Wed, 12 May 2021 09:30:40 +0200
From:   Daniel Wagner <wagi@monom.org>
To:     John Kacur <jkacur@redhat.com>
Cc:     Daniel Wagner <dwagner@suse.de>,
        Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v3 04/33] rt-util: Add rt_init function
Message-ID: <20210512073040.dotjq46s3yh5sy3o@beryllium.lan>
References: <20210320183829.1318-1-dwagner@suse.de>
 <20210320183829.1318-5-dwagner@suse.de>
 <644e52d1-acdb-dc12-b715-3847c9318027@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <644e52d1-acdb-dc12-b715-3847c9318027@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, May 07, 2021 at 12:27:53PM -0400, John Kacur wrote:
> But I don't like the name, it's not initing any test state, it's copying 
> the command line, and the name should reflect that.

I went for rt_init() because rt_test_start() code was part of
it. But without this part we could name it something like:

   rt_{copy|save|store}_{cmdline|args}

What's your preference?
