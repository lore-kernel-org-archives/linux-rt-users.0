From: Allen Pais <allen.pais@oracle.com>
Subject: Cyclictest results on Sparc64 with PREEMPT_RT
Date: Mon, 27 Jan 2014 13:50:43 +0530
Message-ID: <52E616DB.2040202@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, "" <davem@davemloft.net>,
	"Sebastian Andrzej Siewior bigeasy"@linutronix.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:27849 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145AbaA0IVO (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 27 Jan 2014 03:21:14 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

Here's a quick update on how Sparc64(with PREEMPT_RT) behaved with cyclictest.

./cyclictest -l 10000 -i 1000 -n -p 80 -q

With PREEMPT_RT
kernel version: v3.10.24-rt22

(with out load)
Min:6 Act:7 Avg:7 Max:10

(with Load, without hackbench)
Min:6 Act:7 Avg:7 Max:46


Without PREEMPT_RT
kernel version: v3.10

(with out load)
Min:12 Act:13 Avg:13 Max:16

(with load, without hackbench)
Min:10 Act:16 Avg:15 Max:813

But with load after point of repeated tests, the system hit a Soft lockup.

<snip>
[ 1143.894099] INFO: rcu_preempt self-detected stall on CPU { 36}  (t=2100 jiffies g=373 c=372 q=61)
[ 1143.894130]   CPU[  0]: TSTATE[0000009980001602] TPC[000000000048d1ac] TNPC[000000000048d1b0] TASK[ksoftirqd/0:3]
[ 1143.894151]              TPC[idle_cpu+0x2c/0x80] O7[cpumask_next_and+0x18/0x80] I7[find_busiest_group+0x21c/0xa40] RPC[load_balance+0xe8/0x880]
.....
<snip>

trace:

[ 1150.135499] BUG: soft lockup - CPU#36 stuck for 23s! [swapper/36:0]
[ 1150.135552] Modules linked in: usb_storage binfmt_misc ehci_pci ehci_hcd sg n2_rng rng_core ext4 jbd2 crc16 sr_mod mpt2sas scsi_transport_sas raid_class sunvnet sunvdc dm_mirror dm_region_hash dm_log dm_mod be2iscsi iscsi_boot_sysfs bnx2i cnic uio ipv6 cxgb4i cxgb4 cxgb3i libcxgbi cxgb3 mdio libiscsi_tcp libiscsi scsi_transport_iscsi
[ 1150.135556] CPU: 36 PID: 0 Comm: swapper/36 Tainted: G        W    3.10.22-rt19+ #9
[ 1150.135559] task: fffff80fd4dc5b00 ti: fffff80fd4dfc000 task.ti: fffff80fd4dfc000
[ 1150.135561] TSTATE: 0000000080001601 TPC: 0000000000404b54 TNPC: 0000000000404b58 Y: 00000000    Tainted: G        W   
[ 1150.135564] TPC: <rtrap_no_irq_enable+0x0/0xc>
[ 1150.135566] g0: 00000000009d4080 g1: fffff80fd4dfc000 g2: 0000000001010001 g3: 0000000001010001
[ 1150.135567] g4: fffff80fd4dc5b00 g5: fffff80fde86c000 g6: fffff80fd4dfc000 g7: 00000000009dc140
[ 1150.135569] o0: 0000000000000001 o1: fffff80fd4dfec80 o2: 0000000000404b58 o3: 0000000000000000
[ 1150.135570] o4: 000000000000004f o5: 0000000000000185 sp: fffff80fd4dfe3c1 ret_pc: 00000000004209f4
[ 1150.135572] RPC: <tl0_irq15+0x14/0x20>
[ 1150.135574] l0: 0000000000001000 l1: 0000000080001600 l2: 00000000004209f0 l3: 000000000000000a
[ 1150.135576] l4: 0000000000000000 l5: 0000000fdea2c000 l6: fffff80fd4dfc000 l7: 0000000080001001
[ 1150.135577] i0: 0000000000000001 i1: fffff80fd4dfede0 i2: 0000000000404b58 i3: 0000000000000000
[ 1150.135578] i4: 000000000000004f i5: 0000000000000185 i6: fffff80fd4dfe521 i7: 00000000004209f4
[ 1150.135581] I7: <tl0_irq15+0x14/0x20>
[ 1150.135582] Call Trace:
[ 1150.135584]  [0000000000404b54] rtrap_no_irq_enable+0x0/0xc
[ 1150.135586]  [0000000000404b54] rtrap_no_irq_enable+0x0/0xc
[ 1150.135588]  [0000000000404b54] rtrap_no_irq_enable+0x0/0xc
[ 1150.135590]  [0000000000404b54] rtrap_no_irq_enable+0x0/0xc
[ 1150.135592]  [0000000000404b54] rtrap_no_irq_enable+0x0/0xc
[ 1150.135594]  [0000000000404b54] rtrap_no_irq_enable+0x0/0xc
[ 1150.135595]  [0000000000404b54] rtrap_no_irq_enable+0x0/0xc
[ 1150.135597]  [0000000000404b54] rtrap_no_irq_enable+0x0/0xc
[ 1150.135599]  [0000000000404b54] rtrap_no_irq_enable+0x0/0xc
[ 1150.135600]  [0000000000404b54] rtrap_no_irq_enable+0x0/0xc
[ 1150.135604]  [00000000004acc00] in_lock_functions+0x0/0x40
[ 1150.135608]  [000000000080a038] add_preempt_count+0xd8/0x140
[ 1150.135610]  [000000000080617c] __schedule+0x1c/0x500
[ 1150.135613]  [0000000000806b7c] schedule+0x1c/0xc0
[ 1150.135615]  [0000000000806f8c] schedule_preempt_disabled+0xc/0x40
[ 1150.135617]  [000000000049dd10] cpu_startup_entry+0x150/0x300
[ 1160.917971] sd 0:0:0:0: attempting task abort! scmd(fffff80fcea88620)
[ 1164.407662] sd 0:0:0:0: [sda] CDB: 
[ 1164.414603] Read(10): 28 00 27 21 3f b3 00 00 08 00
[ 1164.424320] scsi target0:0:0: handle(0x0009), sas_address(0x5000cca025967659), phy(0)
[ 1164.439960] scsi target0:0:0: enclosure_logical_id(0x50800200013890f8), slot(0)

Message from syslogd@localhost at Jan 27 02:51:15 ...
 kernel:[ 1150.135499] BUG: soft lockup - CPU#36 stuck for 23s! [swapper/36:0]
[ 1194.455533] mpt2sas0: mpt2sas_scsih_issue_tm: timeout
[ 1194.465348] mf:
	01000009 00000100 00000000 00000000 00000000 00000000 00000000 00000000 
	00000000 00000000 00000000 00000000 00000362 
[ 1204.487799] mpt2sas0: sending diag reset !!
[ 1205.598040] mpt2sas0: diag reset: SUCCESS

Am yet to debug what went wrong. 

- Allen
