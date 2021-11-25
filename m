Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86105C433F5
	for <linux-rt-users@archiver.kernel.org>; Thu, 25 Nov 2021 01:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236498AbhKYBpC (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 24 Nov 2021 20:45:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:25737 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345816AbhKYBnB (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 24 Nov 2021 20:43:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637804390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P2LuI67sgCKYj4SftdUSaiKfDduUGTDFWCVICTegQcE=;
        b=UrwbdtYh6uCqYnxnOO3A7hRhPXp9WgK/DpB1zCKyPAPlr4CHszQS8PvY1f23ISrVWnQu3q
        A23WvE/Dcb11C36Hx8mZD/VpqRNX7R1FMsb6viVXw6H8kMjqjcq8U0wMEV6Vmd2L9E3XKo
        KwkcZbZdacEKAFUggl9KqWcbENTrJ3g=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-329-Nqd4Ul9fPPGnuXlnH-0HJw-1; Wed, 24 Nov 2021 20:39:49 -0500
X-MC-Unique: Nqd4Ul9fPPGnuXlnH-0HJw-1
Received: by mail-lf1-f69.google.com with SMTP id j9-20020a05651231c900b004037efe9fddso2290941lfe.18
        for <linux-rt-users@vger.kernel.org>; Wed, 24 Nov 2021 17:39:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P2LuI67sgCKYj4SftdUSaiKfDduUGTDFWCVICTegQcE=;
        b=6NNtq403eb6ihOh0JL0Ez36gLJbyx7Ey9Ub1RpmXoM5Er/VIAd2MugUAWrFiulmh6m
         kUuR08prkdTrEpxCeztzwGAoVM+xLETE+nRiZViMAnan2LTGYCdUcrrmMiux3RbLi1oZ
         satrA6xSyJq5o9UINDbvJdoF7HmaDHv/H/WjBCXdR6oSSjxSmJIlyGT9P3g5DxL9v40G
         K5O+x8g3Cags6xfBG8iRijpSfT7zLAQ6tYiUPA1PXyL6IRAe4PeMcm8T7xEiHzsgJvzE
         yFg1+VFjrdFjd9fXTdsaQ06RxMTyTyWC60ta9xkbmIwSifV0XR6HcNNG8jrP4Cm9zxu1
         79EQ==
X-Gm-Message-State: AOAM532lo+bW8Di8VDX00nOXbJTuOVZiWjrEKi/mgkn+Lzs5ilTzLp2O
        OL1JpGYEExy8g2Bv5UMhDJK9gG2WPfj4xB7YK4neffqQw5upkJvyX7pwnjgPLtSFv8kmDvyRFC/
        HIb84QkriLnYlZlWv+2rN3jqzWuyZGl2n/xMvzKZqe9M=
X-Received: by 2002:a05:6512:220d:: with SMTP id h13mr19335925lfu.593.1637804388007;
        Wed, 24 Nov 2021 17:39:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxaMftcK9c8HUc+gdIQlkVq/2YRzVkWwCg63WX4S6++itQjsXJzeS4yRok/+6jug3Xxa63jTmMHi8cO6CeruyA=
X-Received: by 2002:a05:6512:220d:: with SMTP id h13mr19335907lfu.593.1637804387762;
 Wed, 24 Nov 2021 17:39:47 -0800 (PST)
MIME-Version: 1.0
References: <YVuviZ3F7MbPvleo@uudg.org> <20211011135609.22y7hkycbqm52w6d@linutronix.de>
 <20211011163601.m6j3ibb7ydeevpiz@linutronix.de> <CAD8J--8CjZym2afG3iSdztz51nOt9gmy747KPDxdmr1_WzwxcA@mail.gmail.com>
 <CAD8J---uJXqKeYR_3_8O5WPr9pVH8HX1DmGfE+7MdHDmaK4-Mw@mail.gmail.com>
In-Reply-To: <CAD8J---uJXqKeYR_3_8O5WPr9pVH8HX1DmGfE+7MdHDmaK4-Mw@mail.gmail.com>
From:   Luis Goncalves <lgoncalv@redhat.com>
Date:   Wed, 24 Nov 2021 22:39:34 -0300
Message-ID: <CAD8J---a6X1u7SvKs5mR=EzxJ1uUxYZ0OGqM3PPq_LowBgY-Gw@mail.gmail.com>
Subject: Re: [RFC RT v5.10] [rt] repair usage of dev_base_lock in netstat_show()
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        stable-rt@vger.kernel.org, Nitesh Narayan Lal <nilal@redhat.com>,
        Pei Zhang <pezhang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Nov 4, 2021 at 3:58 PM Luis Goncalves <lgoncalv@redhat.com> wrote:
>
> On Mon, Oct 18, 2021 at 12:42 PM Luis Goncalves <lgoncalv@redhat.com> wrote:
> >
> > On Mon, Oct 11, 2021 at 1:36 PM Sebastian Andrzej Siewior
> > <bigeasy@linutronix.de> wrote:
> > >
> > > On 2021-10-11 15:56:09 [+0200], To Luis Claudio R. Goncalves wrote:
> > > > So my guess is that the _bh isn't needed.
> > >
> > > Correction: If there is at least _one_ reader in softirq all, writer
> > > need to disable BH which _might_ be the case here.
> > > The splat is probably because on read_lock holder disables BH later on
> > > which I don't see yet.
> > >
> > > Sebastian
> >
> > The way I was able to reproduce the problem in 5.10 (and in 5.14 before -rt11)
> > was:
> >
> >     1. systemctl disable tuned.service
> >     2. Reboot to a kernel-rt with lockdep support
> >     3. systemctl start tuned.service
> >
> > I used a few tuned profiles, but stuck with 'realtime' for obvious reasons.
> >
> > If that helps in the process I can investigate which specific
> > action/configuration
> > performed by tuned is triggering the lockdep splat.
>
> Just for the sake of completeness, this is the lockdep splat for v5.10.73-rt54:

Sebastian, I just stumbled over the lockdep splat being discussed here
in v5.15.3-rt21. Well, slightly different, but related to the very
same situation:

(btw, sorry if the formatting is off, I am using the gmail webui)


[35429.000894] ======================================================
[35429.000895] WARNING: possible circular locking dependency detected
[35429.000896] 5.15.3-rt21 #2 Not tainted
[35429.000897] ------------------------------------------------------
[35429.000898] tuned/6697 is trying to acquire lock:
[35429.000899] ffff8dbfd0cebf50 (&adapter->stats_lock){+.+.}-{2:2},
at: cxgb_get_stats+0x41/0x1d0 [cxgb4]
[35429.000925]
               but task is already holding lock:
[35429.000925] ffffffff9e0ed570 (dev_base_lock){++.+}-{2:2}, at:
netstat_show.constprop.0+0x41/0xb0
[35429.000930]
               which lock already depends on the new lock.

[35429.000931]
               the existing dependency chain (in reverse order) is:
[35429.000931]
               -> #2 (dev_base_lock){++.+}-{2:2}:
[35429.000933]        __lock_acquire+0x4d2/0x930
[35429.000937]        lock_acquire.part.0+0x9c/0x210
[35429.000938]        rt_write_lock+0x48/0xc0
[35429.000941]        list_netdevice+0x4c/0x130
[35429.000943]        register_netdevice+0x4fd/0x670
[35429.000945]        register_netdev+0x1c/0x40
[35429.000959]        loopback_net_init+0x48/0x90
[35429.000962]        ops_init+0x3a/0x160
[35429.000964]        register_pernet_operations+0x127/0x220
[35429.000965]        register_pernet_device+0x26/0x60
[35429.000967]        net_dev_init+0x23c/0x2b0
[35429.000971]        do_one_initcall+0x47/0x170
[35429.000974]        do_initcalls+0xc6/0xdf
[35429.000977]        kernel_init_freeable+0xfc/0x12c
[35429.000979]        kernel_init+0x16/0x120
[35429.000982]        ret_from_fork+0x22/0x30
[35429.000984]
               -> #1 ((softirq_ctrl.lock)){+.+.}-{2:2}:
[35429.000986]        __lock_acquire+0x4d2/0x930
[35429.000988]        lock_acquire.part.0+0x9c/0x210
[35429.000989]        rt_spin_lock+0x27/0xe0
[35429.000992]        __local_bh_disable_ip+0xb8/0x190
[35429.000994]        t4_wr_mbox_meat_timeout+0xa7/0x720 [cxgb4]
[35429.001004]        t4_get_mps_bg_map+0xba/0x1b0 [cxgb4]
[35429.001028]        t4_get_port_stats+0x16/0xc50 [cxgb4]
[35429.001039]        t4_get_port_stats_offset+0x12/0x30 [cxgb4]
[35429.001050]        cxgb_get_stats+0x66/0x1d0 [cxgb4]
[35429.001059]        dev_get_stats+0x5c/0xc0
[35429.001061]        rtnl_fill_stats+0x3b/0x130
[35429.001063]        rtnl_fill_ifinfo+0x706/0x1140
[35429.001066]        rtmsg_ifinfo_build_skb+0x88/0xe0
[35429.001068]        rtmsg_ifinfo+0x25/0x60
[35429.001070]        register_netdevice+0x5f9/0x670
[35429.001072]        register_netdev+0x1c/0x40
[35429.001074]        init_one+0x8af/0xda0 [cxgb4]
[35429.001084]        local_pci_probe+0x45/0x80
[35429.001088]        work_for_cpu_fn+0x16/0x20
[35429.001090]        process_one_work+0x27a/0x450
[35429.001092]        worker_thread+0x1ea/0x3c0
[35429.001093]        kthread+0x188/0x1a0
[35429.001095]        ret_from_fork+0x22/0x30
[35429.001098]
               -> #0 (&adapter->stats_lock){+.+.}-{2:2}:
[35429.001099]        check_prev_add+0x91/0xc10
[35429.001101]        validate_chain+0x480/0x510
[35429.001102]        __lock_acquire+0x4d2/0x930
[35429.001104]        lock_acquire.part.0+0x9c/0x210
[35429.001105]        rt_spin_lock+0x27/0xe0
[35429.001107]        cxgb_get_stats+0x41/0x1d0 [cxgb4]
[35429.001116]        dev_get_stats+0x5c/0xc0
[35429.001118]        netstat_show.constprop.0+0x52/0xb0
[35429.001120]        dev_attr_show+0x19/0x40
[35429.001122]        sysfs_kf_seq_show+0xa9/0x100
[35429.001125]        seq_read_iter+0x128/0x4c0
[35429.001128]        new_sync_read+0x121/0x1b0
[35429.001130]        vfs_read+0x133/0x1d0
[35429.001131]        ksys_read+0x68/0xe0
[35429.001133]        do_syscall_64+0x3b/0x90
[35429.001134]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[35429.001137]
               other info that might help us debug this:

[35429.001137] Chain exists of:
                 &adapter->stats_lock --> (softirq_ctrl.lock) --> dev_base_lock

[35429.001139]  Possible unsafe locking scenario:

[35429.001140]        CPU0                    CPU1
[35429.001140]        ----                    ----
[35429.001140]   lock(dev_base_lock);
[35429.001141]                                lock((softirq_ctrl.lock));
[35429.001142]                                lock(dev_base_lock);
[35429.001143]   lock(&adapter->stats_lock);
[35429.001144]
                *** DEADLOCK ***

[35429.001144] 6 locks held by tuned/6697:
[35429.001145]  #0: ffff8dba839df838 (&f->f_pos_lock){+.+.}-{3:3}, at:
__fdget_pos+0x4d/0x60
[35429.001149]  #1: ffff8dba44ef3d98 (&p->lock){+.+.}-{3:3}, at:
seq_read_iter+0x51/0x4c0
[35429.001153]  #2: ffff8dba49960a80 (&of->mutex){+.+.}-{3:3}, at:
kernfs_seq_start+0x2a/0xb0
[35429.001156]  #3: ffff8dbff8ea31e8 (kn->active#223){++++}-{0:0}, at:
kernfs_seq_start+0x32/0xb0
[35429.001159]  #4: ffffffff9e0ed570 (dev_base_lock){++.+}-{2:2}, at:
netstat_show.constprop.0+0x41/0xb0
[35429.001163]  #5: ffffffff9de61200 (rcu_read_lock){....}-{1:2}, at:
rt_read_lock+0x65/0x130
[35429.001166]
               stack backtrace:
[35429.001167] CPU: 16 PID: 6697 Comm: tuned Kdump: loaded Not tainted
5.15.3-rt21 #2
[35429.001169] Hardware name: Dell Inc. PowerEdge R520/08DM12, BIOS
2.1.2 01/20/2014
[35429.001171] Call Trace:
[35429.001172]  <TASK>
[35429.001174]  dump_stack_lvl+0x57/0x7d
[35429.001177]  check_noncircular+0xff/0x110
[35429.001182]  check_prev_add+0x91/0xc10
[35429.001184]  ? add_chain_cache+0x112/0x2d0
[35429.001186]  validate_chain+0x480/0x510
[35429.001190]  __lock_acquire+0x4d2/0x930
[35429.001193]  lock_acquire.part.0+0x9c/0x210
[35429.001195]  ? cxgb_get_stats+0x41/0x1d0 [cxgb4]
[35429.001205]  ? rcu_read_lock_sched_held+0x3f/0x70
[35429.001209]  ? trace_lock_acquire+0x38/0x140
[35429.001210]  ? lock_acquire+0x30/0x80
[35429.001212]  ? cxgb_get_stats+0x41/0x1d0 [cxgb4]
[35429.001222]  rt_spin_lock+0x27/0xe0
[35429.001225]  ? cxgb_get_stats+0x41/0x1d0 [cxgb4]
[35429.001234]  cxgb_get_stats+0x41/0x1d0 [cxgb4]
[35429.001245]  ? check_prev_add+0xa3/0xc10
[35429.001247]  ? check_prev_add+0xa3/0xc10
[35429.001248]  ? add_chain_cache+0x112/0x2d0
[35429.001251]  ? lockdep_unlock+0x5c/0xc0
[35429.001252]  ? validate_chain+0x29a/0x510
[35429.001255]  ? __lock_acquire+0x4d2/0x930
[35429.001258]  ? lock_acquire.part.0+0x9c/0x210
[35429.001261]  ? rcu_read_lock_sched_held+0x3f/0x70
[35429.001263]  ? trace_lock_acquire+0x38/0x140
[35429.001265]  ? lock_acquire+0x30/0x80
[35429.001266]  ? rt_read_lock+0x65/0x130
[35429.001269]  dev_get_stats+0x5c/0xc0
[35429.001272]  netstat_show.constprop.0+0x52/0xb0
[35429.001279]  dev_attr_show+0x19/0x40
[35429.001280]  sysfs_kf_seq_show+0xa9/0x100
[35429.001283]  seq_read_iter+0x128/0x4c0
[35429.001288]  new_sync_read+0x121/0x1b0
[35429.001292]  vfs_read+0x133/0x1d0
[35429.001294]  ksys_read+0x68/0xe0
[35429.001297]  do_syscall_64+0x3b/0x90
[35429.001299]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[35429.001301] RIP: 0033:0x7f03e459a9ec
[35429.001304] Code: ec 28 48 89 54 24 18 48 89 74 24 10 89 7c 24 08
e8 09 87 f8 ff 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 31
c0 0f 05 <48> 3d 00 f0 ff ff 77 34 44 89 c7 48 89 44 24 08 e8 4f 87 f8
ff 48
[35429.001306] RSP: 002b:00007f03e23896a0 EFLAGS: 00000246 ORIG_RAX:
0000000000000000
[35429.001308] RAX: ffffffffffffffda RBX: 00007f03e238b5c0 RCX: 00007f03e459a9ec
[35429.001309] RDX: 0000000000001001 RSI: 00007f03dc03b5b0 RDI: 0000000000000008
[35429.001310] RBP: 0000000000001001 R08: 0000000000000000 R09: 0000000000000000
[35429.001311] R10: 0000000000000002 R11: 0000000000000246 R12: 00007f03e021b540
[35429.001312] R13: 00007f03dc03b5b0 R14: 0000000000000008 R15: 00007f03d8001c00
[35429.001328]  </TASK>
[35430.549435] bnx2x 0000:08:00.1 enp8s0f1: using MSI-X  IRQs: sp 97
fp[0] 99 ... fp[19] 332
[35430.695688] bnx2x 0000:08:00.1 enp8s0f1: NIC Link is Up, 1000 Mbps
full duplex, Flow control: ON - receive & transmit
[35432.120806] bnx2x 0000:08:00.0 enp8s0f0: using MSI-X  IRQs: sp 61
fp[0] 63 ... fp[19] 344
[35432.425838] bnx2x 0000:08:00.0 enp8s0f0: NIC Link is Up, 1000 Mbps
full duplex, Flow control: ON - receive & transmit

