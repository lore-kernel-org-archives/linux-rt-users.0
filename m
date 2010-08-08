From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: BUG: [PlanetCCRMA] update: new kernel for fc13 (2.6.33.6 + rt28)
Date: Sat, 07 Aug 2010 17:44:11 -0700
Message-ID: <1281228251.17527.13.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Bernardo Barros <bernardobarros2@gmail.com>,
	William Blackburn <bill_-@hotmail.com>,
	nando@ccrma.Stanford.EDU
To: john stultz <johnstul@us.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodm
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp1.Stanford.EDU ([171.67.219.81]:35395 "EHLO
	smtp.stanford.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751117Ab0HHAor (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 7 Aug 2010 20:44:47 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Here's a report from of one of the users of my rt28 build for 2.6.33.6
(for Planet CCRMA)... Another user (William) is also having freezes but
with no clues left behind in /var/log/messages...

-- Fernando


-------- Forwarded Message --------
From: Bernardo Barros <bernardobarros2@gmail.com>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: William Blackburn <bill_-@hotmail.com>,
planetccrma@ccrma.Stanford.EDU
Subject: Re: [PlanetCCRMA] update: new kernel for fc13 (2.6.33.6 +
rt28)(William Blackburn)
Date: Sat, 7 Aug 2010 18:06:01 -0300

Hi,

I'm also getting oops and freezes with the new rt-kernel. No
experimental mesa drivers now, but still I only get 3d accelerations
with the experimental mesa drivers. I also get some errors on startup
about nouveau driver (on both kernels) and a error about a USB device
file with the rt-kernel.

I was using supercollider, jack and ardour. The oops bug report is here:

Package:    	kernel
Latest Crash:	Sat 07 Aug 2010 05:14:44 PM
Command:    	not_applicable
Reason:     	BUG: unable to handle kernel NULL pointer dereference at
0000000000000048
Comment:    	None

Bug Reports:	

BUG: unable to handle kernel NULL pointer dereference at 0000000000000048
IP: [<ffffffffa0070e25>] ttm_tt_swapout+0x92/0x1c9 [ttm]
PGD 11009b067 PUD 10ce2f067 PMD 0
Oops: 0000 [#1] PREEMPT SMP
last sysfs file: /sys/devices/system/cpu/cpu7/cache/index2/shared_cpu_map
CPU 1
Pid: 326, comm: ttm_swap Not tainted
2.6.33.6-147.2.4.rt28.1.fc13.ccrma.x86_64.rt #1 43192PU/43192PU
RIP: 0010:[<ffffffffa0070e25>]  [<ffffffffa0070e25>]
ttm_tt_swapout+0x92/0x1c9 [ttm]
RSP: 0018:ffff88012b3afcb0  EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff8800b0f20640 RCX: 0000000000000000
RDX: ffff88012b3b8780 RSI: ffff88010e9375c0 RDI: ffff8800b0f20640
RBP: ffff88012b3afd10 R08: 0000000000000022 R09: 0000000000000002
R10: ffff8800b0f20640 R11: 0000000000000004 R12: ffff88010e9375c0
R13: ffff88010e9375c0 R14: ffff88010ce42090 R15: ffff88012ac623c0
FS:  0000000000000000(0000) GS:ffff880006240000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000048 CR3: 0000000129516000 CR4: 00000000000006e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Process ttm_swap (pid: 326, threadinfo ffff88012b3ae000, task ffff88012b3b8780)
Stack:
0000000000105ee0 0000000000105eef ffff88012a143108 000000000000bdc7
 0000000100000000 ffff88010ce42000 ffff88010ce42044 ffff88010ce42000
 ffff88010ce42044 0000000000000000 ffff88010ce42090 ffff88012ac623c0
Call Trace:
[<ffffffffa007255a>] ttm_bo_swapout+0x1ee/0x22e [ttm]
[<ffffffffa0070385>] ttm_shrink+0x9d/0xc4 [ttm]
[<ffffffffa00703c0>] ttm_shrink_work+0x14/0x16 [ttm]
[<ffffffff81062b56>] worker_thread+0x1d8/0x275
[<ffffffffa00703ac>] ? ttm_shrink_work+0x0/0x16 [ttm]
[<ffffffff81066c23>] ? autoremove_wake_function+0x0/0x34
[<ffffffff8106297e>] ? worker_thread+0x0/0x275
[<ffffffff8106689e>] kthread+0x7a/0x82
[<ffffffff8100aa24>] kernel_thread_helper+0x4/0x10
[<ffffffff81066824>] ? kthread+0x0/0x82
[<ffffffff8100aa20>] ? kernel_thread_helper+0x0/0x10
Code: e8 26 00 06 e1 48 3d 00 f0 ff ff 49 89 c4 76 16 48 c7 c7 66 7c
07 a0 31 c0 45 89 e6 e8 6c b7 3c e1 e9 2a 01 00 00 49 8b 44 24 18 <48>
8b 40 48 4c 8b b8 50 01 00 00 c7 45 c4 00 00 00 00 65 48 8b
RIP  [<ffffffffa0070e25>] ttm_tt_swapout+0x92/0x1c9 [ttm]
RSP <ffff88012b3afcb0>
CR2: 0000000000000048


