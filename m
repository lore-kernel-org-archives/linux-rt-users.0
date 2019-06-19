Return-Path: <SRS0=vVbJ=US=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC18CC31E49
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 Jun 2019 09:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A81C52084A
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 Jun 2019 09:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UxKdEHpJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731267AbfFSJux (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 19 Jun 2019 05:50:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60366 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbfFSJux (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 19 Jun 2019 05:50:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MbgPWobC8/fDBy4WkE0A0yRvyYgfjJzRd9Ukcexabjs=; b=UxKdEHpJNtjfbdVRcfWQ0nNpt
        o5RcsM2AyU0zTW+bRRDCmLQM1dybm7TXoTSDcDwJ5CMCZsJxpLHGqoFF+uwdbnTYY16BEIYxVrBdL
        jxD2hpDqfGvw1hbc/NTOjdRq1EHm4QDWpvaf0B0+Eepq8VOyDN4oFvZn2hWtPELNJtheX1uRZc831
        mLOb7k3LsZq+EE/8igKlmxKc52ZmOpaxSbKqhl7dzh7flqGzeXNAfRHpBFiH9iCUL4DxX3fFCcuy/
        lCjN9Eukex+izdonu+6uXa3kse9YWu3/aty45ywCe+q7oI/CjYro+XbVsK4nBrBtP7+NrjNjgTd6x
        qOXbuy7MA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdXEr-00073x-2O; Wed, 19 Jun 2019 09:50:45 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 15605201F98FB; Wed, 19 Jun 2019 11:50:43 +0200 (CEST)
Date:   Wed, 19 Jun 2019 11:50:43 +0200
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
Message-ID: <20190619095043.GT3402@hirez.programming.kicks-ass.net>
References: <20190326093421.GA29508@localhost.localdomain>
 <20190419085627.GI4742@localhost.localdomain>
 <20190430125130.uw7mhdnsoqr2v3gf@linutronix.de>
 <20190430132811.GB2589@hirez.programming.kicks-ass.net>
 <20190501170953.GB2650@hirez.programming.kicks-ass.net>
 <20190502100932.GA7323@redhat.com>
 <20190502114258.GB7323@redhat.com>
 <20190503145059.GC2606@hirez.programming.kicks-ass.net>
 <20190506165009.GA28959@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506165009.GA28959@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


Sorry, I seem to have missed this email.

On Mon, May 06, 2019 at 06:50:09PM +0200, Oleg Nesterov wrote:
> On 05/03, Peter Zijlstra wrote:
> >
> > -static void lockdep_sb_freeze_release(struct super_block *sb)
> > -{
> > -	int level;
> > -
> > -	for (level = SB_FREEZE_LEVELS - 1; level >= 0; level--)
> > -		percpu_rwsem_release(sb->s_writers.rw_sem + level, 0, _THIS_IP_);
> > -}
> > -
> > -/*
> > - * Tell lockdep we are holding these locks before we call ->unfreeze_fs(sb).
> > - */
> > -static void lockdep_sb_freeze_acquire(struct super_block *sb)
> > -{
> > -	int level;
> > -
> > -	for (level = 0; level < SB_FREEZE_LEVELS; ++level)
> > -		percpu_rwsem_acquire(sb->s_writers.rw_sem + level, 0, _THIS_IP_);
> > +	percpu_down_write_non_owner(sb->s_writers.rw_sem + level-1);
> >  }
> 
> I'd suggest to not change fs/super.c, keep these helpers, and even not introduce
> xxx_write_non_owner().
> 
> freeze_super() takes other locks, it calls sync_filesystem(), freeze_fs(), lockdep
> should know that this task holds SB_FREEZE_XXX locks for writing.

Bah, I so hate these games. But OK, I suppose.

> > @@ -80,14 +83,8 @@ int __percpu_down_read(struct percpu_rw_
> >  	 * and reschedule on the preempt_enable() in percpu_down_read().
> >  	 */
> >  	preempt_enable_no_resched();
> > -
> > -	/*
> > -	 * Avoid lockdep for the down/up_read() we already have them.
> > -	 */
> > -	__down_read(&sem->rw_sem);
> > +	wait_event(sem->waiters, !atomic_read(&sem->block));
> >  	this_cpu_inc(*sem->read_count);
> 
> Argh, this looks racy :/
> 
> Suppose that sem->block == 0 when wait_event() is called, iow the writer released
> the lock.
> 
> Now suppose that this __percpu_down_read() races with another percpu_down_write().
> The new writer can set sem->block == 1 and call readers_active_check() in between,
> after wait_event() and before this_cpu_inc(*sem->read_count).


CPU0			CPU1			CPU2

percpu_up_write()
  sem->block = 0;

			__percpu_down_read()
			  wait_event(, !sem->block);

						percpu_down_write()
						  wait_event_exclusive(, xchg(sem->block,1)==0);
						  readers_active_check()

			  this_cpu_inc();

			  *whoopsy* reader while write owned.



I suppose we can 'patch' that by checking blocking again after we've
incremented, something like the below.

But looking at percpu_down_write() we have two wait_event*() on the same
queue back to back, which is 'odd' at best. Let me ponder that a little
more.


---

--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -61,6 +61,7 @@ int __percpu_down_read(struct percpu_rw_
 	 * writer missed them.
 	 */
 
+again:
 	smp_mb(); /* A matches D */
 
 	/*
@@ -87,7 +88,13 @@ int __percpu_down_read(struct percpu_rw_
 	wait_event(sem->waiters, !atomic_read_acquire(&sem->block));
 	this_cpu_inc(*sem->read_count);
 	preempt_disable();
-	return 1;
+
+	/*
+	 * percpu_down_write() could've set ->blocked right after we've seen it
+	 * 0 but missed our this_cpu_inc(), which is exactly the condition we
+	 * get called for from percpu_down_read().
+	 */
+	goto again;
 }
 EXPORT_SYMBOL_GPL(__percpu_down_read);
 

