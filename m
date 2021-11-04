Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AD0C433EF
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Nov 2021 18:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FEC061216
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Nov 2021 18:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbhKDS6o (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 4 Nov 2021 14:58:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39644 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231684AbhKDS6n (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 4 Nov 2021 14:58:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636052165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F/xDXiRfvSnCmKp7BwEdsx8m4SxFEWCeq7m0ckZxBN8=;
        b=MnoaCWjSaEfzRuIczDCSZ09v0Wu8xAZszy4Jt8tuhSSzhlaqjSyCTxeww5259iwRZXyxSb
        bEMLEkF90rjYqoC0ZgEcljzpAJGdx9R1qB7Jl2qcxvsDQFTtuu7sM7dvKGuNE8AQkZ/mC0
        0Ar/zppgI6mJo0JaTDhEnIxtu0CGFbI=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-525-Nn2HQvXeMjyVnMnNWCgHYg-1; Thu, 04 Nov 2021 14:56:03 -0400
X-MC-Unique: Nn2HQvXeMjyVnMnNWCgHYg-1
Received: by mail-lf1-f72.google.com with SMTP id i1-20020a056512340100b003fdd5b951e0so2308863lfr.22
        for <linux-rt-users@vger.kernel.org>; Thu, 04 Nov 2021 11:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F/xDXiRfvSnCmKp7BwEdsx8m4SxFEWCeq7m0ckZxBN8=;
        b=lLdI/v9KdjMmqGnbJ5I/2q8Gt4l0VU5qa56Sy6neEO0CJLZMQZ+AbJxn2icRc6NJ69
         afX0Nye3CZMSA2tiJ1p49BinDGaBZQuOraux3QqbHTpFr/0HwWMNJoOujxsmlIpG0NnK
         FUzZ/aWiBn7grHqmYlWSHNCc+rFtrqW9XIi5VfpE/klHCYWYovUFsW2bIniOu6v3yQon
         lJscNvmfn3Z0eCaPSX95TSJZUyGZAkRxcOUU08d875oHAqFo24Qk+gA65rwZDcMtPclY
         fyutyDmyUIxJ2gcRYd7CoGvdrfURUib6vF7pMFOAo7fNJcdRdiDJ7ZIl5BcCuOdIYodF
         zYRw==
X-Gm-Message-State: AOAM533XnPyI3BXS+lDw/ndeEHAXoFhg16Xb5TgZfZahP2KUkbw0zBeA
        51maXqC5nvtmg50PqfC6r6i/dGrLjw0bJzRMOUz7KTMNaWMnJq9oO2gjQBe8qXhaXmkI4vY8kCs
        94FZHjfbNv0qTztfyJI2Ki4mWpopmiUcqdJwZwzz8tc4=
X-Received: by 2002:a2e:8584:: with SMTP id b4mr55792867lji.14.1636052162384;
        Thu, 04 Nov 2021 11:56:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxWJiK9NaLbuIoBg2ZB98lwglKWgRPy0PtNuycbmBIeoF1drwMpSxXfvyecs6mV94NRniwr09eTHejHdPIN9ms=
X-Received: by 2002:a2e:8584:: with SMTP id b4mr55792845lji.14.1636052162172;
 Thu, 04 Nov 2021 11:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <YVuwBEWw4F7NGUd2@uudg.org> <20211011163333.2o64amr4qks4gpdm@linutronix.de>
 <CAD8J---eDMZb7Z39vYLY+vZZYhvTokv3NgsCCa=oJhH_hTYH6w@mail.gmail.com> <20211027090650.fqpqtze6wfetihej@linutronix.de>
In-Reply-To: <20211027090650.fqpqtze6wfetihej@linutronix.de>
From:   Luis Goncalves <lgoncalv@redhat.com>
Date:   Thu, 4 Nov 2021 15:55:50 -0300
Message-ID: <CAD8J--_nJXgsNVZSFEs4ZVjvANgxt=vU_i3dMcrWq9hC8UyLRw@mail.gmail.com>
Subject: Re: [RFC RT v5.10] [rt] repair usage of raw_v6_hashinfo.lock in raw_seq_start()
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        stable-rt@vger.kernel.org, Chunyu Hu <chuhu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Oct 27, 2021 at 6:06 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2021-10-18 12:51:32 [-0300], Luis Goncalves wrote:
> > Again, the use of tuned in the tests is mostly to reproduce the
> > configuration in use at
> > the moment. I can isolate the specific configuration that makes it
> > possible to trigger the
> > lockdep splat.
>
> I can't reproduce any of those two issues. I tried both and iterated the
> tuned profiles
>         tuned-adm profile realtime
>         tuned-adm profile throughput-performance
>
> while running the test you mentioned.
> Could you please try if this reproduces with latest v5.15-RT and post
> complete lockdep backtrace?

I couldn't reproduce that on v5.14-rt nor v5.15-rt. But I can easily
reproduce the lockdep splat on v5.10-rt, though.

This is the backtrace  for v5.10.73-rt54:

[  220.768268] run.sh (2905): /proc/2142/oom_adj is deprecated, please
use /proc/2142/oom_score_adj instead.
[  221.794958] LTP: starting read_all_proc (read_all -d /proc -q -r 3)
[  222.678607] ICMPv6: process `read_all' is using deprecated sysctl
(syscall) net.ipv6.neigh.default.base_reachable_time - use
net.ipv6.neigh.default.base_reachable_time_ms instead

[  222.897071] ======================================================
[  222.897071] WARNING: possible circular locking dependency detected
[  222.897072] 5.10.73-rt54.lockdep+ #2 Tainted: G S      W I
[  222.897073] ------------------------------------------------------
[  222.897074] read_all/3946 is trying to acquire lock:
[  222.897075] ffff9727dee18220
((softirq_ctrl.lock).lock){+.+.}-{2:2}, at:
__local_bh_disable_ip+0x116/0x2f0
[  222.897084]
               but task is already holding lock:
[  222.897085] ffffffffba2e9720 (raw_v6_hashinfo.lock){++.+}-{0:0},
at: raw_seq_start+0x25/0x60
[  222.897090]
               which lock already depends on the new lock.

[  222.897091]
               the existing dependency chain (in reverse order) is:
[  222.897092]
               -> #1 (raw_v6_hashinfo.lock){++.+}-{0:0}:
[  222.897093]        lock_acquire+0xde/0x380
[  222.897098]        rt_write_lock+0x3a/0x1b0
[  222.897101]        raw_hash_sk+0x3f/0xd0
[  222.897103]        inet6_create+0x2ef/0x690
[  222.897107]        __sock_create+0x1e2/0x430
[  222.897111]        inet_ctl_sock_create+0x33/0x90
[  222.897113]        icmpv6_sk_init+0x71/0x130
[  222.897118]        ops_init+0x3a/0x180
[  222.897123]        register_pernet_operations+0x126/0x220
[  222.897125]        register_pernet_subsys+0x24/0x40
[  222.897127]        icmpv6_init+0x11/0x4c
[  222.897132]        inet6_init+0x112/0x373
[  222.897133]        do_one_initcall+0x74/0x440
[  222.897137]        kernel_init_freeable+0x39d/0x408
[  222.897140]        kernel_init+0xb/0x12e
[  222.897142]        ret_from_fork+0x1f/0x30
[  222.897144]
               -> #0 ((softirq_ctrl.lock).lock){+.+.}-{2:2}:
[  222.897145]        check_prevs_add+0x1bb/0xe50
[  222.897147]        __lock_acquire+0x1187/0x1640
[  222.897149]        lock_acquire+0xde/0x380
[  222.897151]        rt_spin_lock+0x2b/0xd0
[  222.897152]        __local_bh_disable_ip+0x116/0x2f0
[  222.897155]        sock_i_ino+0x22/0x60
[  222.897157]        __ip6_dgram_sock_seq_show+0x3e/0xe0
[  222.897160]        raw6_seq_show+0x28/0x40
[  222.897162]        seq_read_iter+0x27e/0x420
[  222.897166]        seq_read+0x10f/0x160
[  222.897168]        proc_reg_read+0x3e/0x80
[  222.897171]        vfs_read+0xe7/0x1e0
[  222.897174]        ksys_read+0x5f/0xe0
[  222.897175]        do_syscall_64+0x33/0x40
[  222.897178]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  222.897179]
               other info that might help us debug this:

[  222.897179]  Possible unsafe locking scenario:

[  222.897180]        CPU0                    CPU1
[  222.897180]        ----                    ----
[  222.897180]   lock(raw_v6_hashinfo.lock);
[  222.897181]                                lock((softirq_ctrl.lock).lock);
[  222.897182]                                lock(raw_v6_hashinfo.lock);
[  222.897183]   lock((softirq_ctrl.lock).lock);
[  222.897183]
                *** DEADLOCK ***

[  222.897184] 3 locks held by read_all/3946:
[  222.897185]  #0: ffff9720939dfe10 (&p->lock){+.+.}-{0:0}, at:
seq_read_iter+0x56/0x420
[  222.897188]  #1: ffffffffba2e9720
(raw_v6_hashinfo.lock){++.+}-{0:0}, at: raw_seq_start+0x25/0x60
[  222.897191]  #2: ffffffffb9ec8fe0 (rcu_read_lock){....}-{1:2}, at:
rt_read_lock+0x7d/0x1e0
[  222.897194]
               stack backtrace:
[  222.897195] CPU: 28 PID: 3946 Comm: read_all Tainted: G S      W I
     5.10.73-rt54.lockdep+ #2
[  222.897196] Hardware name: Dell Inc. PowerEdge R740/07X9K0, BIOS
2.8.2 08/27/2020
[  222.897197] Call Trace:
[  222.897199]  dump_stack+0x77/0x97
[  222.897204]  check_noncircular+0xff/0x120
[  222.897208]  check_prevs_add+0x1bb/0xe50
[  222.897211]  __lock_acquire+0x1187/0x1640
[  222.897215]  lock_acquire+0xde/0x380
[  222.897217]  ? __local_bh_disable_ip+0x116/0x2f0
[  222.897221]  ? sock_i_ino+0x5/0x60
[  222.897223]  rt_spin_lock+0x2b/0xd0
[  222.897224]  ? __local_bh_disable_ip+0x116/0x2f0
[  222.897227]  __local_bh_disable_ip+0x116/0x2f0
[  222.897229]  sock_i_ino+0x22/0x60
[  222.897231]  __ip6_dgram_sock_seq_show+0x3e/0xe0
[  222.897234]  raw6_seq_show+0x28/0x40
[  222.897236]  seq_read_iter+0x27e/0x420
[  222.897239]  seq_read+0x10f/0x160
[  222.897243]  proc_reg_read+0x3e/0x80
[  222.897245]  vfs_read+0xe7/0x1e0
[  222.897247]  ksys_read+0x5f/0xe0
[  222.897249]  do_syscall_64+0x33/0x40
[  222.897251]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  222.897254] RIP: 0033:0x7f71817b99b2
[  222.897256] Code: 96 20 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb
b6 0f 1f 80 00 00 00 00 f3 0f 1e fa 8b 05 96 da 20 00 85 c0 75 12 31
c0 0f 05 <48> 3d 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 41 54 49 89 d4 55
48 89
[  222.897258] RSP: 002b:00007ffed3549878 EFLAGS: 00000246 ORIG_RAX:
0000000000000000
[  222.897259] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f71817b99b2
[  222.897261] RDX: 00000000000003ff RSI: 00007ffed3549d20 RDI: 0000000000000003
[  222.897262] RBP: 00007f7181bec000 R08: 0000000000000020 R09: 0000000000000000
[  222.897262] R10: 0000000000000000 R11: 0000000000000246 R12: 000000002cab66e1
[  222.897263] R13: 00007ffed3549921 R14: 0000000000624730 R15: 0000000000000000
[  232.965010] LTP: starting read_all_sys (read_all -d /sys -q -r 3)
[  235.930281] rtc_cmos 00:00: Deprecated ABI, please use nvmem
[  237.200250] WARNING! power/level is deprecated; use power/control instead

