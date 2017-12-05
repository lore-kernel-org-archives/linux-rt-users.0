From: Sam Kappen <skappen@mvista.com>
Subject: Re: schedule under irqs_disabled in SLUB problem
Date: Tue, 5 Dec 2017 22:01:19 +0530
Message-ID: <CAJ9FNxsqcLjq8=jcOJz+3mwbkzuXyXCp59XVhj-xamsv6Ux0nA@mail.gmail.com>
References: <CADF-jezvVP2O++FR2KiRSSSJF7oObjy8LSP3-yj1HCmxyTzB_Q@mail.gmail.com>
 <20171102165009.u7a7ahmmywo2qugd@linutronix.de> <CADF-jexLs9vRuiuoRmcA+0L6Mp-XxW75okheWV+ipGf1b_Ua1w@mail.gmail.com>
 <59FC4393.8030005@mcst.ru> <5A01812F.7040406@mcst.ru> <20171116160837.hfpnq4vb4j2osbuz@linutronix.de>
 <20171117173820.GM872@jcartwri.amer.corp.natinst.com> <CAJ9FNxsfHRuc+UZCPKGDJDtk5neApOb3i6thpGTy9c-oP8T4JA@mail.gmail.com>
 <20171124093724.GB2564@linutronix.de> <CAJ9FNxtpTqjLevwN1w037=g1eqRPf-Fht+SFqSqJS0jVhFXkLg@mail.gmail.com>
 <20171204095912.GH2255@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ua0-f174.google.com ([209.85.217.174]:36990 "EHLO
        mail-ua0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751062AbdLEQbV (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 5 Dec 2017 11:31:21 -0500
Received: by mail-ua0-f174.google.com with SMTP id l36so641244uae.4
        for <linux-rt-users@vger.kernel.org>; Tue, 05 Dec 2017 08:31:20 -0800 (PST)
In-Reply-To: <20171204095912.GH2255@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

Thanks for looking at my queries. Please see my answers inline.

 1.)
> I had derived and tried a patch based on the below analysis.
> ( I referred below open source commit, to derive on this patch.
> https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git/co=
mmit/?h=3Dv4.9.47-rt37-rebase&id=3D7a347757f027190c95a363a491c18156a926a370
> )
>
> In some cases pi_lock in rt_spin_lock_slowlock does not retain the
> irqs state while exiting function, this causes
> issue in migrate_disable() + enable as they are not symmetrical in
> regard to the status of interrupts.
> To fix pi_lock & pi_unlock in rt_spin_lock_slowlock, it has been
> modified to retain irq state by using
> raw_spin_lock and raw_spin_unlock and also modified wait_lock in
> rt_spin_lock_slowlock with raw_spin_lock_irqsave & *_restore.

Can you provide more informations on this? Like a stack strace that
shows that this happens and when it happens? It should not happen.

As we were experiencing a panic issue with in  3 to 6 hours during the
test(Test is continues soft reboot of the system
as mentioned in previous mail). With the help of instrument code we
have been tracked it down to the function rt_spin_lock_slowlock() in
rtmutex.c.
We see this issue when there is a state change for irqs from disabled
to enabled. During slab allocations for SCSI on bootup
the irqs are found to be in disabled state since the system state is
not yet in "RUNNING".

So we have added instrument code throughout the call trace and
confirmed culprit as pi_lock()/pi_unlock for changing the irqs state.
Basically it happens when it acquires the lock with irqs in disabled state.


I guess below scenario is happens when issue hits.

It looks like during normal cases with irqs in disabled state from the
function rt_spin_lock_slowlock(),
It gets mutex lock in its first try and  takes first return path so it
 need not have to take pi_lock/unlock. But in some special case (error
case)
mutex  lock is not available(I am not sure why this happens? ) and go
further retry hence it acquires pi_lock/unlock
then into panic.


I am providing below some stack traces which we have seen during the
test. All relevant debug configs were enabled while testing.

scsi 0:0:0:0: Direct-Access     Linux    scsi_debug       0004 PQ: 0 ANSI: =
5
mm/mempolicy.c alloc_pages_current 2067 irq disabled!!!   =3D=3D> debug
print added by me
mm/mempolicy.c alloc_pages_current 2067 irq disabled!!!   =3D=3D> debug
print added by me
mm/mempolicy.c alloc_pages_current 2067 irq disabled!!!   =3D=3D> debug
print added by me
mm/mempolicy.c alloc_pages_current 2067 irq disabled!!!   =3D=3D> debug
print added by me
------------[ cut here ]------------
------------[ cut here ]------------
WARNING: at kernel/sched/core.c:3052 migrate_disable+0x10b/0x120()
Modules linked in:
CPU: 1 PID: 7 Comm: kworker/u8:0 Not tainted 3.10.107-rt120+ #49
Hardware name: To be filled by O.E.M. To be filled by
O.E.M./WADE-8078, BIOS R1.00.E0 07/07/2014
Workqueue: events_unbound async_run_entry_fn
 0000000000000000 ffff880159ee72e8 ffffffff816b617c 0000000000000000
 0000000000000009 ffff880159ee7328 ffffffff8105fc8b ffff880159ee7348
 ffff880159ea3540 0000000000000038 0000000000000001 0000000000000004
Call Trace:
 [<ffffffff816b617c>] dump_stack+0x4f/0x65
 [<ffffffff8105fc8b>] warn_slowpath_common+0x6b/0xa0
 [<ffffffff8105fcd5>] warn_slowpath_null+0x15/0x20
 [<ffffffff8109585b>] migrate_disable+0x10b/0x120
 [<ffffffff81060c45>] call_console_drivers.constprop.20+0x65/0x100
 [<ffffffff81061da8>] console_unlock+0x398/0x3d0
 [<ffffffff81062303>] vprintk_emit+0x2b3/0x500
 [<ffffffff810b9526>] ? __try_to_take_rt_mutex+0x146/0x190
 [<ffffffff8109569c>] ? migrate_enable+0x14c/0x200
 [<ffffffff816b17e5>] printk+0x48/0x4a
 [<ffffffff8109569c>] ? migrate_enable+0x14c/0x200
 [<ffffffff8105fc59>] warn_slowpath_common+0x39/0xa0
 [<ffffffff8105fcd5>] warn_slowpath_null+0x15/0x20
 [<ffffffff8109569c>] migrate_enable+0x14c/0x200
 [<ffffffff81100fb1>] get_page_from_freelist+0x9a1/0xbc0
 [<ffffffff812fc3d9>] ? number.isra.1+0x329/0x360
 [<ffffffff81101f89>] __alloc_pages_nodemask+0x179/0xa50
 [<ffffffff816ba6b3>] ? _raw_spin_unlock+0x13/0x40
 [<ffffffff8109de14>] ? update_curr+0xa4/0xf0
 [<ffffffff81138ab1>] alloc_pages_current+0x101/0x1f0
 [<ffffffff8113cf95>] new_slab+0x265/0x310
 [<ffffffff816b386e>] __slab_alloc.isra.62+0x4e0/0x6ca
 [<ffffffff816ba744>] ? _raw_spin_unlock_irq+0x14/0x40
 [<ffffffff810fbd0a>] ? mempool_alloc_slab+0x3a/0x70
 [<ffffffff816ba6b3>] ? _raw_spin_unlock+0x13/0x40
 [<ffffffff8113f5d0>] kmem_cache_alloc+0x170/0x190
 [<ffffffff810fbd0a>] ? mempool_alloc_slab+0x3a/0x70
 [<ffffffff810fbd0a>] mempool_alloc_slab+0x3a/0x70
 [<ffffffff810fc0be>] mempool_alloc+0xae/0x210
 [<ffffffff81063f85>] ? unpin_current_cpu+0x15/0x70
 [<ffffffff812d5ce8>] get_request+0x3a8/0x7c0
 [<ffffffff81089c30>] ? __init_waitqueue_head+0x60/0x60
 [<ffffffff812d619a>] blk_get_request+0x9a/0x140
 [<ffffffff8113fb68>] ? kmem_cache_free+0x188/0x1a0
 [<ffffffff813ef02a>] scsi_execute+0x4a/0x170
 [<ffffffff813ef226>] scsi_execute_req_flags+0xd6/0x190
 [<ffffffff81478349>] read_capacity_16+0xb9/0x550
 [<ffffffff81478fc8>] sd_revalidate_disk+0x4c8/0x1c90
 [<ffffffff8147a855>] sd_probe_async+0xc5/0x1d0
 [<ffffffff81090a96>] async_run_entry_fn+0x36/0x130
 [<ffffffff81081047>] process_one_work+0x147/0x3d0
 [<ffffffff810824e1>] worker_thread+0x161/0x3d0
 [<ffffffff81082380>] ? manage_workers.isra.33+0x2f0/0x2f0
 [<ffffffff81088f75>] kthread+0xc5/0xd0
 [<ffffffff81088eb0>] ? __init_kthread_worker+0x60/0x60
 [<ffffffff816bb37e>] ret_from_fork+0x4e/0x80
 [<ffffffff81088eb0>] ? __init_kthread_worker+0x60/0x60
---[ end trace 0000000000000001 ]---
------------[ cut here ]------------
WARNING: at kernel/sched/core.c:3087 migrate_enable+0x14c/0x200()
Modules linked in:
CPU: 1 PID: 7 Comm: kworker/u8:0 Tainted: G        W    3.10.107-rt120+ #49
Hardware name: To be filled by O.E.M. To be filled by
O.E.M./WADE-8078, BIOS R1.00.E0 07/07/2014
Workqueue: events_unbound async_run_entry_fn
 0000000000000000 ffff880159ee7228 ffffffff816b617c 0000000000000000
 0000000000000009 ffff880159ee7268 ffffffff8105fc8b ffff880159ee7258
 ffff880159ea3540 ffffffff81e1a9e8 ffffffff81e1a840 0000000000000000
Call Trace:
 [<ffffffff816b617c>] dump_stack+0x4f/0x65
 [<ffffffff8105fc8b>] warn_slowpath_common+0x6b/0xa0
 [<ffffffff8105fcd5>] warn_slowpath_null+0x15/0x20
 [<ffffffff8109569c>] migrate_enable+0x14c/0x200
 [<ffffffff8138ae56>] serial8250_poll+0xd6/0x120
 [<ffffffff813878dd>] uartdrv_console_write+0xdd/0x330
 [<ffffffff81060cad>] call_console_drivers.constprop.20+0xcd/0x100
 [<ffffffff81061da8>] console_unlock+0x398/0x3d0
 [<ffffffff81062303>] vprintk_emit+0x2b3/0x500
 [<ffffffff810b9526>] ? __try_to_take_rt_mutex+0x146/0x190
sd 0:0:0:0: Attached scsi generic sg0 type 0
 [<ffffffff8109569c>] ? migrate_enable+0x14c/0x200
 [<ffffffff816b17e5>] printk+0x48/0x4a
 [<ffffffff8109569c>] ? migrate_enable+0x14c/0x200
 [<ffffffff8105fc59>] warn_slowpath_common+0x39/0xa0
 [<ffffffff8105fcd5>] warn_slowpath_null+0x15/0x20
 [<ffffffff8109569c>] migrate_enable+0x14c/0x200
 [<ffffffff81100fb1>] get_page_from_freelist+0x9a1/0xbc0
 [<ffffffff812fc3d9>] ? number.isra.1+0x329/0x360
 [<ffffffff81101f89>] __alloc_pages_nodemask+0x179/0xa50
 [<ffffffff816ba6b3>] ? _raw_spin_unlock+0x13/0x40
 [<ffffffff8109de14>] ? update_curr+0xa4/0xf0
 [<ffffffff81138ab1>] alloc_pages_current+0x101/0x1f0
 [<ffffffff8113cf95>] new_slab+0x265/0x310
 [<ffffffff816b386e>] __slab_alloc.isra.62+0x4e0/0x6ca
 [<ffffffff816ba744>] ? _raw_spin_unlock_irq+0x14/0x40
 [<ffffffff810fbd0a>] ? mempool_alloc_slab+0x3a/0x70
 [<ffffffff816ba6b3>] ? _raw_spin_unlock+0x13/0x40
 [<ffffffff8113f5d0>] kmem_cache_alloc+0x170/0x190
 [<ffffffff810fbd0a>] ? mempool_alloc_slab+0x3a/0x70
 [<ffffffff810fbd0a>] mempool_alloc_slab+0x3a/0x70
 [<ffffffff810fc0be>] mempool_alloc+0xae/0x210
 [<ffffffff81063f85>] ? unpin_current_cpu+0x15/0x70
 [<ffffffff812d5ce8>] get_request+0x3a8/0x7c0
 [<ffffffff81089c30>] ? __init_waitqueue_head+0x60/0x60
 [<ffffffff812d619a>] blk_get_request+0x9a/0x140
 [<ffffffff8113fb68>] ? kmem_cache_free+0x188/0x1a0
 [<ffffffff813ef02a>] scsi_execute+0x4a/0x170
 [<ffffffff813ef226>] scsi_execute_req_flags+0xd6/0x190
 [<ffffffff81478349>] read_capacity_16+0xb9/0x550
 [<ffffffff81478fc8>] sd_revalidate_disk+0x4c8/0x
---------------------------------------------------------------------------=
---------
scsi0 : scsi_debug, version 1.82 [20100324], dev_size_mb=3D8, opts=3D0x0
scsi 0:0:0:0: Direct-Access     Linux    scsi_debug       0004 PQ: 0 ANSI: =
5
kernel/rtmutex.c rt_spin_lock_slowlock 1266 enterirq 1 exitirq 0!!!=3D=3D>
debug print added by me
XXX: After local_spin_lock_irqsave enterirqs 1 exitirqs 0!!!    =3D=3D>
debug print added by me
------------[ cut here ]------------
WARNING: at kernel/sched/core.c:3052 migrate_disable+0x10b/0x120()
Modules linked in:
CPU: 0 PID: 7 Comm: kworker/u8:0 Not tainted 3.10.107-rt120+ #106
Hardware name: To be filled by O.E.M. To be filled by
O.E.M./WADE-8078, BIOS R1.00.E0 07/07/2014
Workqueue: events_unbound async_run_entry_fn
 0000000000000000 ffff880159ee73f8 ffffffff816b65bc 0000000000000000
 0000000000000009 ffff880159ee7438 ffffffff8105fc8b ffff880159ee7438
 ffff880159ea3540 0000000000000044 0000000000000001 0000000000000004
Call Trace:
 [<ffffffff816b65bc>] dump_stack+0x4f/0x65
 [<ffffffff8105fc8b>] warn_slowpath_common+0x6b/0xa0
 [<ffffffff8105fcd5>] warn_slowpath_null+0x15/0x20
 [<ffffffff8109585b>] migrate_disable+0x10b/0x120
 [<ffffffff81060c45>] call_console_drivers.constprop.20+0x65/0x100
 [<ffffffff81061da8>] console_unlock+0x398/0x3d0
 [<ffffffff81062303>] vprintk_emit+0x2b3/0x500
 [<ffffffff816b1c25>] printk+0x48/0x4a
 [<ffffffff81100f85>] get_page_from_freelist+0x985/0xc70
 [<ffffffff81102029>] __alloc_pages_nodemask+0x179/0xa50
 [<ffffffff81100b7a>] ? get_page_from_freelist+0x57a/0xc70
 [<ffffffff81063f85>] ? unpin_current_cpu+0x15/0x70
 [<ffffffff81138b2c>] alloc_pages_current+0xdc/0x1b0
 [<ffffffff8113d015>] new_slab+0x285/0x370
 [<ffffffff816b3cae>] __slab_alloc.isra.62+0x4e0/0x6ca
 [<ffffffff810fbcf8>] ? mempool_alloc_slab+0x28/0x60
 [<ffffffff8113f752>] kmem_cache_alloc+0x1a2/0x1e0
 [<ffffffff810fbcf8>] ? mempool_alloc_slab+0x28/0x60
 [<ffffffff810fbcf8>] mempool_alloc_slab+0x28/0x60
 [<ffffffff810fc0ae>] mempool_alloc+0xae/0x210
 [<ffffffff81063f85>] ? unpin_current_cpu+0x15/0x70
 [<ffffffff812d60f8>] get_request+0x3a8/0x7c0
 [<ffffffff81089c30>] ? __init_waitqueue_head+0x60/0x60
 [<ffffffff812d65aa>] blk_get_request+0x9a/0x140
 [<ffffffff813ef46a>] scsi_execute+0x4a/0x170
 [<ffffffff813ef666>] scsi_execute_req_flags+0xd6/0x190
 [<ffffffff81479008>] sd_revalidate_disk+0xc8/0x1c90
 [<ffffffff816ba561>] ? rt_spin_lock_slowlock+0x291/0x340
 [<ffffffff8147ac95>] sd_probe_async+0xc5/0x1d0
 [<ffffffff81090a96>] async_run_entry_fn+0x36/0x130
 [<ffffffff81081047>] process_one_work+0x147/0x3d0
 [<ffffffff810824e1>] worker_thread+0x161/0x3d0
 [<ffffffff81082380>] ? manage_workers.isra.33+0x2f0/0x2f0
 [<ffffffff81088f75>] kthread+0xc5/0xd0
 [<ffffffff81088eb0>] ? __init_kthread_worker+0x60/0x60
 [<ffffffff816bb8fe>] ret_from_fork+0x4e/0x80
 [<ffffffff81088eb0>] ? __init_kthread_worker+0x60/0x60
---[ end trace 0000000000000001 ]---
------------[ cut here ]------------
WARNING: at kernel/sched/core.c:3087 migrate_enable+0x14c/0x200()
Modules linked in:
CPU: 0 PID: 7 Comm: kworker/u8:0 Tainted: G        W    3.10.107-rt120+ #10=
6
Hardware name: To be filled by O.E.M. To be filled by
O.E.M./WADE-8078, BIOS R1.00.E0 07/07/2014
Workqueue: events_unbound async_run_entry_fn
 0000000000000000 ffff880159ee7338 ffffffff816b65bc 0000000000000000
 0000000000000009 ffff880159ee7378 ffffffff8105fc8b ffff880159ee7368
 ffff880159ea3540 ffffffff81e1aa28 ffffffff81e1a880 0000000000000000
Call Trace:
 [<ffffffff816b65bc>] dump_stack+0x4f/0x65
 [<ffffffff8105fc8b>] warn_slowpath_common+0x6b/0xa0
 [<ffffffff8105fcd5>] warn_slowpath_null+0x15/0x20
 [<ffffffff8109569c>] migrate_enable+0x14c/0x200
 [<ffffffff8138b266>] serial8250_poll+0xd6/0x120
 [<ffffffff81387ced>] uartdrv_console_write+0xdd/0x330
 [<ffffffff81060cad>] call_console_drivers.constprop.20+0xcd/0x100
 [<ffffffff81061da8>] console_unlock+0x398/0x3d0
 [<ffffffff81062303>] vprintk_emit+0x2b3/0x500
 [<ffffffff816b1c25>] printk+0x48/0x4a
 [<ffffffff81100f85>] get_page_from_freelist+0x985/0xc70
 [<ffffffff81102029>] __alloc_pages_nodemask+0x179/0xa50
 [<ffffffff81100b7a>] ? get_page_from_freelist+0x57a/0xc70
 [<ffffffff81063f85>] ? unpin_current_cpu+0x15/0x70
 [<ffffffff81138b2c>] alloc_pages_current+0xdc/0x1b0
 [<ffffffff8113d015>] new_slab+0x285/0x370
 [<ffffffff816b3cae>] __slab_alloc.isra.62+0x4e0/0x6ca
 [<ffffffff810fbcf8>] ? mempool_alloc_slab+0x28/0x60
 [<ffffffff8113f752>] kmem_cache_alloc+0x1a2/0x1e0
 [<ffffffff810fbcf8>] ? mempool_alloc_slab+0x28/0x60
 [<ffffffff810fbcf8>] mempool_alloc_slab+0x28/0x60
 [<ffffffff810fc0ae>] mempool_alloc+0xae/0x210
 [<ffffffff81063f85>] ? unpin_current_cpu+0x15/0x70
 [<ffffffff812d60f8>] get_request+0x3a8/0x7c0
 [<ffffffff81089c30>] ? __init_waitqueue_head+0x60/0x60
 [<ffffffff812d65aa>] blk_get_request+0x9a/0x140
 [<ffffffff813ef46a>] scsi_execute+0x4a/0x170
 [<ffffffff813ef666>] scsi_execute_req_flags+0xd6/0x190
 [<ffffffff81479008>] sd_revalidate_disk+0xc8/0x1c90
 [<ffffffff816ba561>] ? rt_spin_lock_slowlock+0x291/0x340
 [<ffffffff8147ac95>] sd_probe_async+0xc5/0x1d0
 [<ffffffff81090a96>] async_run_entry_fn+0x36/0x130
 [<ffffffff81081047>] process_one_work+0x147/0x3d0
 [<ffffffff810824e1>] worker_thread+0x161/0x3d0
 [<ffffffff81082380>] ? manage_workers.isra.33+0x2f0/0x2f0
 [<ffffffff81088f75>] kthread+0xc5/0xd0
 [<ffffffff81088eb0>] ? __init_kthread_worker+0x60/0x60
 [<ffffffff816bb8fe>] ret_from_fork+0x4e/0x80
 [<ffffffff81088eb0>] ? __init_kthread_worker+0x60/0x60
---[ end trace 0000000000000002 ]---
XXX: __rmqueue enterirqs 1 exitirqs 0!!!             =3D=3D> debug print ad=
ded by me
XXX: __mod_zone_freepage_state enterirq 1 exitirq 0!!!    =3D=3D> debug
print added by me
------------[ cut here ]------------
sd 0:0:0:0: Attached scsi generic sg0 type 0
ahci 0000:00:13.0: controller can't do DEVSLP, turning off
ahci 0000:00:13.0: AHCI 0001.0300 32 slots 2 ports 3 Gbps 0x0 impl SATA mod=
e
ahci 0000:00:13.0: flags: 64bit ncq pm led clo pio slum part deso
scsi1 : ahci
---------------------------------------------------------------------------=
-------------------

WARNING: at kernel/sched/core.c:3052 migrate_disable+0x10b/0x120()
Modules linked in:
CPU: 1 PID: 7 Comm: kworker/u8:0 Not tainted 3.10.107-rt120+ #49
Hardware name: To be filled by O.E.M. To be filled by
O.E.M./WADE-8078, BIOS R1.00.E0 07/07/2014
Workqueue: events_unbound async_run_entry_fn
 0000000000000000 ffff880159ee72e8 ffffffff816b617c 0000000000000000
 0000000000000009 ffff880159ee7328 ffffffff8105fc8b ffff880159ee7348
 ffff880159ea3540 0000000000000038 0000000000000001 0000000000000004
Call Trace:
 [<ffffffff816b617c>] dump_stack+0x4f/0x65
 [<ffffffff8105fc8b>] warn_slowpath_common+0x6b/0xa0
 [<ffffffff8105fcd5>] warn_slowpath_null+0x15/0x20
 [<ffffffff8109585b>] migrate_disable+0x10b/0x120
 [<ffffffff81060c45>] call_console_drivers.constprop.20+0x65/0x100
 [<ffffffff81061da8>] console_unlock+0x398/0x3d0
 [<ffffffff81062303>] vprintk_emit+0x2b3/0x500
 [<ffffffff810b9526>] ? __try_to_take_rt_mutex+0x146/0x190
 [<ffffffff8109569c>] ? migrate_enable+0x14c/0x200
 [<ffffffff816b17e5>] printk+0x48/0x4a
 [<ffffffff8109569c>] ? migrate_enable+0x14c/0x200
 [<ffffffff8105fc59>] warn_slowpath_common+0x39/0xa0
 [<ffffffff8105fcd5>] warn_slowpath_null+0x15/0x20
 [<ffffffff8109569c>] migrate_enable+0x14c/0x200
 [<ffffffff81100fb1>] get_page_from_freelist+0x9a1/0xbc0
 [<ffffffff812fc3d9>] ? number.isra.1+0x329/0x360
 [<ffffffff81101f89>] __alloc_pages_nodemask+0x179/0xa50
 [<ffffffff816ba6b3>] ? _raw_spin_unlock+0x13/0x40
 [<ffffffff8109de14>] ? update_curr+0xa4/0xf0
 [<ffffffff81138ab1>] alloc_pages_current+0x101/0x1f0
 [<ffffffff8113cf95>] new_slab+0x265/0x310
 [<ffffffff816b386e>] __slab_alloc.isra.62+0x4e0/0x6ca
 [<ffffffff816ba744>] ? _raw_spin_unlock_irq+0x14/0x40
 [<ffffffff810fbd0a>] ? mempool_alloc_slab+0x3a/0x70
 [<ffffffff816ba6b3>] ? _raw_spin_unlock+0x13/0x40
 [<ffffffff8113f5d0>] kmem_cache_alloc+0x170/0x190
 [<ffffffff810fbd0a>] ? mempool_alloc_slab+0x3a/0x70
 [<ffffffff810fbd0a>] mempool_alloc_slab+0x3a/0x70
 [<ffffffff810fc0be>] mempool_alloc+0xae/0x210
 [<ffffffff81063f85>] ? unpin_current_cpu+0x15/0x70
 [<ffffffff812d5ce8>] get_request+0x3a8/0x7c0
 [<ffffffff81089c30>] ? __init_waitqueue_head+0x60/0x60
 [<ffffffff812d619a>] blk_get_request+0x9a/0x140
 [<ffffffff8113fb68>] ? kmem_cache_free+0x188/0x1a0
 [<ffffffff813ef02a>] scsi_execute+0x4a/0x170
 [<ffffffff813ef226>] scsi_execute_req_flags+0xd6/0x190
 [<ffffffff81478349>] read_capacity_16+0xb9/0x550
 [<ffffffff81478fc8>] sd_revalidate_disk+0x4c8/0x1c90
 [<ffffffff8147a855>] sd_probe_async+0xc5/0x1d0
 [<ffffffff81090a96>] async_run_entry_fn+0x36/0x130
 [<ffffffff81081047>] process_one_work+0x147/0x3d0
 [<ffffffff810824e1>] worker_thread+0x161/0x3d0
 [<ffffffff81082380>] ? manage_workers.isra.33+0x2f0/0x2f0
 [<ffffffff81088f75>] kthread+0xc5/0xd0
 [<ffffffff81088eb0>] ? __init_kthread_worker+0x60/0x60
 [<ffffffff816bb37e>] ret_from_fork+0x4e/0x80
 [<ffffffff81088eb0>] ? __init_kthread_worker+0x60/0x60
---[ end trace 0000000000000001 ]---
------------[ cut here ]------------
WARNING: at kernel/sched/core.c:3087 migrate_enable+0x14c/0x200()
Modules linked in:

=E2=80=A6
> We were testing above patch on multiple targets we could experience
> some stuck issue on some remote target after 2 days. I am not
> sure what really happens there, may be the issue when try for
> scheduling with irq in disabled state.
> The systems I have tested found to be worked 7 days after that I
> stopped the test.

Which patch? The patch I've sent and ask you for testing or the patch
you had in this email?

Patch I had in this mail.

>
> 2.) With your patch during the slab allocations irqs will be in enabled s=
tate.
> So if we enable irqs in early stage will there be any side effects? I
> am sorry if my question doesn't seem
> to be logical.

You must not enable the interrupts too early. At the time of scheduling
it is okay.

Thanks. I have been testing your patch, I will update once I finish the lon=
g
run test.

Regards,
Sam

On Mon, Dec 4, 2017 at 3:29 PM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> On 2017-11-27 12:16:36 [+0530], Sam Kappen wrote:
>> Hi,
> Hi,
>
>> 1.)
>> I had derived and tried a patch based on the below analysis.
>> ( I referred below open source commit, to derive on this patch.
>> https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git/c=
ommit/?h=3Dv4.9.47-rt37-rebase&id=3D7a347757f027190c95a363a491c18156a926a37=
0
>> )
>>
>> In some cases pi_lock in rt_spin_lock_slowlock does not retain the
>> irqs state while exiting function, this causes
>> issue in migrate_disable() + enable as they are not symmetrical in
>> regard to the status of interrupts.
>> To fix pi_lock & pi_unlock in rt_spin_lock_slowlock, it has been
>> modified to retain irq state by using
>> raw_spin_lock and raw_spin_unlock and also modified wait_lock in
>> rt_spin_lock_slowlock with raw_spin_lock_irqsave & *_restore.
>
> Can you provide more informations on this? Like a stack strace that
> shows that this happens and when it happens? It should not happen.
>
> =E2=80=A6
>> We were testing above patch on multiple targets we could experience
>> some stuck issue on some remote target after 2 days. I am not
>> sure what really happens there, may be the issue when try for
>> scheduling with irq in disabled state.
>> The systems I have tested found to be worked 7 days after that I
>> stopped the test.
>
> Which patch? The patch I've sent and ask you for testing or the patch
> you had in this email?
>
>>
>> 2.) With your patch during the slab allocations irqs will be in enabled =
state.
>> So if we enable irqs in early stage will there be any side effects? I
>> am sorry if my question doesn't seem
>> to be logical.
>
> You must not enable the interrupts too early. At the time of scheduling
> it is okay.
>
>> Regards,
>> Sam
>
> Sebastian
