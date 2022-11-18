Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993FEC4332F
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Nov 2022 10:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241512AbiKRKr2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 18 Nov 2022 05:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241702AbiKRKrK (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 18 Nov 2022 05:47:10 -0500
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FBD970A3
        for <linux-rt-users@vger.kernel.org>; Fri, 18 Nov 2022 02:47:08 -0800 (PST)
Received: from zimbra35-e6.priv.proxad.net (unknown [172.20.243.185])
        by smtp3-g21.free.fr (Postfix) with ESMTP id 0EAF813F8E4
        for <linux-rt-users@vger.kernel.org>; Fri, 18 Nov 2022 11:47:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1668768427;
        bh=3SG/cFxke8yyHkf/l2mmgolce71OEeAc8tRI7vgY24I=;
        h=Date:From:To:In-Reply-To:Subject:From;
        b=nkuVOz2xxOcpOcwHoFD7AS7Mcn8D566Xc5w1kJevDM9dMVRZjg0hk/A68y+3erJAR
         35yChKeKvh1rWRbsZ5FPj1sNJoez6L3Z+ErQrjkA9aYbRbuk9g+yfqd+/KQqEQ0Lfi
         WOZsIbEIoJAqyExc9C1IOhuXZRBgUbWvn08/yrsiA4bLDHxOH3c7Jq0tMDFiv6oy5p
         G3DiRrNBuupn/sIGNZtmWW09xy3VMCuQyb6kgWTsjW9kIX2CVCyA8PRPeUCxmP59QE
         8xcQQ1KdlNrSDMQO1INu/tQWwW7Hg0nIfGRCijUtnuHBnYhBPSbo+AuF1mPNUKbag+
         5scoyAUVhsdHA==
Date:   Fri, 18 Nov 2022 11:47:06 +0100 (CET)
From:   ycollette.nospam@free.fr
To:     linux-rt-users@vger.kernel.org
Message-ID: <125788371.8335457.1668768426600.JavaMail.root@zimbra35-e6.priv.proxad.net>
In-Reply-To: <b84eef4c-eac6-3131-2fd4-256a3a012cc4@free.fr>
Subject: Re: Kernel crash with AMD proc and Radeon graphic card
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [2a01:e0a:244:b080:841b:b83f:b5e6:3112]
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - GC107 (Mac)/7.2.0-GA2598)
X-Authenticated-User: ycollette.nospam@free.fr
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hmm, this happens on standard Fedora kernel too. 6.0.8.

----- Mail original -----
De: "Yann COLLETTE" <ycollette.nospam@free.fr>
=C3=80: linux-rt-users@vger.kernel.org
Envoy=C3=A9: Vendredi 18 Novembre 2022 11:33:02
Objet: Kernel crash with AMD proc and Radeon graphic card


Hello,

I noticed a problem while using kernel-rt on post 6.0 kernel (maybe it=20
happened before, but I am not sure).
I managed to get a stack trace for this problem.
The crash was triggered while starting playing a video.
Here is the stack trace:
nov. 18 10:34:41 localhost.localdomain kernel: ---[ end trace=20
0000000000000000 ]---
nov. 18 10:34:41 localhost.localdomain kernel:=C2=A0 </TASK>
nov. 18 10:34:41 localhost.localdomain kernel: R13: 0000000000000000=20
R14: 00007fab8adfbee8 R15: 00007fab8adfbf00
nov. 18 10:34:41 localhost.localdomain kernel: R10: 00007fab8ac05fa8=20
R11: 0000000000000246 R12: 00007fab8adf69e0
nov. 18 10:34:41 localhost.localdomain kernel: RBP: 0000000000000000=20
R08: fffffffffffffc78 R09: 00007fab8ae01b20
nov. 18 10:34:41 localhost.localdomain kernel: RDX: 000000000000003c=20
RSI: 00000000000000e7 RDI: 0000000000000000
nov. 18 10:34:41 localhost.localdomain kernel: RAX: ffffffffffffffda=20
RBX: 00007fab8adf69e0 RCX: 00007fab8ad187f1
nov. 18 10:34:41 localhost.localdomain kernel: RSP:=20
002b:00007ffde2313ab8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
nov. 18 10:34:41 localhost.localdomain kernel: Code: Unable to access=20
opcode bytes at RIP 0x7fab8ad187c7.
nov. 18 10:34:41 localhost.localdomain kernel: RIP: 0033:0x7fab8ad187f1
nov. 18 10:34:41 localhost.localdomain kernel:=20
entry_SYSCALL_64_after_hwframe+0x63/0xcd
nov. 18 10:34:41 localhost.localdomain kernel: do_syscall_64+0x3b/0xc0
nov. 18 10:34:41 localhost.localdomain kernel:=20
__x64_sys_exit_group+0x14/0x20
nov. 18 10:34:41 localhost.localdomain kernel: do_group_exit+0x2d/0x90
nov. 18 10:34:41 localhost.localdomain kernel: do_exit+0x325/0xa10
nov. 18 10:34:41 localhost.localdomain kernel: task_work_run+0x5c/0xa0
nov. 18 10:34:41 localhost.localdomain kernel:=C2=A0 __fput+0xdd/0x250
nov. 18 10:34:41 localhost.localdomain kernel: __dentry_kill+0xf8/0x170
nov. 18 10:34:41 localhost.localdomain kernel: dma_buf_release+0x3a/0xa0
nov. 18 10:34:41 localhost.localdomain kernel:=20
drm_gem_dmabuf_release+0x36/0x50 [drm]
nov. 18 10:34:41 localhost.localdomain kernel:=20
radeon_gem_object_free+0x30/0x60 [radeon]
nov. 18 10:34:41 localhost.localdomain kernel: radeon_bo_unref+0x1a/0x30=20
[radeon]
nov. 18 10:34:41 localhost.localdomain kernel:=C2=A0 ?=20
fsnotify_grab_connector+0x49/0x90
nov. 18 10:34:41 localhost.localdomain kernel:=C2=A0 ? call_rcu+0xd6/0x760
nov. 18 10:34:41 localhost.localdomain kernel:=C2=A0 ?=20
__inode_wait_for_writeback+0x7e/0xf0
nov. 18 10:34:41 localhost.localdomain kernel:=C2=A0 ? xa_load+0x70/0xb0
nov. 18 10:34:41 localhost.localdomain kernel:=C2=A0 <TASK>
nov. 18 10:34:41 localhost.localdomain kernel: Call Trace:
nov. 18 10:34:41 localhost.localdomain kernel: CR2: 00007fab8a604734=20
CR3: 00000001032a4000 CR4: 00000000000406e0
nov. 18 10:34:41 localhost.localdomain kernel: CS:=C2=A0 0010 DS: 0000 ES:=
=20
0000 CR0: 0000000080050033
nov. 18 10:34:41 localhost.localdomain kernel: FS:=20
00007fab8ae0ff00(0000) GS:ffff888233d80000(0000) knlGS:0000000000000000
nov. 18 10:34:41 localhost.localdomain kernel: R13: ffff8881001a0de0=20
R14: ffff888112202240 R15: ffff8881511947c0
nov. 18 10:34:41 localhost.localdomain kernel: R10: 0000000000000000=20
R11: 0000000000000000 R12: ffff888128f42478
nov. 18 10:34:41 localhost.localdomain kernel: RBP: ffff88823d4446f0=20
R08: ffff888128f425c8 R09: 0000000000000000
nov. 18 10:34:41 localhost.localdomain kernel: RDX: 0000000000000003=20
RSI: 0000000000000000 RDI: ffff888128f425c8
nov. 18 10:34:41 localhost.localdomain kernel: RAX: 0000000000000000=20
RBX: ffff888128f425c8 RCX: 0000000000000000
nov. 18 10:34:41 localhost.localdomain kernel: RSP:=20
0018:ffffc90001407d98 EFLAGS: 00010206
nov. 18 10:34:41 localhost.localdomain kernel: Code: 00 e8 9f 90 3f e1=20
48 8b 43 e8 eb a8 be 03 00 00 00 e8 df 4e 17 e1 e9 fc fd ff ff e8 25 66=20
3f e1 e9 f2 fd ff ff 48 89 e8 eb 8a <0f> 0b 48 83 7b 20 00 0f 84 33 fd=20
ff ff 0f 0b e9 2c fd >
nov. 18 10:34:41 localhost.localdomain kernel: RIP:=20
0010:ttm_bo_release+0x305/0x320 [ttm]
nov. 18 10:34:41 localhost.localdomain kernel: Hardware name: HP=20
450-a121nf/2B29, BIOS A0.11 01/15/2016
nov. 18 10:34:41 localhost.localdomain kernel: CPU: 3 PID: 920 Comm:=20
Xorg Tainted: G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6.0.7-lqx1.fc35.x86_64 #1
nov. 18 10:34:41 localhost.localdomain kernel:=C2=A0 snd_seq_device snd_pcm=
=20
mc libarc4 snd_timer hp_wmi sparse_keymap snd joydev mousedev irqbypass=20
platform_profile pktcdvd rfkill pcspkr i2c_piix4 soundcore wmi_bmof=20
fam15h_power k10temp efi>
nov. 18 10:34:41 localhost.localdomain kernel: Modules linked in:=20
snd_seq_dummy snd_hrtimer xt_CHECKSUM xt_MASQUERADE xt_conntrack=20
ipt_REJECT xt_tcpudp nf_nat_tftp nft_objref nf_conntrack_tftp bridge stp=20
llc af_packet nft_fib_inet nft_>
nov. 18 10:34:41 localhost.localdomain kernel: WARNING: CPU: 3 PID: 920=20
at drivers/gpu/drm/ttm/ttm_bo.c:356 ttm_bo_release+0x305/0x320 [ttm]
nov. 18 10:34:41 localhost.localdomain kernel: ------------[ cut here=20
]------------
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl=20
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
Syncing to a disabled ring!
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl=20
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
Syncing to a disabled ring!
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl=20
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
Syncing to a disabled ring!
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl=20
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
Syncing to a disabled ring!
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl=20
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
Syncing to a disabled ring!
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl=20
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
Syncing to a disabled ring!
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl=20
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
Syncing to a disabled ring!
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl=20
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
Syncing to a disabled ring!
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl=20
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
Syncing to a disabled ring!
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl=20
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
Syncing to a disabled ring!
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl=20
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
Syncing to a disabled ring!
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl=20
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
Syncing to a disabled ring!
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl=20
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
Syncing to a disabled ring!
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl=20
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
Syncing to a disabled ring!
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl=20
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
Syncing to a disabled ring!
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl=20
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
Syncing to a disabled ring!
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl=20
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
Syncing to a disabled ring!
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl=20
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
Syncing to a disabled ring!
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl=20
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
Syncing to a disabled ring!
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl=20
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
Syncing to a disabled ring!
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl=20
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
Syncing to a disabled ring!
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl=20
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
Syncing to a disabled ring!
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl=20
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
Syncing to a disabled ring!
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl=20
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
Syncing to a disabled ring!
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl=20
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
Syncing to a disabled ring!
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl=20
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
Syncing to a disabled ring!
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl=20
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
Syncing to a disabled ring!
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl=20
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
Syncing to a disabled ring!
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl=20
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
Syncing to a disabled ring!
nov. 18 10:34:41 localhost.localdomain kernel: [drm:radeon_gem_va_ioctl=20
[radeon]] *ERROR* Couldn't update BO_VA (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
failed to sync rings (-22)
nov. 18 10:34:41 localhost.localdomain kernel: radeon 0000:00:01.0:=20
Syncing to a disabled ring!

Best regards,

Yann

