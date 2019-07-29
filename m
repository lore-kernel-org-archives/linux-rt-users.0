Return-Path: <SRS0=IcT/=V2=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138C1C433FF
	for <linux-rt-users@archiver.kernel.org>; Mon, 29 Jul 2019 13:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7388216C8
	for <linux-rt-users@archiver.kernel.org>; Mon, 29 Jul 2019 13:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387449AbfG2N05 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 29 Jul 2019 09:26:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:38790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726960AbfG2N04 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 29 Jul 2019 09:26:56 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A304206E0;
        Mon, 29 Jul 2019 13:26:55 +0000 (UTC)
Date:   Mon, 29 Jul 2019 09:26:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Scott Wood <swood@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH RT 1/8] sched: migrate_enable: Use sleeping_lock to
 indicate involuntary sleep
Message-ID: <20190729092653.20bcc45e@gandalf.local.home>
In-Reply-To: <20190727055638.20443-2-swood@redhat.com>
References: <20190727055638.20443-1-swood@redhat.com>
        <20190727055638.20443-2-swood@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Sat, 27 Jul 2019 00:56:31 -0500
Scott Wood <swood@redhat.com> wrote:

> Without this, rcu_note_context_switch() will complain if an RCU read
> lock is held when migrate_enable() calls stop_one_cpu().
> 
> Signed-off-by: Scott Wood <swood@redhat.com>
>

> index d3c6542b306f..c3407707e367 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7405,7 +7405,9 @@ void migrate_enable(void)
>  			unpin_current_cpu();
>  			preempt_lazy_enable();
>  			preempt_enable();

This looks like it needs a comment to explain why this is.

-- Steve

> +			sleeping_lock_inc();
>  			stop_one_cpu(task_cpu(p), migration_cpu_stop, &arg);
> +			sleeping_lock_dec();
>  			return;
>  		}
>  	}

