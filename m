Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF47C4338F
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Aug 2021 10:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 846D561029
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Aug 2021 10:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237487AbhHDKsU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 4 Aug 2021 06:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236655AbhHDKsT (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 4 Aug 2021 06:48:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1BEC0613D5;
        Wed,  4 Aug 2021 03:48:06 -0700 (PDT)
Date:   Wed, 4 Aug 2021 12:48:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628074085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C4ug015c3LH1nPiLTgtxw4DPIl6IpKEPHr9Lpc8Y4IM=;
        b=Y3A9Aoc9jpjiuPWAzBOkUIHkqi7DBUaAS6UCz8wI3nkYGSpWAbVMLqatzBUqLG8LIBfjw9
        yntmG7vS0TcmFCRfsmbvEv+KVSoHgF0z5aUtQDe+9nQPBd0Ezy4uWrJf6r4oIlqG2Yu2SA
        /6DBJek1kr9FOMGo3wLmhJp4kmMpbTfXUXiQ4/hdEQCbpvjG5vhVaTY8ecYUF5tjqyJZjL
        faV387vzTclyppC0do8KbggoAJfL32lEzH9nyULmwszU0Wcj3QFYL3JUmNd/6CjsaWCD6j
        TN/PPOx3P+jIt+kjvB+tlKl42agAWo7fYWdc8OvK2EfHteGywTolFTVtn2KB4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628074085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C4ug015c3LH1nPiLTgtxw4DPIl6IpKEPHr9Lpc8Y4IM=;
        b=sczhkmDR+D9ftckwmfozpKWrIREveEk+Rb8FYrXdHIeQELq3imxDLdD1vUtCafUp6VM5R9
        9X/dqPkoy6GyvwBw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Daniel Wagner <wagi@monom.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.14-rc4-rt4
Message-ID: <20210804104803.4nwxi74sa2vwiujd@linutronix.de>
References: <20210802162750.santic4y6lzcet5c@linutronix.de>
 <20210804082418.fbibprcwtzyt5qax@beryllium.lan>
 <20210804104340.fhdjwn3hruymu3ml@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210804104340.fhdjwn3hruymu3ml@linutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-08-04 12:43:42 [+0200], To Daniel Wagner wrote:
> Odd. Do you have a config for that, please?

No need.
| [   90.202543] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:35
| [   90.202549] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 2047, name: iou-wrk-2041
| [   90.202555] CPU: 5 PID: 2047 Comm: iou-wrk-2041 Tainted: G        W         5.14.0-rc4-rt4+ #89
| [   90.202559] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
| [   90.202561] Call Trace:
| [   90.202577]  dump_stack_lvl+0x34/0x44
| [   90.202584]  ___might_sleep.cold+0x87/0x94
| [   90.202588]  rt_spin_lock+0x19/0x70
| [   90.202593]  ___slab_alloc+0xcb/0x7d0
| [   90.202598]  ? newidle_balance.constprop.0+0xf5/0x3b0
| [   90.202603]  ? dequeue_entity+0xc3/0x290
| [   90.202605]  ? io_wqe_dec_running.isra.0+0x98/0xe0
| [   90.202610]  ? pick_next_task_fair+0xb9/0x330
| [   90.202612]  ? __schedule+0x670/0x1410
| [   90.202615]  ? io_wqe_dec_running.isra.0+0x98/0xe0
| [   90.202618]  kmem_cache_alloc_trace+0x79/0x1f0
| [   90.202621]  io_wqe_dec_running.isra.0+0x98/0xe0
| [   90.202625]  io_wq_worker_sleeping+0x37/0x50
| [   90.202628]  schedule+0x30/0xd0
| [   90.202630]  schedule_timeout+0x8f/0x1a0
| [   90.202634]  ? __bpf_trace_tick_stop+0x10/0x10
| [   90.202637]  io_wqe_worker+0xfd/0x320
| [   90.202641]  ? finish_task_switch.isra.0+0xd3/0x290
| [   90.202644]  ? io_worker_handle_work+0x670/0x670
| [   90.202646]  ? io_worker_handle_work+0x670/0x670
| [   90.202649]  ret_from_fork+0x22/0x30

le look.

> > Thanks,
> > Daniel

Sebastian
