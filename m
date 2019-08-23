Return-Path: <SRS0=4xIy=WT=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032FCC3A5A2
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Aug 2019 16:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A6B21726
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Aug 2019 16:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436695AbfHWQU0 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 23 Aug 2019 12:20:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36216 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389701AbfHWQU0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 23 Aug 2019 12:20:26 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1i1CIa-0005sk-7l; Fri, 23 Aug 2019 18:20:24 +0200
Date:   Fri, 23 Aug 2019 18:20:24 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Scott Wood <swood@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH RT v2 2/3] sched: migrate_enable: Use sleeping_lock to
 indicate involuntary sleep
Message-ID: <20190823162024.47t7br6ecfclzgkw@linutronix.de>
References: <20190821231906.4224-1-swood@redhat.com>
 <20190821231906.4224-3-swood@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190821231906.4224-3-swood@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-08-21 18:19:05 [-0500], Scott Wood wrote:
> Without this, rcu_note_context_switch() will complain if an RCU read
> lock is held when migrate_enable() calls stop_one_cpu().
> 
> Signed-off-by: Scott Wood <swood@redhat.com>
> ---
> v2: Added comment.
> 
> If my migrate disable changes aren't taken, then pin_current_cpu()
> will also need to use sleeping_lock_inc() because calling
> __read_rt_lock() bypasses the usual place it's done.
> 
>  include/linux/sched.h    | 4 ++--
>  kernel/rcu/tree_plugin.h | 2 +-
>  kernel/sched/core.c      | 8 ++++++++
>  3 files changed, 11 insertions(+), 3 deletions(-)
> 
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7405,7 +7405,15 @@ void migrate_enable(void)
>  			unpin_current_cpu();
>  			preempt_lazy_enable();
>  			preempt_enable();
> +
> +			/*
> +			 * sleeping_lock_inc suppresses a debug check for
> +			 * sleeping inside an RCU read side critical section
> +			 */
> +			sleeping_lock_inc();
>  			stop_one_cpu(task_cpu(p), migration_cpu_stop, &arg);
> +			sleeping_lock_dec();

this looks like an ugly hack. This sleeping_lock_inc() is used where we
actually hold a sleeping lock and schedule() which is okay. But this
would mean we hold a RCU lock and schedule() anyway. Is that okay?

> +
>  			return;
>  		}
>  	}

Sebastian
