From: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>
Subject: BUG: unable to handle kernel NULL pointer dereference on 3.18.13-rt10
Date: Thu, 9 Jul 2015 10:49:51 +0000
Message-ID: <453aa7881ded41e7a843795863ac1712@FE-MBX1012.de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:50089 "EHLO
	smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799AbbGIKty convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 9 Jul 2015 06:49:54 -0400
Received: from vsmta14.fe.internet.bosch.com (unknown [10.4.98.54])
	by imta24.fe.bosch.de (Postfix) with ESMTP id 9FC8AD80204
	for <linux-rt-users@vger.kernel.org>; Thu,  9 Jul 2015 12:49:52 +0200 (CEST)
Received: from FE-MBX1012.de.bosch.com (vsgw23.fe.internet.bosch.com [10.4.98.23])
	by vsmta14.fe.internet.bosch.com (Postfix) with ESMTP id 9D279A40299
	for <linux-rt-users@vger.kernel.org>; Thu,  9 Jul 2015 12:49:52 +0200 (CEST)
Content-Language: de-DE
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi all,

I have 3.18.13-rt10 running on a x86 PC (32bit) system.
Linux Distribution: Debian 8.1 "Jessie".
Fairly often (but not reproducible for me) I got the following kernel bug.
I looks like the systemd-journald reads some kind of /proc/PID/status file.


BUG: unable to handle kernel NULL pointer dereference at 0000001c
IP: [<c107fb62>] __try_to_take_rt_mutex+0x52/0x100
*pde = 00000000
Oops: 0000 [#1] PREEMPT SMP
Modules linked in: rtpc_dma(O) es53xx(O) nfsd nfs lockd grace sunrpc bridge stp llc e100 mii e1000 e1000e igb i2c_algo_bit ixgbe mdio ptp pps_core dca kvm_intel kvm ecikm(O) i2c_i801 pcspkr i2c_core video backlight processor coretemp autofs4 reiserfs microcode sg sd_mod ahci libahci ehci_pci ehci_hcd xhci_pci xhci_hcd fan thermal_sys hwmon
CPU: 0 PID: 1522 Comm: systemd-journal Tainted: G           O   3.18.13-rt10-2 #2
Hardware name: Supermicro X9SAE/X9SAE, BIOS 2.0b 07/10/2013
task: dff76000 ti: f4760000 task.ti: f4760000
EIP: 0060:[<c107fb62>] EFLAGS: 00010282 CPU: 0
EIP is at __try_to_take_rt_mutex+0x52/0x100
EAX: 00000000 EBX: 00000000 ECX: f4761df4 EDX: 00000000
ESI: dff76000 EDI: dfdec944 EBP: f4761dd4 ESP: f4761dc4
DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
CR0: 80050033 CR2: f8b5cbc0 CR3: 344ad000 CR4: 001407d0
Stack:
dff76000 dfdec944 dff764b0 f4761df4 f4761e28 c1404169 00000001 f4761fec
f3ba9201 dff76000 dff764b0 dff76000 00000001 00000000 00000000 f4761e00
00000000 00000000 dff76000 dfdec944 c1045b01 00000078 dff76000 f3bae000
Call Trace:
[<c1404169>] rt_spin_lock_slowlock+0xf9/0x240
[<c1045b01>] ? pin_current_cpu+0x31/0x1a0
[<c1405567>] rt_spin_lock+0x27/0x30
[<c1051508>] __lock_task_sighand+0x38/0x70
[<c119768b>] proc_pid_status+0x33b/0x620
[<c1193312>] proc_single_show+0x42/0x80
[<c1163d12>] seq_read+0x82/0x380
[<c11283fa>] ? do_mmap_pgoff+0x27a/0x350
[<c1080abd>] ? rt_up_write+0xd/0x10
[<c1163c90>] ? seq_lseek+0x1c0/0x1c0
[<c1142684>] vfs_read+0x74/0x140
[<c1142ca6>] SyS_read+0x46/0x90
[<c1405c54>] sysenter_do_call+0x12/0x12
Code: 83 cb 01 f0 0f b1 1e 39 d0 75 ee 8b 5f 0c 31 c0 83 e3 fe 74 0c 83 c4 04 5b 5e 5f 5d c3 8d 74 26 00 8b 75 f0 85 c9 74 1d 8b 57 08 <3b> 7a 1c 0f 85 93 00 00 00 89 d8 39 d1 75 db 89 ca 89 f8 e8 c6
EIP: [<c107fb62>] __try_to_take_rt_mutex+0x52/0x100 SS:ESP 0068:f4761dc4
CR2: 000000000000001c
---[ end trace 0000000000


Thanks for any support or proposals on this issue.

Mathias
