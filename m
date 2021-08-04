Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCAFAC4338F
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Aug 2021 13:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD76B60F41
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Aug 2021 13:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238395AbhHDNSE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 4 Aug 2021 09:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238410AbhHDNSA (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 4 Aug 2021 09:18:00 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FD2C061798;
        Wed,  4 Aug 2021 06:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=iwNYQxbkeT/WUynvru+66XF3k8+FZ0WZ7SwdccQvJbo=; b=iVP1SDITQjbQIJsDojge1PhJ1I
        aif9yAS0kPS4GkpWQKjGU+9cNwMDKpBPMZwAVQF7/vp6T2xVphgtaMtnAEPbaE3hPuoBzhnEm71mV
        zNl+WmbvkGM7/pdRNBxA7hr5j48g5o0Yc259Aw0hW1TlGu7AzsqCd0+zHG60GoQqw6zYNg/riKPiW
        KVXYz5oaZOt2blC5uGPf82TtA2FCirF/Nnjd8gB1kcRy9fuLdtyYuYbjGQ3RHf6zD8yOk2SYnvsBd
        tm/6dEevXr+ayj+1K1mn5gokueV/BSD9CqpN8xkF5BUeo2EGm1LybWC6BSadK49ojbmvNuBiZUBR6
        73KvAGKw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mBGm4-005kY5-BP; Wed, 04 Aug 2021 13:17:32 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id DF6C59862B0; Wed,  4 Aug 2021 15:17:31 +0200 (CEST)
Date:   Wed, 4 Aug 2021 15:17:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Daniel Wagner <wagi@monom.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [ANNOUNCE] v5.14-rc4-rt4
Message-ID: <20210804131731.GG8057@worktop.programming.kicks-ass.net>
References: <20210802162750.santic4y6lzcet5c@linutronix.de>
 <20210804082418.fbibprcwtzyt5qax@beryllium.lan>
 <20210804104340.fhdjwn3hruymu3ml@linutronix.de>
 <20210804104803.4nwxi74sa2vwiujd@linutronix.de>
 <20210804110057.chsvt7l5xpw7bo5r@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210804110057.chsvt7l5xpw7bo5r@linutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Aug 04, 2021 at 01:00:57PM +0200, Sebastian Andrzej Siewior wrote:
> On 2021-08-04 12:48:05 [+0200], To Daniel Wagner wrote:
> > On 2021-08-04 12:43:42 [+0200], To Daniel Wagner wrote:
> > > Odd. Do you have a config for that, please?
> > 
> > No need.
> > | [   90.202543] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:35
> > | [   90.202549] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 2047, name: iou-wrk-2041
> > | [   90.202555] CPU: 5 PID: 2047 Comm: iou-wrk-2041 Tainted: G        W         5.14.0-rc4-rt4+ #89
> > | [   90.202561] Call Trace:
> …
> > | [   90.202588]  rt_spin_lock+0x19/0x70
> > | [   90.202593]  ___slab_alloc+0xcb/0x7d0
> …
> > | [   90.202618]  kmem_cache_alloc_trace+0x79/0x1f0
> > | [   90.202621]  io_wqe_dec_running.isra.0+0x98/0xe0
> > | [   90.202625]  io_wq_worker_sleeping+0x37/0x50
> > | [   90.202628]  schedule+0x30/0xd0
> > 
> > le look.
> 
> So this is due to commit
>   685fe7feedb96 ("io-wq: eliminate the need for a manager thread")
> 
> introduced in the v5.13-rc1 merge window. The call chain is
>   schedule()
>    sched_submit_work()
>     preempt_disable();
>     io_wq_worker_sleeping()
>       raw_spin_lock_irq(&worker->wqe->lock);
>       io_wqe_dec_running(worker);
>        io_queue_worker_create()
>         kmalloc(sizeof(*cwd), GFP_ATOMIC);
> 
> The lock wqe::lock has been turned into a raw_spinlock_t in commit
>    95da84659226d ("io_wq: Make io_wqe::lock a raw_spinlock_t")
> 
> after a careful analysis of the code at that time. This commit breaks
> things. Is this really needed?

Urgh, doing allocs from schedule seems really yuck. Can we please not do
this?
