Return-Path: <SRS0=5J30=EC=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F19C55178
	for <linux-rt-users@archiver.kernel.org>; Tue, 27 Oct 2020 11:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 992FC22263
	for <linux-rt-users@archiver.kernel.org>; Tue, 27 Oct 2020 11:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="cWNWTDzA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437310AbgJ0LNz (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 27 Oct 2020 07:13:55 -0400
Received: from mout.gmx.net ([212.227.15.19]:44653 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409846AbgJ0LNy (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 27 Oct 2020 07:13:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1603797189;
        bh=Dg1k11LVrI3r6tD+nfehNonuyN1gzgf6FzsXpH6ZekY=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=cWNWTDzAYdAEdLxn9MYSAf905XLJzZsy52f553+FLLsajVqT9pAd8XsySzdscA/6A
         4Gh6BcTty+wQSiO0PC3rEUJtaKhW4QZnraaOTfwcy7o88PdD31atC8BxGG1kBCeblj
         Ey71v/6bZitiy1mrf2Aocpq/T/0HjUnG/dJm6Wuk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.simpson.net ([185.146.51.69]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MuDc7-1kFAEq1YQ1-00uWEo; Tue, 27
 Oct 2020 12:13:09 +0100
Message-ID: <f7e43b369c7d168c2ff04bfd91dfdf3afd0da12c.camel@gmx.de>
Subject: Re: kvm+nouveau induced lockdep  gripe
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Hillf Danton <hdanton@sina.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Skeggs <bskeggs@redhat.com>
Date:   Tue, 27 Oct 2020 12:13:07 +0100
In-Reply-To: <20201027101810.pk5liej6xmbjcwem@linutronix.de>
References: <a23a826af7c108ea5651e73b8fbae5e653f16e86.camel@gmx.de>
         <20201023090108.5lunh4vqfpkllmap@linutronix.de>
         <20201024022236.19608-1-hdanton@sina.com>
         <20201024050000.8104-1-hdanton@sina.com>
         <20201026173107.quylcy6fgjvrqat6@linutronix.de>
         <431e81699f2310eabfe5af0a3de400ab99d9323b.camel@gmx.de>
         <20201026195308.wsbk7xy57wuzfbao@linutronix.de>
         <0dfae65db2f0d3ef603c1db34f37cee63f7f41f4.camel@gmx.de>
         <20201027090019.3vteojm43ljqqe33@linutronix.de>
         <7bbfce68bdd01e1d48d3d2c6f9581654e380bf2d.camel@gmx.de>
         <20201027101810.pk5liej6xmbjcwem@linutronix.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EgtfpgNLhLAKOtdPiU64AusRwNUKK2azEus2BXlWmVcE3uEiFWd
 R0+MMKsWMAQc0hdLFlBQFxSAmlKtuN8eGZC+94bStLGaiIW4yHP0MvpvC7IC0n5h5XSfm2j
 FLY/4tFFEg5DFuKSoU0CJMeNyn3IonHWBSlQnZPP6uwGeYL+W401LL0Id2u45mIP/pPXyC6
 34oJEv7L8/vCgujv09fIQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:j/wZPPw4AcA=:/5xTyN9tvRU8EUECqB2Luf
 woRoSZ+BKLFbqOTFeX/w9wJLH7y2bvDJSF2MAVjSu/4neOnCy3WSP/xf8LSdbkWNVpX0qsjre
 34MCnV05r5dltz/MQog6hJ5gH9i+4bgy9vLBbKK0qvj/cO7ANR/Fltsc7ya/anBC7kV8/eNDD
 at8Asm5pjv2y5fIR9+MjAvax7ysLKpxmEgciZ7FL73qJ7w0Fm5CVNUV00xyhkRvi0gX0jhXD4
 icebHpMtNUTu239+/6VKvWJKmjnXKAB906o/fIiuxmj29EPvKmicOUJ2RrIy32lach91XObHz
 f3mYZi+fMbsC52fTllRNEBGht/T7E/jk41EyBcbtG4Q58gV85E1TmEAljctCcPKLL26P0ZOPD
 wpLb3SB7N5DOT/FBH6gbwxEwisnVSw4UHxLxZX18Yr/KROu6ePibnIpoddfTg7EM0Kqv9IgRx
 mO8tHr+bkszoQE7YOfQ4rTpCZMfMD+hgzBtWijFba+3b0nTGaiC4uBudS5OZ20UKSeW2DqbcV
 YTVKsP93cjNnaP9XtgVAkitJRr+zBY2sDyb8zJ2PYvdVFnPhzikboH6U4pi+AB/gHvkUrek9I
 p7bxWlxnHCUmrLbCUEM7zJmtNvDu60rhdUlpf9I7O2L92tuCijjMf+uNgGdN+ycY7Bf1SypFC
 0NfTMIlPekXSZu3IEBwRI9VmLuXi57eRleFANTFZrSjtqqOOQ8YBKMO2im2L9lMve1eTXsgnI
 NvysJUCOX+9e3cfIBnhs4Q2lYBRRMOD1V0CO7J+nTiBJ9lsP3ZhnCT36ORMP01xfaGTYWdtj9
 Tl5/4GG4wibg/g3A9mt6ZA1MCMSwKMYYzj5Y3LZ/jWOsRpN0jIUFg966YTEvK6Oz3O7woi9Lx
 bYp2/fUcSBjmQg9ajmzA==
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 2020-10-27 at 11:18 +0100, Sebastian Andrzej Siewior wrote:
> On 2020-10-27 11:14:34 [+0100], Mike Galbraith wrote:
> > On Tue, 2020-10-27 at 10:00 +0100, Sebastian Andrzej Siewior wrote:
> > > Let me try if I can figure out when this broke.
> >
> > My money is on...
> > 710da3c8ea7df (Juri Lelli 2019-07-19 16:00:00 +0200 5317)       if (pi=
)
> > 710da3c8ea7df (Juri Lelli 2019-07-19 16:00:00 +0200 5318)             =
  cpuset_read_lock();
> > ...having just had an unnoticed consequence for nouveau.
>
> but that is over a year old and should be noticed in v5.4-RT.

Yup.  Dang lazy sod nouveau users haven't been doing their broad
spectrum RT or threadirqs testing.  This one hasn't anyway ;-)

[   73.087508] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   73.087508] WARNING: possible circular locking dependency detected
[   73.087509] 5.4.72-rt40-rt #1 Tainted: G            E
[   73.087510] ------------------------------------------------------
[   73.087510] libvirtd/1902 is trying to acquire lock:
[   73.087511] ffff8b0f54b2f8d8 (&mm->mmap_sem#2){++++}, at: mpol_rebind_m=
m+0x1e/0x50
[   73.087517]
               but task is already holding lock:
[   73.087518] ffffffff9d2a0430 (&cpuset_rwsem){++++}, at: cpuset_attach+0=
x38/0x390
[   73.087520]
               which lock already depends on the new lock.

[   73.087521]
               the existing dependency chain (in reverse order) is:
[   73.087521]
               -> #3 (&cpuset_rwsem){++++}:
[   73.087523]        cpuset_read_lock+0x39/0x100
[   73.087524]        __sched_setscheduler+0x476/0xb00
[   73.087526]        _sched_setscheduler+0x69/0x70
[   73.087527]        __kthread_create_on_node+0x122/0x180
[   73.087531]        kthread_create_on_node+0x37/0x40
[   73.087532]        setup_irq_thread+0x3c/0xa0
[   73.087533]        __setup_irq+0x4c3/0x760
[   73.087535]        request_threaded_irq+0xf8/0x160
[   73.087535]        nvkm_pci_oneinit+0x4c/0x70 [nouveau]
[   73.087569]        nvkm_subdev_init+0x60/0x1e0 [nouveau]
[   73.087586]        nvkm_device_init+0x10b/0x240 [nouveau]
[   73.087611]        nvkm_udevice_init+0x47/0x70 [nouveau]
[   73.087636]        nvkm_object_init+0x3d/0x180 [nouveau]
[   73.087652]        nvkm_ioctl_new+0x1a1/0x260 [nouveau]
[   73.087667]        nvkm_ioctl+0x10a/0x240 [nouveau]
[   73.087682]        nvif_object_init+0xbf/0x110 [nouveau]
[   73.087697]        nvif_device_init+0xe/0x50 [nouveau]
[   73.087713]        nouveau_cli_init+0x1ce/0x5a0 [nouveau]
[   73.087739]        nouveau_drm_device_init+0x54/0x7e0 [nouveau]
[   73.087765]        nouveau_drm_probe+0x1da/0x330 [nouveau]
[   73.087791]        local_pci_probe+0x42/0x90
[   73.087793]        pci_device_probe+0xe7/0x1a0
[   73.087794]        really_probe+0xf7/0x460
[   73.087796]        driver_probe_device+0x5d/0x130
[   73.087797]        device_driver_attach+0x4f/0x60
[   73.087798]        __driver_attach+0xa2/0x140
[   73.087798]        bus_for_each_dev+0x67/0x90
[   73.087800]        bus_add_driver+0x192/0x230
[   73.087801]        driver_register+0x5b/0xf0
[   73.087801]        do_one_initcall+0x56/0x3c4
[   73.087803]        do_init_module+0x5b/0x21d
[   73.087805]        load_module+0x1cd4/0x2340
[   73.087806]        __do_sys_finit_module+0xa7/0xe0
[   73.087807]        do_syscall_64+0x6c/0x270
[   73.087808]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   73.087810]
               -> #2 (&device->mutex){+.+.}:
[   73.087811]        _mutex_lock+0x28/0x40
[   73.087813]        nvkm_udevice_fini+0x21/0x70 [nouveau]
[   73.087839]        nvkm_object_fini+0xb8/0x210 [nouveau]
[   73.087854]        nvkm_object_fini+0x73/0x210 [nouveau]
[   73.087869]        nvkm_ioctl_del+0x7e/0xa0 [nouveau]
[   73.087884]        nvkm_ioctl+0x10a/0x240 [nouveau]
[   73.087898]        nvif_object_fini+0x49/0x60 [nouveau]
[   73.087914]        nvif_client_fini+0xe/0x40 [nouveau]
[   73.087930]        nouveau_cli_fini+0x78/0x90 [nouveau]
[   73.087955]        nouveau_drm_postclose+0xa3/0xd0 [nouveau]
[   73.087981]        drm_file_free.part.5+0x20c/0x2c0 [drm]
[   73.087991]        drm_release+0x4b/0x80 [drm]
[   73.087997]        __fput+0xd5/0x280
[   73.087999]        task_work_run+0x87/0xb0
[   73.088001]        exit_to_usermode_loop+0x13b/0x160
[   73.088002]        do_syscall_64+0x1be/0x270
[   73.088003]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   73.088004]
               -> #1 (&cli->lock){+.+.}:
[   73.088006]        _mutex_lock+0x28/0x40
[   73.088007]        nouveau_mem_fini+0x4a/0x70 [nouveau]
[   73.088033]        nv04_sgdma_unbind+0xe/0x20 [nouveau]
[   73.088058]        ttm_tt_unbind+0x1d/0x30 [ttm]
[   73.088061]        ttm_tt_destroy+0x13/0x60 [ttm]
[   73.088063]        ttm_bo_cleanup_memtype_use+0x32/0x80 [ttm]
[   73.088066]        ttm_bo_release+0x264/0x460 [ttm]
[   73.088068]        ttm_bo_vm_close+0x15/0x30 [ttm]
[   73.088070]        remove_vma+0x3e/0x70
[   73.088072]        __do_munmap+0x2d7/0x510
[   73.088073]        __vm_munmap+0x5b/0xa0
[   73.088074]        __x64_sys_munmap+0x27/0x30
[   73.088075]        do_syscall_64+0x6c/0x270
[   73.088076]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   73.088077]
               -> #0 (&mm->mmap_sem#2){++++}:
[   73.088078]        __lock_acquire+0x113f/0x1410
[   73.088080]        lock_acquire+0x93/0x230
[   73.088081]        down_write+0x3b/0x50
[   73.088082]        mpol_rebind_mm+0x1e/0x50
[   73.088083]        cpuset_attach+0x229/0x390
[   73.088084]        cgroup_migrate_execute+0x42c/0x450
[   73.088086]        cgroup_attach_task+0x267/0x3f0
[   73.088086]        __cgroup1_procs_write.constprop.20+0xe8/0x140
[   73.088088]        cgroup_file_write+0x7e/0x1a0
[   73.088089]        kernfs_fop_write+0x113/0x1b0
[   73.088091]        vfs_write+0xc1/0x1d0
[   73.088092]        ksys_write+0x87/0xc0
[   73.088093]        do_syscall_64+0x6c/0x270
[   73.088094]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   73.088095]
               other info that might help us debug this:

[   73.088095] Chain exists of:
                 &mm->mmap_sem#2 --> &device->mutex --> &cpuset_rwsem

[   73.088097]  Possible unsafe locking scenario:

[   73.088097]        CPU0                    CPU1
[   73.088098]        ----                    ----
[   73.088098]   lock(&cpuset_rwsem);
[   73.088099]                                lock(&device->mutex);
[   73.088099]                                lock(&cpuset_rwsem);
[   73.088100]   lock(&mm->mmap_sem#2);
[   73.088101]
                *** DEADLOCK ***

[   73.088101] 6 locks held by libvirtd/1902:
[   73.088102]  #0: ffff8b0f771f1ba0 (&f->f_pos_lock){+.+.}, at: __fdget_p=
os+0x46/0x50
[   73.088105]  #1: ffff8b0cc7790658 (sb_writers#7){.+.+}, at: vfs_write+0=
x1af/0x1d0
[   73.088107]  #2: ffff8b0fa42762b8 (&of->mutex){+.+.}, at: kernfs_fop_wr=
ite+0xde/0x1b0
[   73.088110]  #3: ffffffff9d29c578 (cgroup_mutex){+.+.}, at: cgroup_kn_l=
ock_live+0xed/0x1d0
[   73.088112]  #4: ffffffff9d29c1b0 (cgroup_threadgroup_rwsem){++++}, at:=
 cgroup_procs_write_start+0x4c/0x190
[   73.088114]  #5: ffffffff9d2a0430 (&cpuset_rwsem){++++}, at: cpuset_att=
ach+0x38/0x390
[   73.088115]
               stack backtrace:
[   73.088116] CPU: 6 PID: 1902 Comm: libvirtd Kdump: loaded Tainted: G   =
         E     5.4.72-rt40-rt #1
[   73.088117] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09=
/23/2013
[   73.088118] Call Trace:
[   73.088120]  dump_stack+0x71/0x9b
[   73.088122]  check_noncircular+0x155/0x170
[   73.088125]  ? __lock_acquire+0x113f/0x1410
[   73.088127]  __lock_acquire+0x113f/0x1410
[   73.088129]  lock_acquire+0x93/0x230
[   73.088130]  ? mpol_rebind_mm+0x1e/0x50
[   73.088133]  down_write+0x3b/0x50
[   73.088134]  ? mpol_rebind_mm+0x1e/0x50
[   73.088135]  mpol_rebind_mm+0x1e/0x50
[   73.088137]  cpuset_attach+0x229/0x390
[   73.088138]  cgroup_migrate_execute+0x42c/0x450
[   73.088140]  ? rt_spin_unlock+0x5b/0xa0
[   73.088142]  cgroup_attach_task+0x267/0x3f0
[   73.088145]  ? __cgroup1_procs_write.constprop.20+0xe8/0x140
[   73.088146]  __cgroup1_procs_write.constprop.20+0xe8/0x140
[   73.088148]  cgroup_file_write+0x7e/0x1a0
[   73.088150]  kernfs_fop_write+0x113/0x1b0
[   73.088152]  vfs_write+0xc1/0x1d0
[   73.088153]  ksys_write+0x87/0xc0
[   73.088155]  do_syscall_64+0x6c/0x270
[   73.088156]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   73.088157] RIP: 0033:0x7f6be8550deb
[   73.088159] Code: 53 48 89 d5 48 89 f3 48 83 ec 18 48 89 7c 24 08 e8 5a=
 fd ff ff 48 89 ea 41 89 c0 48 89 de 48 8b 7c 24 08 b8 01 00 00 00 0f 05 <=
48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 90 fd ff ff 48
[   73.088160] RSP: 002b:00007f6bde6832f0 EFLAGS: 00000293 ORIG_RAX: 00000=
00000000001
[   73.088161] RAX: ffffffffffffffda RBX: 00007f6bc80388b0 RCX: 00007f6be8=
550deb
[   73.088161] RDX: 0000000000000004 RSI: 00007f6bc80388b0 RDI: 0000000000=
00001f
[   73.088162] RBP: 0000000000000004 R08: 0000000000000000 R09: 0000000000=
000000
[   73.088162] R10: 0000000000000000 R11: 0000000000000293 R12: 00007f6bc8=
0388b0
[   73.088163] R13: 0000000000000000 R14: 000000000000001f R15: 0000000000=
000214

