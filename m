Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD2EC432BE
	for <linux-rt-users@archiver.kernel.org>; Thu, 26 Aug 2021 15:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14A7461037
	for <linux-rt-users@archiver.kernel.org>; Thu, 26 Aug 2021 15:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242925AbhHZPdX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 26 Aug 2021 11:33:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32884 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbhHZPdT (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 26 Aug 2021 11:33:19 -0400
Date:   Thu, 26 Aug 2021 17:32:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629991951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4tQ0V/9ydkXG5X5TbtD8i9ChKFEYCqsWhakG1Wch54g=;
        b=S8W5pA95TNHCMwKU8KsdaoOJ4AE3RuPJDPrT6NoK2ubF5rDQUyaB1BtxbF9K3xexXGHFUZ
        iqFkr9hR7VIAT4X3unT5BwAzaPdDqRGSG6fVAOmcj/r/WBYl72q9vJGyXNT2e0lytuGFaQ
        dNSDEgKacjpKk/vdWkcOWcudmtpn9U3HC8P+lxBwtEdRbVOynKGRae0quAaOzFXbszjPJe
        c0nINqqb/NeM1eYt3q8cMQhH4zDpbj6zrtYdFCRRiRc28ObxRTsPCSgDmtpy9ca48ZLsss
        n4qgOydptBRWRgHeIi4cHTAk3hby5gPCNYQACDiiFy8lv9Vi7IYAbviAzQ2TPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629991951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4tQ0V/9ydkXG5X5TbtD8i9ChKFEYCqsWhakG1Wch54g=;
        b=lzIIBjzEdGotnunHs25baD9Ii1qJeX/xGmAtXvS6NelQe3K9dJM/88YzUTGdS6UTGShMr+
        FvqDn5jLpAfgiTAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Clark Williams <williams@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        RT <linux-rt-users@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH PREEMPT_RT] i915: fix PREEMPT_RT locking splats
Message-ID: <20210826153229.3u3wmwmsszvfzb6m@linutronix.de>
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
> ---
>  drivers/gpu/drm/i915/gt/intel_breadcrumbs.c          | 6 ++++--
>  drivers/gpu/drm/i915/gt/intel_execlists_submission.c | 6 ++++--
>  2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c b/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
> index 38cc42783dfb..b8bf8d6d3c61 100644
> --- a/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
> +++ b/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
> @@ -318,9 +318,11 @@ void __intel_breadcrumbs_park(struct intel_breadcrumbs *b)
>  	/* Kick the work once more to drain the signalers, and disarm the irq */
>  	irq_work_sync(&b->irq_work);
>  	while (READ_ONCE(b->irq_armed) && !atomic_read(&b->active)) {
> -		local_irq_disable();
> +		if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> +			local_irq_disable();
>  		signal_irq_work(&b->irq_work);
> -		local_irq_enable();
> +		if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> +			local_irq_enable();

wouldn't it work to use irq_work_queue() + sync() instead of invoking
the target callback itself? Given that this context is IRQ-enabled then
it should (at least on x86) trigger right away.

>  		cond_resched();
>  	}
>  }
> diff --git a/drivers/gpu/drm/i915/gt/intel_execlists_submission.c b/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
> index fc77592d88a9..0e918831b69f 100644
> --- a/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
> +++ b/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
> @@ -1580,9 +1580,11 @@ static void execlists_dequeue(struct intel_engine_cs *engine)
>  
>  static void execlists_dequeue_irq(struct intel_engine_cs *engine)
>  {
> -	local_irq_disable(); /* Suspend interrupts across request submission */
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> +		local_irq_disable(); /* Suspend interrupts across request submission */
>  	execlists_dequeue(engine);

I've been staring at this for a while. Wouldn't it work in invoke
execlists_dequeue() and let execlists_dequeue() do 
	spin_lock_irq(&engine->active.lock);

? This is the only invocation of the function. I don't know what the
expected synchronisation behaviour is. The only thing that could break
is the tail part of the function after the &engine->active.lock has been
dropped.

> -	local_irq_enable(); /* flush irq_work (e.g. breadcrumb enabling) */
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> +		local_irq_enable(); /* flush irq_work (e.g. breadcrumb enabling) */
>  }
>  
>  static void clear_ports(struct i915_request **ports, int count)

Sebastian
