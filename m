From: Dong Liu <dliu.cn@gmail.com>
Subject: patch-2.6.33.9-rt31 problem
Date: Tue, 10 Jul 2012 16:32:28 -0400
Message-ID: <4FFC915C.80202@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090203050008040707040100"
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:56858 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752691Ab2GJUc1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 10 Jul 2012 16:32:27 -0400
Received: by eekb15 with SMTP id b15so16514eek.19
        for <linux-rt-users@vger.kernel.org>; Tue, 10 Jul 2012 13:32:26 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is a multi-part message in MIME format.
--------------090203050008040707040100
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi All,

Because I could not find a solution for the cpu stall problem on kernel 
3.2.18-rt29. I thought I might try an older kernel. So I download 
linux-2.6.33.9 and patch-2.6.33.9-rt31. But 2.6.33 doesn't have 
vhost_net, so I ported vhost_net from 2.6.34 back to 2.6.33.9.

The kernel was patched and built successfully. But when I boot, I got 
kernel NULL pointer dereference error. After the error, my system seems 
stable, I can start KVM client without CPU stalls. But very frequently, 
processes will locked up for long time, the wchan displayed by ps is 
either sync_page or synchronize_rcu. It looks that rcu still causes 
problem in the rt-kernel.

The dmesg out of NULL pointer is attached.

Thanks!

Dong

--------------090203050008040707040100
Content-Type: text/plain; charset=UTF-8;
 name="kernel-null-pointer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="kernel-null-pointer.txt"

BUG: unable to handle kernel NULL pointer dereference at 0000000000000030
IP: [<ffffffff810645f1>] release_resource+0x21/0x90
PGD 123efa067 PUD 120639067 PMD 0
Oops: 0000 [#1] PREEMPT SMP
last sysfs file: /sys/kernel/kexec_crash_size
CPU 2
Pid: 1826, comm: sh Not tainted 2.6.33.9-1.el6.preempt_rt.x86_64 #1 2A9Ch/HP Elite 7100 Microtower PC
RIP: 0010:[<ffffffff810645f1>]  [<ffffffff810645f1>] release_resource+0x21/0x90
RSP: 0018:ffff880124fffde8  EFLAGS: 00010296
RAX: 0000000000000000 RBX: ffffffff81ac6e40 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000284 RDI: ffffffff8176a620
RBP: ffff880124fffdf8 R08: 0000000000000000 R09: 0000000000000008
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: ffffffff81aee8a0 R15: 0000000000000000
FS:  00007f877dd96700(0000) GS:ffff880028280000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000030 CR3: 000000011f4da000 CR4: 00000000000006e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Process sh (pid: 1826, threadinfo ffff880124ffe000, task ffff88011f426240)
Stack:
 ffff880124fffdf8 0000000000000000 ffff880124fffe48 ffffffff810a366b
<0> ffff880124fffe48 0000000000000000 0000000000000000 0000000000000001
<0> ffff880124ffff48 ffff8801271cf870 ffffffff81aee8a0 ffff880121c348c0
Call Trace:
 [<ffffffff810a366b>] crash_shrink_memory+0x14b/0x170
 [<ffffffff810845b1>] kexec_crash_size_store+0x41/0x60
 [<ffffffff81221e27>] kobj_attr_store+0x17/0x20
 [<ffffffff811b1a8c>] sysfs_write_file+0xfc/0x180
 [<ffffffff81147a78>] vfs_write+0xb8/0x1a0
 [<ffffffff810b96ea>] ? audit_syscall_entry+0x29a/0x2c0
 [<ffffffff81148451>] sys_write+0x51/0x90
 [<ffffffff8100b172>] system_call_fastpath+0x16/0x1b
Code: 66 2e 0f 1f 84 00 00 00 00 00 55 48 89 e5 53 48 83 ec 08 0f 1f 44 00 00 48 89 fb 48 c7 c7 c0 34 a8 81 e8 23 1b 43 00 48 8b 53 20 <48\
> 8b 42 30 48 85 c0 74 20 48 39 c3 75 0e eb 33 0f 1f 80 00 00
RIP  [<ffffffff810645f1>] release_resource+0x21/0x90
 RSP <ffff880124fffde8>
CR2: 0000000000000030

--------------090203050008040707040100--
