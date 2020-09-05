Return-Path: <SRS0=yTcV=CO=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435A2C43461
	for <linux-rt-users@archiver.kernel.org>; Sat,  5 Sep 2020 05:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D62A0208DB
	for <linux-rt-users@archiver.kernel.org>; Sat,  5 Sep 2020 05:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="B6KqEeQd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgIEFTt (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 5 Sep 2020 01:19:49 -0400
Received: from mout.gmx.net ([212.227.15.15]:58201 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbgIEFTt (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 5 Sep 2020 01:19:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599283151;
        bh=rwJdyAHG3C5LedVfBNN5zPz491EITwDDDYp7es9j+0Q=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=B6KqEeQd0ZcKGHSUR0z0kwtYycM57Cyc/fKoP2589ZxkqW8znZtF9CTfAoEXlitdP
         JIJtFc0gL4kRkT5td6jeRHAm0D5BhlpxxJKaqpIzDFVZrHnWbDuyp53tqy1PuHJlvN
         0izjVsUVEIxiI0DZrnzhBYnJc4iIOXVHEWteAKn0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.simpson.net ([185.146.50.208]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4axg-1kEyIj1bAE-001hko; Sat, 05
 Sep 2020 07:19:11 +0200
Message-ID: <b989e196a8b9cceda35152de9202d7a67ca32196.camel@gmx.de>
Subject: Re: v5.9-rc3-rt3 boot time networking lockdep splat
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Sat, 05 Sep 2020 07:19:10 +0200
In-Reply-To: <46a2b89ec8d953a4be18c7389c7d8c66310a7ff0.camel@gmx.de>
References: <20200902155557.h2wl2qpfn2rwsofw@linutronix.de>
         <46a2b89ec8d953a4be18c7389c7d8c66310a7ff0.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:B9ZOW6FCooJa08wS0Ikw/bURGD3tjVyfNihh31TvtsCoafQ3Ohn
 CElGr6izntKxTxC7nxpbhcyCXrAfVFXt6meAdOEgWOKiRY2Pw2K/ewhbAcnra3xOe5Lfks1
 3YTBNEvhkX5KmabomwFxtapdoSqkDsZc7NnEdlXe+CYKi6/fS6523cf3N0QhiCReC2SJNEZ
 NAlrfqCJiSOGhGPda/JMQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5kx/JMdNNUs=:aFiM/+3uU/3RjEPzFAryZi
 I2ZRBRNEAONwq5s1eN4XuUDa5f9VWv3XoiTQIn7ZogOaQi265yuYQNqi4cq0xwYWPz16rf8H3
 RuS0UbpaZW5zfswW79M973tkhpTFdG6kEzamuHuew4JtoLT76dmTH392xFbOkm8HYI4cvoxTM
 hGG7sN6WGWABPIu3PI/gi4KdJiy1BYbd9GQm3phWQn2aOrA2NmOMsRXw6PoVQmh387688XYjp
 8Ft1tFnPi2mWbr/kl31pWdhPWPrm6lrE49fwMNCwPLnogQyJeciSWMmcTUlwkzPfehKkG07Ey
 nH7H/k+++F5X2iR+2JJ9Ffxp8pbq3fvjzPHDkKchwo1kvy6EfsLygHxCNB2OMIrvEAGo2FrKC
 Sg7lHyLhxadfIv6uxRyLUmfSStviqN6nor2nEgOKuX3LrfujrO+BcsNFNylYwWYX+8xTwAQOv
 B6u7oJKWRGxm+EZ9fJly8t36iAz1a0odxgION85dJQWgm+38CO0VFVRZuYGcuEFZUHy9XSDe7
 so0YiJPACrMu0khRqxjvMTJ9VWt78NN9didrTQKzJd3YwTcHzL1khGV1VMz1OQXlaq3PlqDup
 g11aNd3R/plvL9pkDAHEvHKwZaQ7ViXSFcvZ88wwnLZ8f+68p6bFV3AveMai6wDCaYVjeaios
 T0kScy/D7wK105IWg00EfX3hvek504yygQZRSa/BpVOJHwf1AsuTrCFgoFAaxybDiMRF/4r/I
 awdV+Zw7MZXqkDQRRseXYU6S5RfoCmpYiCz5fb8ygwXkIN46FbHGq9gZaJXTQ57HOc/4UA7QK
 G20YwR7jDv0SkF/78iyg0Sxp37TM+BA6XJcUEg97W9h5eRDrwpZM12JBQA5+mcQ2O7gUewG4+
 GwgGSI5RRaalrUfSuCFX1+nFaTopRwgv9U7ceCat5Ef1OM/6zWu5TbBM79yBZX1zc19uSpaP2
 p+0QULDNNTE0cOsl8XJdxoGjtyimhIOTRsdjusAZumZcU2PxeRfKkN/QshDMR0UY7PJJALO/d
 bvslfQ2HmMawXyDvw5IRNxWrn60QBzTJDpLKZueCByCaQaubLpukenOZjLrJRILJMM2BPCZn3
 6HcIpO7MKPKExZ87mvb9nrqvEHqfaIa10zwnMtH/+IXpIKrX7RWR2a/di4rqMJosFcrcYHFXT
 Ux4a6rFtC8/5kWUq9bX3WMRxMu11ZWJtJF4u4fIGLlGUO8JjARvMzvGkWN/IxvbJUiNjPQwa1
 M4sAGbyd+5VpIf5Rf
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Lappy, which does not use bridge, boots clean... but lock leakage
pretty darn quickly inspires lockdep to craps its drawers.

[  209.001111] BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
[  209.001113] turning off the locking correctness validator.
[  209.001114] CPU: 2 PID: 3773 Comm: Socket Thread Tainted: G S        I E     5.9.0.gc70672d-rt3-rt #8
[  209.001117] Hardware name: HP HP Spectre x360 Convertible/804F, BIOS F.47 11/22/2017
[  209.001118] Call Trace:
[  209.001123]  dump_stack+0x77/0x9b
[  209.001129]  validate_chain+0xf60/0x1230
[  209.001135]  __lock_acquire+0x880/0xbf0
[  209.001139]  lock_acquire+0x92/0x3f0
[  209.001142]  ? rcu_note_context_switch+0x118/0x550
[  209.001146]  ? update_load_avg+0x5cc/0x6d0
[  209.001150]  _raw_spin_lock+0x2f/0x40
[  209.001153]  ? rcu_note_context_switch+0x118/0x550
[  209.001155]  rcu_note_context_switch+0x118/0x550
[  209.001157]  ? lockdep_hardirqs_off+0x6e/0xd0
[  209.001161]  __schedule+0xbe/0xb50
[  209.001163]  ? mark_held_locks+0x2d/0x80
[  209.001166]  preempt_schedule_irq+0x44/0xb0
[  209.001168]  irqentry_exit+0x5b/0x80
[  209.001170]  asm_sysvec_reschedule_ipi+0x12/0x20
[  209.001173] RIP: 0010:debug_lockdep_rcu_enabled+0x23/0x30
[  209.001175] Code: 0f 0b e9 6d ff ff ff 8b 05 0a a0 c5 00 85 c0 74 21 8b 05 cc da c5 00 85 c0 74 17 65 48 8b 04 25 c0 91 01 00 8b 80 8c 0a 00 00 <85> c0 0f 94 c0 0f b6 c0 f3 c3 cc cc cc 65 48 8b 04 25 c0 91 01 00
[  209.001178] RSP: 0018:ffffa00202a0f998 EFLAGS: 00000202
[  209.001179] RAX: 0000000000000000 RBX: ffff90a8a6d1da20 RCX: 0000000000000001
[  209.001180] RDX: 0000000000000002 RSI: ffffffff971308fc RDI: ffffffff9710b092
[  209.001181] RBP: 0000000000000048 R08: 0000000000000001 R09: 0000000000000001
[  209.001181] R10: ffff90a8a6d1da38 R11: 0000000000000006 R12: ffffffff97405280
[  209.001182] R13: 0000000000000008 R14: ffffffff97405240 R15: 0000000000000100
[  209.001188]  rt_spin_unlock+0x2c/0x90
[  209.001191]  __do_softirq+0xc1/0x5b2
[  209.001194]  ? ip_finish_output2+0x264/0xa10
[  209.001197]  __local_bh_enable_ip+0x230/0x290
[  209.001200]  ip_finish_output2+0x288/0xa10
[  209.001201]  ? rcu_read_lock_held+0x32/0x40
[  209.001206]  ? ip_output+0x70/0x200
[  209.001207]  ip_output+0x70/0x200
[  209.001210]  ? __ip_finish_output+0x320/0x320
[  209.001212]  __ip_queue_xmit+0x1f0/0x5d0
[  209.001216]  __tcp_transmit_skb+0xa7f/0xc70
[  209.001219]  ? __alloc_skb+0x7b/0x1b0
[  209.001222]  ? __kmalloc_node_track_caller+0x252/0x330
[  209.001230]  tcp_rcv_established+0x365/0x6d0
[  209.001233]  tcp_v4_do_rcv+0x7e/0x1b0
[  209.001236]  __release_sock+0x89/0x130
[  209.001239]  release_sock+0x3c/0xd0
[  209.001241]  tcp_recvmsg+0x2b9/0xa90
[  209.001247]  inet_recvmsg+0x6b/0x210
[  209.001252]  __sys_recvfrom+0xb8/0x110
[  209.001256]  ? poll_select_finish+0x1f0/0x1f0
[  209.001261]  ? syscall_enter_from_user_mode+0x37/0x340
[  209.001263]  ? syscall_enter_from_user_mode+0x3c/0x340
[  209.001265]  ? lockdep_hardirqs_on+0x78/0x100
[  209.001268]  __x64_sys_recvfrom+0x24/0x30
[  209.001269]  do_syscall_64+0x33/0x40
[  209.001271]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  209.001274] RIP: 0033:0x7ff2421a230a
[  209.001276] Code: 7c 24 08 4c 89 14 24 e8 44 f8 ff ff 45 31 c9 89 c3 45 31 c0 4c 8b 14 24 4c 89 e2 48 89 ee 48 8b 7c 24 08 b8 2d 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 32 89 df 48 89 04 24 e8 73 f8 ff ff 48 8b 04
[  209.001278] RSP: 002b:00007ff24243a550 EFLAGS: 00000246 ORIG_RAX: 000000000000002d
[  209.001279] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff2421a230a
[  209.001280] RDX: 00000000000034da RSI: 00007ff21094fb37 RDI: 000000000000006b
[  209.001281] RBP: 00007ff21094fb37 R08: 0000000000000000 R09: 0000000000000000
[  209.001282] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000034da
[  209.001283] R13: 00007ff21094fb37 R14: 0000000000000000 R15: 00007ff20e8a4000

