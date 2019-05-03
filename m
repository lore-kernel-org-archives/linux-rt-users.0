Return-Path: <SRS0=ow8w=TD=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5AFC43219
	for <linux-rt-users@archiver.kernel.org>; Fri,  3 May 2019 15:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 055592081C
	for <linux-rt-users@archiver.kernel.org>; Fri,  3 May 2019 15:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbfECPhy (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 3 May 2019 11:37:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41532 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbfECPhy (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 3 May 2019 11:37:54 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 521BC307EA9C;
        Fri,  3 May 2019 15:37:54 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.159])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0903819C4F;
        Fri,  3 May 2019 15:37:48 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri,  3 May 2019 17:37:54 +0200 (CEST)
Date:   Fri, 3 May 2019 17:37:48 +0200
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
Message-ID: <20190503153747.GC20802@redhat.com>
References: <20190326093421.GA29508@localhost.localdomain>
 <20190419085627.GI4742@localhost.localdomain>
 <20190430125130.uw7mhdnsoqr2v3gf@linutronix.de>
 <20190430132811.GB2589@hirez.programming.kicks-ass.net>
 <20190501170953.GB2650@hirez.programming.kicks-ass.net>
 <20190502100932.GA7323@redhat.com>
 <20190503141633.GB2606@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503141633.GB2606@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 03 May 2019 15:37:54 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 05/03, Peter Zijlstra wrote:
>
> On Thu, May 02, 2019 at 12:09:32PM +0200, Oleg Nesterov wrote:
 >
> > > +static void readers_block(struct percpu_rw_semaphore *sem)
> > > +{
> > > +	wait_event_cmd(sem->writer, !sem->readers_block,
> > > +		       __up_read(&sem->rw_sem), __down_read(&sem->rw_sem));
> > > +}
> > > +
> > > +static void block_readers(struct percpu_rw_semaphore *sem)
> > > +{
> > > +	wait_event_exclusive_cmd(sem->writer, !sem->readers_block,
> > > +				 __up_write(&sem->rw_sem),
> > > +				 __down_write(&sem->rw_sem));
> > > +	/*
> > > +	 * Notify new readers to block; up until now, and thus throughout the
> > > +	 * longish rcu_sync_enter() above, new readers could still come in.
> > > +	 */
> > > +	WRITE_ONCE(sem->readers_block, 1);
> > > +}
> >
> > So iiuc, despite it name block_readers() also serializes the writers, ->rw_sem
> > can be dropped by down_write_non_owner() so the new writer can take this lock.
>
> I don't think block_readers() is sufficient to serialize writers;
> suppose two concurrent callers when !->readers_block. Without ->rwsem
> that case would not serialize.

Of course. I meant that the next writer can enter block_readers() if
up_non_owner() drops ->rw_sem, but it will block in wait_event(!readers_block).

(And if we change this code to use wait_event(xchg(readers_block) == 0) we
 can remove rw_sem altogether).

The main problem is that this is sub-optimal. We can have a lot of readers
sleeping in __down_read() when percpu_down_write() succeeds, then after
percpu_down_write_non_owner() does up_write() they all will be woken just
to hang in readers_block(). Plus the new readers will need to pass the
lock-check-unlock-schedule path.

Peter, just in case... I see another patch from you but I need to run away
till Monday.

Oleg.

