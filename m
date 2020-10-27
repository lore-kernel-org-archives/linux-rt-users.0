Return-Path: <SRS0=5J30=EC=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE301C388F9
	for <linux-rt-users@archiver.kernel.org>; Tue, 27 Oct 2020 06:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 426BF20874
	for <linux-rt-users@archiver.kernel.org>; Tue, 27 Oct 2020 06:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="KJJYkjN/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506230AbgJ0GFG (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 27 Oct 2020 02:05:06 -0400
Received: from mout.gmx.net ([212.227.17.22]:54247 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2506212AbgJ0GFB (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 27 Oct 2020 02:05:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1603778620;
        bh=7ZKgc9SI8q4ikF+gsAnq7UJKpMWkYuL13jjUNMZvh7Y=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=KJJYkjN//bSqq3PueOXxCgN7ZJsxalgAvI5g2gJJv2sallt2Ku5vZyNHqsUhIlZjQ
         1MgSTPLxIdjfPV0pjfBKfh5lyfgkKkA7L2pO7BS+Otv5zFct7MAAbmdH1VCdK3+jFo
         QXzFBVmTzJ8+hxqx1dIUoGPj80Nl+lEGIfiPk8NI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.simpson.net ([185.146.51.69]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M4s0t-1kVNCl300V-0021sk; Tue, 27
 Oct 2020 07:03:40 +0100
Message-ID: <0dfae65db2f0d3ef603c1db34f37cee63f7f41f4.camel@gmx.de>
Subject: Re: kvm+nouveau induced lockdep  gripe
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Hillf Danton <hdanton@sina.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Skeggs <bskeggs@redhat.com>
Date:   Tue, 27 Oct 2020 07:03:38 +0100
In-Reply-To: <20201026195308.wsbk7xy57wuzfbao@linutronix.de>
References: <20201021125324.ualpvrxvzyie6d7d@linutronix.de>
         <a23a826af7c108ea5651e73b8fbae5e653f16e86.camel@gmx.de>
         <20201023090108.5lunh4vqfpkllmap@linutronix.de>
         <20201024022236.19608-1-hdanton@sina.com>
         <20201024050000.8104-1-hdanton@sina.com>
         <20201026173107.quylcy6fgjvrqat6@linutronix.de>
         <431e81699f2310eabfe5af0a3de400ab99d9323b.camel@gmx.de>
         <20201026195308.wsbk7xy57wuzfbao@linutronix.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rhqrXW15CJ0nE4qxQivs1AetNEqwfMlFHoWKi8o38cmq9z2AAqB
 fkpLWRc1SdX2+bnUVqJwt+HYNipJ1icQPUrPXgyoEZLHrsa7/qctNjKxVOH1Uayf4T/Itvf
 5GgOI4x/QbRAFQa9fDtJoajxyOSS3aVRzeiAa51trYvavqRRPF0LYhf3HDOR8p5uhV/5qLL
 mxpiThBnfdpnp8j+n4APg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2HNVgkwLr9w=:lQ+iu9MnH1qRL7rjONLkn3
 2GvuuQlZ8pySibzxcgbMWesO25lCEj/QRDqro7As3znUdOzCotX9klpsjN1+JdHP9Yv5N+Mj/
 Ctr5ZWA1JxAZjZUoMqvkQoRLKRKfan2cIqzsqHdqAoS+IfTV6at7T8evhEqUK4bfUD9q+xePa
 523E5bU5lSovgAc9+9aq8YsiDWEHneBM2v5v3YVln/p+yYQOXU8SWZAcbRoLFPeXoGtJP0FUY
 7ErDjTVRaVxBT/D9SliLdAtz1rFxPxqCC4X8jYNoGn42B3mBK9QxD8UoGM0rgz8XJGbPA/2nm
 B+roZSlGTo/IKpyipYpzgMXeuRuF4Eko9UOo3PIuzWDGgVJEOzQBM9F8Qb4t76FrLGG3EeQlL
 VH1scPpx2wyc324RXYkr/3u9kP20QFFd1oAIyau5vTv1d+JkXMDa7dIpkts7Xuux39Qj4/ed0
 vSpvXv/mRay4Qm1gxFutrtzdXK3u1PdNwG6WTnMO/zlS7MxEoOweDNBAbuITei+XEeUVJSNTC
 i6wRvjSdPPkpxCxrBGZUHGDIiU75zrGoVdkrEjDi/Ff0MiPMvqnmwRXdCa07ZnUaM/ta/OCWp
 F71Qtf1XpwMz0gG+B+hjGUKeXkIvLIsY1bx5nt5lxNaySbuBFZN53zmXeJ7SVczoCX0Q1jC47
 wc/rhl3yKc6VOSEFhaeqi6RPvJhiaZUdf3nAg3l9OLm5+JO1Oq4XqXBn96Aefcw1gto4VHurk
 VrUf1M0onsfHNZol7kr6ACmqrpifyGNSM74Nmd5WTIEJjny7kzz3SqeqckDHbZkI+z8igt4RB
 SIQp8rSHHBHhDmmAYicjiMLChnEwCL2iMB/N1BwSQbpNv9IRUKUNcxNwWfZmVCAX4MANSHbqS
 uSheGJOWYbevn8vSvvdQ==
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, 2020-10-26 at 20:53 +0100, Sebastian Andrzej Siewior wrote:
>
> Could you try this, please?

Nogo, first call of sched_setscheduler() is via kthread_create().  I
confirmed that nuking that (gratuitous user foot saving override) call
on top of moving sched_set_fifo() does shut it up, but that won't fly.

> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -1155,6 +1155,8 @@ static int irq_thread(void *data)
>  	irqreturn_t (*handler_fn)(struct irq_desc *desc,
>  			struct irqaction *action);
>
> +	sched_set_fifo(current);
> +
>  	if (force_irqthreads && test_bit(IRQTF_FORCED_THREAD,
>  					&action->thread_flags))
>  		handler_fn =3D irq_forced_thread_fn;
> @@ -1320,8 +1322,6 @@ setup_irq_thread(struct irqaction *new,
>  	if (IS_ERR(t))
>  		return PTR_ERR(t);
>
> -	sched_set_fifo(t);
> -
>  	/*
>  	 * We keep the reference to the task struct even if
>  	 * the thread dies to avoid that the interrupt code
>

[  150.926954] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  150.926967] WARNING: possible circular locking dependency detected
[  150.926981] 5.10.0.g3650b22-master #13 Tainted: G S          E
[  150.926993] ------------------------------------------------------
[  150.927005] libvirtd/1833 is trying to acquire lock:
[  150.927016] ffff921a45ed55a8 (&mm->mmap_lock#2){++++}-{3:3}, at: mpol_r=
ebind_mm+0x1e/0x50
[  150.927052]
               but task is already holding lock:
[  150.927064] ffffffffad585410 (&cpuset_rwsem){++++}-{0:0}, at: cpuset_at=
tach+0x38/0x390
[  150.927094]
               which lock already depends on the new lock.

[  150.927108]
               the existing dependency chain (in reverse order) is:
[  150.927122]
               -> #3 (&cpuset_rwsem){++++}-{0:0}:
[  150.927145]        cpuset_read_lock+0x39/0xd0
[  150.927160]        __sched_setscheduler+0x456/0xa90
[  150.927173]        _sched_setscheduler+0x69/0x70
[  150.927187]        __kthread_create_on_node+0x114/0x170
[  150.927205]        kthread_create_on_node+0x37/0x40
[  150.927223]        setup_irq_thread+0x33/0xb0
[  150.927238]        __setup_irq+0x4e0/0x7c0
[  150.927254]        request_threaded_irq+0xf8/0x160
[  150.927393]        nvkm_pci_oneinit+0x4c/0x70 [nouveau]
[  150.927469]        nvkm_subdev_init+0x60/0x1e0 [nouveau]
[  150.927603]        nvkm_device_init+0x10b/0x240 [nouveau]
[  150.927733]        nvkm_udevice_init+0x49/0x70 [nouveau]
[  150.927804]        nvkm_object_init+0x3d/0x180 [nouveau]
[  150.927871]        nvkm_ioctl_new+0x1a1/0x260 [nouveau]
[  150.927938]        nvkm_ioctl+0x10a/0x240 [nouveau]
[  150.928001]        nvif_object_ctor+0xeb/0x150 [nouveau]
[  150.928069]        nvif_device_ctor+0x1f/0x60 [nouveau]
[  150.928201]        nouveau_cli_init+0x1ac/0x590 [nouveau]
[  150.928332]        nouveau_drm_device_init+0x68/0x800 [nouveau]
[  150.928462]        nouveau_drm_probe+0xfb/0x200 [nouveau]
[  150.928483]        local_pci_probe+0x42/0x90
[  150.928501]        pci_device_probe+0xe7/0x1a0
[  150.928519]        really_probe+0xf7/0x4d0
[  150.928536]        driver_probe_device+0x5d/0x140
[  150.928552]        device_driver_attach+0x4f/0x60
[  150.928569]        __driver_attach+0xa4/0x140
[  150.928584]        bus_for_each_dev+0x67/0x90
[  150.928600]        bus_add_driver+0x18c/0x230
[  150.928616]        driver_register+0x5b/0xf0
[  150.928633]        do_one_initcall+0x54/0x2f0
[  150.928650]        do_init_module+0x5b/0x21b
[  150.928667]        load_module+0x1e40/0x2370
[  150.928682]        __do_sys_finit_module+0x98/0xe0
[  150.928698]        do_syscall_64+0x33/0x40
[  150.928716]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  150.928731]
               -> #2 (&device->mutex){+.+.}-{3:3}:
[  150.928761]        __mutex_lock+0x90/0x9c0
[  150.928895]        nvkm_udevice_fini+0x23/0x70 [nouveau]
[  150.928975]        nvkm_object_fini+0xb8/0x210 [nouveau]
[  150.929048]        nvkm_object_fini+0x73/0x210 [nouveau]
[  150.929119]        nvkm_ioctl_del+0x7e/0xa0 [nouveau]
[  150.929191]        nvkm_ioctl+0x10a/0x240 [nouveau]
[  150.929258]        nvif_object_dtor+0x4a/0x60 [nouveau]
[  150.929326]        nvif_client_dtor+0xe/0x40 [nouveau]
[  150.929455]        nouveau_cli_fini+0x7a/0x90 [nouveau]
[  150.929586]        nouveau_drm_postclose+0xaa/0xe0 [nouveau]
[  150.929638]        drm_file_free.part.7+0x273/0x2c0 [drm]
[  150.929680]        drm_release+0x6e/0xf0 [drm]
[  150.929697]        __fput+0xb2/0x260
[  150.929714]        task_work_run+0x73/0xc0
[  150.929732]        exit_to_user_mode_prepare+0x1a5/0x1d0
[  150.929749]        syscall_exit_to_user_mode+0x46/0x2a0
[  150.929767]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  150.929782]
               -> #1 (&cli->lock){+.+.}-{3:3}:
[  150.929811]        __mutex_lock+0x90/0x9c0
[  150.929936]        nouveau_mem_fini+0x4c/0x70 [nouveau]
[  150.930062]        nouveau_sgdma_destroy+0x20/0x50 [nouveau]
[  150.930086]        ttm_bo_cleanup_memtype_use+0x3e/0x60 [ttm]
[  150.930109]        ttm_bo_release+0x29c/0x600 [ttm]
[  150.930130]        ttm_bo_vm_close+0x15/0x30 [ttm]
[  150.930150]        remove_vma+0x3e/0x70
[  150.930166]        __do_munmap+0x2b7/0x4f0
[  150.930181]        __vm_munmap+0x5b/0xa0
[  150.930195]        __x64_sys_munmap+0x27/0x30
[  150.930210]        do_syscall_64+0x33/0x40
[  150.930227]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  150.930241]
               -> #0 (&mm->mmap_lock#2){++++}-{3:3}:
[  150.930275]        __lock_acquire+0x149d/0x1a70
[  150.930292]        lock_acquire+0x1a7/0x3b0
[  150.930307]        down_write+0x38/0x70
[  150.930323]        mpol_rebind_mm+0x1e/0x50
[  150.930340]        cpuset_attach+0x229/0x390
[  150.930355]        cgroup_migrate_execute+0x46d/0x490
[  150.930371]        cgroup_attach_task+0x20c/0x3b0
[  150.930388]        __cgroup1_procs_write.constprop.21+0xf3/0x150
[  150.930407]        cgroup_file_write+0x64/0x210
[  150.930423]        kernfs_fop_write+0x117/0x1b0
[  150.930440]        vfs_write+0xe8/0x240
[  150.930456]        ksys_write+0x87/0xc0
[  150.930471]        do_syscall_64+0x33/0x40
[  150.930487]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  150.930501]
               other info that might help us debug this:

[  150.930522] Chain exists of:
                 &mm->mmap_lock#2 --> &device->mutex --> &cpuset_rwsem

[  150.930561]  Possible unsafe locking scenario:

[  150.930577]        CPU0                    CPU1
[  150.930589]        ----                    ----
[  150.930602]   lock(&cpuset_rwsem);
[  150.930617]                                lock(&device->mutex);
[  150.930635]                                lock(&cpuset_rwsem);
[  150.930653]   lock(&mm->mmap_lock#2);
[  150.930671]
                *** DEADLOCK ***

[  150.930690] 6 locks held by libvirtd/1833:
[  150.930703]  #0: ffff921a6f1690f0 (&f->f_pos_lock){+.+.}-{3:3}, at: __f=
dget_pos+0x45/0x50
[  150.930736]  #1: ffff921c88c1d460 (sb_writers#7){.+.+}-{0:0}, at: vfs_w=
rite+0x1aa/0x240
[  150.930771]  #2: ffff921a48734488 (&of->mutex){+.+.}-{3:3}, at: kernfs_=
fop_write+0xe2/0x1b0
[  150.930801]  #3: ffffffffad581848 (cgroup_mutex){+.+.}-{3:3}, at: cgrou=
p_kn_lock_live+0xea/0x1d0
[  150.930833]  #4: ffffffffad5816b0 (cgroup_threadgroup_rwsem){++++}-{0:0=
}, at: cgroup_procs_write_start+0x6e/0x200
[  150.930866]  #5: ffffffffad585410 (&cpuset_rwsem){++++}-{0:0}, at: cpus=
et_attach+0x38/0x390
[  150.930899]
               stack backtrace:
[  150.930918] CPU: 3 PID: 1833 Comm: libvirtd Kdump: loaded Tainted: G S =
         E     5.10.0.g3650b22-master #13
[  150.930938] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09=
/23/2013
[  150.930955] Call Trace:
[  150.930974]  dump_stack+0x77/0x97
[  150.930993]  check_noncircular+0xe7/0x100
[  150.931012]  ? stack_trace_save+0x3b/0x50
[  150.931036]  ? __lock_acquire+0x149d/0x1a70
[  150.931053]  __lock_acquire+0x149d/0x1a70
[  150.931077]  lock_acquire+0x1a7/0x3b0
[  150.931093]  ? mpol_rebind_mm+0x1e/0x50
[  150.931114]  down_write+0x38/0x70
[  150.931129]  ? mpol_rebind_mm+0x1e/0x50
[  150.931144]  mpol_rebind_mm+0x1e/0x50
[  150.931162]  cpuset_attach+0x229/0x390
[  150.931180]  cgroup_migrate_execute+0x46d/0x490
[  150.931199]  ? _raw_spin_unlock_irq+0x2f/0x50
[  150.931217]  cgroup_attach_task+0x20c/0x3b0
[  150.931245]  ? __cgroup1_procs_write.constprop.21+0xf3/0x150
[  150.931263]  __cgroup1_procs_write.constprop.21+0xf3/0x150
[  150.931286]  cgroup_file_write+0x64/0x210
[  150.931304]  kernfs_fop_write+0x117/0x1b0
[  150.931323]  vfs_write+0xe8/0x240
[  150.931341]  ksys_write+0x87/0xc0
[  150.931357]  ? lockdep_hardirqs_on+0x85/0x110
[  150.931374]  do_syscall_64+0x33/0x40
[  150.931391]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  150.931409] RIP: 0033:0x7fcdc56a6deb
[  150.931425] Code: 53 48 89 d5 48 89 f3 48 83 ec 18 48 89 7c 24 08 e8 5a=
 fd ff ff 48 89 ea 41 89 c0 48 89 de 48 8b 7c 24 08 b8 01 00 00 00 0f 05 <=
48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 90 fd ff ff 48
[  150.931456] RSP: 002b:00007fcdbcfdc2f0 EFLAGS: 00000293 ORIG_RAX: 00000=
00000000001
[  150.931476] RAX: ffffffffffffffda RBX: 00007fcdb403ca00 RCX: 00007fcdc5=
6a6deb
[  150.931493] RDX: 0000000000000004 RSI: 00007fcdb403ca00 RDI: 0000000000=
00001f
[  150.931510] RBP: 0000000000000004 R08: 0000000000000000 R09: 0000000000=
000000
[  150.931526] R10: 0000000000000000 R11: 0000000000000293 R12: 00007fcdb4=
03ca00
[  150.931543] R13: 0000000000000000 R14: 000000000000001f R15: 0000000000=
000214




