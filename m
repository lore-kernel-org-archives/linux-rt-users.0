Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07D0C433C1
	for <linux-rt-users@archiver.kernel.org>; Tue, 30 Mar 2021 04:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63E7A61989
	for <linux-rt-users@archiver.kernel.org>; Tue, 30 Mar 2021 04:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbhC3Eq3 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 30 Mar 2021 00:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhC3EqF (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 30 Mar 2021 00:46:05 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A506BC061762
        for <linux-rt-users@vger.kernel.org>; Mon, 29 Mar 2021 21:46:05 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id ay2so5501983plb.3
        for <linux-rt-users@vger.kernel.org>; Mon, 29 Mar 2021 21:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=p4FxBnti1H3ZwkDYi4S/dCykQqVluQxiwAy9roEypVs=;
        b=o35Ty0H3VvDzg9rlBW7XhxStnvusiJOPlqQ72ivH0h5iDwYc+lTNW0w4PAnuVHSNm8
         HEpoggS33eeQ0OpyPsIDAQzQN9zwU7TxCOkbc8SsQSLv2JCSU3Vf/evqU+c9qiWRSDuo
         LBwxXcjhi8Vys/plazQME1CL9O09s4KLqoCQ+pzza9yFX6tsGaEt5J7AobrNtqK0Pkzh
         vBYR4tM6ucIBq/6ByN3yuyhmmmZE56UD7z5d61WrYj6+WVvOheTfKG7/AELzXVakHrE0
         NEQkR8LnszlemthvLMpHy4A7T6c5Ezk/2I3yVHP5Nujm/MD44gfXFVol9jSQAQSST2pp
         I5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=p4FxBnti1H3ZwkDYi4S/dCykQqVluQxiwAy9roEypVs=;
        b=gjzylWt1dSiSCcpo+sjGFtS0XFt3kSVH/u1XwbUv+bmco5IQZ2HP/ENElyAhdgygSH
         hzyDg42vg39rr69BYRVzurtAj0Pg93wlQO18lvQgoKoT5fCao7Z8nRFwyD0OGTMz1l3P
         vz4X3xjfZHcR9J0UZ6WRdo6v0gUWFga3qHthGGYx+po0dEI97nQLVfperyRYNMagZNJr
         dPs3cRjiBmW2IqwsZhJs4fMdbKLbp//qUFvEPwTF1/Lcu3/uriQ2KqsYgZmFpdQcVE+1
         qRxwgwaQDifIOgrIfsR2L9s2PHJpqTvVCt8leFX5lB4RUqD2/EA+1b1qsXvLeY6zWdwN
         q6sQ==
X-Gm-Message-State: AOAM5324JGxjJ6ueviiUzBtlEI3JL8HqkwutWA8Fn0cX8MSgvDZs+SNB
        3NbXpF3AhER3HHuXYpSpGmlq8Q==
X-Google-Smtp-Source: ABdhPJzhud6D+YRGVUSF+8oShoicYscn81bnqNalArLxAamMHJUmSlHuQoU0ZyBrSPXOtdCM7DS4Rw==
X-Received: by 2002:a17:90b:4b08:: with SMTP id lx8mr2442666pjb.135.1617079565036;
        Mon, 29 Mar 2021 21:46:05 -0700 (PDT)
Received: from localhost ([136.185.154.93])
        by smtp.gmail.com with ESMTPSA id t4sm1264891pjs.12.2021.03.29.21.46.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Mar 2021 21:46:04 -0700 (PDT)
Date:   Tue, 30 Mar 2021 10:16:02 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ran Wang <ran.wang_1@nxp.com>
Cc:     Sebastian Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiafei Pan <jiafei.pan@nxp.com>,
        linux-rt-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] rt: cpufreq: Fix cpu hotplug hang
Message-ID: <20210330044602.gtouftuzklm4sdnr@vireshk-i7>
References: <20210330031513.17903-1-ran.wang_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210330031513.17903-1-ran.wang_1@nxp.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 30-03-21, 11:15, Ran Wang wrote:
> When selecting PREEMPT_RT, cpufreq_driver->stop_cpu(policy) might get
> stuck due to irq_work_sync() pending for work on lazy_list, which had
> no chance to be served in softirq context sometimes.
> 
> The reason of lazy_list was not served is because the nearest activated
> timer might have been set to expire after long time (such as 100+ seconds).
> Then function run_local_timers() would not call raise_softirq(TIMER_SOFTIRQ)
> to handle enqueued irq_work.
> 
> This is observed on LX2160ARDB and LS1088ARDB with cpufreq governor of
> ‘schedutil’ or ‘ondemand’.
> 
> Configure related irqwork to run on raw-irq context could fix this issue.
> 
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> ---
> Change in v2:
>  - Update commit message to explain root cause more clear.
> 
>  drivers/cpufreq/cpufreq_governor.c | 2 +-
>  kernel/sched/cpufreq_schedutil.c   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> index 63f7c219062b..731a7b1434df 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -360,7 +360,7 @@ static struct policy_dbs_info *alloc_policy_dbs_info(struct cpufreq_policy *poli
>  	policy_dbs->policy = policy;
>  	mutex_init(&policy_dbs->update_mutex);
>  	atomic_set(&policy_dbs->work_count, 0);
> -	init_irq_work(&policy_dbs->irq_work, dbs_irq_work);
> +	policy_dbs->irq_work = IRQ_WORK_INIT_HARD(dbs_irq_work);
>  	INIT_WORK(&policy_dbs->work, dbs_work_handler);
>  
>  	/* Set policy_dbs for all CPUs, online+offline */
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 50cbad89f7fa..1d5af87ec92e 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -611,7 +611,7 @@ static int sugov_kthread_create(struct sugov_policy *sg_policy)
>  
>  	sg_policy->thread = thread;
>  	kthread_bind_mask(thread, policy->related_cpus);
> -	init_irq_work(&sg_policy->irq_work, sugov_irq_work);
> +	sg_policy->irq_work = IRQ_WORK_INIT_HARD(sugov_irq_work);
>  	mutex_init(&sg_policy->work_lock);
>  
>  	wake_up_process(thread);

Will this have any impact on the non-preempt-rt case ? Otherwise,

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
