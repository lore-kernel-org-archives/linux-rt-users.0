From: Darren Hart <dvhart@linux.intel.com>
Subject: 3.8.4-rt2 panic in migrate_task_rq_fair
Date: Fri, 05 Apr 2013 09:47:09 -0700
Message-ID: <515F000D.9090500@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:21588 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161995Ab3DEQrK (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 5 Apr 2013 12:47:10 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Running on a UEFI 32bit Atom E6xx system I see the following panic after
several minutes running the following cyclictest command.

root@sys940x:~# cyclictest -p 50 -d 10m -t -q
# /dev/cpu_dma_latency set to 0us

BUG: unable to handle kernel paging request at fffffff4
IP: [<c106a41c>] migrate_task_rq_fair+0x4c/0x100
*pde = 0198f067 *pte = 00000000
Oops: 0000 [#1] PREEMPT SMP
Modules linked in:
Pid: 649, comm: cyclictest Not tainted 3.8.4-rt2-yocto-preempt-rt #1
EIP: 0060:[<c106a41c>] EFLAGS: 00010046 CPU: 0
EIP is at migrate_task_rq_fair+0x4c/0x100
EAX: 00000000 EBX: deec43f0 ECX: 00000000 EDX: 00000000
ESI: dde8f948 EDI: c1983900 EBP: dee9fe58 ESP: dee9fe40
 DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
CR0: 80050033 CR2: fffffff4 CR3: 1ef64000 CR4: 000007d0
DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
DR6: ffff0ff0 DR7: 00000400
Process cyclictest (pid: 649, ti=dee9e000 task=def74170 task.ti=dee9e000)
Stack:
 c197f060 00000000 00000000 00000000 deec43f0 00000001 dee9fec0 c1064ec5
 c10380ce 00000010 dee9fe7c c1065894 de699ef0 619b7c30 00000000 dee9feac
 00000010 00000000 dee9fea0 c1037f76 00000000 def74170 00000001 dee9ff28
Call Trace:
 [<c1064ec5>] set_task_cpu+0x55/0x1b0
 [<c10380ce>] ? unpin_current_cpu+0xe/0x70
 [<c1065894>] ? migrate_enable+0xc4/0x1c0
 [<c1037f76>] ? pin_current_cpu+0x76/0x1c0
 [<c106713c>] try_to_wake_up+0x18c/0x300
 [<c10672ef>] wake_up_process+0x1f/0x40
 [<c10595ed>] hrtimer_wakeup+0x1d/0x30
 [<c10599cb>] __run_hrtimer+0x9b/0x260
 [<c10595d0>] ? update_rmtp+0x90/0x90
 [<c105ad62>] hrtimer_interrupt+0x272/0x320
 [<c1645ed5>] smp_apic_timer_interrupt+0x55/0x87
 [<c163f75d>] apic_timer_interrupt+0x2d/0x34
 [<c163f48c>] ? resume_kernel+0x44/0x44
Code: 83 74 01 00 00 74 48 8d 4e 58 e8 94 2e 2c 00 89 45 f0 89 55 f4 8b
8b 78 01 00 00 8b 93 74 01 00 00 29 55 f0 19 4d f4 31 c0 31 d2 <8b> 49
f4 0b 4d f0 75 2c 89 83 74 01 00 00 89 93 78 01 00 00 8b

EIP: [<c106a41c>] migrate_task_rq_fair+0x4c/0x100 SS:ESP 0068:dee9fe40
CR2: 00000000fffffff4
---[ end trace 0000000000000002 ]---
Kernel panic - not syncing: Fatal exception in interrupt

-- 
Darren Hart
Intel Open Source Technology Center
Yocto Project - Technical Lead - Linux Kernel
