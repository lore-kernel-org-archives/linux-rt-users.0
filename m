Return-Path: <SRS0=yCAb=37=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CDDC352A3
	for <linux-rt-users@archiver.kernel.org>; Tue, 11 Feb 2020 17:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AA6D206CC
	for <linux-rt-users@archiver.kernel.org>; Tue, 11 Feb 2020 17:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbgBKRtT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 11 Feb 2020 12:49:19 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46991 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728601AbgBKRtT (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 11 Feb 2020 12:49:19 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1j1Zet-0006CR-QD; Tue, 11 Feb 2020 18:49:15 +0100
Date:   Tue, 11 Feb 2020 18:49:15 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Joe Korty <joe.korty@concurrent-rt.com>,
        Tom Zanussi <zanussi@kernel.org>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH 4.14-rt] Fix wrong-variable use in
 irq_set_affinity_notifier
Message-ID: <20200211174915.mh5bntkysztjmjdd@linutronix.de>
References: <20200211140007.GA6791@zipoli.concurrent-rt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200211140007.GA6791@zipoli.concurrent-rt.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-02-11 09:00:07 [-0500], Joe Korty wrote:
> 4.14-rt: Fix wrong-variable use in irq_set_affinity_notifier.
> 
> The bug was introduced in the 4.14-rt patch
>  
>    0461-genirq-Handle-missing-work_struct-in-irq_set_affinit.patch
> 
> The symptom is a NULL pointer panic in the i40e driver on
> system shutdown.
…
> 4.19-rt and above do not have this problem due to a refactoring.

That would be Tom's to pick. Is v4.14-RT the only one affected? I was
under the impression that we fixed it already in each stable rt tree.

> Signed-off-by: Joe Korty <Joe.Korty@concurrent-rt.com>
> 
> Index: b/kernel/irq/manage.c
> ===================================================================
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -353,7 +353,7 @@ irq_set_affinity_notifier(unsigned int i
>  
>  	if (old_notify) {
>  #ifdef CONFIG_PREEMPT_RT_BASE
> -		kthread_cancel_work_sync(&notify->work);
> +		kthread_cancel_work_sync(&old_notify->work);
>  #else
>  		cancel_work_sync(&old_notify->work);
>  #endif

Sebastian
