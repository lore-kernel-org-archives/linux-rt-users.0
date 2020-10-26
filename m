Return-Path: <SRS0=SXCv=EB=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2930C4363A
	for <linux-rt-users@archiver.kernel.org>; Mon, 26 Oct 2020 19:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9182D207F7
	for <linux-rt-users@archiver.kernel.org>; Mon, 26 Oct 2020 19:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TKVsDOq6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TN19mZrQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbgJZTxL (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 26 Oct 2020 15:53:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42068 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbgJZTxL (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 26 Oct 2020 15:53:11 -0400
Date:   Mon, 26 Oct 2020 20:53:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603741989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lJg5YGePmU6j6NR6StU0tTV5p3YbB6fmqwehTRW4TuE=;
        b=TKVsDOq6M+JtvzpnEu1Sq69OnsNXOZzG2Nccb2wPThtZl0eyUkSaL+JDk42i5P+y9NDGer
        UnemZWqd/f+slSA6vsTskiYoya8u6JkuuGzujIJpzXMarUfbssIqpE813ZTo2BJeORZXtK
        b/fRwZ70e8E+ppmYy1ePatFi84zCTJdkAOwoEMe8K20rI32OYyiQgB2rCQSNx7spI/YeVr
        dhB5BjpdUN4Uh9hi4bBGiv2YGOOi9tYoXAsx66WostorcUSC3/ry5TwYyOI5uNr+aMAcuC
        uzNQoojo+T9KqJGS0prMctZB6Pl1CEegoj9MLEbKmyp1sCnANgMaqOiAmBDSnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603741989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lJg5YGePmU6j6NR6StU0tTV5p3YbB6fmqwehTRW4TuE=;
        b=TN19mZrQldCWAbxbH/5tLXDwOkl+v/ELMdVpm/wuxm+JqMXyluPf/VrlAtPK/UzrDrCpjs
        S2r8PrkSybP1C7AQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Hillf Danton <hdanton@sina.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: Re: kvm+nouveau induced lockdep  gripe
Message-ID: <20201026195308.wsbk7xy57wuzfbao@linutronix.de>
References: <20201021125324.ualpvrxvzyie6d7d@linutronix.de>
 <a23a826af7c108ea5651e73b8fbae5e653f16e86.camel@gmx.de>
 <20201023090108.5lunh4vqfpkllmap@linutronix.de>
 <20201024022236.19608-1-hdanton@sina.com>
 <20201024050000.8104-1-hdanton@sina.com>
 <20201026173107.quylcy6fgjvrqat6@linutronix.de>
 <431e81699f2310eabfe5af0a3de400ab99d9323b.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <431e81699f2310eabfe5af0a3de400ab99d9323b.camel@gmx.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-10-26 20:15:23 [+0100], Mike Galbraith wrote:
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/base.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/base.c
> @@ -116,7 +116,17 @@ nvkm_pci_oneinit(struct nvkm_subdev *sub
>  			return ret;
>  	}
> 
> +	/*
> +	 * Scheduler code taking cpuset_rwsem during irq thread initialization sets
> +	 * up a cpuset_rwsem vs mm->mmap_lock circular dependency gripe upon later
> +	 * cpuset usage. It's harmless, tell lockdep there's nothing to see here.
> +	 */
> +	if (force_irqthreads)
> +		lockdep_off();
>  	ret = request_irq(pdev->irq, nvkm_pci_intr, IRQF_SHARED, "nvkm", pci);
> +	if (force_irqthreads)
> +		lockdep_on();
> +
>  	if (ret)
>  		return ret;
> 
Could you try this, please?

--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1155,6 +1155,8 @@ static int irq_thread(void *data)
 	irqreturn_t (*handler_fn)(struct irq_desc *desc,
 			struct irqaction *action);
 
+	sched_set_fifo(current);
+
 	if (force_irqthreads && test_bit(IRQTF_FORCED_THREAD,
 					&action->thread_flags))
 		handler_fn = irq_forced_thread_fn;
@@ -1320,8 +1322,6 @@ setup_irq_thread(struct irqaction *new,
 	if (IS_ERR(t))
 		return PTR_ERR(t);
 
-	sched_set_fifo(t);
-
 	/*
 	 * We keep the reference to the task struct even if
 	 * the thread dies to avoid that the interrupt code


Sebastian
