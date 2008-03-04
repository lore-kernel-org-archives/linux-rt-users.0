From: Sripathi Kodi <sripathik@in.ibm.com>
Subject: BUG on 2.6.24.3-rt3.
Date: Tue, 4 Mar 2008 22:49:15 +0530
Message-ID: <200803042249.15945.sripathik@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: mingo@elte.hu
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from E23SMTP06.au.ibm.com ([202.81.18.175]:60754 "EHLO
	e23smtp06.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755931AbYCDRSm (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 4 Mar 2008 12:18:42 -0500
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp06.au.ibm.com (8.13.1/8.13.1) with ESMTP id m24HIQ2o010688
	for <linux-rt-users@vger.kernel.org>; Wed, 5 Mar 2008 04:18:26 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id m24HIepw3911704
	for <linux-rt-users@vger.kernel.org>; Wed, 5 Mar 2008 04:18:40 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m24HIiHu019057
	for <linux-rt-users@vger.kernel.org>; Wed, 5 Mar 2008 04:18:44 +1100
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

We are seeing the following BUG on 2.6.24.3-rt3.

task_setprio() holds the rq->lock of the runqueue we are dealing with. 
However, when we reach resched_task through prio_changed_rt(), we see 
that the corresponding rq->lock is not held. The lock is a raw 
spinlock.


static void resched_task(struct task_struct *p)
{
        int cpu;

        assert_spin_locked(&task_rq(p)->lock); <== We hit BUG here.


I can recreate the problem easily and can also get a kdump. Please let 
me know if any other information will help in analyzing this. 


kernel BUG at kernel/sched.c:836!
invalid opcode: 0000 [1] PREEMPT SMP 
CPU 2 
Modules linked in: autofs4 hidp rfcomm l2cap bluetooth sunrpc 
nf_conntrack_netbios_ns ipt_REJECT nf_conntrack_
ipv4 xt_state iptable_filter ip_tables ip6t_REJECT xt_tcpudp 
ip6table_filter ip6_tables x_tables ipv6 dm_mirro
r dm_multipath dm_mod video output sbs sbshc dock battery ac parport_pc 
lp parport joydev sg tg3 rtc_cmos amd_
rng rtc_core shpchp serio_raw i2c_amd756 button rtc_lib k8temp hwmon 
i2c_core pcspkr scsi_transport_fc scsi_tg
t mptspi mptscsih scsi_transport_spi mptbase sd_mod scsi_mod ext3 jbd 
ehci_hcd ohci_hcd ssb uhci_hcd
Pid: 4685, comm: java Not tainted 2.6.24.3-rt3 #1
RIP: 0010:[<ffffffff8022e7e7>]  [<ffffffff8022e7e7>] 
resched_task+0x24/0x5e
RSP: 0000:ffff8101fe1ebcf8  EFLAGS: 00210002
RAX: 0000000000000001 RBX: ffff81020c6c36c0 RCX: ffff81020c6c4000
RDX: ffffffff8062a100 RSI: 00000000000000bf RDI: ffff81020c6c36c0
RBP: ffff8101fe1ebcf8 R08: 0000000000000004 R09: 000000000000003c
R10: 0000000100000003 R11: ffff8101fe1ebcd8 R12: ffff8101120ae480
R13: 0000000000000001 R14: 0000000000000038 R15: ffffffff804b49e0
FS:  00002ae937855260(0000) GS:ffff810211acb740(0000) 
knlGS:00000000b7338b90
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000009d356dc CR3: 000000010e533000 CR4: 00000000000006e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Process java (pid: 4685, threadinfo ffff8101fe1ea000, task 
ffff8101fb431400)
Stack:  ffff8101fe1ebd18 ffffffff8022feac ffff81020c6c36c0 
ffff8101120ae480
 ffff8101fe1ebd68 ffffffff80237121 0000002e00000001 ffff81010f872e80
 0000000000200097 ffff81020c6c36c0 ffff81020c6c3dd0 ffff8101fe1ebe18
Call Trace:
 [<ffffffff8022feac>] prio_changed_rt+0x41/0x46
 [<ffffffff80237121>] task_setprio+0x178/0x1a0
 [<ffffffff80259b50>] __rt_mutex_adjust_prio+0x20/0x24
 [<ffffffff8025a309>] task_blocks_on_rt_mutex+0x15b/0x1bf
 [<ffffffff8049cc2e>] rt_mutex_slowlock+0x184/0x29d
 [<ffffffff8049c90a>] rt_mutex_lock+0x28/0x2a
 [<ffffffff8025a53b>] __rt_down_read+0x47/0x4b
 [<ffffffff8025a555>] rt_down_read+0xb/0xd
 [<ffffffff8023c5a9>] exit_mm+0x34/0x12d
 [<ffffffff8023ddaf>] do_exit+0x277/0x841
 [<ffffffff8020f65b>] syscall_trace_enter+0x95/0x99
 [<ffffffff8023e42f>] complete_and_exit+0x0/0x1e
 [<ffffffff80226b62>] ia32_sysret+0x0/0xa


Code: 0f 0b eb fe 8b 41 10 a8 08 75 2d f0 0f ba 69 10 03 48 8b 47 
RIP  [<ffffffff8022e7e7>] resched_task+0x24/0x5e
 RSP <ffff8101fe1ebcf8>

Thanks,
Sripathi.
