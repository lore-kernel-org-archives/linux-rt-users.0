Return-Path: <SRS0=wEKt=D3=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD45C433E7
	for <linux-rt-users@archiver.kernel.org>; Tue, 20 Oct 2020 11:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9BB42224B
	for <linux-rt-users@archiver.kernel.org>; Tue, 20 Oct 2020 11:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b1oAODf2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393485AbgJTLlt (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 20 Oct 2020 07:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393482AbgJTLlt (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 20 Oct 2020 07:41:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68385C061755;
        Tue, 20 Oct 2020 04:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=7IzqfDrRb+pZf8s+BYZ+ICLzNkKlyZ7HBrSPDJQSEFI=; b=b1oAODf286w6odaXWhyIThR0ih
        8NXQ5U9seGJlBE2Ih3XyWVekx02JKRL6vcjiu0bEVAbxihUJvaKwyRRZEMth9azKo3s/f9sg7muuX
        0QArA+ATjnlQBSbUhvTwamSOcargNIQgSqYRK+goEShzyjhu7cz7bvYzVIhv7Qu+46AstP/rLYi5u
        INIFBv7tEdoruEcqaekU1xOYp/ijrl7y1m+8wwwZB3VApxr/b0jlJF8/34+sJyJNqoRp9clKMjnIu
        bI2PKhffEfLsr935flp1RQoUpUAfOv2i0hJgQQpy4wB4PvDyGMkPn8QJeJmOCqHVfEfv79XTy7zc3
        KSdrepTw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kUq1K-0004bH-VA; Tue, 20 Oct 2020 11:41:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B844D3011FE;
        Tue, 20 Oct 2020 13:41:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 98646203280A2; Tue, 20 Oct 2020 13:41:37 +0200 (CEST)
Date:   Tue, 20 Oct 2020 13:41:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Christian Eggers <ceggers@arri.de>, tglx@linutronix.de,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: sched: system doesn't boot since  "sched: Add new
 migrate_disable() implementation"
Message-ID: <20201020114137.GS2628@hirez.programming.kicks-ass.net>
References: <1654655.1jrfHnk7pZ@n95hx1g2>
 <20201019150935.koqbk57dmahhomdc@linutronix.de>
 <20201020113009.GR2628@hirez.programming.kicks-ass.net>
 <20201020113828.fv7ui4h3gkrcpqoc@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201020113828.fv7ui4h3gkrcpqoc@linutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Oct 20, 2020 at 01:38:28PM +0200, Sebastian Andrzej Siewior wrote:
> On 2020-10-20 13:30:09 [+0200], Peter Zijlstra wrote:
> > On Mon, Oct 19, 2020 at 05:09:35PM +0200, Sebastian Andrzej Siewior wrote:
> > > On 2020-10-19 12:21:06 [+0200], Christian Eggers wrote:
> > > > I have problems with the latest 5.9-rt releases on i.MX6ULL (!CONFIG_SMP):
> > > > 
> > > …
> > > > Any hints?
> > > 
> > > Thank you for the report. The reason is the migrate_disable()
> > > implementation for !SMP.
> > 
> > This should fix things I suppose. I'll fold it in.
> 
> It will. It will also break lazy-preemption. Each time a sleeping lock
> is acquired there is also migrate_disable() and the migrate-disable
> counter is != 0 (even for UP). The result is that a wake up for a
> SCHED_OTHER task with mg counter != 0 will not lead to context switch
> (same like preemption counter != 0). The difference is that a wake up
> for a RT task ignores this counter and perform a context switch anyway.

Right, but this patch set doesn't include the lazy preemption stuff, and
given the 'fun' Valentin and me are still having with it, I'd like to
keep it like that.

But yes, that might warrant a slightly less NOP implementation.
