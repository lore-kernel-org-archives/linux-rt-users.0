Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB738C432BE
	for <linux-rt-users@archiver.kernel.org>; Tue, 31 Aug 2021 10:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 914CF60F6C
	for <linux-rt-users@archiver.kernel.org>; Tue, 31 Aug 2021 10:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbhHaKJk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 31 Aug 2021 06:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbhHaKJj (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 31 Aug 2021 06:09:39 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEFCC061575;
        Tue, 31 Aug 2021 03:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MYa0ikixZAEhuIDeg7K7D5PylKHd6fZI3U61Ut+EyJk=; b=A5XLh7AhNuGufuKfP37eirFZ1h
        eSanDU3emJic5nnU0Y9B1wku4zkwNgNWxxbsDJWGutC7kflq2gweG9/ulF7CG7iB0fpF3qSXbUFK5
        sWPJn2fmoLKWpcWLzKTLkmQ/YT+0630uAX2erYLKPRFnCAlkZPHWM1TuFmX8DqoNV9p21zOFQ05zG
        bG/bHZJW6twRuzRXdrTiSLsM0MjugZ3z845Db1H9mc4zFxXR93feib9xgWSKYkRzyGDyctme9EBKL
        kK5kTvtY5F7JBMJJkib45EgY2FpzWGs+HPTbcm0j6D/Smv//zvOwINMdLU5tvbudZrvyLtv0RbOa8
        4vlSuZbQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mL0gj-00Efh5-6Q; Tue, 31 Aug 2021 10:08:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2AE363001F6;
        Tue, 31 Aug 2021 12:08:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 09CA72C83EAD6; Tue, 31 Aug 2021 12:08:15 +0200 (CEST)
Date:   Tue, 31 Aug 2021 12:08:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     mingo@redhat.com, mgorman@suse.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        achaiken@aurora.tech, lkp@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v3 0/7] sched: support schedstats for RT sched class
Message-ID: <YS3/jhuRNS2GGVrp@hirez.programming.kicks-ass.net>
References: <20210824112946.9324-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824112946.9324-1-laoar.shao@gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Aug 24, 2021 at 11:29:39AM +0000, Yafang Shao wrote:
> Hi Ingo, Peter,
> 
> This feature is useful to trace the sched details of RT tasks. Hopefully
> you can give some feedback on it.
> 
> We want to measure the latency of RT tasks in our production
> environment with schedstats facility, but currently schedstats is only
> supported for fair sched class. In order to support if for other sched
> classes, we should make it independent of fair sched class. The struct
> sched_statistics is the schedular statistics of a task_struct or a
> task_group, both of which are independent of sched class. So we can move
> struct sched_statistics into struct task_struct and struct task_group to
> achieve the goal.

Do you really want schedstats or do you want the tracepoints? In general
I really want to cut back on the built-in statistics crud we carry,
there's too much and it seems to keep growing forever :-(

(as is the case here, you're extending it as well)

That said; making schedstats cover the other classes can be seen as
fixing an inconsistency, but then you forgot deadline.

> After the patchset, schestats are orgnized as follows,
> struct task_struct {
>     ...
>     struct sched_statistics statistics;
>     ...
>     struct sched_entity *se;
>     struct sched_rt_entity *rt;
>     ...
> };
> 
> struct task_group {                    |---> stats[0] : of CPU0
>     ...                                |
>     struct sched_statistics **stats; --|---> stats[1] : of CPU1
>     ...                                |
>                                        |---> stats[n] : of CPUn
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>     struct sched_entity **se;
>  #endif
>  #ifdef CONFIG_RT_GROUP_SCHED
>     struct sched_rt_entity  **rt_se;
>  #endif
>     ...
> };

Yeah, this seems to give a terrible mess, let me see if I can come up
with anything less horrible.
