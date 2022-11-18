Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508DCC433FE
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Nov 2022 10:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241438AbiKRKdN (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 18 Nov 2022 05:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241777AbiKRKdJ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 18 Nov 2022 05:33:09 -0500
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE94942C3
        for <linux-rt-users@vger.kernel.org>; Fri, 18 Nov 2022 02:33:04 -0800 (PST)
Received: from [IPV6:2a01:e0a:244:b080:ef31:9c79:913b:743c] (unknown [IPv6:2a01:e0a:244:b080:ef31:9c79:913b:743c])
        by smtp1-g21.free.fr (Postfix) with ESMTP id 160ABB00585
        for <linux-rt-users@vger.kernel.org>; Fri, 18 Nov 2022 11:33:03 +0100 (CET)
Message-ID: <b84eef4c-eac6-3131-2fd4-256a3a012cc4@free.fr>
Date:   Fri, 18 Nov 2022 11:33:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Content-Language: en-US
To:     linux-rt-users@vger.kernel.org
From:   Yann COLLETTE <ycollette.nospam@free.fr>
Subject: Kernel crash with AMD proc and Radeon graphic card
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


Hello,

I noticed a problem while using kernel-rt on post 6.0 kernel (maybe it 
happened before, but I am not sure).
I managed to get a stack trace for this problem.
The crash was triggered while starting playing a video.
Here is the stack trace:
nov. 18 10:34:41 localhost.localdomain kernel: ---[ end trace 
0000000000000000 ]---
nov. 18 10:34:41 localhost.localdomain kernel:  </TASK>
nov. 18 10:34:41 localhost.localdomain kernel: R13: 0000000000000000 
R14: 00007fab8adfbee8 R15: 00007fab8adfbf00
nov. 18 10:34:41 localhost.localdomain kernel: R10: 00007fab8ac05fa8 
R11: 0000000000000246 R12: 00007fab8adf69e0
nov. 18 10:34:41 localhost.localdomain kernel: RBP: 0000000000000000 
R08: fffffffffffffc78 R09: 00007fab8ae01b20
nov. 18 10:34:41 localhost.localdomain kernel: RDX: 000000000000003c 
RSI: 00000000000000e7 RDI: 0000000000000000
nov. 18 10:34:41 localhost.localdomain kernel: RAX: ffffffffffffffda 
RBX: 00007fab8adf69e0 RCX: 00007fab8ad187f1
nov. 18 10:34:41 localhost.localdomain kernel: RSP: 
002b:00007ffde2313ab8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
nov. 18 10:34:41 localhost.localdomain kernel: Code: Unable to access 
opcode bytes at RIP 0x7fab8ad187c7.
nov. 18 10:34:41 localhost.localdomain kernel: RIP: 0033:0x7fab8ad187f1
nov. 18 10:34:41 localhost.localdomain kernel: 
entry_SYSCALL_64_after_hwframe+0x63/0xcd
nov. 18 10:34:41 localhost.localdomain kernel: do_syscall_64+0x3b/0xc0
nov. 18 10:34:41 localhost.localdomain kernel: 
__x64_sys_exit_group+0x14/0x20
nov. 18 10:34:41 localhost.localdomain kernel: do_group_exit+0x2d/0x90
nov. 18 10:34:41 localhost.localdomain kernel: do_exit+0x325/0xa10
nov. 18 10:34:41 localhost.localdomain kernel: task_work_run+0x5c/0xa0
nov. 18 10:34:41 localhost.localdomain kernel:  __fput+0xdd/0x250
nov. 18 10:34:41 localhost.localdomain kernel: __dentry_kill+0xf8/0x170
nov. 18 10:34:41 localhost.localdomain kernel: dma_buf_release+0x3a/0xa0
nov. 18 10:34:41 localhost.localdomain kernel: 
drm_gem_dmabuf_release+0x36/0x50 [drm]
nov. 18 10:34:41 localhost.localdomain kernel: 
radeon_gem_object_free+0x30/0x60 [radeon]
nov. 18 10:34:41 localhost.localdomain kernel: radeon_bo_unref+0x1a/0x30 
[radeon]
nov. 18 10:34:41 localhost.localdomain kernel:  ? 
fsnotify_grab_connector+0x49/0x90
nov. 18 10:34:41 localhost.localdomain kernel:  ? call_rcu+0xd6/0x760
nov. 18 10:34:41 localhost.localdomain kernel:  ? 
__inode_wait_for_writeback+0x7e/0xf0
nov. 18 10:34:41 localhost.localdomain kernel:  ? xa_load+0x70/0xb0
nov. 18 10:34:41 localhost.localdomain kernel:  <TASK>
nov. 18 10:34:41 localhost.localdomain kernel: Call Trace:
nov. 18 10:34:41 localhost.localdomain kernel: CR2: 00007fab8a604734 
CR3: 00000001032a4000 CR4: 00000000000406e0
nov. 18 10:34:41 localhost.localdomain kernel: CS:  0010 DS: 0000 ES: 
0000 CR0: 0000000080050033
nov. 18 10:34:41 localhost.localdomain kernel: FS: 
00007fab8ae0ff00(0000) GS:ffff888233d80000(0000) knlGS:0000000000000000
nov. 18 10:34:41 localhost.localdomain kernel: R13: ffff8881001a0de0 
R14: ffff888112202240 R15: ffff8881511947c0
nov. 18 10:34:41 localhost.localdomain kernel: R10: 0000000000000000 
R11: 0000000000000000 R12: ffff888128f42478
nov. 18 10:34:41 localhost.localdomain kernel: RBP: ffff88823d4446f0 
R08: ffff888128f425c8 R09: 0000000000000000
nov. 18 10:34:41 localhost.localdomain kernel: RDX: 0000000000000003 
RSI: 0000000000000000 RDI: ffff888128f425c8
nov. 18 10:34:41 localhost.localdomain kernel: RAX: 0000000000000000 
RBX: ffff888128f425c8 RCX: 0000000000000000
nov. 18 10:34:41 localhost.localdomain kernel: RSP: 
0018:ffffc90001407d98 EFLAGS: 00010206
nov. 18 10:34:41 localhost.localdomain kernel: Code: 00 e8 9f 90 3f e1 
48 8b 43 e8 eb a8 be 03 00 00 00 e8 df 4e 17 e1 e9 fc fd ff ff e8 25 66 
3f e1 e9 f2 fd ff ff 48 89 e8 eb 8a <0f> 0b 48 83 7b 20 00 0f 84 33 fd 
ff ff 0f 0b e9 2c fd >
nov. 18 10:34:41 localhost.localdomain kernel: RIP: 
0010:ttm_bo_release+0x305/0x320 [ttm]
nov. 18 10:34:41 localhost.localdomain kernel: Hardware name: HP 
450-a121nf/2B29, BIOS A0.11 01/15/2016
nov. 18 10:34:41 localhost.localdomain kernel: CPU: 3 PID: 920 Comm: 
Xorg Tainted: G        W          6.0.7-lqx1.fc35.x86_64 #1
nov. 18 10:34:41 localhost.localdomain kernel:  snd_seq_device snd_pcm 
mc libarc4 snd_timer hp_wmi sparse_keymap snd joydev mousedev irqbypass 
platform_profile pktcdvd rfkill pcspkr i2c_piix4 soundcore wmi_bmof 
fam15h_power k10temp efi>
nov. 18 10:34:41 localhost.localdomain kernel: Modules linked in: 
snd_seq_dummy snd_hrtimer xt_CHECKSUM xt_MASQUERADE xt_conntrack 
ipt_REJECT xt_tcpudp nf_nat_tftp nft_objref nf_conntrack_tftp bridge stp 
llc af_packet nft_fib_inet nft_>
nov. 18 10:34:41 localhost.localdomain kernel: WARNING: CPU: 3 PID: 920 
at drivers/gpu/drm/ttm/ttm_bo.c:356 ttm_bo_release+0x305/0x320 [ttm]
nov. 18 10:34:41 localhost.localdomain kernel: ------------[ cut here 
]------------
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl 
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
Syncing to a disabled ring!
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl 
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
Syncing to a disabled ring!
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl 
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
Syncing to a disabled ring!
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl 
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
Syncing to a disabled ring!
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl 
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
Syncing to a disabled ring!
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl 
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
Syncing to a disabled ring!
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl 
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
Syncing to a disabled ring!
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl 
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
Syncing to a disabled ring!
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl 
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
Syncing to a disabled ring!
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl 
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
Syncing to a disabled ring!
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl 
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
Syncing to a disabled ring!
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl 
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
Syncing to a disabled ring!
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl 
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
Syncing to a disabled ring!
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl 
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
Syncing to a disabled ring!
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl 
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
Syncing to a disabled ring!
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl 
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
Syncing to a disabled ring!
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl 
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
Syncing to a disabled ring!
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl 
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
Syncing to a disabled ring!
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl 
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
Syncing to a disabled ring!
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl 
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
Syncing to a disabled ring!
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl 
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
Syncing to a disabled ring!
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl 
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
Syncing to a disabled ring!
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl 
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
Syncing to a disabled ring!
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl 
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
Syncing to a disabled ring!
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl 
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
Syncing to a disabled ring!
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl 
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
Syncing to a disabled ring!
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl 
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
Syncing to a disabled ring!
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl 
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
Syncing to a disabled ring!
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl 
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
Syncing to a disabled ring!
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl 
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0: 
Syncing to a disabled ring!

Best regards,

Yann

