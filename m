Return-Path: <SRS0=RNtb=7C=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7C4C433E0
	for <linux-rt-users@archiver.kernel.org>; Wed, 20 May 2020 17:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 107D620709
	for <linux-rt-users@archiver.kernel.org>; Wed, 20 May 2020 17:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589994143;
	bh=pKI8F0u3oqj9vK9T327Bk0pkG9mPYMPmZF4zagVhXYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dN7k2CyQlaJQF0Xmh56u4vInnF4kTkhibdRrSOq8gNs1/JPhYyLTg5lriVEM8+QHu
	 KI1otF/yXly4jPNGFrGkOOxBPnvZ6cOugYQFZ5W0JD573Ux5VsOSCLDxv6k0R1S2Xg
	 nIgZJqGTVh2EhIkAx82s58wtpGqa/Fkv1LDjj6/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgETRCU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 20 May 2020 13:02:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:48878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgETRCT (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 20 May 2020 13:02:19 -0400
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84DAF20708;
        Wed, 20 May 2020 17:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589994139;
        bh=pKI8F0u3oqj9vK9T327Bk0pkG9mPYMPmZF4zagVhXYk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yfpDsdz0pR9Dtpfr9mEFoBX8Y3eUYaZuGtSGbYqOt49a2WhXNGlnpYtNfaYd0Weq0
         jrE2Ak1ARVTmKKbWmsbWiJUfRea/4LnvY/PUakEpxT1awn5iPxUN65zKPvfT3lXsrC
         nm2uklgbOBnYzNO5lseCoMMb7G7NdPmtMe0IPswM=
Date:   Wed, 20 May 2020 19:02:16 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org,
        linux-rt-users@vger.kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] tick/sched: update full_nohz status after SCHED dep
 is cleared
Message-ID: <20200520170215.GB8800@lenoir>
References: <20200520140402.358880-1-juri.lelli@redhat.com>
 <20200520162400.GA8800@lenoir>
 <20200520164925.GM10078@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520164925.GM10078@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, May 20, 2020 at 06:49:25PM +0200, Juri Lelli wrote:
> On 20/05/20 18:24, Frederic Weisbecker wrote:
> 
> Hummm, so I enabled 'timer:*', anything else you think I should be
> looking at?

Are you sure you also enabled timer_expire_entry?
Because:

> 
> ...
> ksoftirqd/13-117   [013]   148.265945: softirq_entry:        vec=1 [action=TIMER]

...the timer softirq keep triggering without any timer callback executed. If that's the
case, we may be dealing with an interesting issue.

Thanks.

> ksoftirqd/13-117   [013]   148.265947: softirq_exit:         vec=1 [action=TIMER]
> ksoftirqd/13-117   [013]   148.265948: softirq_entry:        vec=7 [action=SCHED]
> ksoftirqd/13-117   [013]   148.265950: softirq_exit:         vec=7 [action=SCHED]
> ksoftirqd/13-117   [013]   148.265952: sched_switch:         ksoftirqd/13:117 [120] S ==> sysjitter:2536 [120]
>    sysjitter-2536  [013]   148.266912: local_timer_entry:    vector=236
>    sysjitter-2536  [013]   148.266914: hrtimer_cancel:       hrtimer=0xffff9807df91bee0
>    sysjitter-2536  [013]   148.266916: hrtimer_expire_entry: hrtimer=0xffff9807df91bee0 now=148249107837 function=tick_sched_timer/0x0
>    sysjitter-2536  [013]   148.266918: softirq_raise:        vec=1 [action=TIMER]
>    sysjitter-2536  [013]   148.266920: softirq_raise:        vec=7 [action=SCHED]
>    sysjitter-2536  [013]   148.266922: hrtimer_expire_exit:  hrtimer=0xffff9807df91bee0
>    sysjitter-2536  [013]   148.266924: hrtimer_start:        hrtimer=0xffff9807df91bee0 function=tick_sched_timer/0x0 expires=148250105422 softexpires=148250105422
>    sysjitter-2536  [013]   148.266926: local_timer_exit:     vector=236
>    sysjitter-2536  [013]   148.266930: sched_wakeup:         ksoftirqd/13:117 [120] success=1 CPU:013
>    sysjitter-2536  [013]   148.266932: tick_stop:            success=0 dependency=SCHED
>    sysjitter-2536  [013]   148.266934: irq_work_entry:       vector=246
>    sysjitter-2536  [013]   148.266936: irq_work_exit:        vector=246
>    sysjitter-2536  [013]   148.266937: tick_stop:            success=0 dependency=SCHED
>    sysjitter-2536  [013]   148.266940: sched_switch:         sysjitter:2536 [120] R ==> ksoftirqd/13:117 [120]
> ksoftirqd/13-117   [013]   148.266943: softirq_entry:        vec=1 [action=TIMER]
> ksoftirqd/13-117   [013]   148.266946: softirq_exit:         vec=1 [action=TIMER]
> ksoftirqd/13-117   [013]   148.266946: softirq_entry:        vec=7 [action=SCHED]
> ksoftirqd/13-117   [013]   148.266948: softirq_exit:         vec=7 [action=SCHED]
> ksoftirqd/13-117   [013]   148.266950: sched_switch:         ksoftirqd/13:117 [120] S ==> sysjitter:2536 [120]
>    sysjitter-2536  [013]   148.267912: local_timer_entry:    vector=236
>    sysjitter-2536  [013]   148.267914: hrtimer_cancel:       hrtimer=0xffff9807df91bee0
>    sysjitter-2536  [013]   148.267916: hrtimer_expire_entry: hrtimer=0xffff9807df91bee0 now=148250107750 function=tick_sched_timer/0x0
>    sysjitter-2536  [013]   148.267918: softirq_raise:        vec=1 [action=TIMER]
>    sysjitter-2536  [013]   148.267920: softirq_raise:        vec=7 [action=SCHED]
>    sysjitter-2536  [013]   148.267922: hrtimer_expire_exit:  hrtimer=0xffff9807df91bee0
>    sysjitter-2536  [013]   148.267924: hrtimer_start:        hrtimer=0xffff9807df91bee0 function=tick_sched_timer/0x0 expires=148251105422 softexpires=148251105422
>    sysjitter-2536  [013]   148.267926: local_timer_exit:     vector=236
>    sysjitter-2536  [013]   148.267929: sched_wakeup:         ksoftirqd/13:117 [120] success=1 CPU:013
>    sysjitter-2536  [013]   148.267931: tick_stop:            success=0 dependency=SCHED
>    sysjitter-2536  [013]   148.267934: irq_work_entry:       vector=246
>    sysjitter-2536  [013]   148.267936: irq_work_exit:        vector=246
>    sysjitter-2536  [013]   148.267937: tick_stop:            success=0 dependency=SCHED
>    sysjitter-2536  [013]   148.267940: sched_switch:         sysjitter:2536 [120] R ==> ksoftirqd/13:117 [120]
> ksoftirqd/13-117   [013]   148.267943: softirq_entry:        vec=1 [action=TIMER]
> ksoftirqd/13-117   [013]   148.267945: softirq_exit:         vec=1 [action=TIMER]
> ksoftirqd/13-117   [013]   148.267946: softirq_entry:        vec=7 [action=SCHED]
> ksoftirqd/13-117   [013]   148.267947: softirq_exit:         vec=7 [action=SCHED]
> ksoftirqd/13-117   [013]   148.267949: sched_switch:         ksoftirqd/13:117 [120] S ==> sysjitter:2536 [120]
>    sysjitter-2536  [013]   148.268865: call_function_single_entry: vector=251
>    sysjitter-2536  [013]   148.268867: call_function_single_exit: vector=251
>    sysjitter-2536  [013]   148.268870: tick_stop:            success=1 dependency=NONE
>    sysjitter-2536  [013]   148.268872: hrtimer_cancel:       hrtimer=0xffff9807df91bee0
>    sysjitter-2536  [013]   148.268876: call_function_single_entry: vector=251
>    sysjitter-2536  [013]   148.268878: call_function_single_exit: vector=251
> ...
> 
> it looks like tick sched timer is kept armed until tick_stop
> succedes (because of the check performed after _single_exit)?
> 
> Thanks for your quick reply!
> 
