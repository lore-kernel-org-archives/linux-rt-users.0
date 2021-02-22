Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E38C433DB
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Feb 2021 14:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0613D64E5C
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Feb 2021 14:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbhBVOCU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 22 Feb 2021 09:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbhBVOBv (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 Feb 2021 09:01:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C105CC06174A
        for <linux-rt-users@vger.kernel.org>; Mon, 22 Feb 2021 06:01:10 -0800 (PST)
Date:   Mon, 22 Feb 2021 15:01:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614002469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ne8Bp7t1XIoJcHo9GF7erWwdLw1EggzRqtdBGbfaQZI=;
        b=ye3NwVswRDUyRQSYVL/KJ5gc3ffBWaTbrolWFB/zeGSIpS08+5zRzk3Mpr3Dx0mloYiF+q
        CfhAiyqXzcw7JycAV5Ne8VCdrzw3cxu2FeQ+kzEx3MjoeLMhDaba97fPm85JSGBHzi+NIj
        d+a03swG06KCtPOBWMuwx+dS6k7wp+yF24FCwZHALBSuXe1IkFHiAjOD6dKaBtA6N+KAsN
        qPqLDE8iBbWraTdLRg3s/L9wP3dv7obOXfjtIFMXcuZO4kS24iv4xL470XUPNN7Dy98NnI
        7CSyVSOlTUgHwoXkKxKbrQ+5LXosuIbTxLZueeeEaSm03HMK4Ga80S3bf07raw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614002469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ne8Bp7t1XIoJcHo9GF7erWwdLw1EggzRqtdBGbfaQZI=;
        b=tKbXAFGOVy27Se2x4oac43hHdH62Oo90/UWSV+nOmqzmfeYmgPX9fdjc+u26UzTARMHZiU
        6zLe30pem1iBteBg==
From:   Sebastian Siewior <bigeasy@linutronix.de>
To:     Ran Wang <ran.wang_1@nxp.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jiafei Pan <jiafei.pan@nxp.com>,
        linux-rt-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] rt: cpufreq: Fix cpu hotplug hang
Message-ID: <20210222140107.qk2ymlwyyxspluge@linutronix.de>
References: <20210219084420.23379-1-ran.wang_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210219084420.23379-1-ran.wang_1@nxp.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-02-19 16:44:20 [+0800], Ran Wang wrote:
> When selecting PREEMPT_RT, cpufreq_driver->stop_cpu(policy) might got
> stuck due to irq_work_sync() pending for work on lazy_list. That=E2=80=99s
> because lazy_list may have no chance to be served in softirq context
> sometimes. Below is one of scenarios that was captured:
>=20
> ...
> ret_from_fork
>  kthread
>   smpboot_thread_fn
>    cpuhp_thread_fun
>     cpuhp_invoke_callback: state: 193
>      cpuhp_cpufreq_online
>       cpufreq_online
>        cpufreq_driver->stop_cpu(policy);
>         cpufreq_dbs_governor_stop
>          sugov_stop  // kernel/sched/cpufreq_schedutil.c
>           irq_work_sync(&sg_policy->irq_work);
>=20
> This is observed on LX2160ARDB (16 A72 cores) with cpufreq governor of
> =E2=80=98schedutil=E2=80=99 or =E2=80=98ondemand=E2=80=99.

While staring at it, why do we invoke schedule_work_on() and
kthread_queue_work() from inside irq_work() instead invoking it
directly? It raises an interrupt in which it kicks a user thread.
Couldn't we do it without irq_work?

Sebastian
