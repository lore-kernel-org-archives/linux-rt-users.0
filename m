Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C1EC433F5
	for <linux-rt-users@archiver.kernel.org>; Wed,  8 Sep 2021 19:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26C2361074
	for <linux-rt-users@archiver.kernel.org>; Wed,  8 Sep 2021 19:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348491AbhIHTGX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 8 Sep 2021 15:06:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54116 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240432AbhIHTGW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 8 Sep 2021 15:06:22 -0400
Date:   Wed, 8 Sep 2021 21:05:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631127913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5aGeWY7DO3MzPMypk/VyLpu8f2mEs1dGB7dzzGJfmcI=;
        b=CMwV+ckrrDH9kmSgeaPQ8vRtQtH+WL4pOXJFZAwtgHdzpJ/Sw0g9p8xRlCLIR0Y1oXpiVn
        ZMvcRD04gS/zH9XA6udIyK7rAsoHeYS5UOzNFRBl/amplVKObDGK85x6KVwwQn0Oy0J6ei
        WDPqZop0iAlYw8jncZvDmA7DLhzmKwzIG0XbnzFgZZRN+nDMqcSp1VxH5dGJPuHpvoB6II
        WunQ7MRJqFQff6VeSzua5F1fGi8ItIJPr80/cwhCoJIpgXvBl2VtUN97U4YYKNAGfQkJ8M
        D0P66QjUyMIXknUUmT6jyQQz2tDMFg7tCwBIB9BaS5xDatpKP+NHpnFBaOZTVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631127913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5aGeWY7DO3MzPMypk/VyLpu8f2mEs1dGB7dzzGJfmcI=;
        b=nTWC5aXSoVBtlTqWZrexkU4VusCmN7zXjuKf2Tl2pfLHhvSL0WR6L3qwSJXo/e01N+kps+
        /YoRHL+5WdhV/RCQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Clark Williams <williams@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        RT <linux-rt-users@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH PREEMPT_RT] i915: fix PREEMPT_RT locking splats
Message-ID: <20210908190512.ocuyu2uzuyexas2m@linutronix.de>
References: <20210823150015.61ebc7d6@theseus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210823150015.61ebc7d6@theseus>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-08-23 15:00:15 [-0500], Clark Williams wrote:
> Found two separate spots where i915 was throwing "sleeping
> function called from invalid context" when running on a
> PREEMPT_RT kernel. In both cases it was from calling
> local_irq_disable prior to taking a spin_lock. Since spin
> locks are converted to rt_mutex_t on PREEMPT_RT this means
> that we might sleep with interrupts disabled.
> 
> Since in both cases the calls were in threaded context on RT
> (irq or ksoftirqd) and in no danger of reentrance, change the
> code to only disable interrupts on non-PREEMPT_RT kernels.
> 
> Signed-off-by: Clark Williams <williams@redhat.com>

I try to deal with this in
   https://lkml.kernel.org/r/20210908185703.2989414-1-bigeasy@linutronix.de

Sebastian
