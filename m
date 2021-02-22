Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC21C433E0
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Feb 2021 16:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E52A64E2F
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Feb 2021 16:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbhBVQVv (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 22 Feb 2021 11:21:51 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46292 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbhBVQVX (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 Feb 2021 11:21:23 -0500
Date:   Mon, 22 Feb 2021 17:20:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614010836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dMKGKwsQDejFqgv122do7LdXCQp31z5eR4/NXdM5Ids=;
        b=tvEDHvLxRQKOC5nDbLPUe9TBjRKvfdMQ1qvRdhWPjsoXg+rzFmNbVUtGXdALxTTBeTfbut
        CzqUDY3+BzKpYvcttgGOG7I7h5SBPTxAMUdggNFqFk+RmLTzZLTx+9mAKXbjhGbsRvAx+F
        Jk7hak49GWUMpvI/1HfHRwoJZj/b0bBrx1RoUnPe4jjfxxqx7+g5QgRCppAjNFuknlUXRU
        0g6eTcGDb6NOO9ZSAIvtPSURXAnYnTjrMDDx1rxX55v92klfs4xU98XSG/j8EKgSZImqcl
        OTT1HfZdi6NaHrTV4TqswwqaXzu6FY+6PsYco0o9nhKT6N+67+ya8Uqr7kcb9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614010836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dMKGKwsQDejFqgv122do7LdXCQp31z5eR4/NXdM5Ids=;
        b=uk3fIgdXML8vBovUeEmuuWrpdmE6k6PDXdmTOhtt+tixafw9AXnBG2Ysk0aYblf1COBOvC
        52M2LOpvjfBSBWBw==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Jonathan Schwender <schwenderjonathan@gmail.com>
Cc:     jkacur@redhat.com, williams@redhat.com,
        linux-rt-users@vger.kernel.org
Subject: Re: rt-tests: cyclictest: Add option to specify main pid affinity
Message-ID: <YDPZ0xrEcsS5SfWh@lx-t490>
References: <20210222152833.8758-1-schwenderjonathan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210222152833.8758-1-schwenderjonathan@gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, Feb 22, 2021 at 04:28:30PM +0100, Jonathan Schwender wrote:
>
> Hi John,
>
> This patch adds the option --mainaffinity to specify the affinity of
> the main pid.
> This is mainly useful if you want to bind the main thread to a
> different (e.g. housekeeping ) CPU than the measurement threads.
>

Pardon my ignorance; can you please specify why is this important?
The measurement threads have an RT priority while the main thread is
SCHED_OTHER. So why would the cyclictest measurements really be affected
by the main thread (unless there's a preempt_rt bug)?

Do you also have any numbers showing different results with/without
"--mainaffinity"?

Thanks,

--
Ahmed S. Darwish
