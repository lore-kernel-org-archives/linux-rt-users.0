Return-Path: <SRS0=ow8w=TD=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDDEC43219
	for <linux-rt-users@archiver.kernel.org>; Fri,  3 May 2019 14:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D9542075E
	for <linux-rt-users@archiver.kernel.org>; Fri,  3 May 2019 14:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jHj+ZaM7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbfECOQk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 3 May 2019 10:16:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42400 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbfECOQk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 3 May 2019 10:16:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=J9W9Q4RwiLQp9Sxk+txbESocb1vb6ZSeLsVCWdXZ624=; b=jHj+ZaM7Yh7/FUWKzczrKwmnX
        paUcyATNVJPq2aPs3IZ6Un25fSsIHERDGJoK+31MpQi7Bl4FMTp3Lz1jiyprkMYyUTS/U5XVQPR5h
        1i5XwsgIY3fKaamqNt0ete4AhdAJNHhPfP5mei+SnXm9D9M/RKOlkq5t81SLULLLTKVIc0MqI/Blf
        cfTXM+0S5ijLuv7hegtlVrrHxXsIqvSbHqU9KTQTY9TnSPdYFVaHVG/Jj6siY9LTQWQP7tNn86q67
        5WwGnJDmXY8ZW1ntg43iisjKJbaWF5mxsVXJqMsKjkN8ElHey2GOATClNDIsqdxC23pzyuMD64F9W
        xzYl4EXpA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hMYzL-000586-R9; Fri, 03 May 2019 14:16:36 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9F854214242E2; Fri,  3 May 2019 16:16:33 +0200 (CEST)
Date:   Fri, 3 May 2019 16:16:33 +0200
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
Message-ID: <20190503141633.GB2606@hirez.programming.kicks-ass.net>
References: <20190326093421.GA29508@localhost.localdomain>
 <20190419085627.GI4742@localhost.localdomain>
 <20190430125130.uw7mhdnsoqr2v3gf@linutronix.de>
 <20190430132811.GB2589@hirez.programming.kicks-ass.net>
 <20190501170953.GB2650@hirez.programming.kicks-ass.net>
 <20190502100932.GA7323@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502100932.GA7323@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, May 02, 2019 at 12:09:32PM +0200, Oleg Nesterov wrote:
> On 05/01, Peter Zijlstra wrote:
> >
> > Anyway; I cobbled together the below. Oleg, could you have a look, I'm
> > sure I messed it up.
> 
> Oh, I will need to read this carefully. but at first glance I do not see
> any hole...
> 
> > +static void readers_block(struct percpu_rw_semaphore *sem)
> > +{
> > +	wait_event_cmd(sem->writer, !sem->readers_block,
> > +		       __up_read(&sem->rw_sem), __down_read(&sem->rw_sem));
> > +}
> > +
> > +static void block_readers(struct percpu_rw_semaphore *sem)
> > +{
> > +	wait_event_exclusive_cmd(sem->writer, !sem->readers_block,
> > +				 __up_write(&sem->rw_sem),
> > +				 __down_write(&sem->rw_sem));
> > +	/*
> > +	 * Notify new readers to block; up until now, and thus throughout the
> > +	 * longish rcu_sync_enter() above, new readers could still come in.
> > +	 */
> > +	WRITE_ONCE(sem->readers_block, 1);
> > +}
> 
> So iiuc, despite it name block_readers() also serializes the writers, ->rw_sem
> can be dropped by down_write_non_owner() so the new writer can take this lock.

I don't think block_readers() is sufficient to serialize writers;
suppose two concurrent callers when !->readers_block. Without ->rwsem
that case would not serialize.

> But this all is cosmetic, it seems that we can remove ->rw_sem altogether
> but I am not sure...

Only if we introduce something like ->wait_lock to serialize things.
