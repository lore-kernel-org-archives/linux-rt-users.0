Return-Path: <SRS0=ow8w=TD=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE149C04AAA
	for <linux-rt-users@archiver.kernel.org>; Fri,  3 May 2019 15:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F7532087F
	for <linux-rt-users@archiver.kernel.org>; Fri,  3 May 2019 15:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YQryQ31C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbfECPZW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 3 May 2019 11:25:22 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38562 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfECPZW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 3 May 2019 11:25:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Eq3p4WPpnsO3kbWP0EleAU41bsxOPze1ups0UapJXvg=; b=YQryQ31CprLphAYO1XMEpaxKK
        SBCLX/+k8AqwrgmIzbYlT7+x1JKrI87iWxZNMl3BL43fs2X5Eyi273D0qWzGtTsZKqaJErTI3eBxo
        K/196KLZKXROxZi0YvgzDhl1MQCtv79Gk8cq1KzVuDiFaXJ9gq3vYZtQ+cLTS0PypULCcNFrcj+OW
        Xk/HtfXqtxpJS37EcD+yc5NSn9Bk3KQZIpPL1a2blZA6WJ5U57jvl2lqSsSyo8TIUuP+GTbBpGYXF
        7YH3odyET8f2Nzloa8SNWHoguhZhj2mkBMFsKhXS3bjnyhm8EEYND2tr4ZwdtwHf5c0odo0OINiMP
        QCYZVpUDw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hMa3m-0000Mz-QQ; Fri, 03 May 2019 15:25:15 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 944F9214242EE; Fri,  3 May 2019 17:25:13 +0200 (CEST)
Date:   Fri, 3 May 2019 17:25:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, jack@suse.com,
        Waiman Long <longman@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [RT WARNING] DEBUG_LOCKS_WARN_ON(rt_mutex_owner(lock) !=
 current) with fsfreeze (4.19.25-rt16)
Message-ID: <20190503152513.GE2650@hirez.programming.kicks-ass.net>
References: <20190326093421.GA29508@localhost.localdomain>
 <20190419085627.GI4742@localhost.localdomain>
 <20190430125130.uw7mhdnsoqr2v3gf@linutronix.de>
 <20190430132811.GB2589@hirez.programming.kicks-ass.net>
 <20190501170953.GB2650@hirez.programming.kicks-ass.net>
 <20190502100932.GA7323@redhat.com>
 <20190502114258.GB7323@redhat.com>
 <20190503145059.GC2606@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503145059.GC2606@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, May 03, 2019 at 04:50:59PM +0200, Peter Zijlstra wrote:
> So how about something like so then?

> --- a/kernel/locking/percpu-rwsem.c
> +++ b/kernel/locking/percpu-rwsem.c

> @@ -63,7 +66,7 @@ int __percpu_down_read(struct percpu_rw_
>  	 * If !readers_block the critical section starts here, matched by the
>  	 * release in percpu_up_write().
>  	 */
> -	if (likely(!smp_load_acquire(&sem->readers_block)))
> +	if (likely(!atomic_read_acquire(&sem->block)))
>  		return 1;
>  
>  	/*
> @@ -80,14 +83,8 @@ int __percpu_down_read(struct percpu_rw_
>  	 * and reschedule on the preempt_enable() in percpu_down_read().
>  	 */
>  	preempt_enable_no_resched();
> -
> -	/*
> -	 * Avoid lockdep for the down/up_read() we already have them.
> -	 */
> -	__down_read(&sem->rw_sem);
> +	wait_event(sem->waiters, !atomic_read(&sem->block));

That should be:

	wait_event(sem->waiters, !atomic_read_acquire(&sem->block));

I suppose.

>  	this_cpu_inc(*sem->read_count);
> -	__up_read(&sem->rw_sem);
> -
>  	preempt_disable();
>  	return 1;
>  }
> @@ -104,7 +101,7 @@ void __percpu_up_read(struct percpu_rw_s
>  	__this_cpu_dec(*sem->read_count);
>  
>  	/* Prod writer to recheck readers_active */
> -	rcuwait_wake_up(&sem->writer);
> +	wake_up(&sem->waiters);
>  }
>  EXPORT_SYMBOL_GPL(__percpu_up_read);
>  
> @@ -139,18 +136,22 @@ static bool readers_active_check(struct
>  	return true;
>  }
>  
> +static inline bool acquire_block(struct percpu_rw_semaphore *sem)
> +{
> +	if (atomic_read(&sem->block))
> +		return false;
> +
> +	return atomic_xchg(&sem->block, 1) == 0;
> +}
> +
>  void percpu_down_write(struct percpu_rw_semaphore *sem)
>  {
> +	rwsem_acquire(&sem->dep_map, 0, 0, _RET_IP_);
> +
>  	/* Notify readers to take the slow path. */
>  	rcu_sync_enter(&sem->rss);
>  
> -	down_write(&sem->rw_sem);
> -
> -	/*
> -	 * Notify new readers to block; up until now, and thus throughout the
> -	 * longish rcu_sync_enter() above, new readers could still come in.
> -	 */
> -	WRITE_ONCE(sem->readers_block, 1);
> +	wait_event_exclusive(sem->waiters, acquire_block(sem));
>  
>  	smp_mb(); /* D matches A */

And we can remove that smp_mb() and rely on the atomic_xchg() from
acquire_block().

>  
> @@ -161,7 +162,7 @@ void percpu_down_write(struct percpu_rw_
>  	 */
>  
>  	/* Wait for all now active readers to complete. */
> -	rcuwait_wait_event(&sem->writer, readers_active_check(sem));
> +	wait_event(sem->waiters, readers_active_check(sem));
>  }
>  EXPORT_SYMBOL_GPL(percpu_down_write);
>  
> @@ -177,12 +178,8 @@ void percpu_up_write(struct percpu_rw_se
>  	 * Therefore we force it through the slow path which guarantees an
>  	 * acquire and thereby guarantees the critical section's consistency.
>  	 */
> -	smp_store_release(&sem->readers_block, 0);
> -
> -	/*
> -	 * Release the write lock, this will allow readers back in the game.
> -	 */
> -	up_write(&sem->rw_sem);
> +	atomic_set_release(&sem->block, 0);
> +	wake_up(&sem->waiters);
>  
>  	/*
>  	 * Once this completes (at least one RCU-sched grace period hence) the
> @@ -190,5 +187,21 @@ void percpu_up_write(struct percpu_rw_se
>  	 * exclusive write lock because its counting.
>  	 */
>  	rcu_sync_exit(&sem->rss);
> +
> +	rwsem_release(&sem->dep_map, 1, _RET_IP_);
>  }
>  EXPORT_SYMBOL_GPL(percpu_up_write);
