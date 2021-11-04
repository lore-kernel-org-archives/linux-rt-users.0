Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D112C433EF
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Nov 2021 18:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2D1261051
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Nov 2021 18:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbhKDTA7 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 4 Nov 2021 15:00:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45791 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231732AbhKDTA7 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 4 Nov 2021 15:00:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636052300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K0AuWmeSL7C3eQ2j+efHKMGejE4KpjSbTneQtkWPJXo=;
        b=Mf9C/amQqt+Eh3qkrzdf54HpVpBF3+OyQGzuh7U+ZODe9/UvrfDRyy/TGNqrp8aOW3P1bu
        lbFrsSKhhOLwlfykGwtJfNArdwhBDyY4Q9yR2attmVq5oTdoAPLXP0DqGWIToyfrLG2WPl
        AScFn3Wnmc5eFht1UtZAe7OIaWp0MAo=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-4WTPC-5lOtiWN3TIL1rgBA-1; Thu, 04 Nov 2021 14:58:19 -0400
X-MC-Unique: 4WTPC-5lOtiWN3TIL1rgBA-1
Received: by mail-lj1-f197.google.com with SMTP id n17-20020a2e8791000000b0021896c29706so1989931lji.12
        for <linux-rt-users@vger.kernel.org>; Thu, 04 Nov 2021 11:58:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K0AuWmeSL7C3eQ2j+efHKMGejE4KpjSbTneQtkWPJXo=;
        b=LI7e/1MbOXfh3uUMXMdlV2ZIZe5oSFszGW0BaVDbFbTAOTErDtYjJa/I51pCx5GNxQ
         Wo1CZno0YXyQPdTzWQOHXnejW/TVvm4yOBXO3Eb+TZNrq/C0+9ByRucvyHLBEW2KwVMP
         /g3ykVMJN1eO5ShybM5dDLvz2k+SdaiZ1lngxEyO13IXDVS/1pB1yNzH1Ev4HjAqlstH
         ueVCRZ8bg30WNjCD4GV6Fw1hRyCCY1ngAbCOwuS0ST7hz9ALnQdgnh0/plK3kDsQdOws
         gseiw91T9mKdxPcgphdyczv6apv4tLhh8XvJAfA54TkqK4zWGCzcsJf2GUlPTqCT9J+i
         PzAg==
X-Gm-Message-State: AOAM532bWyhOFBH95pEb2sJoKwIHFMVzbQCKujFmpQM5fsh5CZNHgvJk
        yR0o6sQ0gcSwSkJySS4nOotdg8c+jZCgYeFEswue069fP8AOdAB5K0wkBOAR61PGrPF9W0rAW5K
        1f9Z9SPxEp7f9Qv+1F9ViOHn8GP95owK0QjFn8BUWBNs=
X-Received: by 2002:a05:6512:220d:: with SMTP id h13mr49041591lfu.623.1636052297805;
        Thu, 04 Nov 2021 11:58:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzXB3SSnoLpmWHotFviTeImOaNDxKRTyumQoYFVI1xqkyM3kpfPn0/lcmJxt/WSmqTM/6ElxZeATa5G1uX1bTE=
X-Received: by 2002:a05:6512:220d:: with SMTP id h13mr49041568lfu.623.1636052297600;
 Thu, 04 Nov 2021 11:58:17 -0700 (PDT)
MIME-Version: 1.0
References: <YVuviZ3F7MbPvleo@uudg.org> <20211011135609.22y7hkycbqm52w6d@linutronix.de>
 <20211011163601.m6j3ibb7ydeevpiz@linutronix.de> <CAD8J--8CjZym2afG3iSdztz51nOt9gmy747KPDxdmr1_WzwxcA@mail.gmail.com>
In-Reply-To: <CAD8J--8CjZym2afG3iSdztz51nOt9gmy747KPDxdmr1_WzwxcA@mail.gmail.com>
From:   Luis Goncalves <lgoncalv@redhat.com>
Date:   Thu, 4 Nov 2021 15:58:05 -0300
Message-ID: <CAD8J---uJXqKeYR_3_8O5WPr9pVH8HX1DmGfE+7MdHDmaK4-Mw@mail.gmail.com>
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

On Mon, Oct 18, 2021 at 12:42 PM Luis Goncalves <lgoncalv@redhat.com> wrote:
>
> On Mon, Oct 11, 2021 at 1:36 PM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> >
> > On 2021-10-11 15:56:09 [+0200], To Luis Claudio R. Goncalves wrote:
> > > So my guess is that the _bh isn't needed.
> >
> > Correction: If there is at least _one_ reader in softirq all, writer
> > need to disable BH which _might_ be the case here.
> > The splat is probably because on read_lock holder disables BH later on
> > which I don't see yet.
> >
> > Sebastian
>
> The way I was able to reproduce the problem in 5.10 (and in 5.14 before -rt11)
> was:
>
>     1. systemctl disable tuned.service
>     2. Reboot to a kernel-rt with lockdep support
>     3. systemctl start tuned.service
>
> I used a few tuned profiles, but stuck with 'realtime' for obvious reasons.
>
> If that helps in the process I can investigate which specific
> action/configuration
> performed by tuned is triggering the lockdep splat.

Just for the sake of completeness, this is the lockdep splat for v5.10.73-rt54:

[   41.917124] hrtimer: interrupt took 19800197 ns
[   45.105231] bnxt_en 0000:19:00.0 eno1np0: NIC Link is Up, 10000
Mbps full duplex, Flow control: ON - receive & transmit
[   45.105235] bnxt_en 0000:19:00.0 eno1np0: FEC autoneg off encoding: None

[   46.370088] ======================================================
[   46.370089] WARNING: possible circular locking dependency detected
[   46.370089] 5.10.73-rt54.lockdep+ #2 Tainted: G          I
[   46.370091] ------------------------------------------------------
[   46.370091] tuned/2248 is trying to acquire lock:
[   46.370093] ffff954d9e818220
((softirq_ctrl.lock).lock){+.+.}-{2:2}, at:
__local_bh_disable_ip+0x116/0x2f0
[   46.370104]
               but task is already holding lock:
[   46.370104] ffffffff9ccafa60 (dev_base_lock){++.+}-{0:0}, at:
netstat_show.isra.17+0x4a/0xb0
[   46.370111]
               which lock already depends on the new lock.

[   46.370111]
               the existing dependency chain (in reverse order) is:
[   46.370111]
               -> #1 (dev_base_lock){++.+}-{0:0}:
[   46.370113]        lock_acquire+0xde/0x380
[   46.370117]        rt_write_lock+0x3a/0x1b0
[   46.370122]        list_netdevice+0x4c/0x140
[   46.370125]        register_netdevice+0x59b/0x810
[   46.370127]        register_netdev+0x1a/0x30
[   46.370128]        loopback_net_init+0x48/0xa0
[   46.370130]        ops_init+0x3a/0x180
[   46.370133]        register_pernet_operations+0x126/0x220
[   46.370135]        register_pernet_device+0x25/0x60
[   46.370138]        net_dev_init+0x31b/0x391
[   46.370141]        do_one_initcall+0x74/0x440
[   46.370145]        kernel_init_freeable+0x39d/0x408
[   46.370148]        kernel_init+0xb/0x12e
[   46.370150]        ret_from_fork+0x1f/0x30
[   46.370152]
               -> #0 ((softirq_ctrl.lock).lock){+.+.}-{2:2}:
[   46.370153]        check_prevs_add+0x1bb/0xe50
[   46.370155]        __lock_acquire+0x1187/0x1640
[   46.370157]        lock_acquire+0xde/0x380
[   46.370158]        rt_spin_lock+0x2b/0xd0
[   46.370160]        __local_bh_disable_ip+0x116/0x2f0
[   46.370162]        tg3_get_stats64+0x29/0xb0 [tg3]
[   46.370167]        dev_get_stats+0x5b/0xc0
[   46.370168]        netstat_show.isra.17+0x5b/0xb0
[   46.370170]        dev_attr_show+0x18/0x50
[   46.370173]        sysfs_kf_seq_show+0xa1/0x130
[   46.370176]        seq_read_iter+0x19e/0x420
[   46.370178]        new_sync_read+0x121/0x1c0
[   46.370180]        vfs_read+0x185/0x1e0
[   46.370182]        ksys_read+0x5f/0xe0
[   46.370184]        do_syscall_64+0x33/0x40
[   46.370186]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   46.370188]
               other info that might help us debug this:

[   46.370188]  Possible unsafe locking scenario:

[   46.370189]        CPU0                    CPU1
[   46.370189]        ----                    ----
[   46.370189]   lock(dev_base_lock);
[   46.370190]                                lock((softirq_ctrl.lock).lock);
[   46.370191]                                lock(dev_base_lock);
[   46.370192]   lock((softirq_ctrl.lock).lock);
[   46.370193]
                *** DEADLOCK ***

[   46.370193] 6 locks held by tuned/2248:
[   46.370194]  #0: ffff954606ef7d30 (&f->f_pos_lock){+.+.}-{0:0}, at:
__fdget_pos+0x4b/0x60
[   46.370199]  #1: ffff9545d307a1f0 (&p->lock){+.+.}-{0:0}, at:
seq_read_iter+0x56/0x420
[   46.370202]  #2: ffff9545fcde6cb8 (&of->mutex){+.+.}-{0:0}, at:
kernfs_seq_start+0x28/0x90
[   46.370205]  #3: ffff953e5c12dd98 (kn->active#246){.+.+}-{0:0}, at:
kernfs_seq_start+0x30/0x90
[   46.370208]  #4: ffffffff9ccafa60 (dev_base_lock){++.+}-{0:0}, at:
netstat_show.isra.17+0x4a/0xb0
[   46.370211]  #5: ffffffff9c8c8fe0 (rcu_read_lock){....}-{1:2}, at:
rt_read_lock+0x7d/0x1e0
[   46.370214]
               stack backtrace:
[   46.370214] CPU: 27 PID: 2248 Comm: tuned Tainted: G          I
  5.10.73-rt54.lockdep+ #2
[   46.370216] Hardware name: Dell Inc. PowerEdge R740/07X9K0, BIOS
2.8.2 08/27/2020
[   46.370217] Call Trace:
[   46.370218]  dump_stack+0x77/0x97
[   46.370224]  check_noncircular+0xff/0x120
[   46.370228]  check_prevs_add+0x1bb/0xe50
[   46.370232]  __lock_acquire+0x1187/0x1640
[   46.370236]  lock_acquire+0xde/0x380
[   46.370237]  ? __local_bh_disable_ip+0x116/0x2f0
[   46.370242]  ? tg3_get_stats64+0x5/0xb0 [tg3]
[   46.370245]  rt_spin_lock+0x2b/0xd0
[   46.370246]  ? __local_bh_disable_ip+0x116/0x2f0
[   46.370249]  __local_bh_disable_ip+0x116/0x2f0
[   46.370251]  tg3_get_stats64+0x29/0xb0 [tg3]
[   46.370255]  dev_get_stats+0x5b/0xc0
[   46.370257]  netstat_show.isra.17+0x5b/0xb0
[   46.370263]  dev_attr_show+0x18/0x50
[   46.370264]  sysfs_kf_seq_show+0xa1/0x130
[   46.370266]  seq_read_iter+0x19e/0x420
[   46.370269]  new_sync_read+0x121/0x1c0
[   46.370272]  vfs_read+0x185/0x1e0
[   46.370274]  ksys_read+0x5f/0xe0
[   46.370276]  do_syscall_64+0x33/0x40
[   46.370278]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   46.370280] RIP: 0033:0x7f4ee932b9e4
[   46.370282] Code: c3 0f 1f 44 00 00 41 54 49 89 d4 55 48 89 f5 53
89 fb 48 83 ec 10 e8 7b fc ff ff 4c 89 e2 48 89 ee 89 df 41 89 c0 31
c0 0f 05 <48> 3d 00 f0 ff ff 77 38 44 89 c7 48 89 44 24 08 e8 b7 fc ff
ff 48
[   46.370283] RSP: 002b:00007f4ede603be0 EFLAGS: 00000246 ORIG_RAX:
0000000000000000
[   46.370285] RAX: ffffffffffffffda RBX: 0000000000000039 RCX: 00007f4ee932b9e4
[   46.370286] RDX: 0000000000001001 RSI: 00007f4ed801b670 RDI: 0000000000000039
[   46.370287] RBP: 00007f4ed801b670 R08: 0000000000000000 R09: 0000000000000003
[   46.370288] R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000001001
[   46.370289] R13: 0000000000000039 R14: 00007f4ed801b670 R15: 000055cd6476e060
[   47.606432] DMA-API: dma_debug_entry pool grown to 131072 (200%)
[   49.474083] DMA-API: dma_debug_entry pool grown to 196608 (300%)
[   49.653708] DMA-API: dma_debug_entry pool grown to 262144 (400%)

Luis

