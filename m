Return-Path: <SRS0=oduH=TC=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70353C04AA9
	for <linux-rt-users@archiver.kernel.org>; Thu,  2 May 2019 10:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C6320652
	for <linux-rt-users@archiver.kernel.org>; Thu,  2 May 2019 10:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbfEBKJo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 2 May 2019 06:09:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48044 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbfEBKJo (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 2 May 2019 06:09:44 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AFAF530832D1;
        Thu,  2 May 2019 10:09:43 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.159])
        by smtp.corp.redhat.com (Postfix) with SMTP id 13EA082783;
        Thu,  2 May 2019 10:09:34 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu,  2 May 2019 12:09:42 +0200 (CEST)
Date:   Thu, 2 May 2019 12:09:32 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20190502100932.GA7323@redhat.com>
References: <20190326093421.GA29508@localhost.localdomain>
 <20190419085627.GI4742@localhost.localdomain>
 <20190430125130.uw7mhdnsoqr2v3gf@linutronix.de>
 <20190430132811.GB2589@hirez.programming.kicks-ass.net>
 <20190501170953.GB2650@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501170953.GB2650@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 02 May 2019 10:09:43 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 05/01, Peter Zijlstra wrote:
>
> Anyway; I cobbled together the below. Oleg, could you have a look, I'm
> sure I messed it up.

Oh, I will need to read this carefully. but at first glance I do not see
any hole...

> +static void readers_block(struct percpu_rw_semaphore *sem)
> +{
> +	wait_event_cmd(sem->writer, !sem->readers_block,
> +		       __up_read(&sem->rw_sem), __down_read(&sem->rw_sem));
> +}
> +
> +static void block_readers(struct percpu_rw_semaphore *sem)
> +{
> +	wait_event_exclusive_cmd(sem->writer, !sem->readers_block,
> +				 __up_write(&sem->rw_sem),
> +				 __down_write(&sem->rw_sem));
> +	/*
> +	 * Notify new readers to block; up until now, and thus throughout the
> +	 * longish rcu_sync_enter() above, new readers could still come in.
> +	 */
> +	WRITE_ONCE(sem->readers_block, 1);
> +}

So iiuc, despite it name block_readers() also serializes the writers, ->rw_sem
can be dropped by down_write_non_owner() so the new writer can take this lock.

And note that the caller of readers_block() does down_read(), the caller of
block_readers() does down_write(). So perhaps it makes sense to shift these
down_read/write into the helpers above and rename them,

	void xxx_down_read(struct percpu_rw_semaphore *sem)
	{
		__down_read(&sem->rw_sem);

		wait_event_cmd(sem->writer, !sem->readers_block,
		       __up_read(&sem->rw_sem), __down_read(&sem->rw_sem));
	}

	void xxx_down_write(struct percpu_rw_semaphore *sem)
	{
		down_write(&sem->rw_sem);

		wait_event_exclusive_cmd(sem->writer, !sem->readers_block,
					 __up_write(&sem->rw_sem),
					 __down_write(&sem->rw_sem));
		/*
		 * Notify new readers to block; up until now, and thus throughout the
		 * longish rcu_sync_enter() above, new readers could still come in.
		 */
		WRITE_ONCE(sem->readers_block, 1);
	}

to make this logic more clear? Or even

	bool ck_read(struct percpu_rw_semaphore *sem)
	{
		__down_read(&sem->rw_sem);
		if (!sem->readers_block)
			return true;
		__up_read(&sem->rw_sem);
	}

	bool ck_write(struct percpu_rw_semaphore *sem)
	{
		down_write(&sem->rw_sem);
		if (!sem->readers_block)
			return true;
		up_write(&sem->rw_sem);
	}

Then percpu_down_read/write can simply do wait_event(ck_read(sem)) and
wait_event_exclusive(ck_write(sem)) respectively.

But this all is cosmetic, it seems that we can remove ->rw_sem altogether
but I am not sure...

Oleg.

