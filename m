Return-Path: <SRS0=wEKt=D3=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A593AC433E7
	for <linux-rt-users@archiver.kernel.org>; Tue, 20 Oct 2020 11:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52AF622409
	for <linux-rt-users@archiver.kernel.org>; Tue, 20 Oct 2020 11:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b08buPol";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EOmy9Sx3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393868AbgJTLvK (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 20 Oct 2020 07:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393628AbgJTLvK (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 20 Oct 2020 07:51:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1B9C061755;
        Tue, 20 Oct 2020 04:51:10 -0700 (PDT)
Date:   Tue, 20 Oct 2020 13:51:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603194667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9Vkq0GQGPp+/9SF0HllUGc99HNOes06ZrnYtH1JbC7I=;
        b=b08buPolgMx6h2xIRczwStlnv1J+oicAhhEgM9+feC9gGskAiGpJEFCIrdsOUCgPrFIrVd
        msHKsnLgdOFW7p8INUdZFEK9pXZyaRfop4m6D6dL/qsoOC+kdEVbPauTj6pCL8rvPD5koA
        ycaI2IxYbWUgiIByUrRk2hCJ1p8RKha0SuZ8GfIrdgUMskETYM5Pdjc6bR+BAe3qVa1d1p
        vxj4p4R+6WJznXlcURQsXK1v4oxDES2hKqWPHSwJ5V5Y0mbFJw2MX4HXjrM5wUHRHAaeiq
        IngvNcRZy57bx5WrtF0UOKEFZevaMc63mUfm2lKxu8mqKPysT1MWU6w7bkoLLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603194667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9Vkq0GQGPp+/9SF0HllUGc99HNOes06ZrnYtH1JbC7I=;
        b=EOmy9Sx3OgMfreqZmnde5PWjDVJYZMnsj9nq8tIY/ZOs+6wCp3VVMOcby9XWTjSWFy+ob6
        VEOJ2NR/xS/XbADQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Christian Eggers <ceggers@arri.de>, tglx@linutronix.de,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: sched: system doesn't boot since  "sched: Add new
 migrate_disable() implementation"
Message-ID: <20201020115106.n474gls6oxfy5im4@linutronix.de>
References: <1654655.1jrfHnk7pZ@n95hx1g2>
 <20201019150935.koqbk57dmahhomdc@linutronix.de>
 <20201020113009.GR2628@hirez.programming.kicks-ass.net>
 <20201020113828.fv7ui4h3gkrcpqoc@linutronix.de>
 <20201020114137.GS2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201020114137.GS2628@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-10-20 13:41:37 [+0200], Peter Zijlstra wrote:
> Right, but this patch set doesn't include the lazy preemption stuff, and
> given the 'fun' Valentin and me are still having with it, I'd like to
> keep it like that.
> 
> But yes, that might warrant a slightly less NOP implementation.

Uh. Looking at the actual implementation we don't look at the mg-counter
but have preempt_lazy_disable() for that.
Let me sync your bits then.
Thanks.

Sebastian
