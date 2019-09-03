Return-Path: <SRS0=pNo3=W6=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CC0C3A5A2
	for <linux-rt-users@archiver.kernel.org>; Tue,  3 Sep 2019 08:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B2B322DBF
	for <linux-rt-users@archiver.kernel.org>; Tue,  3 Sep 2019 08:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfICIDj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 3 Sep 2019 04:03:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59025 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfICIDi (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 3 Sep 2019 04:03:38 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1i53mp-0001mB-C0; Tue, 03 Sep 2019 10:03:35 +0200
Date:   Tue, 3 Sep 2019 10:03:35 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Clark Williams <clark.williams@gmail.com>
Cc:     bigeasy@linutronix.com, tglx@linutronix.com,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PREEMPT_RT PATCH 2/3] i915: convert all irq_locks spinlocks to
 raw spinlocks
Message-ID: <20190903080335.pe45dmgmjvdvbyd4@linutronix.de>
References: <20190820003319.24135-1-clark.williams@gmail.com>
 <20190820003319.24135-3-clark.williams@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190820003319.24135-3-clark.williams@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-08-19 19:33:18 [-0500], Clark Williams wrote:
> From: Clark Williams <williams@redhat.com>
> 
> The following structures contain a member named 'irq_lock'.
> These three locks are of type spinlock_t and are used in
> multiple contexts including atomic:
> 
>     struct drm_i915_private
>     struct intel_breadcrumbs
>     strict intel_guc
> 
> Convert them all to be raw_spinlock_t so that lockdep and the lock
> debugging code will be happy.

What is your motivation to make the lock raw?
I did the following:

 void intel_engine_signal_breadcrumbs(struct intel_engine_cs *engine)
 {
-       local_irq_disable();
-       intel_engine_breadcrumbs_irq(engine);
-       local_irq_enable();
+       if (IS_ENABLED(CONFIG_PREEMPT_RT_FULL)) {
+               intel_engine_breadcrumbs_irq(engine);
+       } else {
+               local_irq_disable();
+               intel_engine_breadcrumbs_irq(engine);
+               local_irq_enable();
+       }
 }

and lockdep was quiet (+ ignoring/patching the lockdep-irq-off-asserts).
The local_irq_disable() is here (my interpretation of the situation)
because that function is called from process context while the remaining
callers invoke intel_engine_breadcrumbs_irq() from the interrupt
handler and it acquires irq_lock via a plain spin_lock().  That
local_irq_disable() would be required if everyone did a _irqsave().

I tried to check how much worse the latency gets here but I didn't see
anything in a brief test. What I saw however is that switching to
fullscreen while playing a video gives me ~0.5 to ~2ms latency. This is
has nothing to do with this change, I have to dig deeper… It might be
one of the preempt_disable() section I just noticed.
I would prefer to keep the lock non-raw unless there is actual need for
it.

Sebastian
