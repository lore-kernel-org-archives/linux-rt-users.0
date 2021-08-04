Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCDCC432BE
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Aug 2021 15:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03BE660F14
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Aug 2021 15:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239217AbhHDPsA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 4 Aug 2021 11:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239114AbhHDPr7 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 4 Aug 2021 11:47:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5639AC0613D5;
        Wed,  4 Aug 2021 08:47:46 -0700 (PDT)
Date:   Wed, 4 Aug 2021 17:47:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628092064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L8OdJeF6JX172ja4DHg/13gB0TcQV9nvDbrJGCXaKxI=;
        b=eAJ0WYaBxEx94IoYGhNmJgpLXavP/dbnM4waqvyYkxxDEaZpXaU5Bu9UaIgu/gURL/wq1K
        FF5Mhaz113Rqt6wD18suN+6rk06HMZrXkfKMH/G+ZPKCNkpNm3FycGTA+asDYSG1lovGuc
        mRW5nRnEzCvJY3Bx5OheXTFFrbm0f97rev6evqRCp5NqatlxkVVh2dgD3JNRHdkHWiIvpf
        JfFuCL4VeHoyj4ABaFMukk/HEP8tl0sLYec+94i9lsHZOI6t+k7XUhTFON3G44k0Nv/M9i
        DcsISUB9DC+u9690yPCZuLCNz8ugL9Up+w8x7WUG3/QWg4F08k/sAqEYip3ipw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628092064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L8OdJeF6JX172ja4DHg/13gB0TcQV9nvDbrJGCXaKxI=;
        b=hMQgg0lYWq9HDBfvQ1C8h3Lc1r6amaA3itFJgjy5MXMF+3tEHcRWcy4Iav8yuWNnPh6oON
        s2YQC/j9qyh1utDA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <wagi@monom.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.14-rc4-rt4
Message-ID: <20210804154743.niogqvnladdkfgi2@linutronix.de>
References: <20210802162750.santic4y6lzcet5c@linutronix.de>
 <20210804082418.fbibprcwtzyt5qax@beryllium.lan>
 <20210804104340.fhdjwn3hruymu3ml@linutronix.de>
 <20210804104803.4nwxi74sa2vwiujd@linutronix.de>
 <20210804110057.chsvt7l5xpw7bo5r@linutronix.de>
 <20210804131731.GG8057@worktop.programming.kicks-ass.net>
 <4f549344-1040-c677-6a6a-53e243c5f364@kernel.dk>
 <feebf183-2e33-36b5-4538-62a40b2a58b6@kernel.dk>
 <20210804153308.oasahcxjmcw7vivo@linutronix.de>
 <f2d0a028-fe85-28ff-9cea-8ab1d26a15d0@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f2d0a028-fe85-28ff-9cea-8ab1d26a15d0@kernel.dk>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-08-04 09:39:30 [-0600], Jens Axboe wrote:
> I'm confused, the waitqueue locks are always IRQ disabling.

spin_lock_irq() does not disable interrupts on -RT. The patch above
produces:

| BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:35
| in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 2020, name: iou-wrk-2018
| 1 lock held by iou-wrk-2018/2020:
|  #0: ffff888111a47de8 (&hash->wait){+.+.}-{0:0}, at: io_worker_handle_work+0x443/0x630
| irq event stamp: 10
| hardirqs last  enabled at (9): [<ffffffff81c47818>] _raw_spin_unlock_irqrestore+0x28/0x70
| hardirqs last disabled at (10): [<ffffffff81c4769e>] _raw_spin_lock_irq+0x3e/0x40
| softirqs last  enabled at (0): [<ffffffff81077238>] copy_process+0x8f8/0x2020
| softirqs last disabled at (0): [<0000000000000000>] 0x0
| CPU: 5 PID: 2020 Comm: iou-wrk-2018 Tainted: G        W         5.14.0-rc4-rt4+ #97
| Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
| Call Trace:
|  dump_stack_lvl+0x45/0x59
|  ___might_sleep.cold+0xa6/0xb6
|  rt_spin_lock+0x35/0xc0
|  ? io_worker_handle_work+0x443/0x630
|  io_worker_handle_work+0x443/0x630
|  io_wqe_worker+0xb4/0x340
|  ? lockdep_hardirqs_on_prepare+0xd4/0x170
|  ? _raw_spin_unlock_irqrestore+0x28/0x70
|  ? _raw_spin_unlock_irqrestore+0x28/0x70
|  ? io_worker_handle_work+0x630/0x630
|  ? rt_mutex_slowunlock+0x2ba/0x310
|  ? io_worker_handle_work+0x630/0x630
|  ret_from_fork+0x22/0x30


But indeed, you are right, my snippet breaks non-RT. So this then maybe:

diff --git a/fs/io-wq.c b/fs/io-wq.c
index 57d3cdddcdb3e..0b931ac3c83e6 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -384,7 +384,7 @@ static void io_wait_on_hash(struct io_wqe *wqe, unsigned int hash)
 {
 	struct io_wq *wq = wqe->wq;
 
-	spin_lock(&wq->hash->wait.lock);
+	spin_lock_irq(&wq->hash->wait.lock);
 	if (list_empty(&wqe->wait.entry)) {
 		__add_wait_queue(&wq->hash->wait, &wqe->wait);
 		if (!test_bit(hash, &wq->hash->map)) {
@@ -392,7 +392,7 @@ static void io_wait_on_hash(struct io_wqe *wqe, unsigned int hash)
 			list_del_init(&wqe->wait.entry);
 		}
 	}
-	spin_unlock(&wq->hash->wait.lock);
+	spin_unlock_irq(&wq->hash->wait.lock);
 }
 
 static struct io_wq_work *io_get_next_work(struct io_wqe *wqe)
@@ -430,9 +430,9 @@ static struct io_wq_work *io_get_next_work(struct io_wqe *wqe)
 	}
 
 	if (stall_hash != -1U) {
-		raw_spin_unlock(&wqe->lock);
+		raw_spin_unlock_irq(&wqe->lock);
 		io_wait_on_hash(wqe, stall_hash);
-		raw_spin_lock(&wqe->lock);
+		raw_spin_lock_irq(&wqe->lock);
 	}
 
 	return NULL;

(this is on-top of the patch you sent earlier and Daniel Cc: me on after
I checked that the problem/warning still exists).

Sebastian
