Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63ECC4338F
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Aug 2021 11:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F19760EFF
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Aug 2021 11:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237692AbhHDLBN (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 4 Aug 2021 07:01:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35118 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236972AbhHDLBM (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 4 Aug 2021 07:01:12 -0400
Date:   Wed, 4 Aug 2021 13:00:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628074859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/qzMYdzbyWXTGkpKXzF/fSYUzk2iizLWCTObH2YpTn8=;
        b=Bh1116628+bGDQRKauoqgOBXfXRcY13Xn7dXTJ5rOWOb/brQzLplZrdOWS5TNyFlUJVsmq
        VByVI2FS+lrKPAJbfQK58apX+0jYQSKv2sJwr5wlztoFhBxgNpZPzhegG33lgnyvKafUQQ
        luUp3p2N3w9A5EhrM7N82pZGwjGHVxejNf7i/FPJWjgQRW9riVWqfScRJ09n0xfyM30h8p
        2qJhKNWnPBGMWn5EORtcARXcN8K0irAceH6QYERqaVxYJ9DJKIPC1/ZE9nEjnA2DMOgL+e
        b1f+6GVy43tS8lBArjT9D0GGYC2VFi6bKGrCm2dtDyAQmllBLqN3fQPUudXviA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628074859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/qzMYdzbyWXTGkpKXzF/fSYUzk2iizLWCTObH2YpTn8=;
        b=6NCqbpqNv4lYoxgHmGCS15ye0VReKhO6iF2Ov/TY80VXkuEpKPxb9h5Q3anWGKm282tF3B
        Giqh4F8ICtTeN8Cg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Daniel Wagner <wagi@monom.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [ANNOUNCE] v5.14-rc4-rt4
Message-ID: <20210804110057.chsvt7l5xpw7bo5r@linutronix.de>
References: <20210802162750.santic4y6lzcet5c@linutronix.de>
 <20210804082418.fbibprcwtzyt5qax@beryllium.lan>
 <20210804104340.fhdjwn3hruymu3ml@linutronix.de>
 <20210804104803.4nwxi74sa2vwiujd@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210804104803.4nwxi74sa2vwiujd@linutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-08-04 12:48:05 [+0200], To Daniel Wagner wrote:
> On 2021-08-04 12:43:42 [+0200], To Daniel Wagner wrote:
> > Odd. Do you have a config for that, please?
>=20
> No need.
> | [   90.202543] BUG: sleeping function called from invalid context at ke=
rnel/locking/spinlock_rt.c:35
> | [   90.202549] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 2=
047, name: iou-wrk-2041
> | [   90.202555] CPU: 5 PID: 2047 Comm: iou-wrk-2041 Tainted: G        W =
        5.14.0-rc4-rt4+ #89
> | [   90.202561] Call Trace:
=E2=80=A6
> | [   90.202588]  rt_spin_lock+0x19/0x70
> | [   90.202593]  ___slab_alloc+0xcb/0x7d0
=E2=80=A6
> | [   90.202618]  kmem_cache_alloc_trace+0x79/0x1f0
> | [   90.202621]  io_wqe_dec_running.isra.0+0x98/0xe0
> | [   90.202625]  io_wq_worker_sleeping+0x37/0x50
> | [   90.202628]  schedule+0x30/0xd0
>=20
> le look.

So this is due to commit
  685fe7feedb96 ("io-wq: eliminate the need for a manager thread")

introduced in the v5.13-rc1 merge window. The call chain is
  schedule()
   sched_submit_work()
    preempt_disable();
    io_wq_worker_sleeping()
      raw_spin_lock_irq(&worker->wqe->lock);
      io_wqe_dec_running(worker);
       io_queue_worker_create()
        kmalloc(sizeof(*cwd), GFP_ATOMIC);

The lock wqe::lock has been turned into a raw_spinlock_t in commit
   95da84659226d ("io_wq: Make io_wqe::lock a raw_spinlock_t")

after a careful analysis of the code at that time. This commit breaks
things. Is this really needed?

> > > Thanks,
> > > Daniel

Sebastian
