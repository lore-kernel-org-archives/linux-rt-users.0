Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF1DEC433E2
	for <linux-rt-users@archiver.kernel.org>; Wed, 31 Mar 2021 09:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84615619C9
	for <linux-rt-users@archiver.kernel.org>; Wed, 31 Mar 2021 09:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbhCaJwM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 31 Mar 2021 05:52:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50468 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234796AbhCaJwA (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 31 Mar 2021 05:52:00 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617184319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n1O7Ro6mrGBXJy3LP3Zw2Gkl3YAtQijGkEfBpifq0EY=;
        b=HOyvQwSa53zJ3yf71cTgELVGcLqHXdkEK2CEu0gp8OOSYvuiixqKkqMfNgPS0F8oVFPIHE
        jmTzygMsSqwM+rt29Adn27OOdO49isF18RvQg0mAQfmkFgpaJNv4mh1DRS9+lAtrRi6b+P
        Ro21ZHuRiMHNvQUb+nXtLIzOIg3JEvJeGMMyri2/ypbeOCuJMZvchRNPnovTvqdE1BbA7T
        R2vKVR4tyr+SiXlTslxxbG0DHokYavrSaZNNT1G4SUzhnFFcwg5e15WaZHNZwyf9UTXZbL
        xavqaUR4MieS1A7hev8sMd33SCgzb1Gb+gQgVJS1eWXoPhtyx53w8qC//dfFAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617184319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n1O7Ro6mrGBXJy3LP3Zw2Gkl3YAtQijGkEfBpifq0EY=;
        b=b37v2WvjQZmtY/D9COwHoRQgG0LNzM16wZTVkFlEwRlC91LuvoB0tJpX9LKQezq8LIoIc1
        pYKfVfp3jHfyD4Cg==
To:     Mel Gorman <mgorman@techsingularity.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC PATCH 0/6] Use local_lock for pcp protection and reduce stat overhead
In-Reply-To: <20210331085213.GZ3697@techsingularity.net>
References: <20210329120648.19040-1-mgorman@techsingularity.net> <20210331085213.GZ3697@techsingularity.net>
Date:   Wed, 31 Mar 2021 11:51:59 +0200
Message-ID: <87a6qj6474.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Mar 31 2021 at 09:52, Mel Gorman wrote:
> Ingo, Thomas or Peter, is there any chance one of you could take a look
> at patch "[PATCH 2/6] mm/page_alloc: Convert per-cpu list protection to
> local_lock" from this series? It's partially motivated by PREEMPT_RT. More
> details below.

Sure.
