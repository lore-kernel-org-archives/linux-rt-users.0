Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAAFCC4167B
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Dec 2020 10:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A399223609
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Dec 2020 10:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbgLIKGp (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Dec 2020 05:06:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728613AbgLIKGh (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Dec 2020 05:06:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E71C0613D6;
        Wed,  9 Dec 2020 02:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5Ta0pUvivfJjPddK9tmcCu8IPehpixjBiVyKYVHmlMM=; b=hyMeTHpt/J+9hQsHNIKqnqlKBP
        VONNeROd/w6oi/0Uj1p4n2i+f+/KbaLR1u+BuzDqT7CYinfS5WE43D6kSOzN5ZIxlPD/I5hLN4z59
        HW1EsAjPLx39JdmyxL3Ealh2H2SB6v9fLnWo3GQb0EttJcGG/Q4j0wZWa1BHteIA37Gmb02oAT+QF
        dJxKpKLvtnTOq7xJrkUr57RmqGvRKRSp/53iic+l3VxMQZgoSJaS58EEe9gVWml7WB1p7rtTxkZqr
        FfZLNRy5Vanaao2yjVWhtJnKsszxsbRRaejEDTqReJs8xb6nhuR/wxT4n/HJMHsgqJ6gYLW+tqy/r
        VhkqLFLA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmwM1-0003cn-6w; Wed, 09 Dec 2020 10:05:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 56FAB3011F0;
        Wed,  9 Dec 2020 11:05:46 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3CBA922BC6AA7; Wed,  9 Dec 2020 11:05:46 +0100 (CET)
Date:   Wed, 9 Dec 2020 11:05:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        tglx@linutronix.de, linux-rt-users@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>
Subject: Re: [RT] 5.9-rt14  softirq_ctrl.lock vs listening_hash[i].lock
  lockdep splat
Message-ID: <X9CheYjuXWc75Spa@hirez.programming.kicks-ass.net>
References: <12d6f9879a97cd56c09fb53dee343cbb14f7f1f7.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12d6f9879a97cd56c09fb53dee343cbb14f7f1f7.camel@gmx.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Sat, Oct 10, 2020 at 06:31:57AM +0200, Mike Galbraith wrote:
> 
> [   47.844511] ======================================================
> [   47.844511] WARNING: possible circular locking dependency detected
> [   47.844512] 5.9.0.gc85fb28-rt14-rt #1 Tainted: G            E
> [   47.844513] ------------------------------------------------------
> [   47.844514] perl/2751 is trying to acquire lock:
> [   47.844515] ffff92cadec5a410 ((softirq_ctrl.lock).lock){+.+.}-{2:2}, at: __local_bh_disable_ip+0x127/0x2c0
> [   47.844521]
>                but task is already holding lock:
> [   47.844522] ffffffffa8871468 (&h->listening_hash[i].lock){+.+.}-{0:0}, at: listening_get_next.isra.41+0xd7/0x130
> [   47.844528]
>                which lock already depends on the new lock.
> 
> [   47.844528]
>                the existing dependency chain (in reverse order) is:
> [   47.844529]
>                -> #1 (&h->listening_hash[i].lock){+.+.}-{0:0}:
> [   47.844532]        rt_spin_lock+0x2b/0xc0
> [   47.844536]        __inet_hash+0x68/0x320
> [   47.844539]        inet_hash+0x31/0x60
> [   47.844541]        inet_csk_listen_start+0xaf/0xe0
> [   47.844543]        inet_listen+0x86/0x150
> [   47.844546]        __sys_listen+0x58/0x80
> [   47.844548]        __x64_sys_listen+0x12/0x20
> [   47.844549]        do_syscall_64+0x33/0x40
> [   47.844552]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [   47.844555]
>                -> #0 ((softirq_ctrl.lock).lock){+.+.}-{2:2}:
> [   47.844557]        __lock_acquire+0x1343/0x1890
> [   47.844560]        lock_acquire+0x92/0x410
> [   47.844562]        rt_spin_lock+0x2b/0xc0
> [   47.844564]        __local_bh_disable_ip+0x127/0x2c0
> [   47.844566]        sock_i_ino+0x22/0x60
> [   47.844569]        tcp4_seq_show+0x14f/0x420
> [   47.844571]        seq_read+0x27c/0x420
> [   47.844574]        proc_reg_read+0x5c/0x80
> [   47.844576]        vfs_read+0xd1/0x1d0
> [   47.844580]        ksys_read+0x87/0xc0
> [   47.844581]        do_syscall_64+0x33/0x40
> [   47.844583]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [   47.844585]
>                other info that might help us debug this:
> 
> [   47.844585]  Possible unsafe locking scenario:
> 
> [   47.844586]        CPU0                    CPU1
> [   47.844586]        ----                    ----
> [   47.844587]   lock(&h->listening_hash[i].lock);
> [   47.844588]                                lock((softirq_ctrl.lock).lock);
> [   47.844588]                                lock(&h->listening_hash[i].lock);
> [   47.844589]   lock((softirq_ctrl.lock).lock);
> [   47.844590]
>                 *** DEADLOCK ***
> 
> [   47.844590] 3 locks held by perl/2751:
> [   47.844591]  #0: ffff92ca6525a4e0 (&p->lock){+.+.}-{0:0}, at: seq_read+0x37/0x420
> [   47.844594]  #1: ffffffffa8871468 (&h->listening_hash[i].lock){+.+.}-{0:0}, at: listening_get_next.isra.41+0xd7/0x130
> [   47.844597]  #2: ffffffffa74b90e0 (rcu_read_lock){....}-{1:2}, at: rt_spin_lock+0x5/0xc0
> [   47.844600]
>                stack backtrace:
> [   47.844601] CPU: 1 PID: 2751 Comm: perl Kdump: loaded Tainted: G            E     5.9.0.gc85fb28-rt14-rt #1
> [   47.844603] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/23/2013
> [   47.844604] Call Trace:
> [   47.844606]  dump_stack+0x77/0x9b
> [   47.844611]  check_noncircular+0x148/0x160
> [   47.844616]  ? __lock_acquire+0x1343/0x1890
> [   47.844617]  __lock_acquire+0x1343/0x1890
> [   47.844621]  lock_acquire+0x92/0x410
> [   47.844623]  ? __local_bh_disable_ip+0x127/0x2c0
> [   47.844626]  ? sock_i_ino+0x5/0x60
> [   47.844628]  rt_spin_lock+0x2b/0xc0
> [   47.844630]  ? __local_bh_disable_ip+0x127/0x2c0
> [   47.844631]  __local_bh_disable_ip+0x127/0x2c0
> [   47.844634]  sock_i_ino+0x22/0x60
> [   47.844635]  tcp4_seq_show+0x14f/0x420
> [   47.844640]  seq_read+0x27c/0x420
> [   47.844643]  proc_reg_read+0x5c/0x80
> [   47.844645]  vfs_read+0xd1/0x1d0
> [   47.844648]  ksys_read+0x87/0xc0
> [   47.844649]  ? lockdep_hardirqs_on+0x78/0x100
> [   47.844652]  do_syscall_64+0x33/0x40
> [   47.844654]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [   47.844656] RIP: 0033:0x7fb3f3c23e51
> [   47.844658] Code: 7d 81 20 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb ba 0f 1f 80 00 00 00 00 8b 05 1a c3 20 00 48 63 ff 85 c0 75 13 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 57 f3 c3 0f 1f 44 00 00 55 53 48 89 d5 48 89
> [   47.844660] RSP: 002b:00007ffd7604f108 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [   47.844661] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fb3f3c23e51
> [   47.844662] RDX: 0000000000002000 RSI: 000055dbff4da600 RDI: 0000000000000003
> [   47.844662] RBP: 0000000000002000 R08: 000055dbff4d9290 R09: 000055dbff4da600
> [   47.844663] R10: ffffffffffffffb0 R11: 0000000000000246 R12: 000055dbff4da600
> [   47.844664] R13: 000055dbff4ae260 R14: 000055dbff4d92c0 R15: 0000000000000003

So I've been looking at these local_lock vs lockdep splats for a bit,
and unlike the IRQ inversions as reported here:

  https://lore.kernel.org/linux-usb/20201029174348.omqiwjqy64tebg5z@linutronix.de/

I think the above is an actual real problem (for RT).

AFAICT the above translates to:

  inet_listen()
    lock_sock()
      spin_lock_bh(&sk->sk_lock.slock);
	acquire(softirq_ctrl);
	acquire(&sk->sk_lock.slock);

    inet_csk_listen_start()
      sk->sk_prot->hash() := inet_hash()
	local_bh_disable()
	__inet_hash()
	  spin_lock(&ilb->lock);
	    acquire(&ilb->lock);

  ----

  tcp4_seq_next()
    listening_get_next()
      spin_lock(&ilb->lock);
	acquire(&ilb->lock);

  tcp4_seq_show()
    get_tcp4_sock()
      sock_i_ino()
	read_lock_bh(&sk->sk_callback_lock);
	  acquire(softirq_ctrl)	// <---- whoops
	  acquire(&sk->sk_callback_lock)


Which you can run in two tasks on the same CPU (and thus get the same
softirq_ctrl local_lock), and deadlock.

By holding softirq_ctrl we serialize against softirq-context
(in-softirq) but that isn't relevant here, since neither context is
that.

On !RT there isn't a problem because softirq_ctrl isn't an actual lock,
but the moment that turns into a real lock (like on RT) you're up a
creek.

In general we have the rule that as long as a lock is only ever used
from task context (like the above ilb->lock, afaict) then it doesn't
matter if you also take it with (soft)irqs disabled or not. But this
softirq scheme breaks that. If you ever take a lock with BH disabled,
you must now always take it with BH disabled, otherwise you risk
deadlocks against the softirq_ctrl lock.

Or am I missing something obvious (again) ?
