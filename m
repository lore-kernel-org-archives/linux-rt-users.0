Return-Path: <SRS0=2Uay=D6=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CB0C388F9
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Oct 2020 12:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22A29221F9
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Oct 2020 12:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="IsE65/Cb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S463073AbgJWMHu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 23 Oct 2020 08:07:50 -0400
Received: from mout.gmx.net ([212.227.17.21]:53657 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S463023AbgJWMHu (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 23 Oct 2020 08:07:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1603454834;
        bh=buFmFBI5bWfKQwj2dncf//GIACTmfqOHWf+jzAc/KY8=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=IsE65/CbnLybac4XkZOiWUo1MdBv7s0HUqHKXGAmkfMoqmtvtxDBlu4T71xWv/K3h
         w6sMR50LSKSwFBZj2ZpKQpSVxw8w4PEztpuG14HECPjJePm4KMf9XKFywipXeATcVv
         SdY8d9BJnDLujEhlAezv3IOKNcoX6LtvNPj3MgYg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.simpson.net ([185.221.151.75]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvbG2-1kEfeG2xWg-00scLR; Fri, 23
 Oct 2020 14:07:14 +0200
Message-ID: <e4bf2fe3c5d2fdeded9b3d873a08094dbf145bf9.camel@gmx.de>
Subject: Re: kvm+nouveau induced lockdep  gripe
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Skeggs <bskeggs@redhat.com>, nouveau@lists.freedesktop.org
Date:   Fri, 23 Oct 2020 14:07:13 +0200
In-Reply-To: <20201023090108.5lunh4vqfpkllmap@linutronix.de>
References: <20201021125324.ualpvrxvzyie6d7d@linutronix.de>
         <a23a826af7c108ea5651e73b8fbae5e653f16e86.camel@gmx.de>
         <20201023090108.5lunh4vqfpkllmap@linutronix.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pEyd8jNNKABKe5H+htY5zWV2AedmCWj/EeFT0rpBfxQnmEIm51w
 pgtvMG6c0+DfeRY5CjQ4gH7LWTGY6hQpP6NYWF35ZITlSulKs+S+VWcwDBsnru8CwIAyuD/
 DxtH4myxsPCm4XCSEUwVd28+X+wa/8SddC3Qh77cRX+aCSiCWNluWxRdHW0F2i4GMtAyEJI
 +BiT0AF00/Gz41gs5jnpg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:v0s44Vwf83A=:WCeqBKs1NjGm8raQ20XoeR
 Fyx07JtrpLlpBI8b+Ra7RG9Wu18VabYfIDGCqfj2plqJYW1YY0Eu0q5qZ2BTviY3ZhG0DOyt6
 3qOmw9JMSxFUhh3R32/XG2nn7WN86U3z8PIHbFfEok6S9NqT+YKjGPxgidYr80j1fddHHbBT3
 hBwrPorx7943luDA4+9aNyDW5YjnFacLq1gelxxEm5rO9yNE5j0CIH3Ty7wLUuX1bS2iQrG9X
 C7+n8Y+rhGY1wSQeQWVboCO3yn67SwnGKZeQmLKrXDHuEni4tqBnbC1XAnv4XSWdHLMlsqFrx
 3AJ3uGxx9oqI0wKAqPJi3lDonr/RW9NI4lCOLz6iiZIlbMg9VnXwnDBxmtqUrfv4BTE3/dAWX
 e5p0GaOynb4B++Fymgn6CdqixMd4a8mhI0mGdhybkCNkXGzJfEgsDHoaumtrRNSoq5IfNBwvR
 7sPHWu4BQ67y10S8lhr8l9G1iuvqLviJkoeyU3fuSKHwUMquBKM+JnDnZlhvH4pJFf0IY/LJX
 CJb8/xGXYSTyc2TlRbFSZ6VODLor34Urq/xjYWaw0q0iiHSoQhsVn9l5oc4b7EU/re17hJVCX
 WptJcKDp8NLjKLAhbfVRBzJPjLWDTYZ//BNwg7lt718F5d7G2lEOI8Bfd+0gnOtgl6CdAYJ+1
 UEIXUubo13pktFdFZih3vnORB+wYYPFg3R0G93jCv8LHGo8r5BwJ08R9jQFpHzXqIFUmbzhE4
 0c/M2WluFc4A0Fqf9MBRNVZFkF/pPcO6UAbhW6EQ4YcbXBNAsDfWDp04JWZzUT7Mj7k3S6IuB
 +sxeJlK+o7sYnwpAu4xAWXMgYjI1LktOVqge3Ww5IxApRssRmD5IAVvruVyeGfRYF5SS+tAVA
 qv+4Y985HvS+F6R/ihyA==
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, 2020-10-23 at 11:01 +0200, Sebastian Andrzej Siewior wrote:
> On 2020-10-22 07:28:20 [+0200], Mike Galbraith wrote:
> > I've only as yet seen nouveau lockdep gripage when firing up one of my
> > full distro KVM's.
>
> Could you please check !RT with the `threadirqs' command line option? I
> don't think RT is doing here anything different (except for having
> threaded interrupts enabled by default).

Yup, you are correct, RT is innocent.


[   70.135201] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   70.135206] WARNING: possible circular locking dependency detected
[   70.135211] 5.9.0.gf989335-master #1 Tainted: G            E
[   70.135216] ------------------------------------------------------
[   70.135220] libvirtd/1838 is trying to acquire lock:
[   70.135225] ffff983590c2d5a8 (&mm->mmap_lock#2){++++}-{3:3}, at: mpol_r=
ebind_mm+0x1e/0x50
[   70.135239]
               but task is already holding lock:
[   70.135244] ffffffff8a585410 (&cpuset_rwsem){++++}-{0:0}, at: cpuset_at=
tach+0x38/0x390
[   70.135256]
               which lock already depends on the new lock.

[   70.135261]
               the existing dependency chain (in reverse order) is:
[   70.135266]
               -> #3 (&cpuset_rwsem){++++}-{0:0}:
[   70.135275]        cpuset_read_lock+0x39/0xd0
[   70.135282]        __sched_setscheduler+0x456/0xa90
[   70.135287]        _sched_setscheduler+0x69/0x70
[   70.135292]        __kthread_create_on_node+0x114/0x170
[   70.135297]        kthread_create_on_node+0x37/0x40
[   70.135306]        setup_irq_thread+0x37/0x90
[   70.135312]        __setup_irq+0x4e0/0x7c0
[   70.135318]        request_threaded_irq+0xf8/0x160
[   70.135371]        nvkm_pci_oneinit+0x4c/0x70 [nouveau]
[   70.135399]        nvkm_subdev_init+0x60/0x1e0 [nouveau]
[   70.135449]        nvkm_device_init+0x10b/0x240 [nouveau]
[   70.135506]        nvkm_udevice_init+0x49/0x70 [nouveau]
[   70.135531]        nvkm_object_init+0x3d/0x180 [nouveau]
[   70.135555]        nvkm_ioctl_new+0x1a1/0x260 [nouveau]
[   70.135578]        nvkm_ioctl+0x10a/0x240 [nouveau]
[   70.135600]        nvif_object_ctor+0xeb/0x150 [nouveau]
[   70.135622]        nvif_device_ctor+0x1f/0x60 [nouveau]
[   70.135668]        nouveau_cli_init+0x1ac/0x590 [nouveau]
[   70.135711]        nouveau_drm_device_init+0x68/0x800 [nouveau]
[   70.135753]        nouveau_drm_probe+0xfb/0x200 [nouveau]
[   70.135761]        local_pci_probe+0x42/0x90
[   70.135767]        pci_device_probe+0xe7/0x1a0
[   70.135773]        really_probe+0xf7/0x4d0
[   70.135779]        driver_probe_device+0x5d/0x140
[   70.135785]        device_driver_attach+0x4f/0x60
[   70.135790]        __driver_attach+0xa4/0x140
[   70.135796]        bus_for_each_dev+0x67/0x90
[   70.135801]        bus_add_driver+0x18c/0x230
[   70.135807]        driver_register+0x5b/0xf0
[   70.135813]        do_one_initcall+0x54/0x2f0
[   70.135819]        do_init_module+0x5b/0x21b
[   70.135825]        load_module+0x1e40/0x2370
[   70.135830]        __do_sys_finit_module+0x98/0xe0
[   70.135836]        do_syscall_64+0x33/0x40
[   70.135842]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   70.135847]
               -> #2 (&device->mutex){+.+.}-{3:3}:
[   70.135857]        __mutex_lock+0x90/0x9c0
[   70.135902]        nvkm_udevice_fini+0x23/0x70 [nouveau]
[   70.135927]        nvkm_object_fini+0xb8/0x210 [nouveau]
[   70.135951]        nvkm_object_fini+0x73/0x210 [nouveau]
[   70.135974]        nvkm_ioctl_del+0x7e/0xa0 [nouveau]
[   70.135997]        nvkm_ioctl+0x10a/0x240 [nouveau]
[   70.136019]        nvif_object_dtor+0x4a/0x60 [nouveau]
[   70.136040]        nvif_client_dtor+0xe/0x40 [nouveau]
[   70.136085]        nouveau_cli_fini+0x7a/0x90 [nouveau]
[   70.136128]        nouveau_drm_postclose+0xaa/0xe0 [nouveau]
[   70.136150]        drm_file_free.part.7+0x273/0x2c0 [drm]
[   70.136165]        drm_release+0x6e/0xf0 [drm]
[   70.136171]        __fput+0xb2/0x260
[   70.136177]        task_work_run+0x73/0xc0
[   70.136183]        exit_to_user_mode_prepare+0x1a5/0x1d0
[   70.136189]        syscall_exit_to_user_mode+0x46/0x2a0
[   70.136195]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   70.136200]
               -> #1 (&cli->lock){+.+.}-{3:3}:
[   70.136209]        __mutex_lock+0x90/0x9c0
[   70.136252]        nouveau_mem_fini+0x4c/0x70 [nouveau]
[   70.136294]        nouveau_sgdma_destroy+0x20/0x50 [nouveau]
[   70.136302]        ttm_bo_cleanup_memtype_use+0x3e/0x60 [ttm]
[   70.136310]        ttm_bo_release+0x29c/0x600 [ttm]
[   70.136317]        ttm_bo_vm_close+0x15/0x30 [ttm]
[   70.136324]        remove_vma+0x3e/0x70
[   70.136329]        __do_munmap+0x2b7/0x4f0
[   70.136333]        __vm_munmap+0x5b/0xa0
[   70.136338]        __x64_sys_munmap+0x27/0x30
[   70.136343]        do_syscall_64+0x33/0x40
[   70.136349]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   70.136354]
               -> #0 (&mm->mmap_lock#2){++++}-{3:3}:
[   70.136365]        __lock_acquire+0x149d/0x1a70
[   70.136371]        lock_acquire+0x1a7/0x3b0
[   70.136376]        down_write+0x38/0x70
[   70.136382]        mpol_rebind_mm+0x1e/0x50
[   70.136387]        cpuset_attach+0x229/0x390
[   70.136393]        cgroup_migrate_execute+0x46d/0x490
[   70.136398]        cgroup_attach_task+0x20c/0x3b0
[   70.136404]        __cgroup1_procs_write.constprop.21+0xf3/0x150
[   70.136411]        cgroup_file_write+0x64/0x210
[   70.136416]        kernfs_fop_write+0x117/0x1b0
[   70.136422]        vfs_write+0xe8/0x240
[   70.136427]        ksys_write+0x87/0xc0
[   70.136432]        do_syscall_64+0x33/0x40
[   70.136438]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   70.136443]
               other info that might help us debug this:

[   70.136450] Chain exists of:
                 &mm->mmap_lock#2 --> &device->mutex --> &cpuset_rwsem

[   70.136463]  Possible unsafe locking scenario:

[   70.136469]        CPU0                    CPU1
[   70.136473]        ----                    ----
[   70.136477]   lock(&cpuset_rwsem);
[   70.136483]                                lock(&device->mutex);
[   70.136489]                                lock(&cpuset_rwsem);
[   70.136495]   lock(&mm->mmap_lock#2);
[   70.136501]
                *** DEADLOCK ***

[   70.136508] 6 locks held by libvirtd/1838:
[   70.136512]  #0: ffff98359eb27af0 (&f->f_pos_lock){+.+.}-{3:3}, at: __f=
dget_pos+0x45/0x50
[   70.136524]  #1: ffff983591a58460 (sb_writers#7){.+.+}-{0:0}, at: vfs_w=
rite+0x1aa/0x240
[   70.136535]  #2: ffff9835bbf50488 (&of->mutex){+.+.}-{3:3}, at: kernfs_=
fop_write+0xe2/0x1b0
[   70.136545]  #3: ffffffff8a581848 (cgroup_mutex){+.+.}-{3:3}, at: cgrou=
p_kn_lock_live+0xea/0x1d0
[   70.136556]  #4: ffffffff8a5816b0 (cgroup_threadgroup_rwsem){++++}-{0:0=
}, at: cgroup_procs_write_start+0x6e/0x200
[   70.136567]  #5: ffffffff8a585410 (&cpuset_rwsem){++++}-{0:0}, at: cpus=
et_attach+0x38/0x390
[   70.136579]
               stack backtrace:
[   70.136585] CPU: 2 PID: 1838 Comm: libvirtd Kdump: loaded Tainted: G   =
         E     5.9.0.gf989335-master #1
[   70.136592] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09=
/23/2013
[   70.136598] Call Trace:
[   70.136605]  dump_stack+0x77/0x97
[   70.136611]  check_noncircular+0xe7/0x100
[   70.136618]  ? stack_trace_save+0x3b/0x50
[   70.136626]  ? __lock_acquire+0x149d/0x1a70
[   70.136631]  __lock_acquire+0x149d/0x1a70
[   70.136640]  lock_acquire+0x1a7/0x3b0
[   70.136645]  ? mpol_rebind_mm+0x1e/0x50
[   70.136652]  down_write+0x38/0x70
[   70.136657]  ? mpol_rebind_mm+0x1e/0x50
[   70.136663]  mpol_rebind_mm+0x1e/0x50
[   70.136669]  cpuset_attach+0x229/0x390
[   70.136675]  cgroup_migrate_execute+0x46d/0x490
[   70.136681]  ? _raw_spin_unlock_irq+0x2f/0x50
[   70.136688]  cgroup_attach_task+0x20c/0x3b0
[   70.136702]  ? __cgroup1_procs_write.constprop.21+0xf3/0x150
[   70.136712]  __cgroup1_procs_write.constprop.21+0xf3/0x150
[   70.136722]  cgroup_file_write+0x64/0x210
[   70.136728]  kernfs_fop_write+0x117/0x1b0
[   70.136735]  vfs_write+0xe8/0x240
[   70.136741]  ksys_write+0x87/0xc0
[   70.136746]  ? lockdep_hardirqs_on+0x85/0x110
[   70.136752]  do_syscall_64+0x33/0x40
[   70.136758]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   70.136764] RIP: 0033:0x7efc17533deb
[   70.136770] Code: 53 48 89 d5 48 89 f3 48 83 ec 18 48 89 7c 24 08 e8 5a=
 fd ff ff 48 89 ea 41 89 c0 48 89 de 48 8b 7c 24 08 b8 01 00 00 00 0f 05 <=
48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 90 fd ff ff 48
[   70.136781] RSP: 002b:00007efc0d66b2f0 EFLAGS: 00000293 ORIG_RAX: 00000=
00000000001
[   70.136788] RAX: ffffffffffffffda RBX: 00007efbf80500f0 RCX: 00007efc17=
533deb
[   70.136794] RDX: 0000000000000004 RSI: 00007efbf80500f0 RDI: 0000000000=
00001f
[   70.136799] RBP: 0000000000000004 R08: 0000000000000000 R09: 0000000000=
000000
[   70.136805] R10: 0000000000000000 R11: 0000000000000293 R12: 00007efbf8=
0500f0
[   70.136811] R13: 0000000000000000 R14: 000000000000001f R15: 0000000000=
000214

