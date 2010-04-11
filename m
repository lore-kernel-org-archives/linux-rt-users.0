From: Udo van den Heuvel <udovdh@xs4all.nl>
Subject: 2.6.33.1-rt11-related bug?
Date: Sun, 11 Apr 2010 09:53:56 +0200
Message-ID: <4BC18014.4040506@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from pindarots.xs4all.nl ([80.101.128.228]:54309 "EHLO
	pindarots.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751050Ab0DKHx6 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 11 Apr 2010 03:53:58 -0400
Received: from surfplank2.hierzo (localhost.localdomain [127.0.0.1])
	by pindarots.xs4all.nl (8.14.3/8.14.3) with ESMTP id o3B7ruNb011263
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO)
	for <linux-rt-users@vger.kernel.org>; Sun, 11 Apr 2010 09:53:56 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

Can anyone shed some light on this bug?

Kind regards,
Udo

BUG: unable to handle kernel paging request at ffffffff8970247d
IP: [<ffffffff810c9080>] __mem_cgroup_try_charge+0x20/0x2d0
PGD 14f3067 PUD 14f7063 PMD 0
Oops: 0002 [#1] PREEMPT SMP
last sysfs file:
/sys/devices/pci0000:00/0000:00:06.0/net/eth0/statistics/collisions
CPU 2
Pid: 10270, comm: cc1 Not tainted 2.6.33.1-rt11 #4 GA-M56S-S3/M56S-S3
RIP: 0010:[<ffffffff810c9080>]  [<ffffffff810c9080>]
__mem_cgroup_try_charge+0x20/0x2d0
RSP: 0000:ffff88000539bd88  EFLAGS: 00010296
RAX: ffff88011c290880 RBX: ffff88011c290880 RCX: 0000000000000001
RDX: ffff88000539be20 RSI: 00000000000000d0 RDI: ffff88011fb30c00
RBP: ffff88000539be20 R08: ffffea000183efa0 R09: 00000000000035b6
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88011fb30c00
R13: 0000000000000001 R14: 00000000000000d0 R15: 0000000000000000
FS:  00007f9f037bf700(0000) GS:ffff880028300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffff8970247d CR3: 000000009c478000 CR4: 00000000000006e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Process cc1 (pid: 10270, threadinfo ffff88000539a000, task ffff880115b0e810)
Stack:
 00000010000280da ffff88011c290820 0000000000000001 ffffffff810c8d88
<0> 01000000000000da ffff88011f85ac00 ffff88011c290828 0000000000000001
<0> 0000000000000001 ffff88011c290880 ffffea000183efa0 ffff88011fb30c00
Call Trace:
 [<ffffffff810c8d88>] ? mem_cgroup_charge_statistics+0x78/0xf0
 [<ffffffff810c9a7e>] ? mem_cgroup_charge_common+0x5e/0xb0
 [<ffffffff810b0ad5>] ? handle_mm_fault+0x6e5/0x910
 [<ffffffff810b68f0>] ? mmap_region+0x1f0/0x510
 [<ffffffff81024a2f>] ? do_page_fault+0x13f/0x3b0
 [<ffffffff8139904f>] ? page_fault+0x1f/0x30
Code: ff e9 6a ff ff ff 0f 1f 44 00 00 48 83 ec 78 48 89 6c 24 50 48 89
5c 24 48 48 89 d5 4c 89 64 24 58 4c 89 6c 24 60 4c 89 74 24 68 <4c> 89
7c 24 70 89 74 24 0c 4c 89 44 24 18 88 4c 24 27 65 48 8b
RIP  [<ffffffff810c9080>] __mem_cgroup_try_charge+0x20/0x2d0
 RSP <ffff88000539bd88>
CR2: ffffffff8970247d
---[ end trace e87d617f94498765 ]---
BUG: unable to handle kernel paging request at ffffffff8970247d
IP: [<ffffffff810c9080>] __mem_cgroup_try_charge+0x20/0x2d0
PGD 14f3067 PUD 14f7063 PMD 0
Oops: 0002 [#2] PREEMPT SMP
last sysfs file:
/sys/devices/pci0000:00/0000:00:06.0/net/eth0/statistics/collisions
CPU 2
Pid: 10271, comm: as Tainted: G      D    2.6.33.1-rt11 #4
GA-M56S-S3/M56S-S3
RIP: 0010:[<ffffffff810c9080>]  [<ffffffff810c9080>]
__mem_cgroup_try_charge+0x20/0x2d0
RSP: 0000:ffff880005281d88  EFLAGS: 00010296
RAX: ffff88011da968e0 RBX: ffff88011da968e0 RCX: 0000000000000001
RDX: ffff880005281e20 RSI: 00000000000000d0 RDI: ffff8800263e5000
RBP: ffff880005281e20 R08: ffffea0000dc27d8 R09: 0000000000004764
R10: 0000000000000000 R11: 00003ffffffff000 R12: ffff8800263e5000
R13: 0000000000000001 R14: 00000000000000d0 R15: 0000000000000000
FS:  00007f3bde439700(0000) GS:ffff880028300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffff8970247d CR3: 00000000bbfbb000 CR4: 00000000000006e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Process as (pid: 10271, threadinfo ffff880005280000, task ffff88009c788810)
Stack:
 00000010000280da 0000000000000008 ffff8801196f80e8 ffff88011f85ac00
<0> 0000000000000001 ffffffff810c9bc2 ffff8800263e5000 ffff8800053e4db0
<0> ffffea0002bbb5d8 ffff88011da968e0 ffffea0000dc27d8 ffff8800263e5000
Call Trace:
 [<ffffffff810c9bc2>] ? mem_cgroup_update_file_mapped+0x92/0xd0
 [<ffffffff810c9a7e>] ? mem_cgroup_charge_common+0x5e/0xb0
 [<ffffffff810b0ad5>] ? handle_mm_fault+0x6e5/0x910
 [<ffffffff810c33dc>] ? kmem_cache_free+0x8c/0xf0
 [<ffffffff81024a2f>] ? do_page_fault+0x13f/0x3b0
 [<ffffffff8139904f>] ? page_fault+0x1f/0x30
Code: ff e9 6a ff ff ff 0f 1f 44 00 00 48 83 ec 78 48 89 6c 24 50 48 89
5c 24 48 48 89 d5 4c 89 64 24 58 4c 89 6c 24 60 4c 89 74 24 68 <4c> 89
7c 24 70 89 74 24 0c 4c 89 44 24 18 88 4c 24 27 65 48 8b
RIP  [<ffffffff810c9080>] __mem_cgroup_try_charge+0x20/0x2d0
 RSP <ffff880005281d88>
CR2: ffffffff8970247d
---[ end trace e87d617f94498766 ]---
BUG: unable to handle kernel paging request at ffffffff8970247d
IP: [<ffffffff810c9080>] __mem_cgroup_try_charge+0x20/0x2d0
PGD 14f3067 PUD 14f7063 PMD 0
Oops: 0002 [#3] PREEMPT SMP
last sysfs file:
/sys/devices/pci0000:00/0000:00:06.0/net/eth0/statistics/collisions
CPU 2
Pid: 10269, comm: gcc Tainted: G      D    2.6.33.1-rt11 #4
GA-M56S-S3/M56S-S3
RIP: 0010:[<ffffffff810c9080>]  [<ffffffff810c9080>]
__mem_cgroup_try_charge+0x20/0x2d0
RSP: 0000:ffff88000524fd88  EFLAGS: 00010296
RAX: ffff88011d988ee0 RBX: ffff88011d988ee0 RCX: 0000000000000001
RDX: ffff88000524fe20 RSI: 00000000000000d0 RDI: ffff88009c4bdc00
RBP: ffff88000524fe20 R08: ffffea0000d25358 R09: 0000000000004ac8
R10: 0000000000000000 R11: 00003ffffffff000 R12: ffff88009c4bdc00
R13: 0000000000000001 R14: 00000000000000d0 R15: 0000000000000000
FS:  00007f3260062700(0000) GS:ffff880028300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffff8970247d CR3: 00000000bbfd7000 CR4: 00000000000006e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Process gcc (pid: 10269, threadinfo ffff88000524e000, task ffff8800bbd76810)
Stack:
 00000010000280da ffff88006cf86a68 ffff880079234b90 ffff88002830b7e0
<0> ffffffff81508bc0 0000000000000246 ffff88009c4bdc00 00000036c4048e10
<0> ffffea0003eff628 ffff88011d988ee0 ffffea0000d25358 ffff88009c4bdc00
Call Trace:
 [<ffffffff810c9a7e>] ? mem_cgroup_charge_common+0x5e/0xb0
 [<ffffffff810b0ad5>] ? handle_mm_fault+0x6e5/0x910
 [<ffffffff813987fc>] ? rt_spin_lock+0x2c/0x70
 [<ffffffff81024a2f>] ? do_page_fault+0x13f/0x3b0
 [<ffffffff8139904f>] ? page_fault+0x1f/0x30
Code: ff e9 6a ff ff ff 0f 1f 44 00 00 48 83 ec 78 48 89 6c 24 50 48 89
5c 24 48 48 89 d5 4c 89 64 24 58 4c 89 6c 24 60 4c 89 74 24 68 <4c> 89
7c 24 70 89 74 24 0c 4c 89 44 24 18 88 4c 24 27 65 48 8b
RIP  [<ffffffff810c9080>] __mem_cgroup_try_charge+0x20/0x2d0
 RSP <ffff88000524fd88>
CR2: ffffffff8970247d
---[ end trace e87d617f94498767 ]---
BUG: unable to handle kernel paging request at ffffffff8970247d
IP: [<ffffffff810c9080>] __mem_cgroup_try_charge+0x20/0x2d0
PGD 14f3067 PUD 14f7063 PMD 0
Oops: 0002 [#4] PREEMPT SMP
last sysfs file:
/sys/devices/pci0000:00/0000:00:06.0/net/eth0/statistics/collisions
CPU 2
Pid: 10266, comm: gcc Tainted: G      D    2.6.33.1-rt11 #4
GA-M56S-S3/M56S-S3
RIP: 0010:[<ffffffff810c9080>]  [<ffffffff810c9080>]
__mem_cgroup_try_charge+0x20/0x2d0
RSP: 0000:ffff880005385bd8  EFLAGS: 00010296
RAX: ffff88011d075720 RBX: ffff88011d075720 RCX: 0000000000000001
RDX: ffff880005385c70 RSI: 00000000000000d0 RDI: ffff88009c4bdc00
RBP: ffff880005385c70 R08: ffffea0001004828 R09: 0000000000004b06
R10: 0000000000000000 R11: 00003ffffffff000 R12: ffff88009c4bdc00
R13: 0000000000000001 R14: 00000000000000d0 R15: 0000000000000000
FS:  00007f0799e86700(0000) GS:ffff880028300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: ffffffff8970247d CR3: 000000006cdea000 CR4: 00000000000006e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Process gcc (pid: 10266, threadinfo ffff880005384000, task ffff8801156db810)
Stack:
 00000010000280da ffffffff813987fc ffff88002830bf60 ffffffff813987fc
<0> 0000000000000002 ffffffff810c2c36 00000000000000d0 ffff880005385c54
<0> ffff88011f836ec0 ffff88011d075720 ffffea0001004828 ffff88009c4bdc00
Call Trace:
 [<ffffffff813987fc>] ? rt_spin_lock+0x2c/0x70
 [<ffffffff813987fc>] ? rt_spin_lock+0x2c/0x70
 [<ffffffff810c2c36>] ? _slab_irq_disable+0x46/0x60
 [<ffffffff810c9a7e>] ? mem_cgroup_charge_common+0x5e/0xb0
 [<ffffffff810b0ad5>] ? handle_mm_fault+0x6e5/0x910
 [<ffffffff810b0e49>] ? __get_user_pages+0x149/0x3f0
 [<ffffffff810d26f6>] ? get_arg_page+0x56/0xc0
 [<ffffffff810d286c>] ? copy_strings+0x10c/0x230
 [<ffffffff810d29be>] ? copy_strings_kernel+0x2e/0x50
 [<ffffffff810d4762>] ? do_execve+0x1d2/0x2c0
 [<ffffffff8100b0c4>] ? sys_execve+0x44/0x70
 [<ffffffff8100294a>] ? stub_execve+0x6a/0xc0
Code: ff e9 6a ff ff ff 0f 1f 44 00 00 48 83 ec 78 48 89 6c 24 50 48 89
5c 24 48 48 89 d5 4c 89 64 24 58 4c 89 6c 24 60 4c 89 74 24 68 <4c> 89
7c 24 70 89 74 24 0c 4c 89 44 24 18 88 4c 24 27 65 48 8b
RIP  [<ffffffff810c9080>] __mem_cgroup_try_charge+0x20/0x2d0
 RSP <ffff880005385bd8>
CR2: ffffffff8970247d
---[ end trace e87d617f94498768 ]---
------------[ cut here ]------------
kernel BUG at fs/buffer.c:1264!
invalid opcode: 0000 [#5] PREEMPT SMP
last sysfs file:
/sys/devices/pci0000:00/0000:00:06.0/net/eth0/statistics/collisions
CPU 2
Pid: 10266, comm: gcc Tainted: G      D    2.6.33.1-rt11 #4
GA-M56S-S3/M56S-S3
RIP: 0010:[<ffffffff810f4a52>]  [<ffffffff810f4a52>]
__find_get_block+0x1e2/0x1f0
RSP: 0000:ffff880005385748  EFLAGS: 00010046
RAX: 0000000000000086 RBX: ffff880117777540 RCX: 0000000000080002
RDX: 0000000000001000 RSI: 0000000000080052 RDI: ffff880117777540
RBP: 0000000000001000 R08: ffff880113964660 R09: 0000000000000000
R10: ffff88011faf1800 R11: 0000000000000001 R12: ffff880117777540
R13: 0000000000080052 R14: 0000000000001000 R15: 0000000000000001
FS:  00007f0799e86700(0000) GS:ffff880028300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: ffffffff8970247d CR3: 00000000014f1000 CR4: 00000000000006e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Process gcc (pid: 10266, threadinfo ffff880005384000, task ffff8801156db810)
Stack:
 ffff88002830ba20 ffffffff813987fc ffffffff8153d900 ffffffff8109c28e
<0> ffffffff8153db40 ffff880005385814 ffff880005385fd8 ffffea0000125c10
<0> ffff880114a66800 0000000000001000 ffff880117777540 0000000000080052
Call Trace:
 [<ffffffff813987fc>] ? rt_spin_lock+0x2c/0x70
 [<ffffffff8109c28e>] ? get_zone_pcp+0x4e/0x80
 [<ffffffff810f4a7b>] ? __getblk+0x1b/0x2f0
 [<ffffffff813987fc>] ? rt_spin_lock+0x2c/0x70
 [<ffffffffa01c4862>] ? __ext4_get_inode_loc+0x132/0x3f0 [ext4]
 [<ffffffff813987fc>] ? rt_spin_lock+0x2c/0x70
 [<ffffffffa01c5357>] ? ext4_reserve_inode_write+0x27/0xa0 [ext4]
 [<ffffffffa01c542c>] ? ext4_mark_inode_dirty+0x5c/0x1e0 [ext4]
 [<ffffffffa01b31c6>] ? jbd2_journal_start+0xb6/0x100 [jbd2]
 [<ffffffffa01cb73e>] ? ext4_delete_inode+0xfe/0x2d0 [ext4]
 [<ffffffffa01cb640>] ? ext4_delete_inode+0x0/0x2d0 [ext4]
 [<ffffffff810e43f5>] ? generic_delete_inode+0xc5/0x190
 [<ffffffff810dff26>] ? d_kill+0x56/0x80
 [<ffffffff810e05dd>] ? dput+0x9d/0x1a0
 [<ffffffff810ce958>] ? __fput+0x198/0x260
 [<ffffffff810cb106>] ? filp_close+0x56/0x90
 [<ffffffff810414bd>] ? put_files_struct+0xcd/0x110
 [<ffffffff810434c3>] ? do_exit+0x723/0x790
 [<ffffffff81395f45>] ? printk+0x40/0x4b
 [<ffffffff8103fd2a>] ? kmsg_dump+0x7a/0x130
 [<ffffffff81006952>] ? oops_end+0x72/0xa0
 [<ffffffff8102442b>] ? no_context+0xfb/0x260
 [<ffffffff8139904f>] ? page_fault+0x1f/0x30
 [<ffffffff810c9080>] ? __mem_cgroup_try_charge+0x20/0x2d0
 [<ffffffff813987fc>] ? rt_spin_lock+0x2c/0x70
 [<ffffffff813987fc>] ? rt_spin_lock+0x2c/0x70
 [<ffffffff810c2c36>] ? _slab_irq_disable+0x46/0x60
 [<ffffffff810c9a7e>] ? mem_cgroup_charge_common+0x5e/0xb0
 [<ffffffff810b0ad5>] ? handle_mm_fault+0x6e5/0x910
 [<ffffffff810b0e49>] ? __get_user_pages+0x149/0x3f0
 [<ffffffff810d26f6>] ? get_arg_page+0x56/0xc0
 [<ffffffff810d286c>] ? copy_strings+0x10c/0x230
 [<ffffffff810d29be>] ? copy_strings_kernel+0x2e/0x50
 [<ffffffff810d4762>] ? do_execve+0x1d2/0x2c0
 [<ffffffff8100b0c4>] ? sys_execve+0x44/0x70
 [<ffffffff8100294a>] ? stub_execve+0x6a/0xc0
Code: d0 75 eb 4c 89 21 e9 b6 fe ff ff 4c 89 e7 e8 a6 fc ff ff 4c 89 f7
e9 37 ff ff ff 0f 0b eb fe 0f 0b 0f 1f 84 00 00 00 00 00 eb f6 <0f> 0b
eb fe 66 2e 0f 1f 84 00 00 00 00 00 41 57 41 56 41 55 49
RIP  [<ffffffff810f4a52>] __find_get_block+0x1e2/0x1f0
 RSP <ffff880005385748>
---[ end trace e87d617f94498769 ]---
Fixing recursive fault but reboot is needed!
