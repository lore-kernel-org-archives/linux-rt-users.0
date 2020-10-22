Return-Path: <SRS0=0dn7=D5=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B83C388F7
	for <linux-rt-users@archiver.kernel.org>; Thu, 22 Oct 2020 05:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 528B92225F
	for <linux-rt-users@archiver.kernel.org>; Thu, 22 Oct 2020 05:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="CazcULwK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507949AbgJVF3B (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 22 Oct 2020 01:29:01 -0400
Received: from mout.gmx.net ([212.227.15.15]:51791 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394725AbgJVF3B (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 22 Oct 2020 01:29:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1603344501;
        bh=qI7QGHZYwIcy1kCD0RSXuGT1f/0AELxLnDOZMG+f9S8=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=CazcULwKde+lsLDpxMX167ALI3SIHVqiUk6SArREsGQnsucqPQEASgqspQeHNDAlj
         4GccfDxV0Ssgx4xcRF9VSgnG9tHLB4kJizhrld4p/n5RnjIoGhQIyCRtNLdx2pnfty
         O1J+7CHZy3UrZCLEe23eH74CYP5M8CwD7Cyl/8LI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.simpson.net ([185.221.150.153]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MnJhO-1k6Lar18lg-00jL18; Thu, 22
 Oct 2020 07:28:21 +0200
Message-ID: <a23a826af7c108ea5651e73b8fbae5e653f16e86.camel@gmx.de>
Subject: kvm+nouveau induced lockdep  gripe
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Thu, 22 Oct 2020 07:28:20 +0200
In-Reply-To: <20201021125324.ualpvrxvzyie6d7d@linutronix.de>
References: <20201021125324.ualpvrxvzyie6d7d@linutronix.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+R8iwycAOTDLDGTMRDUknFryNI0UFfIXVi/Zt6EJkAJ4X4kVVJu
 GGFKBM1Ys5rCNrRhMNQQbKT8g8+GHnHfKIwplGYUM7IJT+DtMHrjyIlWapqeagH4sRN+A2j
 6oso2n7vVvJRDZLeaheYA1vWYOSjgZaZCQak7BuXY8iAPhY2MQ1FOduD8SSemLZA27UJID/
 IiPBJFRA7XBnCd0BJ/7og==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ijroPbr0mV8=:DaF9nfM9RLBXrzYgK04+Th
 UQzzJ5xTB7/gal0caJpVseh4zLrCPfVtVnwtzHZ3juRKVZVDnMBrFP/sDb1PuYFKW7xtVx4GJ
 bqjkjhLG024te4aq65EkWUtjgoH0r/PceMYjnPCTbdAUebXOkaaNc/YiiVNqDsTziCybSLIIF
 Um2+RdYVw7f2LtdRFih4uiXd8MNBSEykWfPiIjSB0i14jmrw/xF4188O5sdNTKXjKJuPTUKJQ
 1L0YrWKAkNx7sB61qMv6kR3qya+Kj/CS5P/rUeWdS6AL4DDIvqL/NGFW5F/NcpByoi+NhO5U6
 4nB4RsrSMLl+76PT5lj8UhvhOy22Y5cZKCMAFRlLBR+KAJsTJOyrAFM6/uUMN+kLntZ2yW6Ie
 /dJaDy4hXpBJWH03dalrEdzScIESl9sAoUxDVLer/GQdLgKW4FRP9KEuQwDj4oQ8H7+IdLBCe
 HbR2OJRBWc8FFLFCEPw7XTEmUkjbsIMNhw41OV9lsJ/9l3CQrEUnJ6AyQdAsTsy/KjJFiG065
 K7ux9WAOpCTKbLTuz0GJEcgoExLtlYYWDkR7xKCbmRthlZTIJJK4k5fH3i8MoP07tuvcqyUoz
 6d4kc9+voK2O46aW7ht2ypRKiXHuwbzQXOgqkRqUvNH56L0+Bfq9mXnKEyZPRknRxJq1tmlt3
 QN84ytaKXi3icJrHH24sFMbmyiTphmSK/+FRC+Kwe2JzIlZVPvPgkoaGbAEkz0IPXYpqxoTAS
 J0n+Lsd/tRKpuOk3sQC/jcQEAG1IgtO6lxA61OQix04ymLIbsdlqVd0VYoCqWJMiW15FCdRU7
 Lrocypw45jEwmcRbuTqshjWwlYccs8YDkp45qJLa/i4ZN73agOkbaLeEd8AKeU3fh1zTVHMsn
 7z7y+t8RZoqu2Qu0Ucow==
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

I've only as yet seen nouveau lockdep gripage when firing up one of my
full distro KVM's.

[   91.655613] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   91.655614] WARNING: possible circular locking dependency detected
[   91.655614] 5.9.1-rt18-rt #5 Tainted: G S          E
[   91.655615] ------------------------------------------------------
[   91.655615] libvirtd/1868 is trying to acquire lock:
[   91.655616] ffff918554b801c0 (&mm->mmap_lock#2){++++}-{0:0}, at: mpol_r=
ebind_mm+0x1e/0x50
[   91.655622]
               but task is already holding lock:
[   91.655622] ffffffff995b6c80 (&cpuset_rwsem){++++}-{0:0}, at: cpuset_at=
tach+0x38/0x390
[   91.655625]
               which lock already depends on the new lock.

[   91.655625]
               the existing dependency chain (in reverse order) is:
[   91.655625]
               -> #3 (&cpuset_rwsem){++++}-{0:0}:
[   91.655626]        lock_acquire+0x92/0x410
[   91.655629]        cpuset_read_lock+0x39/0xf0
[   91.655630]        __sched_setscheduler+0x4be/0xaf0
[   91.655632]        _sched_setscheduler+0x69/0x70
[   91.655633]        __kthread_create_on_node+0x114/0x170
[   91.655634]        kthread_create_on_node+0x37/0x40
[   91.655635]        setup_irq_thread+0x37/0x90
[   91.655637]        __setup_irq+0x4de/0x7b0
[   91.655637]        request_threaded_irq+0xf8/0x160
[   91.655638]        nvkm_pci_oneinit+0x4c/0x70 [nouveau]
[   91.655674]        nvkm_subdev_init+0x60/0x1e0 [nouveau]
[   91.655689]        nvkm_device_init+0x10b/0x240 [nouveau]
[   91.655716]        nvkm_udevice_init+0x47/0x70 [nouveau]
[   91.655742]        nvkm_object_init+0x3d/0x180 [nouveau]
[   91.655755]        nvkm_ioctl_new+0x1a1/0x260 [nouveau]
[   91.655768]        nvkm_ioctl+0x10a/0x240 [nouveau]
[   91.655779]        nvif_object_ctor+0xeb/0x150 [nouveau]
[   91.655790]        nvif_device_ctor+0x1f/0x60 [nouveau]
[   91.655801]        nouveau_cli_init+0x1dc/0x5c0 [nouveau]
[   91.655826]        nouveau_drm_device_init+0x66/0x810 [nouveau]
[   91.655850]        nouveau_drm_probe+0xfb/0x200 [nouveau]
[   91.655873]        local_pci_probe+0x42/0x90
[   91.655875]        pci_device_probe+0xe7/0x1a0
[   91.655876]        really_probe+0xf7/0x4d0
[   91.655877]        driver_probe_device+0x5d/0x140
[   91.655878]        device_driver_attach+0x4f/0x60
[   91.655879]        __driver_attach+0xa2/0x140
[   91.655880]        bus_for_each_dev+0x67/0x90
[   91.655881]        bus_add_driver+0x192/0x230
[   91.655882]        driver_register+0x5b/0xf0
[   91.655883]        do_one_initcall+0x56/0x3c4
[   91.655884]        do_init_module+0x5b/0x21c
[   91.655886]        load_module+0x1cc7/0x2430
[   91.655887]        __do_sys_finit_module+0xa7/0xe0
[   91.655888]        do_syscall_64+0x33/0x40
[   91.655889]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   91.655890]
               -> #2 (&device->mutex){+.+.}-{0:0}:
[   91.655891]        lock_acquire+0x92/0x410
[   91.655893]        _mutex_lock+0x28/0x40
[   91.655895]        nvkm_udevice_fini+0x21/0x70 [nouveau]
[   91.655919]        nvkm_object_fini+0xb8/0x210 [nouveau]
[   91.655931]        nvkm_object_fini+0x73/0x210 [nouveau]
[   91.655943]        nvkm_ioctl_del+0x7e/0xa0 [nouveau]
[   91.655954]        nvkm_ioctl+0x10a/0x240 [nouveau]
[   91.655966]        nvif_object_dtor+0x4a/0x60 [nouveau]
[   91.655976]        nvif_client_dtor+0xe/0x40 [nouveau]
[   91.655986]        nouveau_cli_fini+0x78/0x90 [nouveau]
[   91.656010]        nouveau_drm_postclose+0xa6/0xe0 [nouveau]
[   91.656033]        drm_file_free.part.9+0x27e/0x2d0 [drm]
[   91.656045]        drm_release+0x6f/0xf0 [drm]
[   91.656052]        __fput+0xb2/0x260
[   91.656053]        task_work_run+0x73/0xc0
[   91.656055]        exit_to_user_mode_prepare+0x204/0x230
[   91.656056]        syscall_exit_to_user_mode+0x4a/0x330
[   91.656057]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   91.656058]
               -> #1 (&cli->lock){+.+.}-{0:0}:
[   91.656059]        lock_acquire+0x92/0x410
[   91.656060]        _mutex_lock+0x28/0x40
[   91.656061]        nouveau_mem_fini+0x4a/0x70 [nouveau]
[   91.656086]        ttm_tt_destroy+0x22/0x70 [ttm]
[   91.656089]        ttm_bo_cleanup_memtype_use+0x32/0xa0 [ttm]
[   91.656091]        ttm_bo_put+0xe7/0x670 [ttm]
[   91.656093]        ttm_bo_vm_close+0x15/0x30 [ttm]
[   91.656096]        remove_vma+0x3e/0x70
[   91.656097]        __do_munmap+0x2b7/0x4f0
[   91.656098]        __vm_munmap+0x5b/0xa0
[   91.656098]        __x64_sys_munmap+0x27/0x30
[   91.656099]        do_syscall_64+0x33/0x40
[   91.656100]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   91.656100]
               -> #0 (&mm->mmap_lock#2){++++}-{0:0}:
[   91.656102]        validate_chain+0x981/0x1250
[   91.656103]        __lock_acquire+0x86f/0xbd0
[   91.656104]        lock_acquire+0x92/0x410
[   91.656105]        down_write+0x3b/0x50
[   91.656106]        mpol_rebind_mm+0x1e/0x50
[   91.656108]        cpuset_attach+0x229/0x390
[   91.656109]        cgroup_migrate_execute+0x46d/0x490
[   91.656111]        cgroup_attach_task+0x20c/0x430
[   91.656112]        __cgroup1_procs_write.constprop.21+0xf3/0x150
[   91.656113]        cgroup_file_write+0x7e/0x1a0
[   91.656114]        kernfs_fop_write+0x113/0x1b0
[   91.656116]        vfs_write+0xf0/0x230
[   91.656116]        ksys_write+0x87/0xc0
[   91.656117]        do_syscall_64+0x33/0x40
[   91.656118]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   91.656118]
               other info that might help us debug this:

[   91.656119] Chain exists of:
                 &mm->mmap_lock#2 --> &device->mutex --> &cpuset_rwsem

[   91.656120]  Possible unsafe locking scenario:

[   91.656120]        CPU0                    CPU1
[   91.656120]        ----                    ----
[   91.656121]   lock(&cpuset_rwsem);
[   91.656121]                                lock(&device->mutex);
[   91.656122]                                lock(&cpuset_rwsem);
[   91.656122]   lock(&mm->mmap_lock#2);
[   91.656123]
                *** DEADLOCK ***

[   91.656123] 6 locks held by libvirtd/1868:
[   91.656124]  #0: ffff9186df6f5f88 (&f->f_pos_lock){+.+.}-{0:0}, at: __f=
dget_pos+0x46/0x50
[   91.656127]  #1: ffff918553b695f8 (sb_writers#7){.+.+}-{0:0}, at: vfs_w=
rite+0x1c1/0x230
[   91.656128]  #2: ffff91873fb950a8 (&of->mutex){+.+.}-{0:0}, at: kernfs_=
fop_write+0xde/0x1b0
[   91.656130]  #3: ffffffff995b2cc8 (cgroup_mutex){+.+.}-{3:3}, at: cgrou=
p_kn_lock_live+0xe8/0x1d0
[   91.656133]  #4: ffffffff995b2900 (cgroup_threadgroup_rwsem){++++}-{0:0=
}, at: cgroup_procs_write_start+0x6e/0x200
[   91.656135]  #5: ffffffff995b6c80 (&cpuset_rwsem){++++}-{0:0}, at: cpus=
et_attach+0x38/0x390
[   91.656137]
               stack backtrace:
[   91.656137] CPU: 6 PID: 1868 Comm: libvirtd Kdump: loaded Tainted: G S =
         E     5.9.1-rt18-rt #5
[   91.656138] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09=
/23/2013
[   91.656139] Call Trace:
[   91.656141]  dump_stack+0x77/0x9b
[   91.656143]  check_noncircular+0x148/0x160
[   91.656144]  ? validate_chain+0x9d6/0x1250
[   91.656146]  ? validate_chain+0x981/0x1250
[   91.656147]  validate_chain+0x981/0x1250
[   91.656150]  __lock_acquire+0x86f/0xbd0
[   91.656151]  lock_acquire+0x92/0x410
[   91.656152]  ? mpol_rebind_mm+0x1e/0x50
[   91.656155]  down_write+0x3b/0x50
[   91.656156]  ? mpol_rebind_mm+0x1e/0x50
[   91.656157]  mpol_rebind_mm+0x1e/0x50
[   91.656158]  cpuset_attach+0x229/0x390
[   91.656160]  cgroup_migrate_execute+0x46d/0x490
[   91.656162]  cgroup_attach_task+0x20c/0x430
[   91.656165]  ? __cgroup1_procs_write.constprop.21+0xf3/0x150
[   91.656166]  __cgroup1_procs_write.constprop.21+0xf3/0x150
[   91.656168]  cgroup_file_write+0x7e/0x1a0
[   91.656169]  kernfs_fop_write+0x113/0x1b0
[   91.656171]  vfs_write+0xf0/0x230
[   91.656172]  ksys_write+0x87/0xc0
[   91.656173]  ? lockdep_hardirqs_on+0x78/0x100
[   91.656174]  do_syscall_64+0x33/0x40
[   91.656175]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   91.656176] RIP: 0033:0x7fbfe3bc0deb
[   91.656178] Code: 53 48 89 d5 48 89 f3 48 83 ec 18 48 89 7c 24 08 e8 5a=
 fd ff ff 48 89 ea 41 89 c0 48 89 de 48 8b 7c 24 08 b8 01 00 00 00 0f 05 <=
48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 90 fd ff ff 48
[   91.656179] RSP: 002b:00007fbfd94f72f0 EFLAGS: 00000293 ORIG_RAX: 00000=
00000000001
[   91.656179] RAX: ffffffffffffffda RBX: 00007fbfc8048b20 RCX: 00007fbfe3=
bc0deb
[   91.656180] RDX: 0000000000000004 RSI: 00007fbfc8048b20 RDI: 0000000000=
00001f
[   91.656180] RBP: 0000000000000004 R08: 0000000000000000 R09: 0000000000=
000000
[   91.656181] R10: 0000000000000000 R11: 0000000000000293 R12: 00007fbfc8=
048b20
[   91.656181] R13: 0000000000000000 R14: 000000000000001f R15: 0000000000=
000214

