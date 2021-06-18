Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 657FCC48BE8
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Jun 2021 21:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A96C61279
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Jun 2021 21:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbhFRVIU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 18 Jun 2021 17:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbhFRVIT (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 18 Jun 2021 17:08:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028EDC061574;
        Fri, 18 Jun 2021 14:06:09 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624050368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f83ggUS1oIlNNC9hfEwN+dr34PECUFOQa5KW491Gq9Q=;
        b=sQ6I40ywzqmBhOJhDOHOjSSkVTUHWAzfyaN0XlR2kZG/MuZEnZJi7rUMwdInWKrU9lfIoe
        K4GQw+Blm7jSQIaKZbKyVmOm/bAbZ8CMnJEMqwG6p/K8czPjiV/ssmhwvUAM97z7Nv+p31
        gR8NNzaA80Na+E9CBPpHbKnQMOFhPApHZa2yoeE/oFEWMLJcE6Yc/V19/dAcexJPAt0C6v
        UMyiDh79OCbMAfLlcce74vTHzLYCNrSt+xObMA/RtYtX6lmLwevvVtt0eyYwUgDzopKN0E
        gbHcygac6MAapFD96kN5qliiRdIFkJNZCDofQY35baG95S6EmK23zpsd5TYxGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624050368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f83ggUS1oIlNNC9hfEwN+dr34PECUFOQa5KW491Gq9Q=;
        b=UaD5FPo27aRlFWQy9e26SNLK8fPIYjj6+T/uvWS7j0LKgtHTXAdJTBOEA8mq8/B3Q/aEs7
        /8n6jcVHrTnDO4CQ==
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        linux-rt-users@vger.kernel.org, frederic@kernel.org
Cc:     mtosatti@redhat.com, Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 1/2] timers: Add pending timer bool in struct timer_base
In-Reply-To: <20210610125945.558872-1-nsaenzju@redhat.com>
References: <20210610125945.558872-1-nsaenzju@redhat.com>
Date:   Fri, 18 Jun 2021 23:06:08 +0200
Message-ID: <87pmwievcv.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Nicolas,

On Thu, Jun 10 2021 at 14:59, Nicolas Saenz Julienne wrote:

please always Cc the relevant mailing lists and the maintainers.
MAINTAINERS exists for a reason.

> We need to efficiently check whether a timer base has no pending
> events.

'We need' is not a technical explanation. That's close to 'I want a pony'.

Please describe what you are trying to solve and why the existing
mechanisms are not good enough.

See Documentation/process/submitting-patches.rst

> So introduce a new variable in struct timer_base to do so.

The variable solves your problem? Interesting solution.

>  		base->next_expiry = bucket_expiry;
>  		base->next_expiry_recalc = false;
> +#ifdef CONFIG_PREEMPT_RT
> +		base->pending = true;
> +#endif

What is RT specific about that?

>  		trigger_dyntick_cpu(base, timer);
>  	}
>  }
> @@ -1598,6 +1602,9 @@ static unsigned long __next_timer_interrupt(struct timer_base *base)
>  	}
>  
>  	base->next_expiry_recalc = false;
> +#ifdef CONFIG_PREEMPT_RT
> +	base->pending = (next != base->clk + NEXT_TIMER_MAX_DELTA);
> +#endif

This lacks any information about the semantics of this flag:

  - When is it valid and when not?
  - What is the valid use case for this flag?

Summary of the supplied information: We need a flag, so we added one.

Sorry that's not sufficient.

Thanks,

        tglx

  

