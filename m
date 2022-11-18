Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A10C4332F
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Nov 2022 11:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241271AbiKRLPp (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 18 Nov 2022 06:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235188AbiKRLPo (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 18 Nov 2022 06:15:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683308E0B9
        for <linux-rt-users@vger.kernel.org>; Fri, 18 Nov 2022 03:15:43 -0800 (PST)
Date:   Fri, 18 Nov 2022 12:15:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668770142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MrCJgBhJdXhmsjXIzshwiE2aZzXsu2VcNpqocytJYJo=;
        b=hhnYnREoW+RhnA2mQXTdsQA92Urxc9Qkl6RgzbnkeB7UAQpaTK4TmhE8Rj0hshGgX8rCvr
        Ys7ev5ZFhOiMfY8ZGiCgjIlA3edo9qEBCpb0puhharGpmBhwBHXc1zrRvA8YfhpBzshdzA
        wm+ym08WXPmQ6CS2nvGj5qs72ryhV5IX9zYleXykKZSx/aJATS7VJCCN84dcNBDsgTuFhT
        4NSuEC8jqFf8AYNnbsSjR4OS7icb9rp1iViNlHqinJCABr2HGsJtgW8v+it+Q+iHxF7BTy
        HLGsq1BavpeKKhk9oguGtF19TJIOGtM64Surej6D/2mu5pX5lfuGA4Kwdtp8VA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668770142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MrCJgBhJdXhmsjXIzshwiE2aZzXsu2VcNpqocytJYJo=;
        b=fNacyQr2WcsviqB0k4kDYmNBzH5zfL/x2uVuZCiVOwethftyFdtGkjMB9dfynHFk0l31ew
        /g6yZmPjPRci5QBA==
From:   "Ahmed S. Darwish" <darwi@linutronix.de>
To:     yosi yarchi <yosi.yarchi@gmail.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: high prioritized threaded interrupt is delayed due to low
 priority softirq job
Message-ID: <Y3dpXJ/gswWR6qdL@lx-t490>
References: <be1a23f2-f8c1-17f0-db77-a32469fa56fa@gmail.com>
 <656ed13b-df87-ac56-ea39-7222dcb80bf6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <656ed13b-df87-ac56-ea39-7222dcb80bf6@gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Nov 17, 2022, yosi yarchi wrote:
>
> 1. SAM9X35 (8 CAN mailboxes),
>

This is a *very* very low-end core (ARM926), so be careful that some
latency issues would be expected.

If you don't have a specific Linux use-case, maybe you can try something
like ZephyrOS instead?

Given that low-end core, and if you're stuck with Linux, a mainline
kernel with preemption disabled (CONFIG_PREEMPT_NONE) might actually be
more beneficial latency-wise than PREEMPT_RT...

> 2. Linux mscb 5.4.41-linux4sam-2020.04-rt24 #1 PREEMPT_RT Wed Nov 9
> 06:12:28 UTC 2022 armv5tejl GNU/Linux

"5.4.41-linux4sam-2020.04-rt24". This is a vendored RT kernel, and
vendored RT kernels are known to have latency issues.

Can you please try official RT kernels instead? More info is here:

  https://wiki.linuxfoundation.org/realtime/preempt_rt_versions

Make sure that debugging options are disabled, e.g.
CONFIG_PROVE_LOCKING, and so on. Afterwards, you'd like to measure the
latencies of your (single-core) system with something like:

  cyclictest                    \
        --default-system        \
        --secaligned            \
        --mlockall              \
        --interval=500          \
        --priority=98           \
        --histogram=2000

And then check the reported worst-case latencies.

> 3. CAN threaded interrupt (irq/30-can0-346) is configured to be
> highest priority on system.

Please not that in RT, many system-critical kernel threads run at rtprio
99. The hight (sane) priority to be assigned should thus be 98.

>
> my problem is that from time to time I get CAN RX overflow.
>

That would be kinda expected with such a low-end core, even when
everything else is "perfect".

>
> I've tried some solutions, no one worked out of the box:
>
> 1. disable all relevant irqs (timer, network) at CAN irq_handler
> (irq_handler_entry: irq=30 name=can0), and enable them at the end of CAN
> threaded interrupt job processing (at91_irq_r)
>

That's wrong in so many ways, please don't do that.

> 2. configure CAN job (at91_irq) to run inside the CAN irq_handler
> (irq_handler_entry: irq=30 name=can0) by adding IRQF_NO_THREAD flag to
> request_irq.

ditto.

Good luck,

--
Ahmed S. Darwish
Linutronix GmbH
