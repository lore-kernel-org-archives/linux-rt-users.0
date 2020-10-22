Return-Path: <SRS0=0dn7=D5=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,
	BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B82C388F9
	for <linux-rt-users@archiver.kernel.org>; Thu, 22 Oct 2020 15:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3759924630
	for <linux-rt-users@archiver.kernel.org>; Thu, 22 Oct 2020 15:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J+irhIXQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h1sz9w67"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508048AbgJVPEi (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 22 Oct 2020 11:04:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48160 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbgJVPEi (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 22 Oct 2020 11:04:38 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603379075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=poLlHTm/lGhh0YgbXT+GhwzFdYA915RedWp0uJjh7qo=;
        b=J+irhIXQ9SNSEkJdP8SKot/CtKI1zRTwvvMQxcARj1yCISQTfOT4xqhHdY3QEzQEwg5n5G
        XRV3Sc4L/WFDOge0JjOnX8DHWss/01oW5+NXaFK7Reetu0AvCWvfqFkxFfYz5vOyWTdVIO
        fNBsSj0GKfDAbr2SY870p2429MzF/Qaq4uchabkaNIuPeeqWOp+DgqemMzUoCEQgjFzc7o
        3z6JypOUoX2+FwGjINEZ/1opDGHNav86zNNoBLdeMKjR9cmjs47XEJrKFSv0s8IOuMCFqF
        7eQyFj4wEi6vTAiqmH9dGFlW4UHLKYybs0tbPhIZrYie4pxGlCNzBpMWAysg4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603379075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=poLlHTm/lGhh0YgbXT+GhwzFdYA915RedWp0uJjh7qo=;
        b=h1sz9w67lpuQSTeLYI4+3+9yLE8fvufM8AEDnoLxKnfMMFnj9Z+nngiSAeZRlMVXPx48EO
        5saaimoqeGQ8wQBg==
To:     Mike Galbraith <efault@gmx.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: printk: add pr_flush()
In-Reply-To: <15cd3dc322eb1485fe1e67df465febdc6ad389d8.camel@gmx.de>
References: <15cd3dc322eb1485fe1e67df465febdc6ad389d8.camel@gmx.de>
Date:   Thu, 22 Oct 2020 17:10:34 +0206
Message-ID: <874kmmz4hp.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

--=-=-=
Content-Type: text/plain

On 2020-10-22, Mike Galbraith <efault@gmx.de> wrote:
> Seems this patch can cause hangs.  I can reliably reproduce one such
> hang by poking sysrq-b, and it goes away if I revert that.

I see an RCU warning and then 30 seconds later the software watchdog
kicks in showing the ttyS0 irq handler is stuck in the D state.

I thought that kmsg_dumps for non-OOPS scenarios were always
preemptible. I will re-evaluate the possible non-OOPS kmsg_dump paths.

Thanks for reporting.

John Ogness


--=-=-=
Content-Type: text/plain
Content-Disposition: attachment; filename=dmesg.txt

[   10.120370][ T1067] ------------[ cut here ]------------
[   10.122210][ T1067] WARNING: CPU: 0 PID: 1067 at kernel/rcu/tree_plugin.h:295 rcu_note_context_switch+0x75/0x520
[   10.123313][ T1067] Modules linked in:
[   10.123753][ T1067] CPU: 0 PID: 1067 Comm: irq/4-ttyS0 Not tainted 5.9.0-rt16+ #3
[   10.124502][ T1067] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   10.125529][ T1067] RIP: 0010:rcu_note_context_switch+0x75/0x520
[   10.126220][ T1067] Code: ff 74 0f 65 8b 05 07 3f f0 7e 85 c0 0f 85 89 00 00 00 45 84 e4 75 15 65 48 8b 04 25 00 71 01 00 8b b0 bc 03 00 00 85 f6 7e 02 <0f> 0b 65 48 8b 04 25 00 71 01 00 8b 88 bc 03 00 00 851
[   10.128323][ T1067] RSP: 0018:ffffc90000bfbbb0 EFLAGS: 00010002
[   10.129040][ T1067] RAX: ffff88805b3db400 RBX: ffff88807e6283c0 RCX: 0000000000000001
[   10.129837][ T1067] RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000001
[   10.130788][ T1067] RBP: ffffc90000bfbbe8 R08: 0000000000000001 R09: 0000000000000001
[   10.131692][ T1067] R10: 0000000000000001 R11: ffffc90000bfbca0 R12: 0000000000000000
[   10.132586][ T1067] R13: 0000000000000000 R14: ffff88805b3db400 R15: 0000000000000000
[   10.133531][ T1067] FS:  0000000000000000(0000) GS:ffff88807e600000(0000) knlGS:0000000000000000
[   10.134517][ T1067] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   10.135247][ T1067] CR2: 000055f49044f118 CR3: 000000007f8b4001 CR4: 0000000000370ef0
[   10.136100][ T1067] Call Trace:
[   10.136397][ T1067]  __schedule+0xb5/0x930
[   10.136975][ T1067]  ? lockdep_hardirqs_on+0x7d/0x100
[   10.137525][ T1067]  schedule+0x5a/0x100
[   10.137932][ T1067]  schedule_timeout+0x192/0x250
[   10.138491][ T1067]  ? del_timer_sync+0x120/0x120
[   10.139044][ T1067]  ? msleep+0x1c/0x50
[   10.139511][ T1067]  msleep+0x3c/0x50
[   10.139887][ T1067]  pr_flush+0xdd/0xf0
[   10.140403][ T1067]  kmsg_dump+0x4e/0x1a0
[   10.140985][ T1067]  emergency_restart+0x13/0x20
[   10.141619][ T1067]  sysrq_handle_reboot+0x27/0x30
[   10.142173][ T1067]  __handle_sysrq.cold.13+0x52/0x138
[   10.142788][ T1067]  handle_sysrq+0x1d/0x30
[   10.143273][ T1067]  serial8250_handle_irq.part.29+0x12f/0x160
[   10.143966][ T1067]  serial8250_default_handle_irq+0x42/0x60
[   10.144636][ T1067]  serial8250_interrupt+0x68/0xc0
[   10.145287][ T1067]  ? irq_thread+0xa1/0x1d0
[   10.145825][ T1067]  irq_forced_thread_fn+0x35/0x80
[   10.146373][ T1067]  irq_thread+0x10b/0x1d0
[   10.146882][ T1067]  ? irq_finalize_oneshot.part.48+0xe0/0xe0
[   10.147601][ T1067]  ? wake_threads_waitq+0x30/0x30
[   10.148196][ T1067]  ? irq_thread_dtor+0x90/0x90
[   10.148751][ T1067]  kthread+0x181/0x1a0
[   10.149310][ T1067]  ? kthread_park+0x90/0x90
[   10.149789][ T1067]  ret_from_fork+0x22/0x30
[   10.150364][ T1067] irq event stamp: 785
[   10.150875][ T1067] hardirqs last  enabled at (784): [<ffffffff81d17325>] _raw_spin_unlock_irqrestore+0x75/0x80
[   10.151954][ T1067] hardirqs last disabled at (785): [<ffffffff81d125dc>] __schedule+0x53c/0x930
[   10.152918][ T1067] softirqs last  enabled at (760): [<ffffffff8107bd2f>] __local_bh_enable_ip+0x7f/0x130
[   10.153967][ T1067] softirqs last disabled at (770): [<ffffffff810fc2d5>] irq_forced_thread_fn+0x5/0x80
[   10.154966][ T1067] ---[ end trace 0000000000000002 ]---
[   61.851699][  T495] INFO: task rcub/0:12 blocked for more than 30 seconds.
[   61.854535][  T495]       Tainted: G        W         5.9.0-rt16+ #3
[   61.856706][  T495] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[   61.857491][  T495] task:rcub/0          state:D stack:14728 pid:   12 ppid:     2 flags:0x00004000
[   61.858230][  T495] Call Trace:
[   61.858497][  T495]  __schedule+0x2ec/0x930
[   61.858847][  T495]  ? _raw_spin_unlock_irq+0x27/0x70
[   61.859266][  T495]  schedule+0x5a/0x100
[   61.859592][  T495]  __rt_mutex_slowlock+0x93/0x1a0
[   61.859996][  T495]  rt_mutex_slowlock_locked+0xd0/0x300
[   61.860436][  T495]  rt_mutex_slowlock.constprop.31+0x72/0xb0
[   61.860919][  T495]  __rt_mutex_lock_state+0x32/0x40
[   61.861393][  T495]  rt_mutex_lock_nested+0x38/0x60
[   61.861889][  T495]  ? rcu_boost_kthread+0x140/0x6d0
[   61.862301][  T495]  ? rcu_boost_kthread+0x7a/0x6d0
[   61.862704][  T495]  rcu_boost_kthread+0x140/0x6d0
[   61.863101][  T495]  ? rcu_barrier+0x320/0x320
[   61.863469][  T495]  kthread+0x181/0x1a0
[   61.863796][  T495]  ? kthread_park+0x90/0x90
[   61.864158][  T495]  ret_from_fork+0x22/0x30
[   61.864527][  T495] INFO: task irq/4-ttyS0:1067 blocked for more than 30 seconds.
[   61.865183][  T495]       Tainted: G        W         5.9.0-rt16+ #3
[   61.865702][  T495] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[   61.866394][  T495] task:irq/4-ttyS0     state:D stack:13512 pid: 1067 ppid:     2 flags:0x00004000
[   61.867130][  T495] Call Trace:
[   61.867394][  T495]  __schedule+0x2ec/0x930
[   61.867744][  T495]  schedule+0x5a/0x100
[   61.868070][  T495]  schedule_timeout+0x192/0x250
[   61.868459][  T495]  ? del_timer_sync+0x120/0x120
[   61.868850][  T495]  ? msleep+0x1c/0x50
[   61.869214][  T495]  msleep+0x3c/0x50
[   61.869519][  T495]  pr_flush+0xdd/0xf0
[   61.869840][  T495]  kmsg_dump+0x4e/0x1a0
[   61.870173][  T495]  emergency_restart+0x13/0x20
[   61.870555][  T495]  sysrq_handle_reboot+0x27/0x30
[   61.870950][  T495]  __handle_sysrq.cold.13+0x52/0x138
[   61.871374][  T495]  handle_sysrq+0x1d/0x30
[   61.871836][  T495]  serial8250_handle_irq.part.29+0x12f/0x160
[   61.872320][  T495]  serial8250_default_handle_irq+0x42/0x60
[   61.872787][  T495]  serial8250_interrupt+0x68/0xc0
[   61.873236][  T495]  ? irq_thread+0xa1/0x1d0
[   61.873589][  T495]  irq_forced_thread_fn+0x35/0x80
[   61.873993][  T495]  irq_thread+0x10b/0x1d0
[   61.874436][  T495]  ? irq_finalize_oneshot.part.48+0xe0/0xe0
[   61.874910][  T495]  ? wake_threads_waitq+0x30/0x30
[   61.875314][  T495]  ? irq_thread_dtor+0x90/0x90
[   61.875696][  T495]  kthread+0x181/0x1a0
[   61.876022][  T495]  ? kthread_park+0x90/0x90
[   61.876384][  T495]  ret_from_fork+0x22/0x30
[   61.876745][  T495] 
[   61.876745][  T495] Showing all locks held in the system:
[   61.877428][  T495] 1 lock held by rcuc/0/10:
[   61.877787][  T495]  #0: ffff88807e617e30 ((softirq_ctrl.lock).lock){+.+.}-{3:3}, at: __local_bh_disable_ip+0x11a/0x2b0
[   61.878662][  T495] 1 lock held by rcub/0/12:
[   61.879021][  T495]  #0: ffffffff828bb488 (rcu_state){+.+.}-{0:0}, at: rcu_boost_kthread+0x140/0x6d0
[   61.879767][  T495] 1 lock held by khungtaskd/495:
[   61.880161][  T495]  #0: ffffffff828b8e00 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x23/0x17c
[   61.880995][  T495] 6 locks held by irq/4-ttyS0/1067:
[   61.881486][  T495]  #0: ffff88807e617e30 ((softirq_ctrl.lock).lock){+.+.}-{3:3}, at: __local_bh_disable_ip+0x11a/0x2b0
[   61.882402][  T495]  #1: ffffffff828b8e00 (rcu_read_lock){....}-{1:3}, at: rt_spin_lock+0x5/0xc0
[   61.883119][  T495]  #2: ffffffff828b8e00 (rcu_read_lock){....}-{1:3}, at: __local_bh_disable_ip+0x157/0x2b0
[   61.883917][  T495]  #3: ffff88805b74e8a8 (&i->lock){+.+.}-{0:0}, at: serial8250_interrupt+0x32/0xc0
[   61.884661][  T495]  #4: ffffffff828b8e00 (rcu_read_lock){....}-{1:3}, at: rt_spin_lock+0x5/0xc0
[   61.885380][  T495]  #5: ffffffff828b8e00 (rcu_read_lock){....}-{1:3}, at: __handle_sysrq+0x5/0xa0
[   61.886108][  T495] 2 locks held by init/1084:
[   61.886474][  T495]  #0: ffff88807f4c1098 (&tty->ldisc_sem){++++}-{0:0}, at: ldsem_down_read+0x32/0x40
[   61.887229][  T495]  #1: ffffc90000303308 (&ldata->atomic_read_lock){+.+.}-{0:0}, at: n_tty_read+0xc2/0x9c0
[   61.888021][  T495] 
[   61.888207][  T495] =============================================
[   61.888207][  T495] 
[   68.863491][ T1054] printk: console [ttyS0]: printing thread stopped
[   68.891970][ T1056] random: fast init done

--=-=-=--
