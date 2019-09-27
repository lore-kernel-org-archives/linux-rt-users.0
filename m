Return-Path: <SRS0=wj13=XW=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE52BC352AB
	for <linux-rt-users@archiver.kernel.org>; Fri, 27 Sep 2019 08:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBB552146E
	for <linux-rt-users@archiver.kernel.org>; Fri, 27 Sep 2019 08:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbfI0ILq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 27 Sep 2019 04:11:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60965 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbfI0ILq (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 27 Sep 2019 04:11:46 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E41CCC05AA58
        for <linux-rt-users@vger.kernel.org>; Fri, 27 Sep 2019 08:11:45 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id w8so696231wrm.3
        for <linux-rt-users@vger.kernel.org>; Fri, 27 Sep 2019 01:11:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pPrTuKk2wLdZOfUDuO7yrMjO/e9382JtMmczzGLdwP4=;
        b=BjI7o7GbIU0EcdFCrQ2nvcbyR7Jb+RnahNB2ZLzs+/Hbynyeb6lRaisrdFZDbOx0Rz
         KfwG7yDCv8D0AklcsoDS74UTcQEw3567JXL21Muv8OlboQ2m3ucemUlCFbu8PUF73Zjv
         WYWUTqfSmFyar26yYkAIBD+Hkcr/TK4NscgUYzEn79Npb4xA6Uf1MyaenL4eVGfq/PlP
         muIRPn/LUC/NKai/b4QR/UrvSltzPVQ0Jczr5mtM5Pv3WOdJjmpxdthcY41ukHhsHOjy
         3cPzu7DyoRxW6HkOm/en648myxZkTxekawOQX5p+mxT2xZd7+XgaRNKQCwmfJkwJa+vu
         AmKw==
X-Gm-Message-State: APjAAAUIHV7APmkxZda67sdg2g/8oLstfSBfVONggplR2JsKzLuopj5N
        sTT55RSjmjrrOUIh4KCO4CFqfZcb1LRtM77hGAZzZbXJ8VtpqXA2kbL1KXFkNmqHwdDHoo5djet
        lw65NhYInHFjxkNL5CgnY3H61Ccs=
X-Received: by 2002:a1c:7418:: with SMTP id p24mr5857435wmc.132.1569571904506;
        Fri, 27 Sep 2019 01:11:44 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzAwxtJAN4HD53FB2NTvALXb2oR6uoMP4Tujox2rhYOh66Hcxkn+J2iVBsOgpM7gJWutAgtJg==
X-Received: by 2002:a1c:7418:: with SMTP id p24mr5857414wmc.132.1569571904151;
        Fri, 27 Sep 2019 01:11:44 -0700 (PDT)
Received: from localhost.localdomain ([151.29.237.241])
        by smtp.gmail.com with ESMTPSA id q3sm1688984wrm.86.2019.09.27.01.11.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Sep 2019 01:11:43 -0700 (PDT)
Date:   Fri, 27 Sep 2019 10:11:41 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Scott Wood <swood@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH RT 5/8] sched/deadline: Reclaim cpuset bandwidth in
 .migrate_task_rq()
Message-ID: <20190927081141.GB31660@localhost.localdomain>
References: <20190727055638.20443-1-swood@redhat.com>
 <20190727055638.20443-6-swood@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190727055638.20443-6-swood@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Scott,

On 27/07/19 00:56, Scott Wood wrote:
> With the changes to migrate disabling, ->set_cpus_allowed() no longer
> gets deferred until migrate_enable().  To avoid releasing the bandwidth
> while the task may still be executing on the old CPU, move the subtraction
> to ->migrate_task_rq().
> 
> Signed-off-by: Scott Wood <swood@redhat.com>
> ---
>  kernel/sched/deadline.c | 67 +++++++++++++++++++++++--------------------------
>  1 file changed, 31 insertions(+), 36 deletions(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index c18be51f7608..2f18d0cf1b56 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1606,14 +1606,42 @@ static void yield_task_dl(struct rq *rq)
>  	return cpu;
>  }
>  
> +static void free_old_cpuset_bw_dl(struct rq *rq, struct task_struct *p)
> +{
> +	struct root_domain *src_rd = rq->rd;
> +
> +	/*
> +	 * Migrating a SCHED_DEADLINE task between exclusive
> +	 * cpusets (different root_domains) entails a bandwidth
> +	 * update. We already made space for us in the destination
> +	 * domain (see cpuset_can_attach()).
> +	 */
> +	if (!cpumask_intersects(src_rd->span, p->cpus_ptr)) {
> +		struct dl_bw *src_dl_b;
> +
> +		src_dl_b = dl_bw_of(cpu_of(rq));
> +		/*
> +		 * We now free resources of the root_domain we are migrating
> +		 * off. In the worst case, sched_setattr() may temporary fail
> +		 * until we complete the update.
> +		 */
> +		raw_spin_lock(&src_dl_b->lock);
> +		__dl_sub(src_dl_b, p->dl.dl_bw, dl_bw_cpus(task_cpu(p)));
> +		raw_spin_unlock(&src_dl_b->lock);
> +	}
> +}
> +
>  static void migrate_task_rq_dl(struct task_struct *p, int new_cpu __maybe_unused)
>  {
>  	struct rq *rq;
>  
> -	if (p->state != TASK_WAKING)
> +	rq = task_rq(p);
> +
> +	if (p->state != TASK_WAKING) {
> +		free_old_cpuset_bw_dl(rq, p);

What happens if a DEADLINE task is moved between cpusets while it was
sleeping? Don't we miss removing from the old cpuset if the task gets
migrated on wakeup?

Thanks,

Juri
