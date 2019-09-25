Return-Path: <SRS0=768X=XU=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF65C432C2
	for <linux-rt-users@archiver.kernel.org>; Wed, 25 Sep 2019 16:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02A5F214D9
	for <linux-rt-users@archiver.kernel.org>; Wed, 25 Sep 2019 16:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392011AbfIYQrP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 25 Sep 2019 12:47:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37833 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732903AbfIYQrP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 25 Sep 2019 12:47:15 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iDARc-0007C7-6I; Wed, 25 Sep 2019 18:47:12 +0200
Date:   Wed, 25 Sep 2019 18:47:12 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Clark Williams <clark.williams@gmail.com>
Cc:     bigeasy@linutronix.com, tglx@linutronix.com,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PREEMPT_RT PATCH 1/3] i915: do not call
 lockdep_assert_irqs_disabled() on PREEMPT_RT
Message-ID: <20190925164712.msyraninmjiomqr5@linutronix.de>
References: <20190820003319.24135-1-clark.williams@gmail.com>
 <20190820003319.24135-2-clark.williams@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190820003319.24135-2-clark.williams@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-08-19 19:33:17 [-0500], Clark Williams wrote:
> From: Clark Williams <williams@redhat.com>
> 
> The 'breadcrumb' code in the i915 driver calls lockdep_assert_irqs_disabled()
> when starting some operations. This is valid on a stock kernel
> but on a PREEMPT_RT kernel the spin_lock_irq*() calls to not disable
> interrupts and likewise the spin_unlock_irq*() calls to not enable interrupts.
> 
> Conditionalize these calls based on whether PREEMPT_RT_FULL is enabled.
> 
> Signed-off-by: Clark Williams <williams@redhat.com>
> ---
>  drivers/gpu/drm/i915/intel_breadcrumbs.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/intel_breadcrumbs.c b/drivers/gpu/drm/i915/intel_breadcrumbs.c
> index 832cb6b1e9bd..3eef6010ebf6 100644
> --- a/drivers/gpu/drm/i915/intel_breadcrumbs.c
> +++ b/drivers/gpu/drm/i915/intel_breadcrumbs.c
> @@ -101,7 +101,8 @@ __dma_fence_signal__notify(struct dma_fence *fence)
>  	struct dma_fence_cb *cur, *tmp;
>  
>  	lockdep_assert_held(fence->lock);
> -	lockdep_assert_irqs_disabled();
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT_FULL))
> +		lockdep_assert_irqs_disabled();
>  

Both asserts went in commit c36beba6b296b ("drm/i915: Seal races between
async GPU cancellation, retirement and signaling"). It looks like its
purpose is to ensure that ->lock is acquired and that interrupts are
also disabled because that lock is always acquired with disabled
interrupts. This isn't required, lockdep is clever enough to yell at you
if you manage to use it wrong.
Let me drop that lockdep_assert_irqs_disabled().

Sebastian
