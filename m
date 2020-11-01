Return-Path: <SRS0=Wn/T=EH=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED158C2D0A3
	for <linux-rt-users@archiver.kernel.org>; Sun,  1 Nov 2020 05:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 813D120853
	for <linux-rt-users@archiver.kernel.org>; Sun,  1 Nov 2020 05:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="h4xR+Gad"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgKAFYd (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 1 Nov 2020 01:24:33 -0400
Received: from mout.gmx.net ([212.227.17.21]:36943 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726117AbgKAFYb (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 1 Nov 2020 01:24:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604208231;
        bh=/501+kPrAKn7yu1Ytdo01pn4jXO4GgkfdbLGw15xBe8=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=h4xR+GadcOra4IBvmBcJeY7ncMRNFOm0GgNtJpGjmKSuJlDtA9W6kp0oB/CeemnWQ
         KA1bqz3773kLU+kq438q31f+mqUWX88eCftK0PSHukCEwgfSA2FmlVnjWqXD3B0S5X
         feGHu1SS67r3ASI4P1Rg+ETHWAgWgENmj/e1oTLE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.simpson.net ([185.191.216.249]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MtwUm-1kEGfj2VYa-00uJNp; Sun, 01
 Nov 2020 06:23:51 +0100
Message-ID: <17f055aad6788c17dbeb522f2cac4f8bb94f759b.camel@gmx.de>
Subject: 5.10-rt: non-repeatable
 flush_delayed_work()...del_timer_wait_running() ATOMIC_SLEEP splat
From:   Mike Galbraith <efault@gmx.de>
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Sun, 01 Nov 2020 06:23:50 +0100
In-Reply-To: <20201030191853.raabwjou753fk4sh@linutronix.de>
References: <20201030191853.raabwjou753fk4sh@linutronix.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:2UZgJBbgwHyOA6V7RNl58JUeGiTx4Hh6jEiiQO5Q7WFzM8gn3Mf
 l20pauItCqD3sQkUnz9hbg2q7p+1XkHms3G9ioRhjS01YZu8ILSQHt7nBll1jnSvVIHI3GT
 WqNmTGfQZCj6q/gXG6gYF7On4YcIjOwPdUsY658Es6dEU9eqURUXwnzg2+MRP2zaBfgp8UD
 xXe6wiTmEzbTF3NWpwr5A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8oHv/nlu8+o=:kVzbCW3qb4fgqeiaxHNqiZ
 nEvF/qCowurafiZ6OKHabF5cJd9jfMNdlZNzDjg/0uVGO4ShXEZnFhVWGIGkiJ6xlZ5zN6AoQ
 GS0ToT6BDHnSuqgXQCt+ysxzzUEplllibezhMxC/QbnxQ//poLFYBbFRmRcH73dOPcKLadtXU
 SsuAvlUiZXeg4YRiDpheB4+wKGn1ByYdE1GPAFLJCPWlmCsUgdNcg9aWYwZFp4+zck9dgXRPg
 wNtq6rBhVmclX1ttv8Mc5HSyLwnaQx33a42KRE7XuDebtWOAS6KExRDPyDKkJ51Ia6+8L4glM
 EaR7r5xD1o0fSgZKK50X0CzC3NrWPbzpGPqBf8XQZzfcDM4xd4FBOTha6jKuINqVNlnGthQgN
 MZmrqiyK5jcMN3frMannuO5xZhs/TiqDoc5rBjIfmVYP6VeQbcSABoLRSoEtTn4Df+569+fRo
 fVXbVdEjBxYmje4os6p7s43rRNYYJtAR17JaJOUvjr+mje7TONPVJsSdmGK03Ym674sL5Ijy1
 0CSumrX+OSw/tyrauzgKi6znyx4IwY5LRbLdK2olqjmcXan5/FUMsGuD44SqPZZbB1X4DQ1nd
 PmIk8lCK4F0dGT9pbrDXxkUiNB6UkYiRkpfP47IVVhRtPFtHDpIzRL6zr67e6Qes+P0Z2XiDl
 Kqut9WqZ1/DGOKP7ebuqS90Tjx1/i9lFCXu0JJQjJ5yRXvCjwop91MbaKpxsCbJLKTacsawZw
 tmZiXX3OmuQPmTLoe/KeIRrlatAfyMw4Of0bhgs1rNoEFpqIF/9xBhv6SJdwlES4KZ/ru+7Mg
 DI7AwRGkFsMU3gOBKA9NUvzLZEur+XXOOqL4FhylbRR4/PzsJmUVcmQaIUi0Cb63CaR/QlGxv
 0KUIS8Pz0Xa7VEfv61Hg==
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Apparently, timer ain't ever supposed to be running when you get there
via flush_delayed_work(), but it was.

[   28.932213] BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:969
[   28.932220] in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 336, name: systemd-udevd
[   28.932223] 1 lock held by systemd-udevd/336:
[   28.932225]  #0: ffff90cf9ecdb418 (&base->expiry_lock){+...}-{0:0}, at: del_timer_sync+0xfa/0x150
[   28.932243] irq event stamp: 810843
[   28.932245] hardirqs last  enabled at (810841): [<ffffffffaf9d7170>] _raw_spin_unlock_irqrestore+0x70/0x80
[   28.932252] hardirqs last disabled at (810842): [<ffffffffaf0b2b09>] flush_delayed_work+0x49/0x50
[   28.932259] softirqs last  enabled at (807242): [<ffffffffaf095825>] __local_bh_enable_ip+0x75/0x130
[   28.932266] softirqs last disabled at (810843): [<ffffffffaf14eca3>] del_timer_sync+0xd3/0x150
[   28.932271] CPU: 6 PID: 336 Comm: systemd-udevd Tainted: G            E     5.10.0.g07e0887-rt2-rt #18
[   28.932275] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/23/2013
[   28.932277] Call Trace:
[   28.932288]  dump_stack+0x77/0x97
[   28.932304]  ___might_sleep+0x14e/0x1f0
[   28.932324]  rt_spin_lock+0x3e/0xc0
[   28.932328]  ? del_timer_sync+0xfa/0x150
[   28.932337]  del_timer_sync+0xfa/0x150
[   28.932358]  flush_delayed_work+0x1a/0x50
[   28.932366]  fsnotify_destroy_group+0x58/0xd0
[   28.932392]  inotify_release+0x1e/0x50
[   28.932402]  __fput+0xb2/0x260
[   28.932422]  task_work_run+0x73/0xc0
[   28.932444]  exit_to_user_mode_prepare+0x1da/0x200
[   28.932461]  syscall_exit_to_user_mode+0x46/0x310
[   28.932471]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   28.932477] RIP: 0033:0x7f6509e31ef4
[   28.932483] Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 80 00 00 00 00 8b 05 7a c2 20 00 48 63 ff 85 c0 75 13 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 44 f3 c3 66 90 48 83 ec 18 48 89 7c 24 08 e8
[   28.932487] RSP: 002b:00007ffe2518d9c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
[   28.932491] RAX: 0000000000000000 RBX: 0000000000000008 RCX: 00007f6509e31ef4
[   28.932493] RDX: 00007f6509e19af8 RSI: 00007f6509beaf30 RDI: 0000000000000008
[   28.932495] RBP: 00007f650ad1cb70 R08: 000055c5ace35830 R09: 00007ffe2518eef2
[   28.932497] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[   28.932499] R13: 0000000000000006 R14: 00007ffe2518db04 R15: 0000000000000006
[   28.933184] ------------[ cut here ]------------
[   28.933185] WARNING: CPU: 6 PID: 336 at kernel/softirq.c:227 __local_bh_enable_ip+0x95/0x130
[   28.933192] Modules linked in: hid_logitech_hidpp(E) sr_mod(E) cdrom(E) hid_logitech_dj(E) ums_realtek(E) hid_generic(E) uas(E) usb_storage(E) usbhid(E) nouveau(E) wmi(E) i2c_algo_bit(E) drm_kms_helper(E) syscopyarea(E) sysfillrect(E) sysimgblt(E) fb_sys_fops(E) xhci_pci(E) cec(E) ahci(E) ehci_pci(E) rc_core(E) libahci(E) ehci_hcd(E) xhci_hcd(E) ttm(E) libata(E) drm(E) usbcore(E) video(E) button(E) sd_mod(E) vfat(E) fat(E) virtio_blk(E) virtio_mmio(E) virtio_ring(E) virtio(E) ext4(E) crc32c_intel(E) crc16(E) mbcache(E) jbd2(E) loop(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E)
[   28.933256] CPU: 6 PID: 336 Comm: systemd-udevd Tainted: G        W   E     5.10.0.g07e0887-rt2-rt #18
[   28.933259] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/23/2013
[   28.933261] RIP: 0010:__local_bh_enable_ip+0x95/0x130
[   28.933266] Code: 89 de 44 89 e7 e8 3b f9 ff ff 4d 85 ed 74 05 e8 01 04 14 00 55 9d 5b 5d 41 5c 41 5d 41 5e c3 65 8b 05 5b 48 f8 50 85 c0 75 bb <0f> 0b eb b7 e8 f2 04 14 00 eb bf 48 c7 c7 54 77 1a b0 e8 b4 43 93
[   28.933269] RSP: 0018:ffffbbccc0417df0 EFLAGS: 00010046
[   28.933272] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
[   28.933274] RDX: 0000000000000000 RSI: 0000000000000200 RDI: ffffffffaf14eca3
[   28.933276] RBP: ffffbbccc0417e48 R08: 0000000000000001 R09: 0000000000000000
[   28.933278] R10: 0000000000000000 R11: ffffffffffffffff R12: 0000000000000200
[   28.933280] R13: 000000000001c6c0 R14: ffff90cf9ecdb388 R15: ffff90cf9ecdb340
[   28.933282] FS:  00007f650ad1cd40(0000) GS:ffff90cf9ed80000(0000) knlGS:0000000000000000
[   28.933285] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   28.933287] CR2: 00005575baf61550 CR3: 000000010a262005 CR4: 00000000001706e0
[   28.933289] Call Trace:
[   28.933305]  del_timer_sync+0x11b/0x150
[   28.933325]  flush_delayed_work+0x1a/0x50
[   28.933332]  fsnotify_destroy_group+0x58/0xd0
[   28.933355]  inotify_release+0x1e/0x50
[   28.933362]  __fput+0xb2/0x260
[   28.933379]  task_work_run+0x73/0xc0
[   28.933399]  exit_to_user_mode_prepare+0x1da/0x200
[   28.933413]  syscall_exit_to_user_mode+0x46/0x310
[   28.933422]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   28.933426] RIP: 0033:0x7f6509e31ef4
[   28.933429] Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 80 00 00 00 00 8b 05 7a c2 20 00 48 63 ff 85 c0 75 13 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 44 f3 c3 66 90 48 83 ec 18 48 89 7c 24 08 e8
[   28.933433] RSP: 002b:00007ffe2518d9c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
[   28.933436] RAX: 0000000000000000 RBX: 0000000000000008 RCX: 00007f6509e31ef4
[   28.933438] RDX: 00007f6509e19af8 RSI: 00007f6509beaf30 RDI: 0000000000000008
[   28.933439] RBP: 00007f650ad1cb70 R08: 000055c5ace35830 R09: 00007ffe2518eef2
[   28.933441] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[   28.933443] R13: 0000000000000006 R14: 00007ffe2518db04 R15: 0000000000000006
[   28.933497] CPU: 6 PID: 336 Comm: systemd-udevd Tainted: G        W   E     5.10.0.g07e0887-rt2-rt #18
[   28.933499] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/23/2013
[   28.933500] Call Trace:
[   28.933505]  dump_stack+0x77/0x97
[   28.933517]  __warn+0x8c/0x110
[   28.933526]  ? __local_bh_enable_ip+0x95/0x130
[   28.933541]  report_bug+0xbb/0x130
[   28.933561]  handle_bug+0x44/0x80
[   28.933570]  exc_invalid_op+0x13/0x60
[   28.933580]  asm_exc_invalid_op+0x12/0x20
[   28.933585] RIP: 0010:__local_bh_enable_ip+0x95/0x130
[   28.933589] Code: 89 de 44 89 e7 e8 3b f9 ff ff 4d 85 ed 74 05 e8 01 04 14 00 55 9d 5b 5d 41 5c 41 5d 41 5e c3 65 8b 05 5b 48 f8 50 85 c0 75 bb <0f> 0b eb b7 e8 f2 04 14 00 eb bf 48 c7 c7 54 77 1a b0 e8 b4 43 93
[   28.933592] RSP: 0018:ffffbbccc0417df0 EFLAGS: 00010046
[   28.933595] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
[   28.933596] RDX: 0000000000000000 RSI: 0000000000000200 RDI: ffffffffaf14eca3
[   28.933598] RBP: ffffbbccc0417e48 R08: 0000000000000001 R09: 0000000000000000
[   28.933600] R10: 0000000000000000 R11: ffffffffffffffff R12: 0000000000000200
[   28.933601] R13: 000000000001c6c0 R14: ffff90cf9ecdb388 R15: ffff90cf9ecdb340
[   28.933638]  ? del_timer_sync+0xd3/0x150
[   28.933668]  del_timer_sync+0x11b/0x150
[   28.933686]  flush_delayed_work+0x1a/0x50
[   28.933694]  fsnotify_destroy_group+0x58/0xd0
[   28.933716]  inotify_release+0x1e/0x50
[   28.933724]  __fput+0xb2/0x260
[   28.933741]  task_work_run+0x73/0xc0
[   28.933761]  exit_to_user_mode_prepare+0x1da/0x200
[   28.933773]  syscall_exit_to_user_mode+0x46/0x310
[   28.933782]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   28.933787] RIP: 0033:0x7f6509e31ef4
[   28.933790] Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 80 00 00 00 00 8b 05 7a c2 20 00 48 63 ff 85 c0 75 13 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 44 f3 c3 66 90 48 83 ec 18 48 89 7c 24 08 e8
[   28.933793] RSP: 002b:00007ffe2518d9c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
[   28.933795] RAX: 0000000000000000 RBX: 0000000000000008 RCX: 00007f6509e31ef4
[   28.933797] RDX: 00007f6509e19af8 RSI: 00007f6509beaf30 RDI: 0000000000000008
[   28.933799] RBP: 00007f650ad1cb70 R08: 000055c5ace35830 R09: 00007ffe2518eef2
[   28.933800] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[   28.933802] R13: 0000000000000006 R14: 00007ffe2518db04 R15: 0000000000000006
[   28.933856] irq event stamp: 810843
[   28.933857] hardirqs last  enabled at (810841): [<ffffffffaf9d7170>] _raw_spin_unlock_irqrestore+0x70/0x80
[   28.933861] hardirqs last disabled at (810842): [<ffffffffaf0b2b09>] flush_delayed_work+0x49/0x50
[   28.933866] softirqs last  enabled at (807242): [<ffffffffaf095825>] __local_bh_enable_ip+0x75/0x130
[   28.933870] softirqs last disabled at (810843): [<ffffffffaf14eca3>] del_timer_sync+0xd3/0x150
[   28.933874] ---[ end trace 0000000000000002 ]---

