From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference on
 3.18.13-rt10
Date: Thu, 9 Jul 2015 16:11:41 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1507091605410.5134@nanos>
References: <453aa7881ded41e7a843795863ac1712@FE-MBX1012.de.bosch.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:42437 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752561AbbGIOLt (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 9 Jul 2015 10:11:49 -0400
In-Reply-To: <453aa7881ded41e7a843795863ac1712@FE-MBX1012.de.bosch.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 9 Jul 2015, Koehrer Mathias (ETAS/ESW5) wrote:
> BUG: unable to handle kernel NULL pointer dereference at 0000001c
> IP: [<c107fb62>] __try_to_take_rt_mutex+0x52/0x100
> *pde = 00000000
> Oops: 0000 [#1] PREEMPT SMP
> Modules linked in: rtpc_dma(O) es53xx(O) nfsd nfs lockd grace sunrpc bridge stp llc e100 mii e1000 e1000e igb i2c_algo_bit ixgbe mdio ptp pps_core dca kvm_intel kvm ecikm(O) i2c_i801 pcspkr i2c_core video backlight processor coretemp autofs4 reiserfs microcode sg sd_mod ahci libahci ehci_pci ehci_hcd xhci_pci xhci_hcd fan thermal_sys hwmon
> CPU: 0 PID: 1522 Comm: systemd-journal Tainted: G           O   3.18.13-rt10-2 #2
> Hardware name: Supermicro X9SAE/X9SAE, BIOS 2.0b 07/10/2013
> task: dff76000 ti: f4760000 task.ti: f4760000
> EIP: 0060:[<c107fb62>] EFLAGS: 00010282 CPU: 0
> EIP is at __try_to_take_rt_mutex+0x52/0x100
> EAX: 00000000 EBX: 00000000 ECX: f4761df4 EDX: 00000000
> ESI: dff76000 EDI: dfdec944 EBP: f4761dd4 ESP: f4761dc4
> DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
> CR0: 80050033 CR2: f8b5cbc0 CR3: 344ad000 CR4: 001407d0
> Stack:
> dff76000 dfdec944 dff764b0 f4761df4 f4761e28 c1404169 00000001 f4761fec
> f3ba9201 dff76000 dff764b0 dff76000 00000001 00000000 00000000 f4761e00
> 00000000 00000000 dff76000 dfdec944 c1045b01 00000078 dff76000 f3bae000
> Call Trace:
> [<c1404169>] rt_spin_lock_slowlock+0xf9/0x240
> [<c1045b01>] ? pin_current_cpu+0x31/0x1a0
> [<c1405567>] rt_spin_lock+0x27/0x30
> [<c1051508>] __lock_task_sighand+0x38/0x70
> [<c119768b>] proc_pid_status+0x33b/0x620
> [<c1193312>] proc_single_show+0x42/0x80
> [<c1163d12>] seq_read+0x82/0x380
> [<c11283fa>] ? do_mmap_pgoff+0x27a/0x350
> [<c1080abd>] ? rt_up_write+0xd/0x10
> [<c1163c90>] ? seq_lseek+0x1c0/0x1c0
> [<c1142684>] vfs_read+0x74/0x140
> [<c1142ca6>] SyS_read+0x46/0x90
> [<c1405c54>] sysenter_do_call+0x12/0x12
> Code: 83 cb 01 f0 0f b1 1e 39 d0 75 ee 8b 5f 0c 31 c0 83 e3 fe 74 0c 83 c4 04 5b 5e 5f 5d c3 8d 74 26 00 8b 75 f0 85 c9 74 1d 8b 57 08 <3b> 7a 1c 0f 85 93 00 00 00 89 d8 39 d1 75 db 89 ca 89 f8 e8 c6
> EIP: [<c107fb62>] __try_to_take_rt_mutex+0x52/0x100 SS:ESP 0068:f4761dc4
> CR2: 000000000000001c
> ---[ end trace 0000000000

Looks like the old ghosts of exit race conditions have come back to
haunt us.

I have no idea how this can happen because all protections are in
place. Can you try to reproduce that with function tracing enabled?

If the machine is still accessible you can retrieve the trace in the
usual way. Otherwise you need to enable ftrace_dump_on_oops and let it
spill out over the serial console.

Thanks,

	tglx
