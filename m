Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D598EC433DB
	for <linux-rt-users@archiver.kernel.org>; Wed, 24 Feb 2021 16:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AFE664EF1
	for <linux-rt-users@archiver.kernel.org>; Wed, 24 Feb 2021 16:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbhBXQkg (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 24 Feb 2021 11:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235219AbhBXQib (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 24 Feb 2021 11:38:31 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE49C061574
        for <linux-rt-users@vger.kernel.org>; Wed, 24 Feb 2021 08:37:48 -0800 (PST)
Date:   Wed, 24 Feb 2021 17:37:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614184667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gufceKp16mUIobcpX2euV3P3lTUU1VtK71ljzCH1oJI=;
        b=r0CM2+Y3/TifIT7VM/BioV4CTh3HXrQLg5tWJ0KtjzxCvJxn19PAIH5suDTZhJXO6JMa+M
        XET8u57Tt4YH/C6rnFt4OR6dd8jBRznuV1HHCnYlMeItjmrp/BaI9v2ox2kQkIkD6WGwVi
        FKEm90/GlbNB7U0qNtqm3q+1GLuPtaFDzbL/83YikRH+hLn0ioq3NTSb+ye2letYBHrrdG
        /WItXBQnnq6UUOXd+VfyJjmnQgrOm47+3l6hVXLoC7LGinbNSOCikROu6CFNXM5YyFXm6S
        4bSjIeH47ojxyGrbZVnVJWFnIK8a4+fIuuB6xoNIAlr73zCfrq7/vnvJYYJPkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614184667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gufceKp16mUIobcpX2euV3P3lTUU1VtK71ljzCH1oJI=;
        b=M9ApOoQb/BWFLHebjAKKyfCxUXu0e48SNvHOyXJF8Xt/5KVB++ljek7Sr5mzKs1TZ+qs7h
        beFiz2hef2onxDAw==
From:   Sebastian Siewior <bigeasy@linutronix.de>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ran Wang <ran.wang_1@nxp.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiafei Pan <jiafei.pan@nxp.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] rt: cpufreq: Fix cpu hotplug hang
Message-ID: <20210224163745.5lqhnjviznsjojtl@linutronix.de>
References: <20210219084420.23379-1-ran.wang_1@nxp.com>
 <20210222140107.qk2ymlwyyxspluge@linutronix.de>
 <AM6PR04MB5413DB3654A87D50C909004CF1809@AM6PR04MB5413.eurprd04.prod.outlook.com>
 <20210223031308.rjwswy5whejrme43@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210223031308.rjwswy5whejrme43@vireshk-i7>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-02-23 08:43:08 [+0530], Viresh Kumar wrote:
> On 23-02-21, 02:26, Ran Wang wrote:
> > On Monday, February 22, 2021 10:01 PM, Sebastian Siewior wrote:
> > > On 2021-02-19 16:44:20 [+0800], Ran Wang wrote:
> > > > When selecting PREEMPT_RT, cpufreq_driver->stop_cpu(policy) might g=
ot
> > > > stuck due to irq_work_sync() pending for work on lazy_list. That=E2=
=80=99s
> > > > because lazy_list may have no chance to be served in softirq context
> > > > sometimes. Below is one of scenarios that was captured:
> > > >
> > > > ...
> > > > ret_from_fork
> > > >  kthread
> > > >   smpboot_thread_fn
> > > >    cpuhp_thread_fun
> > > >     cpuhp_invoke_callback: state: 193
> > > >      cpuhp_cpufreq_online
> > > >       cpufreq_online
> > > >        cpufreq_driver->stop_cpu(policy);
> > > >         cpufreq_dbs_governor_stop
> > > >          sugov_stop  // kernel/sched/cpufreq_schedutil.c
> > > >           irq_work_sync(&sg_policy->irq_work);
> > > >
> > > > This is observed on LX2160ARDB (16 A72 cores) with cpufreq governor=
 of
> > > > =E2=80=98schedutil=E2=80=99 or =E2=80=98ondemand=E2=80=99.
> > >=20
> > > While staring at it, why do we invoke schedule_work_on() and
> > > kthread_queue_work() from inside irq_work() instead invoking it direc=
tly? It raises an interrupt in which it kicks a user thread.
> > > Couldn't we do it without irq_work?
>=20
> Because we reach there from scheduler's context, which must be
> hard-irq context..

Oha. Too bad.
Ran, any chance to figure out why the softirq can not be served?
ksoftirqd and the timer should be up.
Any numbers on how often that is irq_work is scheduled?

Sebastian
