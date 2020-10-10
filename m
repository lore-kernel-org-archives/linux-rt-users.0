Return-Path: <SRS0=Wvn+=DR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C251C433E7
	for <linux-rt-users@archiver.kernel.org>; Sat, 10 Oct 2020 04:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0C6F221FD
	for <linux-rt-users@archiver.kernel.org>; Sat, 10 Oct 2020 04:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="eZgRm+IM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbgJJEiS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 10 Oct 2020 00:38:18 -0400
Received: from mout.gmx.net ([212.227.15.15]:32987 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbgJJEhX (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 10 Oct 2020 00:37:23 -0400
X-Greylist: delayed 308 seconds by postgrey-1.27 at vger.kernel.org; Sat, 10 Oct 2020 00:37:21 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602304636;
        bh=KjPtpoxdHfigUXlAPLk4KEVi6vW8xHyllnXJHqmeORs=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date;
        b=eZgRm+IMy+NEF0yDTwbtW0h8Oz1Sbrd1McESbUk24N4BS6EIee+iBZ55cD9MJHJUh
         3PdZZcF9NuQ8opu5qOCFXkhXMM7D5BIOo8qrTNFo+VPyHtQnaJtDxMqEDL1XHj0NHx
         4e43C2cXvA3yFD30689A4/JhovbNvc7RtrN7UpgQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.simpson.net ([185.221.148.188]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N9dwd-1kNgjo424L-015cMA; Sat, 10
 Oct 2020 06:31:58 +0200
Message-ID: <12d6f9879a97cd56c09fb53dee343cbb14f7f1f7.camel@gmx.de>
Subject: [RT] 5.9-rt14  softirq_ctrl.lock vs listening_hash[i].lock  lockdep
 splat
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     tglx@linutronix.de, linux-rt-users@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Date:   Sat, 10 Oct 2020 06:31:57 +0200
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:spdwCzTNc3K+Tm4UjBkxphiVjf5KtlJ7RXuXPzyOw4JhRi3IqEI
 Z94Z4d0ODTwh4r/+S8YcXEC+02p7qipwzcAMHJca5HyIuNptnhGbv4OLeka7IAO+vdf7ZsE
 FEXkUywY14JVy969AQD++uPwgvA2RqEQXXiZ0XKchM3Uvn5tPMDttyGWP4NhfiW6mlFo+PE
 m0e10SkkjVSVnrslCxo/w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pGUzvSXId2c=:qo4DyeqydizTmRzbUxjmZ/
 lmSkBJs2OgW7M83m62DV7Q20gtkOmrnXTVQ2zryKq6/PCecqUdXFby9eT/6pqCWx8VCFT9v1v
 xC3fFSVPZNvgyIsUBagvRGi9qR3Zj24umaGPGh6OBXHecu5E/5F9ueEnjQF4bvqLCI4yA0NOj
 rZ4mE3/ix4u8M+hm+RAgkq0q/7AyM2vKvVadbpBivQQnFCS2bsZtAsZGbVwO8U0uYpgHmXjST
 Di954r5nl0sUY00X8JUhwH/3Ul+XuCA4taJHM10C+oeAByTbOebDu8z/ZRhIZg+LPt1YOGbQi
 DMrE2CMeZ2xG3j4sJ8IiUhZtoLbBJD/xt+srXpGi6FxZfJrHa2iXl8ED1su0CCbkSDseI7Vgq
 7ZXFPjzZcHPz+BYJm9iwrZDjkgAKgAU5fxFuiQhI6J7p8Pfkqb0rdh2HXsdiiBQTeRQQA8iC2
 Zo63AvvEcqWcBf0R7pOjGJocXgk4fRvrONusnStDrUzW/HpPtD1s4HOWabQBxw+vbsuIo6FD1
 QRNO4ybuvdzPEkqKyGXKg1FmL0o296iOrSwfrUA+N2wFXFc7DvBLH7vfk7j9ji1JNJPe1bE83
 0GJw/ZPp6yorRnDif8ni6cSQsASQh4Jqx5RhTduczZcN5l2uNYlO1dS5dHIuOHp68zFxub5Aa
 VwGVEp8YlDRKJ7TbLoCqT7UOUHgb50qj21HXtOn0WswkiHRL7h6k8QknJfgT7+MptntCYC6bM
 CROzXPB6oLzVhFsl+x6TlKU8nAc3fQ8MG4deBXDsgmJYJPyom3F1vy6xMeuGhq17O3P4HBXSo
 SkiJ9WNTfXsFkYZ+yuaMm+hVae38cJOd2OoV1QbxV0o0LXMwP0mMvB0sCsIFon0bYdRH08QCe
 v0xg9wAulbq6QSNUeNjN+hZ1HqAowzxQUN+Y08B3VJNeLqEeyrVRSjQdBuVoGEAbKkGGmH81V
 uXQklc5fLKXvni/6vdRUZ5vqsvd013XApYZWc9Bp2xZhk7uvffjVj3HWlnSfvrRVCMSJdAH/B
 EeC10dr+zBoDgMkidcL9aZFFnfDLwVphdqQ7JBjZbeZ2Vp/AwW/yraLqikQW6TTDXZ+yLY/9r
 yVazeeCF7sOkdAHXYDvez2Z2eF0HCmbSLCcEKWM6uO0USMtP218OE2MoSJMjLhHq3epruRqDP
 Lcu/NmTrkBGlM3R4w8+gpjqepTiGA4S5BvsfyI5rH7hAzTtJO8Sp1S2rTdt8sLGNwerO4HRWz
 mO22l2rnVOJevnavc
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


[   47.844511] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   47.844511] WARNING: possible circular locking dependency detected
[   47.844512] 5.9.0.gc85fb28-rt14-rt #1 Tainted: G            E
[   47.844513] ------------------------------------------------------
[   47.844514] perl/2751 is trying to acquire lock:
[   47.844515] ffff92cadec5a410 ((softirq_ctrl.lock).lock){+.+.}-{2:2}, at=
: __local_bh_disable_ip+0x127/0x2c0
[   47.844521]
               but task is already holding lock:
[   47.844522] ffffffffa8871468 (&h->listening_hash[i].lock){+.+.}-{0:0}, =
at: listening_get_next.isra.41+0xd7/0x130
[   47.844528]
               which lock already depends on the new lock.

[   47.844528]
               the existing dependency chain (in reverse order) is:
[   47.844529]
               -> #1 (&h->listening_hash[i].lock){+.+.}-{0:0}:
[   47.844532]        rt_spin_lock+0x2b/0xc0
[   47.844536]        __inet_hash+0x68/0x320
[   47.844539]        inet_hash+0x31/0x60
[   47.844541]        inet_csk_listen_start+0xaf/0xe0
[   47.844543]        inet_listen+0x86/0x150
[   47.844546]        __sys_listen+0x58/0x80
[   47.844548]        __x64_sys_listen+0x12/0x20
[   47.844549]        do_syscall_64+0x33/0x40
[   47.844552]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   47.844555]
               -> #0 ((softirq_ctrl.lock).lock){+.+.}-{2:2}:
[   47.844557]        __lock_acquire+0x1343/0x1890
[   47.844560]        lock_acquire+0x92/0x410
[   47.844562]        rt_spin_lock+0x2b/0xc0
[   47.844564]        __local_bh_disable_ip+0x127/0x2c0
[   47.844566]        sock_i_ino+0x22/0x60
[   47.844569]        tcp4_seq_show+0x14f/0x420
[   47.844571]        seq_read+0x27c/0x420
[   47.844574]        proc_reg_read+0x5c/0x80
[   47.844576]        vfs_read+0xd1/0x1d0
[   47.844580]        ksys_read+0x87/0xc0
[   47.844581]        do_syscall_64+0x33/0x40
[   47.844583]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   47.844585]
               other info that might help us debug this:

[   47.844585]  Possible unsafe locking scenario:

[   47.844586]        CPU0                    CPU1
[   47.844586]        ----                    ----
[   47.844587]   lock(&h->listening_hash[i].lock);
[   47.844588]                                lock((softirq_ctrl.lock).loc=
k);
[   47.844588]                                lock(&h->listening_hash[i].l=
ock);
[   47.844589]   lock((softirq_ctrl.lock).lock);
[   47.844590]
                *** DEADLOCK ***

[   47.844590] 3 locks held by perl/2751:
[   47.844591]  #0: ffff92ca6525a4e0 (&p->lock){+.+.}-{0:0}, at: seq_read+=
0x37/0x420
[   47.844594]  #1: ffffffffa8871468 (&h->listening_hash[i].lock){+.+.}-{0=
:0}, at: listening_get_next.isra.41+0xd7/0x130
[   47.844597]  #2: ffffffffa74b90e0 (rcu_read_lock){....}-{1:2}, at: rt_s=
pin_lock+0x5/0xc0
[   47.844600]
               stack backtrace:
[   47.844601] CPU: 1 PID: 2751 Comm: perl Kdump: loaded Tainted: G       =
     E     5.9.0.gc85fb28-rt14-rt #1
[   47.844603] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09=
/23/2013
[   47.844604] Call Trace:
[   47.844606]  dump_stack+0x77/0x9b
[   47.844611]  check_noncircular+0x148/0x160
[   47.844616]  ? __lock_acquire+0x1343/0x1890
[   47.844617]  __lock_acquire+0x1343/0x1890
[   47.844621]  lock_acquire+0x92/0x410
[   47.844623]  ? __local_bh_disable_ip+0x127/0x2c0
[   47.844626]  ? sock_i_ino+0x5/0x60
[   47.844628]  rt_spin_lock+0x2b/0xc0
[   47.844630]  ? __local_bh_disable_ip+0x127/0x2c0
[   47.844631]  __local_bh_disable_ip+0x127/0x2c0
[   47.844634]  sock_i_ino+0x22/0x60
[   47.844635]  tcp4_seq_show+0x14f/0x420
[   47.844640]  seq_read+0x27c/0x420
[   47.844643]  proc_reg_read+0x5c/0x80
[   47.844645]  vfs_read+0xd1/0x1d0
[   47.844648]  ksys_read+0x87/0xc0
[   47.844649]  ? lockdep_hardirqs_on+0x78/0x100
[   47.844652]  do_syscall_64+0x33/0x40
[   47.844654]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   47.844656] RIP: 0033:0x7fb3f3c23e51
[   47.844658] Code: 7d 81 20 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb ba=
 0f 1f 80 00 00 00 00 8b 05 1a c3 20 00 48 63 ff 85 c0 75 13 31 c0 0f 05 <=
48> 3d 00 f0 ff ff 77 57 f3 c3 0f 1f 44 00 00 55 53 48 89 d5 48 89
[   47.844660] RSP: 002b:00007ffd7604f108 EFLAGS: 00000246 ORIG_RAX: 00000=
00000000000
[   47.844661] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fb3f3=
c23e51
[   47.844662] RDX: 0000000000002000 RSI: 000055dbff4da600 RDI: 0000000000=
000003
[   47.844662] RBP: 0000000000002000 R08: 000055dbff4d9290 R09: 000055dbff=
4da600
[   47.844663] R10: ffffffffffffffb0 R11: 0000000000000246 R12: 000055dbff=
4da600
[   47.844664] R13: 000055dbff4ae260 R14: 000055dbff4d92c0 R15: 0000000000=
000003

