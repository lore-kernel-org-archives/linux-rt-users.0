Return-Path: <SRS0=v1XI=UX=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F60C43613
	for <linux-rt-users@archiver.kernel.org>; Mon, 24 Jun 2019 18:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B23C20645
	for <linux-rt-users@archiver.kernel.org>; Mon, 24 Jun 2019 18:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbfFXS3X (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 24 Jun 2019 14:29:23 -0400
Received: from smtp6-g21.free.fr ([212.27.42.6]:18234 "EHLO smtp6-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbfFXS3X (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 24 Jun 2019 14:29:23 -0400
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:244:b080:7446:96cf:df6:1525])
        by smtp6-g21.free.fr (Postfix) with ESMTP id 102BD78034D
        for <linux-rt-users@vger.kernel.org>; Mon, 24 Jun 2019 20:29:15 +0200 (CEST)
Subject: BUG kernel 5.0.21rt12
To:     linux-rt-users@vger.kernel.org
References: <20190530025254.GE23690@uudg.org> <20190624180115.GC4902@uudg.org>
From:   Yann COLLETTE <ycollette.nospam@free.fr>
Message-ID: <58aace7a-295c-c20e-4dc6-5d74a2b58545@free.fr>
Date:   Mon, 24 Jun 2019 20:29:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190624180115.GC4902@uudg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: fr-classic
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello,


I have compiled a vanilla kernel 5.0.21rt12 on Fedora 30 64 bits.

I use this kernel for music (jack-audio oriented).

I meet a bug with the last RT kernel.

I was just able to get a kernel oops (this is my first "bug report") ...


juin 24 18:38:08 localhost.localdomain kernel: BUG: scheduling while 
atomic: Xorg:rcs0/1129/0x00000003
juin 24 18:38:08 localhost.localdomain kernel: Modules linked in: 
snd_seq_midi snd_seq_midi_event snd_seq_dummy fuse xt_CHECKSUM 
ipt_MASQUERADE tun bridge stp llc cc>
juin 24 18:38:08 localhost.localdomain kernel:  wmi_bmof mac80211 
snd_seq snd_seq_device snd_pcm cfg80211 sp5100_tco snd_timer rfkill 
pcc_cpufreq snd soundcore fam15>
juin 24 18:38:08 localhost.localdomain kernel: Preemption disabled at:
juin 24 18:38:08 localhost.localdomain kernel: [<ffffffff8267265e>] 
reservation_object_add_shared_fence+0x3e/0x1b0
juin 24 18:38:08 localhost.localdomain kernel: CPU: 1 PID: 1129 Comm: 
Xorg:rcs0 Not tainted 5.0.21-rt12.fc30.x86_64 #1
juin 24 18:38:08 localhost.localdomain kernel: Hardware name: HP 
450-a121nf/2B29, BIOS A0.11 01/15/2016
juin 24 18:38:08 localhost.localdomain kernel: Call Trace:
juin 24 18:38:08 localhost.localdomain kernel: dump_stack+0x5c/0x80
juin 24 18:38:08 localhost.localdomain kernel:  ? 
reservation_object_add_shared_fence+0x3e/0x1b0
juin 24 18:38:08 localhost.localdomain kernel: __schedule_bug.cold+0x44/0x51
juin 24 18:38:08 localhost.localdomain kernel: __schedule+0x5c6/0x6f0
juin 24 18:38:08 localhost.localdomain kernel:  ? 
unpin_current_cpu+0x3a/0x80
juin 24 18:38:08 localhost.localdomain kernel:  schedule+0x43/0xd0
juin 24 18:38:08 localhost.localdomain kernel: 
rt_spin_lock_slowlock_locked+0x114/0x2b0
juin 24 18:38:08 localhost.localdomain kernel: 
rt_spin_lock_slowlock+0x51/0x80
juin 24 18:38:08 localhost.localdomain kernel: 
__wake_up_common_lock+0x61/0xb0
juin 24 18:38:08 localhost.localdomain kernel: 
radeon_fence_is_signaled+0x74/0x90 [radeon]
juin 24 18:38:08 localhost.localdomain kernel: 
reservation_object_add_shared_fence+0x97/0x1b0
juin 24 18:38:08 localhost.localdomain kernel: 
ttm_eu_fence_buffer_objects+0x49/0xa0 [ttm]
juin 24 18:38:08 localhost.localdomain kernel: 
radeon_cs_parser_fini+0x10f/0x120 [radeon]
juin 24 18:38:08 localhost.localdomain kernel: 
radeon_cs_ioctl+0x22b/0x800 [radeon]
juin 24 18:38:08 localhost.localdomain kernel:  ? 
radeon_cs_parser_init+0x20/0x20 [radeon]
juin 24 18:38:08 localhost.localdomain kernel: 
drm_ioctl_kernel+0xa7/0xf0 [drm]
juin 24 18:38:08 localhost.localdomain kernel: drm_ioctl+0x208/0x390 [drm]
juin 24 18:38:08 localhost.localdomain kernel:  ? 
radeon_cs_parser_init+0x20/0x20 [radeon]
juin 24 18:38:08 localhost.localdomain kernel:  ? migrate_enable+0x235/0x400
juin 24 18:38:08 localhost.localdomain kernel:  ? 
_raw_spin_unlock_irqrestore+0x1f/0x60
juin 24 18:38:08 localhost.localdomain kernel: 
radeon_drm_ioctl+0x49/0x80 [radeon]
juin 24 18:38:08 localhost.localdomain kernel: do_vfs_ioctl+0x40c/0x670
juin 24 18:38:08 localhost.localdomain kernel: ksys_ioctl+0x5e/0x90
juin 24 18:38:08 localhost.localdomain kernel: __x64_sys_ioctl+0x16/0x20
juin 24 18:38:08 localhost.localdomain kernel: do_syscall_64+0x5b/0x180
juin 24 18:38:08 localhost.localdomain kernel: 
entry_SYSCALL_64_after_hwframe+0x44/0xa9
juin 24 18:38:08 localhost.localdomain kernel: RIP: 0033:0x7f9c10a221fb
juin 24 18:38:08 localhost.localdomain kernel: Code: 0f 1e fa 48 8b 05 
8d dc 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 
00 f3 0f 1e fa b8 10 0>
juin 24 18:38:08 localhost.localdomain kernel: RSP: 
002b:00007f9c0a995a38 EFLAGS: 00003246 ORIG_RAX: 0000000000000010
juin 24 18:38:08 localhost.localdomain kernel: RAX: ffffffffffffffda 
RBX: 00007f9c0259f058 RCX: 00007f9c10a221fb
juin 24 18:38:08 localhost.localdomain kernel: RDX: 00007f9c0259f058 
RSI: 00000000c0206466 RDI: 0000000000000012
juin 24 18:38:08 localhost.localdomain kernel: RBP: 00000000c0206466 
R08: 000055c362cfb980 R09: 0000000000000000
juin 24 18:38:08 localhost.localdomain kernel: R10: 0000000000000000 
R11: 0000000000003246 R12: 00007f9c0258f010
juin 24 18:38:08 localhost.localdomain kernel: R13: 0000000000000012 
R14: 0000000000000000 R15: 000055c362cfb948
juin 24 18:38:08 localhost.localdomain kernel: WARNING: CPU: 1 PID: 1129 
at kernel/sched/core.c:7308 migrate_enable+0x2e7/0x400
juin 24 18:38:08 localhost.localdomain kernel: Modules linked in: 
snd_seq_midi snd_seq_midi_event snd_seq_dummy fuse xt_CHECKSUM 
ipt_MASQUERADE tun bridge stp llc cc>
juin 24 18:38:08 localhost.localdomain kernel:  wmi_bmof mac80211 
snd_seq snd_seq_device snd_pcm cfg80211 sp5100_tco snd_timer rfkill 
pcc_cpufreq snd soundcore fam15>
juin 24 18:38:08 localhost.localdomain kernel: CPU: 1 PID: 1129 Comm: 
Xorg:rcs0 Tainted: G        W 5.0.21-rt12.fc30.x86_64 #1
juin 24 18:38:08 localhost.localdomain kernel: Hardware name: HP 
450-a121nf/2B29, BIOS A0.11 01/15/2016
juin 24 18:38:08 localhost.localdomain kernel: RIP: 
0010:migrate_enable+0x2e7/0x400
juin 24 18:38:08 localhost.localdomain kernel: Code: fe ff ff e8 7f 17 
ef ff e9 7b fe ff ff 48 8b 00 a9 00 00 04 00 0f 84 53 ff ff ff e8 67 17 
ef ff e9 49 ff ff ff e>
juin 24 18:38:08 localhost.localdomain kernel: RSP: 
0018:ffffb21c4257b950 EFLAGS: 00010246
juin 24 18:38:08 localhost.localdomain kernel: RAX: 0000000000000000 
RBX: ffff8a47cf8e5dc0 RCX: ffff8a47f680ae08
juin 24 18:38:08 localhost.localdomain kernel: RDX: 0000000000000000 
RSI: 0000000000100000 RDI: ffff8a47f680ae00
juin 24 18:38:08 localhost.localdomain kernel: RBP: 0000000000000003 
R08: ffff8a47e9cd58a0 R09: ffffb21c4257b9a8
juin 24 18:38:08 localhost.localdomain kernel: R10: 0000000000000000 
R11: 0000000000000001 R12: 0000000000000000
juin 24 18:38:08 localhost.localdomain kernel: R13: 0000000000000000 
R14: 0000000000000000 R15: ffff8a47aa265f00
juin 24 18:38:08 localhost.localdomain kernel: FS: 
00007f9c0a996700(0000) GS:ffff8a47f6e80000(0000) knlGS:0000000000000000
juin 24 18:38:08 localhost.localdomain kernel: CS:  0010 DS: 0000 ES: 
0000 CR0: 0000000080050033
juin 24 18:38:08 localhost.localdomain kernel: CR2: 00007fa680652580 
CR3: 0000000215ab6000 CR4: 00000000000406e0
juin 24 18:38:08 localhost.localdomain kernel: Call Trace:
juin 24 18:38:08 localhost.localdomain kernel: rt_spin_unlock+0x23/0x40
juin 24 18:38:08 localhost.localdomain kernel: 
__wake_up_common_lock+0x82/0xb0
juin 24 18:38:08 localhost.localdomain kernel: 
radeon_fence_is_signaled+0x74/0x90 [radeon]
juin 24 18:38:08 localhost.localdomain kernel: 
reservation_object_add_shared_fence+0x97/0x1b0
juin 24 18:38:08 localhost.localdomain kernel: 
ttm_eu_fence_buffer_objects+0x49/0xa0 [ttm]
juin 24 18:38:08 localhost.localdomain kernel: 
radeon_cs_parser_fini+0x10f/0x120 [radeon]
juin 24 18:38:08 localhost.localdomain kernel: 
radeon_cs_ioctl+0x22b/0x800 [radeon]
juin 24 18:38:08 localhost.localdomain kernel:  ? 
radeon_cs_parser_init+0x20/0x20 [radeon]
juin 24 18:38:08 localhost.localdomain kernel: 
drm_ioctl_kernel+0xa7/0xf0 [drm]
juin 24 18:38:08 localhost.localdomain kernel: drm_ioctl+0x208/0x390 [drm]
juin 24 18:38:08 localhost.localdomain kernel:  ? 
radeon_cs_parser_init+0x20/0x20 [radeon]
juin 24 18:38:08 localhost.localdomain kernel:  ? migrate_enable+0x235/0x400
juin 24 18:38:08 localhost.localdomain kernel:  ? 
_raw_spin_unlock_irqrestore+0x1f/0x60
juin 24 18:38:08 localhost.localdomain kernel: 
radeon_drm_ioctl+0x49/0x80 [radeon]
juin 24 18:38:08 localhost.localdomain kernel: do_vfs_ioctl+0x40c/0x670
juin 24 18:38:08 localhost.localdomain kernel: ksys_ioctl+0x5e/0x90
juin 24 18:38:08 localhost.localdomain kernel: __x64_sys_ioctl+0x16/0x20
juin 24 18:38:08 localhost.localdomain kernel: do_syscall_64+0x5b/0x180
juin 24 18:38:08 localhost.localdomain kernel: 
entry_SYSCALL_64_after_hwframe+0x44/0xa9
juin 24 18:38:08 localhost.localdomain kernel: RIP: 0033:0x7f9c10a221fb
juin 24 18:38:08 localhost.localdomain kernel: Code: 0f 1e fa 48 8b 05 
8d dc 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 
00 f3 0f 1e fa b8 10 0>
juin 24 18:38:08 localhost.localdomain kernel: RSP: 
002b:00007f9c0a995a38 EFLAGS: 00003246 ORIG_RAX: 0000000000000010
juin 24 18:38:08 localhost.localdomain kernel: RAX: ffffffffffffffda 
RBX: 00007f9c0259f058 RCX: 00007f9c10a221fb
juin 24 18:38:08 localhost.localdomain kernel: RDX: 00007f9c0259f058 
RSI: 00000000c0206466 RDI: 0000000000000012
juin 24 18:38:08 localhost.localdomain kernel: RBP: 00000000c0206466 
R08: 000055c362cfb980 R09: 0000000000000000
juin 24 18:38:08 localhost.localdomain kernel: R10: 0000000000000000 
R11: 0000000000003246 R12: 00007f9c0258f010
juin 24 18:38:08 localhost.localdomain kernel: R13: 0000000000000012 
R14: 0000000000000000 R15: 000055c362cfb948
juin 24 18:38:08 localhost.localdomain kernel: ---[ end trace 
0000000000000002 ]---
juin 24 18:38:08 localhost.localdomain kernel: ------------[ cut here 
]------------
juin 24 18:38:08 localhost.localdomain kernel: DEBUG_LOCKS_WARN_ON(val > 
preempt_count())
juin 24 18:38:08 localhost.localdomain kernel: WARNING: CPU: 1 PID: 1129 
at kernel/sched/core.c:3314 preempt_count_sub+0x5e/0xa0
juin 24 18:38:08 localhost.localdomain kernel: Modules linked in: 
snd_seq_midi snd_seq_midi_event snd_seq_dummy fuse xt_CHECKSUM 
ipt_MASQUERADE tun bridge stp llc cc>
juin 24 18:38:08 localhost.localdomain kernel:  wmi_bmof mac80211 
snd_seq snd_seq_device snd_pcm cfg80211 sp5100_tco snd_timer rfkill 
pcc_cpufreq snd soundcore fam15>
juin 24 18:38:08 localhost.localdomain kernel: CPU: 1 PID: 1129 Comm: 
Xorg:rcs0 Tainted: G        W 5.0.21-rt12.fc30.x86_64 #1
juin 24 18:38:08 localhost.localdomain kernel: Hardware name: HP 
450-a121nf/2B29, BIOS A0.11 01/15/2016
juin 24 18:38:08 localhost.localdomain kernel: RIP: 
0010:preempt_count_sub+0x5e/0xa0
juin 24 18:38:08 localhost.localdomain kernel: Code: 6f f0 7d c3 e8 93 
0f 3b 00 85 c0 74 f6 8b 15 dd 4e 25 01 85 d2 75 ec 48 c7 c6 61 07 0b 83 
48 c7 c7 b8 85 09 83 e>
juin 24 18:38:08 localhost.localdomain kernel: RSP: 
0018:ffffb21c4257ba30 EFLAGS: 00010286
juin 24 18:38:08 localhost.localdomain kernel: RAX: 0000000000000000 
RBX: 0000000000000001 RCX: 0000000000000000
juin 24 18:38:08 localhost.localdomain kernel: RDX: ffffffff8325c1b0 
RSI: 00000000ffffffff RDI: 00000000ffffffff
juin 24 18:38:08 localhost.localdomain kernel: RBP: ffff8a475f1e7e40 
R08: 0000000000000001 R09: ffffffff8325c140
juin 24 18:38:08 localhost.localdomain kernel: R10: ffffb21c4257b970 
R11: ffffffff83990763 R12: ffff8a47b1071f00
juin 24 18:38:08 localhost.localdomain kernel: R13: 0000000000000001 
R14: 0000000000000005 R15: ffff8a47aa265f00
juin 24 18:38:08 localhost.localdomain kernel: FS: 
00007f9c0a996700(0000) GS:ffff8a47f6e80000(0000) knlGS:0000000000000000
juin 24 18:38:08 localhost.localdomain kernel: CS:  0010 DS: 0000 ES: 
0000 CR0: 0000000080050033
juin 24 18:38:08 localhost.localdomain kernel: CR2: 00007fa680652580 
CR3: 0000000215ab6000 CR4: 00000000000406e0
juin 24 18:38:08 localhost.localdomain kernel: Call Trace:
juin 24 18:38:08 localhost.localdomain kernel: 
reservation_object_add_shared_fence+0xfa/0x1b0
juin 24 18:38:08 localhost.localdomain kernel: 
ttm_eu_fence_buffer_objects+0x49/0xa0 [ttm]
juin 24 18:38:08 localhost.localdomain kernel: 
radeon_cs_parser_fini+0x10f/0x120 [radeon]
juin 24 18:38:08 localhost.localdomain kernel: 
radeon_cs_ioctl+0x22b/0x800 [radeon]
juin 24 18:38:08 localhost.localdomain kernel:  ? 
radeon_cs_parser_init+0x20/0x20 [radeon]
juin 24 18:38:08 localhost.localdomain kernel: 
drm_ioctl_kernel+0xa7/0xf0 [drm]
juin 24 18:38:08 localhost.localdomain kernel: drm_ioctl+0x208/0x390 [drm]
juin 24 18:38:08 localhost.localdomain kernel:  ? 
radeon_cs_parser_init+0x20/0x20 [radeon]
juin 24 18:38:08 localhost.localdomain kernel:  ? migrate_enable+0x235/0x400
juin 24 18:38:08 localhost.localdomain kernel:  ? 
_raw_spin_unlock_irqrestore+0x1f/0x60
juin 24 18:38:08 localhost.localdomain kernel: 
radeon_drm_ioctl+0x49/0x80 [radeon]
juin 24 18:38:08 localhost.localdomain kernel: do_vfs_ioctl+0x40c/0x670
juin 24 18:38:08 localhost.localdomain kernel: ksys_ioctl+0x5e/0x90
juin 24 18:38:08 localhost.localdomain kernel: __x64_sys_ioctl+0x16/0x20
juin 24 18:38:08 localhost.localdomain kernel: do_syscall_64+0x5b/0x180
juin 24 18:38:08 localhost.localdomain kernel: 
entry_SYSCALL_64_after_hwframe+0x44/0xa9
juin 24 18:38:08 localhost.localdomain kernel: RIP: 0033:0x7f9c10a221fb
juin 24 18:38:08 localhost.localdomain kernel: Code: 0f 1e fa 48 8b 05 
8d dc 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 
00 f3 0f 1e fa b8 10 0>
juin 24 18:38:08 localhost.localdomain kernel: RSP: 
002b:00007f9c0a995a38 EFLAGS: 00003246 ORIG_RAX: 0000000000000010
juin 24 18:38:08 localhost.localdomain kernel: RAX: ffffffffffffffda 
RBX: 00007f9c0259f058 RCX: 00007f9c10a221fb
juin 24 18:38:08 localhost.localdomain kernel: RDX: 00007f9c0259f058 
RSI: 00000000c0206466 RDI: 0000000000000012
juin 24 18:38:08 localhost.localdomain kernel: RBP: 00000000c0206466 
R08: 000055c362cfb980 R09: 0000000000000000
juin 24 18:38:08 localhost.localdomain kernel: R10: 0000000000000000 
R11: 0000000000003246 R12: 00007f9c0258f010
juin 24 18:38:08 localhost.localdomain kernel: R13: 0000000000000012 
R14: 0000000000000000 R15: 000055c362cfb948
juin 24 18:38:08 localhost.localdomain kernel: ---[ end trace 
0000000000000003 ]---
juin 24 18:38:08 localhost.localdomain kernel: WARNING: CPU: 1 PID: 1129 
at kernel/sched/core.c:7312 migrate_enable+0x92/0x400
juin 24 18:38:08 localhost.localdomain kernel: Modules linked in: 
snd_seq_midi snd_seq_midi_event snd_seq_dummy fuse xt_CHECKSUM 
ipt_MASQUERADE tun bridge stp llc cc>
juin 24 18:38:08 localhost.localdomain kernel:  wmi_bmof mac80211 
snd_seq snd_seq_device snd_pcm cfg80211 sp5100_tco snd_timer rfkill 
pcc_cpufreq snd soundcore fam15>
juin 24 18:38:08 localhost.localdomain kernel: CPU: 1 PID: 1129 Comm: 
Xorg:rcs0 Tainted: G        W 5.0.21-rt12.fc30.x86_64 #1
juin 24 18:38:08 localhost.localdomain kernel: Hardware name: HP 
450-a121nf/2B29, BIOS A0.11 01/15/2016
juin 24 18:38:08 localhost.localdomain kernel: RIP: 
0010:migrate_enable+0x92/0x400
juin 24 18:38:08 localhost.localdomain kernel: Code: 00 00 eb 07 83 ab 
c4 03 00 00 01 48 8b 44 24 20 65 48 33 04 25 28 00 00 00 0f 85 72 03 00 
00 48 83 c4 28 5b 5d 4>
juin 24 18:38:08 localhost.localdomain kernel: RSP: 
0018:ffffb21c4257ba58 EFLAGS: 00010246
juin 24 18:38:08 localhost.localdomain kernel: RAX: 0000000000000000 
RBX: ffff8a47cf8e5dc0 RCX: ffff8a47f680ae08
juin 24 18:38:08 localhost.localdomain kernel: RDX: 0000000000100000 
RSI: 0000000000100000 RDI: ffff8a47f680ae00
juin 24 18:38:08 localhost.localdomain kernel: RBP: ffffb21c4257bb18 
R08: ffff8a47e9cd4ba8 R09: ffff8a47e9cd4ba8
juin 24 18:38:08 localhost.localdomain kernel: R10: ffffb21c4257b970 
R11: 0000000000000001 R12: 0000000000000000
juin 24 18:38:08 localhost.localdomain kernel: R13: ffffb21c4257bad0 
R14: ffff8a47e9cd4018 R15: ffff8a47d584e600
juin 24 18:38:08 localhost.localdomain kernel: FS: 
00007f9c0a996700(0000) GS:ffff8a47f6e80000(0000) knlGS:0000000000000000
juin 24 18:38:08 localhost.localdomain kernel: CS:  0010 DS: 0000 ES: 
0000 CR0: 0000000080050033
juin 24 18:38:08 localhost.localdomain kernel: CR2: 00007fa680652580 
CR3: 0000000215ab6000 CR4: 00000000000406e0
juin 24 18:38:08 localhost.localdomain kernel: Call Trace:
juin 24 18:38:08 localhost.localdomain kernel: rt_spin_unlock+0x23/0x40
juin 24 18:38:08 localhost.localdomain kernel: 
radeon_cs_parser_fini+0x10f/0x120 [radeon]
juin 24 18:38:08 localhost.localdomain kernel: 
radeon_cs_ioctl+0x22b/0x800 [radeon]
juin 24 18:38:08 localhost.localdomain kernel:  ? 
radeon_cs_parser_init+0x20/0x20 [radeon]
juin 24 18:38:08 localhost.localdomain kernel: 
drm_ioctl_kernel+0xa7/0xf0 [drm]
juin 24 18:38:08 localhost.localdomain kernel: drm_ioctl+0x208/0x390 [drm]
juin 24 18:38:08 localhost.localdomain kernel:  ? 
radeon_cs_parser_init+0x20/0x20 [radeon]
juin 24 18:38:08 localhost.localdomain kernel:  ? migrate_enable+0x235/0x400
juin 24 18:38:08 localhost.localdomain kernel:  ? 
_raw_spin_unlock_irqrestore+0x1f/0x60
juin 24 18:38:08 localhost.localdomain kernel: 
radeon_drm_ioctl+0x49/0x80 [radeon]
juin 24 18:38:08 localhost.localdomain kernel: do_vfs_ioctl+0x40c/0x670
juin 24 18:38:08 localhost.localdomain kernel: ksys_ioctl+0x5e/0x90
juin 24 18:38:08 localhost.localdomain kernel: __x64_sys_ioctl+0x16/0x20
juin 24 18:38:08 localhost.localdomain kernel: do_syscall_64+0x5b/0x180
juin 24 18:38:08 localhost.localdomain kernel: 
entry_SYSCALL_64_after_hwframe+0x44/0xa9
juin 24 18:38:08 localhost.localdomain kernel: RIP: 0033:0x7f9c10a221fb
juin 24 18:38:08 localhost.localdomain kernel: Code: 0f 1e fa 48 8b 05 
8d dc 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 
00 f3 0f 1e fa b8 10 0>
juin 24 18:38:08 localhost.localdomain kernel: RSP: 
002b:00007f9c0a995a38 EFLAGS: 00003246 ORIG_RAX: 0000000000000010
juin 24 18:38:08 localhost.localdomain kernel: RAX: ffffffffffffffda 
RBX: 00007f9c0259f058 RCX: 00007f9c10a221fb
juin 24 18:38:08 localhost.localdomain kernel: RDX: 00007f9c0259f058 
RSI: 00000000c0206466 RDI: 0000000000000012
juin 24 18:38:08 localhost.localdomain kernel: RBP: 00000000c0206466 
R08: 000055c362cfb980 R09: 0000000000000000
juin 24 18:38:08 localhost.localdomain kernel: R10: 0000000000000000 
R11: 0000000000003246 R12: 00007f9c0258f010
juin 24 18:38:08 localhost.localdomain kernel: R13: 0000000000000012 
R14: 0000000000000000 R15: 000055c362cfb948
juin 24 18:38:08 localhost.localdomain kernel: ---[ end trace 
0000000000000004 ]---
juin 24 18:38:08 localhost.localdomain kernel: WARNING: CPU: 1 PID: 1129 
at kernel/cpu.c:330 unpin_current_cpu+0x60/0x80
juin 24 18:38:08 localhost.localdomain kernel: Modules linked in: 
snd_seq_midi snd_seq_midi_event snd_seq_dummy fuse xt_CHECKSUM 
ipt_MASQUERADE tun bridge stp llc cc>
juin 24 18:38:08 localhost.localdomain kernel:  wmi_bmof mac80211 
snd_seq snd_seq_device snd_pcm cfg80211 sp5100_tco snd_timer rfkill 
pcc_cpufreq snd soundcore fam15>
juin 24 18:38:08 localhost.localdomain kernel: CPU: 1 PID: 1129 Comm: 
Xorg:rcs0 Tainted: G        W 5.0.21-rt12.fc30.x86_64 #1
juin 24 18:38:08 localhost.localdomain kernel: Hardware name: HP 
450-a121nf/2B29, BIOS A0.11 01/15/2016
juin 24 18:38:08 localhost.localdomain kernel: RIP: 
0010:unpin_current_cpu+0x60/0x80
juin 24 18:38:08 localhost.localdomain kernel: Code: 36 bf 3e 00 41 39 
c5 75 21 65 48 8b 04 25 c0 5c 01 00 c7 80 c0 03 00 00 ff ff ff ff 48 89 
ef 5b 5d 41 5c 41 5d e>
juin 24 18:38:08 localhost.localdomain kernel: RSP: 
0018:ffffb21c4257ba30 EFLAGS: 00010282
juin 24 18:38:08 localhost.localdomain kernel: RAX: 0000000000000001 
RBX: 0000000000016720 RCX: 0000000000000000
juin 24 18:38:08 localhost.localdomain kernel: RDX: ffffffff82e11380 
RSI: ffffffff830ea67d RDI: ffffffff830c50f4
juin 24 18:38:08 localhost.localdomain kernel: RBP: ffff8a47f6e96720 
R08: ffff8a47e9cd4ba8 R09: 0000000000000000
juin 24 18:38:08 localhost.localdomain kernel: R10: ffffb21c4257b970 
R11: 0000000000000001 R12: ffff8a47cf8e5dc0
juin 24 18:38:08 localhost.localdomain kernel: R13: 00000000ffffffff 
R14: ffff8a47e9cd4018 R15: ffff8a47d584e600
juin 24 18:38:08 localhost.localdomain kernel: FS: 
00007f9c0a996700(0000) GS:ffff8a47f6e80000(0000) knlGS:0000000000000000
juin 24 18:38:08 localhost.localdomain kernel: CS:  0010 DS: 0000 ES: 
0000 CR0: 0000000080050033
juin 24 18:38:08 localhost.localdomain kernel: CR2: 00007fa680652580 
CR3: 0000000215ab6000 CR4: 00000000000406e0
juin 24 18:38:08 localhost.localdomain kernel: Call Trace:
juin 24 18:38:08 localhost.localdomain kernel: migrate_enable+0x1fc/0x400
juin 24 18:38:08 localhost.localdomain kernel: rt_spin_unlock+0x23/0x40
juin 24 18:38:08 localhost.localdomain kernel: 
radeon_cs_parser_fini+0x10f/0x120 [radeon]
juin 24 18:38:08 localhost.localdomain kernel: 
radeon_cs_ioctl+0x22b/0x800 [radeon]
juin 24 18:38:08 localhost.localdomain kernel:  ? 
radeon_cs_parser_init+0x20/0x20 [radeon]
juin 24 18:38:08 localhost.localdomain kernel: 
drm_ioctl_kernel+0xa7/0xf0 [drm]
juin 24 18:38:08 localhost.localdomain kernel: drm_ioctl+0x208/0x390 [drm]
juin 24 18:38:08 localhost.localdomain kernel:  ? 
radeon_cs_parser_init+0x20/0x20 [radeon]
juin 24 18:38:08 localhost.localdomain kernel:  ? migrate_enable+0x235/0x400
juin 24 18:38:08 localhost.localdomain kernel:  ? 
_raw_spin_unlock_irqrestore+0x1f/0x60
juin 24 18:38:08 localhost.localdomain kernel: 
radeon_drm_ioctl+0x49/0x80 [radeon]
juin 24 18:38:08 localhost.localdomain kernel: do_vfs_ioctl+0x40c/0x670
juin 24 18:38:08 localhost.localdomain kernel: ksys_ioctl+0x5e/0x90
juin 24 18:38:08 localhost.localdomain kernel: __x64_sys_ioctl+0x16/0x20
juin 24 18:38:08 localhost.localdomain kernel: do_syscall_64+0x5b/0x180
juin 24 18:38:08 localhost.localdomain kernel: 
entry_SYSCALL_64_after_hwframe+0x44/0xa9
juin 24 18:38:08 localhost.localdomain kernel: RIP: 0033:0x7f9c10a221fb
juin 24 18:38:08 localhost.localdomain kernel: Code: 0f 1e fa 48 8b 05 
8d dc 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 
00 f3 0f 1e fa b8 10 0>
juin 24 18:38:08 localhost.localdomain kernel: RSP: 
002b:00007f9c0a995a38 EFLAGS: 00003246 ORIG_RAX: 0000000000000010
juin 24 18:38:08 localhost.localdomain kernel: RAX: ffffffffffffffda 
RBX: 00007f9c0259f058 RCX: 00007f9c10a221fb
juin 24 18:38:08 localhost.localdomain kernel: RDX: 00007f9c0259f058 
RSI: 00000000c0206466 RDI: 0000000000000012
juin 24 18:38:08 localhost.localdomain kernel: RBP: 00000000c0206466 
R08: 000055c362cfb980 R09: 0000000000000000
juin 24 18:38:08 localhost.localdomain kernel: R10: 0000000000000000 
R11: 0000000000003246 R12: 00007f9c0258f010
juin 24 18:38:08 localhost.localdomain kernel: R13: 0000000000000012 
R14: 0000000000000000 R15: 000055c362cfb948
juin 24 18:38:08 localhost.localdomain kernel: ---[ end trace 
0000000000000005 ]---
juin 24 18:38:08 localhost.localdomain kernel: BUG: unable to handle 
kernel paging request at 0000000000016748
juin 24 18:38:08 localhost.localdomain kernel: #PF error: [WRITE]
juin 24 18:38:09 localhost.localdomain kernel: PGD 0 P4D 0
juin 24 18:38:09 localhost.localdomain kernel: Oops: 0002 [#1] PREEMPT 
SMP NOPTI
juin 24 18:38:09 localhost.localdomain kernel: CPU: 1 PID: 1129 Comm: 
Xorg:rcs0 Tainted: G        W 5.0.21-rt12.fc30.x86_64 #1
juin 24 18:38:09 localhost.localdomain kernel: Hardware name: HP 
450-a121nf/2B29, BIOS A0.11 01/15/2016
juin 24 18:38:09 localhost.localdomain kernel: RIP: 
0010:__read_rt_unlock+0x5/0x40
juin 24 18:38:09 localhost.localdomain kernel: Code: 18 8d 4a 01 89 d0 
f0 0f b1 4f 28 39 c2 75 06 b8 01 00 00 00 c3 89 c2 eb e4 31 c0 c3 66 0f 
1f 84 00 00 00 00 00 0>
juin 24 18:38:09 localhost.localdomain kernel: RSP: 
0018:ffffb21c4257ba50 EFLAGS: 00010202
juin 24 18:38:09 localhost.localdomain kernel: RAX: ffff8a47cf8e5dc0 
RBX: ffff8a47cf8e5dc0 RCX: 0000000000000000
juin 24 18:38:09 localhost.localdomain kernel: RDX: ffffffff82e11380 
RSI: ffffffff830ea67d RDI: 0000000000016720
juin 24 18:38:09 localhost.localdomain kernel: RBP: ffff8a47f6e9fb40 
R08: ffff8a47e9cd4ba8 R09: 0000000000000000
juin 24 18:38:09 localhost.localdomain kernel: R10: ffffb21c4257b970 
R11: 0000000000000001 R12: ffff8a47cf8e6170
juin 24 18:38:09 localhost.localdomain kernel: R13: ffff8a47cf8e6610 
R14: ffff8a47e9cd4018 R15: ffff8a47d584e600
juin 24 18:38:09 localhost.localdomain kernel: FS: 
00007f9c0a996700(0000) GS:ffff8a47f6e80000(0000) knlGS:0000000000000000
juin 24 18:38:09 localhost.localdomain kernel: CS:  0010 DS: 0000 ES: 
0000 CR0: 0000000080050033
juin 24 18:38:09 localhost.localdomain kernel: CR2: 0000000000016748 
CR3: 0000000215ab6000 CR4: 00000000000406e0
juin 24 18:38:09 localhost.localdomain kernel: Call Trace:
juin 24 18:38:09 localhost.localdomain kernel: migrate_enable+0x1fc/0x400
juin 24 18:38:09 localhost.localdomain kernel: rt_spin_unlock+0x23/0x40
juin 24 18:38:09 localhost.localdomain kernel: 
radeon_cs_parser_fini+0x10f/0x120 [radeon]
juin 24 18:38:09 localhost.localdomain kernel: 
radeon_cs_ioctl+0x22b/0x800 [radeon]
juin 24 18:38:09 localhost.localdomain kernel:  ? 
radeon_cs_parser_init+0x20/0x20 [radeon]
juin 24 18:38:09 localhost.localdomain kernel: 
drm_ioctl_kernel+0xa7/0xf0 [drm]
juin 24 18:38:09 localhost.localdomain kernel: drm_ioctl+0x208/0x390 [drm]
juin 24 18:38:09 localhost.localdomain kernel:  ? 
radeon_cs_parser_init+0x20/0x20 [radeon]
juin 24 18:38:09 localhost.localdomain kernel:  ? migrate_enable+0x235/0x400
juin 24 18:38:09 localhost.localdomain kernel:  ? 
_raw_spin_unlock_irqrestore+0x1f/0x60
juin 24 18:38:09 localhost.localdomain kernel: 
radeon_drm_ioctl+0x49/0x80 [radeon]
juin 24 18:38:09 localhost.localdomain kernel: do_vfs_ioctl+0x40c/0x670
juin 24 18:38:09 localhost.localdomain kernel: ksys_ioctl+0x5e/0x90
juin 24 18:38:09 localhost.localdomain kernel: __x64_sys_ioctl+0x16/0x20
juin 24 18:38:09 localhost.localdomain kernel: do_syscall_64+0x5b/0x180
juin 24 18:38:09 localhost.localdomain kernel: 
entry_SYSCALL_64_after_hwframe+0x44/0xa9
juin 24 18:38:09 localhost.localdomain kernel: RIP: 0033:0x7f9c10a221fb
juin 24 18:38:09 localhost.localdomain kernel: Code: 0f 1e fa 48 8b 05 
8d dc 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 
00 f3 0f 1e fa b8 10 0>
juin 24 18:38:09 localhost.localdomain kernel: RSP: 
002b:00007f9c0a995a38 EFLAGS: 00003246 ORIG_RAX: 0000000000000010
juin 24 18:38:09 localhost.localdomain kernel: RAX: ffffffffffffffda 
RBX: 00007f9c0259f058 RCX: 00007f9c10a221fb
juin 24 18:38:09 localhost.localdomain kernel: RDX: 00007f9c0259f058 
RSI: 00000000c0206466 RDI: 0000000000000012
juin 24 18:38:09 localhost.localdomain kernel: RBP: 00000000c0206466 
R08: 000055c362cfb980 R09: 0000000000000000
juin 24 18:38:09 localhost.localdomain kernel: R10: 0000000000000000 
R11: 0000000000003246 R12: 00007f9c0258f010
juin 24 18:38:09 localhost.localdomain kernel: R13: 0000000000000012 
R14: 0000000000000000 R15: 000055c362cfb948
juin 24 18:38:09 localhost.localdomain kernel: Modules linked in: 
snd_seq_midi snd_seq_midi_event snd_seq_dummy fuse xt_CHECKSUM 
ipt_MASQUERADE tun bridge stp llc cc>
juin 24 18:38:09 localhost.localdomain kernel:  wmi_bmof mac80211 
snd_seq snd_seq_device snd_pcm cfg80211 sp5100_tco snd_timer rfkill 
pcc_cpufreq snd soundcore fam15>
juin 24 18:38:09 localhost.localdomain kernel: CR2: 0000000000016748
juin 24 18:38:09 localhost.localdomain kernel: ---[ end trace 
0000000000000006 ]---
juin 24 18:38:09 localhost.localdomain kernel: RIP: 
0010:__read_rt_unlock+0x5/0x40
juin 24 18:38:09 localhost.localdomain kernel: Code: 18 8d 4a 01 89 d0 
f0 0f b1 4f 28 39 c2 75 06 b8 01 00 00 00 c3 89 c2 eb e4 31 c0 c3 66 0f 
1f 84 00 00 00 00 00 0>
juin 24 18:38:09 localhost.localdomain kernel: RSP: 
0018:ffffb21c4257ba50 EFLAGS: 00010202
juin 24 18:38:09 localhost.localdomain kernel: RAX: ffff8a47cf8e5dc0 
RBX: ffff8a47cf8e5dc0 RCX: 0000000000000000
juin 24 18:38:09 localhost.localdomain kernel: RDX: ffffffff82e11380 
RSI: ffffffff830ea67d RDI: 0000000000016720
juin 24 18:38:09 localhost.localdomain kernel: RBP: ffff8a47f6e9fb40 
R08: ffff8a47e9cd4ba8 R09: 0000000000000000
juin 24 18:38:09 localhost.localdomain kernel: R10: ffffb21c4257b970 
R11: 0000000000000001 R12: ffff8a47cf8e6170
juin 24 18:38:09 localhost.localdomain kernel: R13: ffff8a47cf8e6610 
R14: ffff8a47e9cd4018 R15: ffff8a47d584e600
juin 24 18:38:09 localhost.localdomain kernel: FS: 
00007f9c0a996700(0000) GS:ffff8a47f6e80000(0000) knlGS:0000000000000000
juin 24 18:38:09 localhost.localdomain kernel: CS:  0010 DS: 0000 ES: 
0000 CR0: 0000000080050033
juin 24 18:38:09 localhost.localdomain kernel: CR2: 0000000000016748 
CR3: 0000000215ab6000 CR4: 00000000000406e0
juin 24 18:38:09 localhost.localdomain kernel: note: Xorg:rcs0[1129] 
exited with preempt_count 1
juin 24 18:38:09 localhost.localdomain kernel: WARNING: CPU: 1 PID: 1129 
at kernel/sched/core.c:7274 migrate_disable+0x1de/0x220
juin 24 18:38:09 localhost.localdomain kernel: Modules linked in: 
snd_seq_midi snd_seq_midi_event snd_seq_dummy fuse xt_CHECKSUM 
ipt_MASQUERADE tun bridge stp llc cc>
juin 24 18:38:09 localhost.localdomain kernel:  wmi_bmof mac80211 
snd_seq snd_seq_device snd_pcm cfg80211 sp5100_tco snd_timer rfkill 
pcc_cpufreq snd soundcore fam15>
juin 24 18:38:09 localhost.localdomain kernel: CPU: 1 PID: 1129 Comm: 
Xorg:rcs0 Tainted: G      D W 5.0.21-rt12.fc30.x86_64 #1
juin 24 18:38:09 localhost.localdomain kernel: Hardware name: HP 
450-a121nf/2B29, BIOS A0.11 01/15/2016
juin 24 18:38:09 localhost.localdomain kernel: RIP: 
0010:migrate_disable+0x1de/0x220
juin 24 18:38:09 localhost.localdomain kernel: Code: 0f 8e 2e ff ff ff 
8b 4b 44 48 c7 c2 40 fb 01 00 48 03 14 cd 20 e8 17 83 48 83 aa a0 08 00 
00 01 e9 0f ff ff ff e>
juin 24 18:38:09 localhost.localdomain kernel: RSP: 
0018:ffffb21c4257be60 EFLAGS: 00010246
juin 24 18:38:09 localhost.localdomain kernel: RAX: 0000000000100000 
RBX: ffff8a47cf8e5dc0 RCX: ffff8a47f680ae08
juin 24 18:38:09 localhost.localdomain kernel: RDX: 0000000000100000 
RSI: 0000000000100000 RDI: ffff8a47f680ae00
juin 24 18:38:09 localhost.localdomain kernel: RBP: ffff8a47d5912188 
R08: ffff8a47d5badf00 R09: ffffffff8325c140
juin 24 18:38:09 localhost.localdomain kernel: R10: ffffb21c4257be28 
R11: 0000000000000001 R12: 0000000000000009
juin 24 18:38:09 localhost.localdomain kernel: R13: ffff8a47cf8e5dc0 
R14: ffff8a47cf8e5d00 R15: 0000000000000046
juin 24 18:38:09 localhost.localdomain kernel: FS: 
00007f9c0a996700(0000) GS:ffff8a47f6e80000(0000) knlGS:0000000000000000
juin 24 18:38:09 localhost.localdomain kernel: CS:  0010 DS: 0000 ES: 
0000 CR0: 0000000080050033
juin 24 18:38:09 localhost.localdomain kernel: CR2: 0000000000016748 
CR3: 0000000215ab6000 CR4: 00000000000406e0
juin 24 18:38:09 localhost.localdomain kernel: Call Trace:
juin 24 18:38:09 localhost.localdomain kernel: rt_spin_lock+0x1f/0x40
juin 24 18:38:09 localhost.localdomain kernel: acct_collect+0x1b3/0x1d0
juin 24 18:38:09 localhost.localdomain kernel: do_exit+0x126/0xc40
juin 24 18:38:09 localhost.localdomain kernel:  ? ksys_ioctl+0x5e/0x90
juin 24 18:38:09 localhost.localdomain kernel: 
rewind_stack_do_exit+0x17/0x20
juin 24 18:38:09 localhost.localdomain kernel: ---[ end trace 
0000000000000007 ]---
juin 24 18:38:10 localhost.localdomain abrt-dump-journal-oops[873]: 
abrt-dump-journal-oops: Found oopses: 7
juin 24 18:38:10 localhost.localdomain abrt-dump-journal-oops[873]: 
abrt-dump-journal-oops: Creating problem directories

Best regards,


YC

