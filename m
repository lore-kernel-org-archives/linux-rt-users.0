From: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>
Subject: RE: BUG: unable to handle kernel NULL pointer dereference on
 3.18.13-rt10
Date: Fri, 10 Jul 2015 12:49:46 +0000
Message-ID: <c7ec9b06a341497687b03c367196f534@FE-MBX1012.de.bosch.com>
References: <453aa7881ded41e7a843795863ac1712@FE-MBX1012.de.bosch.com>
 <alpine.DEB.2.11.1507091605410.5134@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:44299 "EHLO
	smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753865AbbGJMts convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 10 Jul 2015 08:49:48 -0400
In-Reply-To: <alpine.DEB.2.11.1507091605410.5134@nanos>
Content-Language: de-DE
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Thomas,

> Looks like the old ghosts of exit race conditions have come back to
> haunt us.
> 
> I have no idea how this can happen because all protections are in
> place. Can you try to reproduce that with function tracing enabled?
> 
> If the machine is still accessible you can retrieve the trace in the
> usual way. Otherwise you need to enable ftrace_dump_on_oops and let it
> spill out over the serial console.

I have been able to catch this BUG again on a different PC during a reboot. Unfortunately, it happened before I had enabled ftrace_dump_on_oops.
BTW: Is it possible to configure the tracing to be already active on boot?

[    4.844585] BUG: unable to handle kernel NULL pointer dereference at 0000001c
[    4.844598] IP: [<c107fb62>] __try_to_take_rt_mutex+0x52/0x100
[    4.844599] *pde = 00000000 
[    4.844600] Oops: 0000 [#1] PREEMPT SMP 
[    4.844620] Modules linked in: dis_irm(O+) es53xx(O) nfsd nfs lockd grace sunrpc bridge stp llc e100 mii e1000 kvm_intel kvm pcspkr psmouse i2c_i801 radeon drm_kms_helper ttm drm agpgart e1000e igb i2c_algo_bit i2c_core ixgbe mdio ptp pps_core dca parport_pc parport video backlight acpi_cpufreq processor coretemp autofs4 reiserfs microcode sg sd_mod ahci libahci ehci_pci ehci_hcd fan thermal_sys hwmon xhci_pci xhci_hcd
[    4.844621] CPU: 0 PID: 2392 Comm: ps Tainted: G           O   3.18.13-rt10-2 #1
[    4.844622] Hardware name: LENOVO 32282Z8/MAHOBAY, BIOS 9SKT70AUS 06/07/2013
[    4.844622] task: ea3d0000 ti: ea3cc000 task.ti: ea3cc000
[    4.844623] EIP: 0060:[<c107fb62>] EFLAGS: 00010282 CPU: 0
[    4.844624] EIP is at __try_to_take_rt_mutex+0x52/0x100
[    4.844625] EAX: 00000000 EBX: 00000000 ECX: ea3cdda8 EDX: 00000000
[    4.844625] ESI: ea3d0000 EDI: ea072f04 EBP: ea3cdd88 ESP: ea3cdd78
[    4.844625]  DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
[    4.844626] CR0: 80050033 CR2: 0000001c CR3: 2aff3000 CR4: 001407d0
[    4.844626] Stack:
[    4.844628]  ea3d0000 ea072f04 ea3d04b0 ea3cdda8 ea3cdddc c1404169 00000001 ea3cdfec
[    4.844629]  ea274201 ea3d0000 ea3d04b0 ea3d0000 00000001 00000000 00000000 ea3cddb4
[    4.844630]  00000000 00000000 ea3d0000 ea072f04 c1045b01 00000078 ea3d0000 ea274800
[    4.844630] Call Trace:
[    4.844633]  [<c1404169>] rt_spin_lock_slowlock+0xf9/0x240
[    4.844635]  [<c1045b01>] ? pin_current_cpu+0x31/0x1a0
[    4.844637]  [<c1405567>] rt_spin_lock+0x27/0x30
[    4.844638]  [<c1051508>] __lock_task_sighand+0x38/0x70
[    4.844640]  [<c1196662>] do_task_stat+0xf2/0xd40
[    4.844642]  [<c1069580>] ? migrate_enable+0x80/0x180
[    4.844644]  [<c11f77ac>] ? lockref_put_or_lock+0x2c/0x40
[    4.844646]  [<c1201bd2>] ? debug_smp_processor_id+0x12/0x20
[    4.844647]  [<c1045c83>] ? unpin_current_cpu+0x13/0x60
[    4.844647]  [<c1069580>] ? migrate_enable+0x80/0x180
[    4.844648]  [<c11f77ac>] ? lockref_put_or_lock+0x2c/0x40
[    4.844650]  [<c115f9f5>] ? mntput_no_expire+0x25/0x150
[    4.844651]  [<c115fb40>] ? mntput+0x20/0x40
[    4.844653]  [<c1150220>] ? path_openat+0x120/0x550
[    4.844654]  [<c1068fab>] ? get_parent_ip+0xb/0x40
[    4.844655]  [<c11979bf>] proc_tgid_stat+0x1f/0x30
[    4.844656]  [<c1193312>] proc_single_show+0x42/0x80
[    4.844657]  [<c1163d12>] seq_read+0x82/0x380
[    4.844658]  [<c1150a3d>] ? final_putname+0x1d/0x40
[    4.844659]  [<c1163c90>] ? seq_lseek+0x1c0/0x1c0
[    4.844660]  [<c1142684>] vfs_read+0x74/0x140
[    4.844661]  [<c1142ca6>] SyS_read+0x46/0x90
[    4.844662]  [<c1405c54>] sysenter_do_call+0x12/0x12
[    4.844669] Code: 83 cb 01 f0 0f b1 1e 39 d0 75 ee 8b 5f 0c 31 c0 83 e3 fe 74 0c 83 c4 04 5b 5e 5f 5d c3 8d 74 26 00 8b 75 f0 85 c9 74 1d 8b 57 08 <3b> 7a 1c 0f 85 93 00 00 00 89 d8 39 d1 75 db 89 ca 89 f8 e8 c6
[    4.844671] EIP: [<c107fb62>] __try_to_take_rt_mutex+0x52/0x100 SS:ESP 0068:ea3cdd78
[    4.844671] CR2: 000000000000001c
[    5.168516] ---[ end trace 0000000000000002 ]---
[    5.168517] note: ps[2392] exited with preempt_count 1
[    5.168554] ------------[ cut here ]-

Regards

Mathias

