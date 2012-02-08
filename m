From: Yong Zhang <yong.zhang0@gmail.com>
Subject: Re: lockdep complaints with 3.2.5+rt11 on OMAP
Date: Wed, 8 Feb 2012 16:42:00 +0800
Message-ID: <CAM2zO=AnhMv27pFNMRRKZbw-Yu7KAZXG_vO-zU4CeDhaGj7KtQ@mail.gmail.com>
References: <20120207203814.GA32384@rexfeany.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Rex Feany <rfeany@laeos.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:39168 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756040Ab2BHImB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 8 Feb 2012 03:42:01 -0500
Received: by wics10 with SMTP id s10so179557wic.19
        for <linux-rt-users@vger.kernel.org>; Wed, 08 Feb 2012 00:42:00 -0800 (PST)
In-Reply-To: <20120207203814.GA32384@rexfeany.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Feb 8, 2012 at 4:38 AM, Rex Feany <rfeany@laeos.net> wrote:
> Is this the right place to report this? Booting 3.2.5+rt11 on an omap=
3730 gives me this:

Yes.

>
> [ =C2=A0 =C2=A00.138354]
> [ =C2=A0 =C2=A00.138374] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [ =C2=A0 =C2=A00.138386] [ INFO: inconsistent lock state ]
> [ =C2=A0 =C2=A00.138400] 3.2.5-rt11-00002-g7b398a8 #10
> [ =C2=A0 =C2=A00.138409] ---------------------------------
> [ =C2=A0 =C2=A00.138423] inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W=
} usage.
> [ =C2=A0 =C2=A00.138442] swapper/1 [HC1[1]:SC0[0]:HE0:SE1] takes:
> [ =C2=A0 =C2=A00.138456] =C2=A0(rcu_kthread_wq.lock.lock.wait_lock){?=
=2E+...}, at: [<c0276810>] rt_spin_lock_slowlock+0x38/0x1e8

Because we change wait_queue_head_t::lock to rt_mutex.
And for rcutiny, rcu_kthread_wq() is waken in IRQ.

Maybe we can try to use simple_wait for rcutiny or move the
wakeup of rcu_kthread_wq() to rcu softirq.

Thanks,
Yong

> [ =C2=A0 =C2=A00.138506] {HARDIRQ-ON-W} state was registered at:
> [ =C2=A0 =C2=A00.138518] =C2=A0 [<c00729f0>] mark_lock+0x290/0x600
> [ =C2=A0 =C2=A00.138542] =C2=A0 [<c00749c8>] __lock_acquire+0x79c/0x1=
a34
> [ =C2=A0 =C2=A00.138562] =C2=A0 [<c0076278>] lock_acquire+0x114/0x134
> [ =C2=A0 =C2=A00.138580] =C2=A0 [<c0277724>] _raw_spin_lock+0x4c/0x5c
> [ =C2=A0 =C2=A00.138602] =C2=A0 [<c0276810>] rt_spin_lock_slowlock+0x=
38/0x1e8
> [ =C2=A0 =C2=A00.138621] =C2=A0 [<c0276da0>] rt_spin_lock+0x20/0x50
> [ =C2=A0 =C2=A00.138639] =C2=A0 [<c005fab0>] prepare_to_wait+0x30/0x7=
4
> [ =C2=A0 =C2=A00.138660] =C2=A0 [<c0083c70>] rcu_kthread+0x74/0x1c4
> [ =C2=A0 =C2=A00.138682] =C2=A0 [<c005f500>] kthread+0x8c/0x94
> [ =C2=A0 =C2=A00.138698] =C2=A0 [<c0014cd4>] kernel_thread_exit+0x0/0=
x8
> [ =C2=A0 =C2=A00.138719] irq event stamp: 2135
> [ =C2=A0 =C2=A00.138729] hardirqs last =C2=A0enabled at (2134): [<c00=
73360>] debug_check_no_locks_freed+0x11c/0x148
> [ =C2=A0 =C2=A00.138755] hardirqs last disabled at (2135): [<c00137b4=
>] __irq_svc+0x34/0xa0
> [ =C2=A0 =C2=A00.138784] softirqs last =C2=A0enabled at (0): [<c003e3=
cc>] copy_process+0x334/0xde0
> [ =C2=A0 =C2=A00.138811] softirqs last disabled at (0): [< =C2=A0(nul=
l)>] =C2=A0 (null)
> [ =C2=A0 =C2=A00.138828]
> [ =C2=A0 =C2=A00.138832] other info that might help us debug this:
> [ =C2=A0 =C2=A00.138844] =C2=A0Possible unsafe locking scenario:
> [ =C2=A0 =C2=A00.138852]
> [ =C2=A0 =C2=A00.138858] =C2=A0 =C2=A0 =C2=A0 =C2=A0CPU0
> [ =C2=A0 =C2=A00.138865] =C2=A0 =C2=A0 =C2=A0 =C2=A0----
> [ =C2=A0 =C2=A00.138872] =C2=A0 lock(rcu_kthread_wq.lock.lock.wait_lo=
ck);
> [ =C2=A0 =C2=A00.138887] =C2=A0 <Interrupt>
> [ =C2=A0 =C2=A00.138895] =C2=A0 =C2=A0 lock(rcu_kthread_wq.lock.lock.=
wait_lock);
> [ =C2=A0 =C2=A00.138909]
> [ =C2=A0 =C2=A00.138914] =C2=A0*** DEADLOCK ***
> [ =C2=A0 =C2=A00.138920]
> [ =C2=A0 =C2=A00.138929] 1 lock held by swapper/1:
> [ =C2=A0 =C2=A00.138939] =C2=A0#0: =C2=A0(sysfs_assoc_lock.lock.wait_=
lock){+.+...}, at: [<c0276810>] rt_spin_lock_slowlock+0x38/0x1e8
> [ =C2=A0 =C2=A00.138976]
> [ =C2=A0 =C2=A00.138980] stack backtrace:
> [ =C2=A0 =C2=A00.139014] [<c0019e74>] (unwind_backtrace+0x0/0xf0) fro=
m [<c02749a0>] (dump_stack+0x1c/0x20)
> [ =C2=A0 =C2=A00.139047] [<c02749a0>] (dump_stack+0x1c/0x20) from [<c=
00726f8>] (print_usage_bug+0x230/0x298)
> [ =C2=A0 =C2=A00.139078] [<c00726f8>] (print_usage_bug+0x230/0x298) f=
rom [<c0072ab4>] (mark_lock+0x354/0x600)
> [ =C2=A0 =C2=A00.139108] [<c0072ab4>] (mark_lock+0x354/0x600) from [<=
c007493c>] (__lock_acquire+0x710/0x1a34)
> [ =C2=A0 =C2=A00.139138] [<c007493c>] (__lock_acquire+0x710/0x1a34) f=
rom [<c0076278>] (lock_acquire+0x114/0x134)
> [ =C2=A0 =C2=A00.139170] [<c0076278>] (lock_acquire+0x114/0x134) from=
 [<c0277724>] (_raw_spin_lock+0x4c/0x5c)
> [ =C2=A0 =C2=A00.139202] [<c0277724>] (_raw_spin_lock+0x4c/0x5c) from=
 [<c0276810>] (rt_spin_lock_slowlock+0x38/0x1e8)
> [ =C2=A0 =C2=A00.139234] [<c0276810>] (rt_spin_lock_slowlock+0x38/0x1=
e8) from [<c0276da0>] (rt_spin_lock+0x20/0x50)
> [ =C2=A0 =C2=A00.139265] [<c0276da0>] (rt_spin_lock+0x20/0x50) from [=
<c0036cf8>] (__wake_up+0x28/0x50)
> [ =C2=A0 =C2=A00.139298] [<c0036cf8>] (__wake_up+0x28/0x50) from [<c0=
084374>] (rcu_check_callbacks+0xc8/0x11c)
> [ =C2=A0 =C2=A00.139339] [<c0084374>] (rcu_check_callbacks+0xc8/0x11c=
) from [<c004e6d4>] (update_process_times+0x4c/0x58)
> [ =C2=A0 =C2=A00.139383] [<c004e6d4>] (update_process_times+0x4c/0x58=
) from [<c006e9a8>] (tick_periodic+0x90/0xb4)
> [ =C2=A0 =C2=A00.139419] [<c006e9a8>] (tick_periodic+0x90/0xb4) from =
[<c006e9f0>] (tick_handle_periodic+0x24/0x98)
> [ =C2=A0 =C2=A00.139457] [<c006e9f0>] (tick_handle_periodic+0x24/0x98=
) from [<c00212a0>] (omap2_gp_timer_interrupt+0x30/0x40)
> [ =C2=A0 =C2=A00.139495] [<c00212a0>] (omap2_gp_timer_interrupt+0x30/=
0x40) from [<c007f350>] (handle_irq_event_percpu+0xa8/0x260)
> [ =C2=A0 =C2=A00.139526] [<c007f350>] (handle_irq_event_percpu+0xa8/0=
x260) from [<c007f554>] (handle_irq_event+0x4c/0x6c)
> [ =C2=A0 =C2=A00.139556] [<c007f554>] (handle_irq_event+0x4c/0x6c) fr=
om [<c008200c>] (handle_level_irq+0xd0/0x100)
> [ =C2=A0 =C2=A00.139586] [<c008200c>] (handle_level_irq+0xd0/0x100) f=
rom [<c007ee60>] (generic_handle_irq+0x38/0x4c)
> [ =C2=A0 =C2=A00.139615] [<c007ee60>] (generic_handle_irq+0x38/0x4c) =
from [<c0014c54>] (handle_IRQ+0x6c/0x90)
> [ =C2=A0 =C2=A00.139644] [<c0014c54>] (handle_IRQ+0x6c/0x90) from [<c=
00084ac>] (asm_do_IRQ+0x14/0x18)
> [ =C2=A0 =C2=A00.139677] [<c00084ac>] (asm_do_IRQ+0x14/0x18) from [<c=
00137b8>] (__irq_svc+0x38/0xa0)
> [ =C2=A0 =C2=A00.139696] Exception stack(0xdf84dd40 to 0xdf84dd88)
> [ =C2=A0 =C2=A00.139719] dd40: 00000001 c053b798 00000001 df84a040 00=
000000 00000000 00000000 00000000
> [ =C2=A0 =C2=A00.139746] dd60: c0450cd8 00000002 60000013 df84ddcc 00=
000526 df84dd88 c047ef70 c007628c
> [ =C2=A0 =C2=A00.139765] dd80: 80000013 ffffffff
> [ =C2=A0 =C2=A00.139792] [<c00137b8>] (__irq_svc+0x38/0xa0) from [<c0=
07628c>] (lock_acquire+0x128/0x134)
> [ =C2=A0 =C2=A00.139828] [<c007628c>] (lock_acquire+0x128/0x134) from=
 [<c0277724>] (_raw_spin_lock+0x4c/0x5c)
> [ =C2=A0 =C2=A00.139861] [<c0277724>] (_raw_spin_lock+0x4c/0x5c) from=
 [<c0276810>] (rt_spin_lock_slowlock+0x38/0x1e8)
> [ =C2=A0 =C2=A00.139894] [<c0276810>] (rt_spin_lock_slowlock+0x38/0x1=
e8) from [<c0276da0>] (rt_spin_lock+0x20/0x50)
> [ =C2=A0 =C2=A00.139931] [<c0276da0>] (rt_spin_lock+0x20/0x50) from [=
<c0126070>] (sysfs_do_create_link+0x50/0x1e4)
> [ =C2=A0 =C2=A00.139964] [<c0126070>] (sysfs_do_create_link+0x50/0x1e=
4) from [<c0126238>] (sysfs_create_link+0x18/0x1c)
> [ =C2=A0 =C2=A00.140003] [<c0126238>] (sysfs_create_link+0x18/0x1c) f=
rom [<c018b1f8>] (bus_add_device+0xc4/0x178)
> [ =C2=A0 =C2=A00.140038] [<c018b1f8>] (bus_add_device+0xc4/0x178) fro=
m [<c0189e48>] (device_add+0x3d4/0x5bc)
> [ =C2=A0 =C2=A00.140070] [<c0189e48>] (device_add+0x3d4/0x5bc) from [=
<c018d768>] (platform_device_add+0x110/0x16c)
> [ =C2=A0 =C2=A00.140104] [<c018d768>] (platform_device_add+0x110/0x16=
c) from [<c036ce7c>] (regulator_dummy_init+0x3c/0x9c)
> [ =C2=A0 =C2=A00.140136] [<c036ce7c>] (regulator_dummy_init+0x3c/0x9c=
) from [<c036cc78>] (regulator_init+0x94/0xc4)
> [ =C2=A0 =C2=A00.140167] [<c036cc78>] (regulator_init+0x94/0xc4) from=
 [<c0357268>] (do_one_initcall+0x9c/0x168)
> [ =C2=A0 =C2=A00.140198] [<c0357268>] (do_one_initcall+0x9c/0x168) fr=
om [<c03573ec>] (kernel_init+0x7c/0x120)
> [ =C2=A0 =C2=A00.140228] [<c03573ec>] (kernel_init+0x7c/0x120) from [=
<c0014cd4>] (kernel_thread_exit+0x0/0x8)
>
> config: http://tonya.fnordsoft.com/omap-rt/omap-3.2.5-rt-config
> full dmesg: http://tonya.fnordsoft.com/omap-rt/rt-dmesg
> non-rt kernel dmesg: http://tonya.fnordsoft.com/omap-rt/non-rt-dmesg
>
> take care!
> /rex.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml



--=20
Only stand for myself
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
