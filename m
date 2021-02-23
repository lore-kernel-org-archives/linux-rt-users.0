Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5DDC433E0
	for <linux-rt-users@archiver.kernel.org>; Tue, 23 Feb 2021 03:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E9E164E4B
	for <linux-rt-users@archiver.kernel.org>; Tue, 23 Feb 2021 03:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhBWDNy (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 22 Feb 2021 22:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhBWDNx (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 Feb 2021 22:13:53 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89863C061574
        for <linux-rt-users@vger.kernel.org>; Mon, 22 Feb 2021 19:13:13 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id e6so1863977pgk.5
        for <linux-rt-users@vger.kernel.org>; Mon, 22 Feb 2021 19:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=vhHsi0uk5ltNxwhJcqtaD77NXzGldSTr71hD7QPJ/7g=;
        b=vBABbZpKOTDImCMES/3czKrDMP7JwUjGp5pdgtywySVT1IhRjEcK4BbkftRcGa9JHJ
         IslXD/uadbNVy/nhfxFwf7GEr7EuZvhqixPfXF6CzXGKHaNEXvkXNbgJnb9ZhFI6h6dO
         C10KcfS6pd4aMvbFGBzDxsxCtFupoc3rlVouAh5Imn9o1BmgPpCgBouEMvV9hEv97UUi
         sa9g6Tv/gWPYfseVhZ3RvScmKUbfX6rUbCrHO7PTEKkJzswu89osMaMswjvzO3mD4lqU
         vQQIUIAQkN3609SRoiYu/Mqjz3Dlrk+ReQQrePcuIJHUf7dTa7WGwI0S/fZkq5U4e3gC
         QH3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=vhHsi0uk5ltNxwhJcqtaD77NXzGldSTr71hD7QPJ/7g=;
        b=TGUeTydy2j4Gz7jtzOlugbufdwRA2tDnIcbg5kb1TwJ+3nN4dTDhIVWNfOmM5W+3vg
         rMQJZ1hQAk1CIeZ61bbS7fhCuSlE11P1ViZPFqeYI5CzxWEddmEvownzpRl9to364k8W
         QK8UqT3Pf10r0aAx+TNZVKmvoBwXxYlUANJ8CrHErWk77EUFupeDuzwR+znYTB48VkhM
         i3LpOOZTTDWMYETM4Iyit8YkOUH9kFjJcboqsEZa2Pulyq8xWxt/S5EcNijGzcyKquW+
         w7xT117zBoI4thQPTZBnsVum7beW3wBoYR6l5RFQI+BSHzInfhcYMZudkC61jqo8tWVE
         HJKA==
X-Gm-Message-State: AOAM533qm3q3D85GIQV9eTNXOlToxPbpUMxNZs6bEea2OM/LDpX5RjRA
        olFTnb6Vnhv+b4JDTSpVCvO/mQ==
X-Google-Smtp-Source: ABdhPJy2NFQglSw2zLxel3x/s8HfJkuvwj3WtwmeyOooz1mH4lPwOsIxVhlgaSEdp57rOklFCQAZ1g==
X-Received: by 2002:a63:6741:: with SMTP id b62mr14714665pgc.371.1614049993081;
        Mon, 22 Feb 2021 19:13:13 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id q7sm964225pjr.13.2021.02.22.19.13.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Feb 2021 19:13:12 -0800 (PST)
Date:   Tue, 23 Feb 2021 08:43:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ran Wang <ran.wang_1@nxp.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiafei Pan <jiafei.pan@nxp.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] rt: cpufreq: Fix cpu hotplug hang
Message-ID: <20210223031308.rjwswy5whejrme43@vireshk-i7>
References: <20210219084420.23379-1-ran.wang_1@nxp.com>
 <20210222140107.qk2ymlwyyxspluge@linutronix.de>
 <AM6PR04MB5413DB3654A87D50C909004CF1809@AM6PR04MB5413.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM6PR04MB5413DB3654A87D50C909004CF1809@AM6PR04MB5413.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 23-02-21, 02:26, Ran Wang wrote:
> On Monday, February 22, 2021 10:01 PM, Sebastian Siewior wrote:
> > On 2021-02-19 16:44:20 [+0800], Ran Wang wrote:
> > > When selecting PREEMPT_RT, cpufreq_driver->stop_cpu(policy) might got
> > > stuck due to irq_work_sync() pending for work on lazy_list. That’s
> > > because lazy_list may have no chance to be served in softirq context
> > > sometimes. Below is one of scenarios that was captured:
> > >
> > > ...
> > > ret_from_fork
> > >  kthread
> > >   smpboot_thread_fn
> > >    cpuhp_thread_fun
> > >     cpuhp_invoke_callback: state: 193
> > >      cpuhp_cpufreq_online
> > >       cpufreq_online
> > >        cpufreq_driver->stop_cpu(policy);
> > >         cpufreq_dbs_governor_stop
> > >          sugov_stop  // kernel/sched/cpufreq_schedutil.c
> > >           irq_work_sync(&sg_policy->irq_work);
> > >
> > > This is observed on LX2160ARDB (16 A72 cores) with cpufreq governor of
> > > ‘schedutil’ or ‘ondemand’.
> > 
> > While staring at it, why do we invoke schedule_work_on() and
> > kthread_queue_work() from inside irq_work() instead invoking it directly? It raises an interrupt in which it kicks a user thread.
> > Couldn't we do it without irq_work?

Because we reach there from scheduler's context, which must be
hard-irq context..

-- 
viresh
