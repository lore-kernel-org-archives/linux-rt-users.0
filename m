Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C6FEB64D7
	for <linux-rt-users@archiver.kernel.org>; Fri, 30 Jun 2023 13:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbjF3NKC (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 30 Jun 2023 09:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbjF3NJ4 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 30 Jun 2023 09:09:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5303A92
        for <linux-rt-users@vger.kernel.org>; Fri, 30 Jun 2023 06:09:54 -0700 (PDT)
Date:   Fri, 30 Jun 2023 15:09:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1688130592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=NgMalKPoVpTY84qrO8TZaf3B/Zurs/fDU7/Pgv9787w=;
        b=FYYQT6ZifFX/+dawOa2QRnak/jHpikE6ntjGMLH4E73c9LXr9XF7lZQu6hmc2kSF5hbMfS
        /A9z6koGatlIgfbZelo+y2ou9QauC/9F/S4N3x7mkkVbXkwNKZmeFM9ewAorbcbeNRGHSe
        yVrdQA/gnpvjmEcAX0ZbLsYn77+D5cmU0u/DWDOC16eyO2RSDzmNHZ9D1fdM7iKjzcc+di
        gTAG7h73B1WDnNPVlz1J9rueGV6GD2W5XYVQF6ldWZSLgnm/SWNf6FKu1Gus132mUxJKtn
        dFb09t1XX9JTZ7YUvZfXyfEymkwEW7rwR2nvXVWr8IhS6G5kFKx1mLR8jta2Yw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1688130592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=NgMalKPoVpTY84qrO8TZaf3B/Zurs/fDU7/Pgv9787w=;
        b=U/7WHY217x4wEKRM8z8hhe/YR9geOwRLvqetoWVfHYYioTbAy8R84TR1qc7aCVTOMZmiSd
        g4XTjwY6HIajLAAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        linux-rt-users@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] tentative fix for drm/i915/gt regression on preempt-rt
Message-ID: <20230630130949.coN0sVU4@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZJTuDi1HNp9L2zxY@windriver.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2023-06-22 20:57:50 [-0400], Paul Gortmaker wrote:
[ longer report about what is broken.]

Commit ade8a0f598443 ("drm/i915: Make all GPU resets atomic") introduces
a preempt_disable() section around the invocation of the reset callback.
I can't find an explanation why this is needed. There was a comment
saying
| * We want to perform per-engine reset from atomic context (e.g.
| * softirq), which imposes the constraint that we cannot sleep.

but it does not state the problem with being preempted while waiting for
the reset. The commit itself does not explain why an atomic reset is
needed, it just states that it is a requirement now. On !RT we could
pull packets from a NICs and forward them other NICs for 2ms.

I've been looking over the reset callbacks and gen8_reset_engines() +
gen6_reset_engines() acquire a spinlock_t. Since this becomes a sleeping
lock on PREEMPT_RT it must not be acquired with disabled preemption.
i915_do_reset() acquires no lock but then has two udelay()s of 50us
each. Not good latency wise in a preempt-off section.

Could someone please explain why atomic is needed during reset, what
problems are introduced by a possible preemption?

Sebastian
