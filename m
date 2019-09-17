Return-Path: <SRS0=0Kbd=XM=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA54C4CEC9
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Sep 2019 16:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EAA82171F
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Sep 2019 16:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbfIQQue (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 17 Sep 2019 12:50:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43027 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727545AbfIQQue (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 17 Sep 2019 12:50:34 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iAGgN-0004H6-2z; Tue, 17 Sep 2019 18:50:27 +0200
Date:   Tue, 17 Sep 2019 18:50:27 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Scott Wood <swood@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH RT 8/8] sched: Lazy migrate_disable processing
Message-ID: <20190917165026.pv3neijrpxrszdzo@linutronix.de>
References: <20190727055638.20443-1-swood@redhat.com>
 <20190727055638.20443-9-swood@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190727055638.20443-9-swood@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-07-27 00:56:38 [-0500], Scott Wood wrote:
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 885a195dfbe0..0096acf1a692 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -939,17 +893,34 @@ static int takedown_cpu(unsigned int cpu)
>  	 */
>  	irq_lock_sparse();
>  
> -#ifdef CONFIG_PREEMPT_RT_FULL
> -	__write_rt_lock(cpuhp_pin);
> +#ifdef CONFIG_PREEMPT_RT_BASE
> +	WARN_ON_ONCE(takedown_cpu_task);
> +	takedown_cpu_task = current;
> +
> +again:
> +	for (;;) {
> +		int nr_pinned;
> +
> +		set_current_state(TASK_UNINTERRUPTIBLE);
> +		nr_pinned = cpu_nr_pinned(cpu);
> +		if (nr_pinned == 0)
> +			break;
> +		schedule();
> +	}

we used to have cpuhp_pin which ensured that once we own the write lock
there will be no more tasks that can enter a migrate_disable() section
on this CPU. It has been placed fairly late to ensure that nothing new
comes in as part of the shutdown process and that it flushes everything
out that is still in a migrate_disable() section.
Now you claim that once the counter reached zero it never increments
again. I would be happier if there was an explicit check for that :)
There is no back off and flush mechanism which means on a busy CPU (as
in heavily lock contended by multiple tasks) this will wait until the
CPU gets idle again.

> +	set_current_state(TASK_RUNNING);
>  #endif

Sebastian
