Return-Path: <SRS0=0Kbd=XM=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AA0C4CEC9
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Sep 2019 15:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39AEB214AF
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Sep 2019 15:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbfIQPbR (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 17 Sep 2019 11:31:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42249 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729417AbfIQPbR (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 17 Sep 2019 11:31:17 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iAFRe-0001LW-72; Tue, 17 Sep 2019 17:31:10 +0200
Date:   Tue, 17 Sep 2019 17:31:10 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Scott Wood <swood@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH RT 6/8] sched: migrate_enable: Set state to TASK_RUNNING
Message-ID: <20190917153110.fgi6ilb6mpfkcwbr@linutronix.de>
References: <20190727055638.20443-1-swood@redhat.com>
 <20190727055638.20443-7-swood@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190727055638.20443-7-swood@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-07-27 00:56:36 [-0500], Scott Wood wrote:
> If migrate_enable() is called while a task is preparing to sleep
> (state != TASK_RUNNING), that triggers a debug check in stop_one_cpu().
> Explicitly reset state to acknowledge that we're accepting the spurious
> wakeup.
> 
> Signed-off-by: Scott Wood <swood@redhat.com>
> ---
>  kernel/sched/core.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 38a9a9df5638..eb27a9bf70d7 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7396,6 +7396,14 @@ void migrate_enable(void)
>  			unpin_current_cpu();
>  			preempt_lazy_enable();
>  			preempt_enable();
> +
> +			/*
> +			 * Avoid sleeping with an existing non-running
> +			 * state.  This will result in a spurious wakeup
> +			 * for the calling context.
> +			 */
> +			__set_current_state(TASK_RUNNING);

Do you have an example for this? I'm not too sure if we are not using a
state by doing this. Actually we were losing it and get yelled at.  We do:
|rt_spin_unlock()
|{
|         rt_spin_lock_fastunlock();
|         migrate_enable();
|}

So save the state as part of the locking process and lose it as part of
migrate_enable() if the CPU mask was changed. I *think* we need to
preserve that state until after the migration to the other CPU.

>  			sleeping_lock_inc();
>  			stop_one_cpu(task_cpu(p), migration_cpu_stop, &arg);
>  			sleeping_lock_dec();

Sebastian
