From: =?iso-8859-1?Q?Sami_Pietik=E4inen?= <Sami.Pietikainen@wapice.com>
Subject: Crash in TCP/IP stack
Date: Tue, 17 Dec 2013 10:21:33 +0000
Message-ID: <EBD2DE4ADA47B94E831AED12A4B0CADA76D06990@edb1.wapice.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jouko Haapaluoma <jouko.haapaluoma@wapice.com>
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wapice.fi ([81.209.51.2]:47825 "EHLO brando.wapice.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750901Ab3LQKVg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 Dec 2013 05:21:36 -0500
Received: from localhost (localhost [127.0.0.1])
	by brando.wapice.com (Postfix) with ESMTP id 751131784689
	for <linux-rt-users@vger.kernel.org>; Tue, 17 Dec 2013 12:21:31 +0200 (EET)
Received: from brando.wapice.com ([127.0.0.1])
 by localhost (brando.wapice.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 09955-08 for <linux-rt-users@vger.kernel.org>;
 Tue, 17 Dec 2013 12:21:30 +0200 (EET)
Received: from edb0.wapice.localdomain (unknown [10.0.4.32])
	by brando.wapice.com (Postfix) with ESMTP id C29E817841AD
	for <linux-rt-users@vger.kernel.org>; Tue, 17 Dec 2013 12:21:30 +0200 (EET)
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

We have run into a crash in the TCP/IP stack when doing torture tests on our devices. 
We have been able to reproduce this issue with Atmel SAMA5D35-EK using 3.6.9-rt21, 
3.10.20-rt17 and 3.12.5-rt6 kernels and using Xilinx Zynq Zedboard with 3.8.13-rt15 kernel. 
We also tested the Zedboard with vanilla kernel, and the problem does not occur with it.

The crash can be reproduced by spawning a lot of wget (or similar) processes that download a small file.
-> lot of calls to tcp_close inside the stack
while [ 1 ] ; do wget -O - ftp://10.0.0.1/small_file > /dev/null 2>&1; done &

The crash occurs in a matter of seconds when the stress testing is started.

We have been reviewing the rt patch, and at the moment we think that this issue is related to patches
net-use-cpu-light-in-ip-send-unicast-reply.patch and net-flip-lock-dep-thingy.patch.

Any ideas about the root cause or possible fix are welcome.

Please find the stack trace below.

BR,
Sami


Unable to handle kernel NULL pointer dereference at virtual address 00000010
pgd = dec4c000
[00000010] *pgd=3f37a831i, *pte=00000000, *ppte=00000000
Internal error: Oops: 17 [#1] PREEMPT THUMB2
Modules linked in:
CPU: 0 PID: 7292 Comm: wget Not tainted 3.12.5-rt6-custom #1
task: dedfce00 ti: dec1c000 task.ti: dec1c000
PC is at __ip_make_skb+0x200/0x280
LR is at ip_push_pending_frames+0xf/0x24
pc : [<c01989fc>]    lr : [<c0198acf>]    psr: 60070033
sp : dec1dd70  ip : c0315bc4  fp : dec1dde0
r10: 00000000  r9 : c0315ae0  r8 : c0315d10
r7 : c0315bc4  r6 : 00000024  r5 : df1aab48  r4 : df2a7240
r3 : 00000001  r2 : c0315bc4  r1 : 00000010  r0 : df1aaa10
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA Thumb  Segment user
Control: 50c53c7d  Table: 3ec4c059  DAC: 00000015
Process wget (pid: 7292, stack limit = 0xdec1c240)
Stack: (0xdec1dd70 to 0xdec1e000)
dd60:                                     c0315ca8 c0196da1 dec1de70 00000014
dd80: 00000000 df2a7240 df2a7c00 00000024 c0315bc4 00000000 f605000a 000045d2
dda0: 00000000 c0198acf 00000000 c0198cf5 00000014 00000000 dec1ddd0 dec1ddcc
ddc0: 00000040 00000000 00000001 00000000 f605000a dedfce00 00000000 00800000
dde0: 00000003 00000001 00000000 00060000 00000000 ad00000a f605000a 45d21500
de00: dec1c000 c031a440 00000000 00000000 00000000 00000000 00000000 00000001
de20: c031a440 df26d080 00000000 df26d080 00000000 c0175573 df26d080 c01aa3d5
de40: 80000000 00000014 c0314500 dec1de84 ad00000a df26d080 dec1de70 00000001
de60: 0010d358 c01a992d dec1de84 00000014 150045d2 f171548a 00000000 00000450
de80: 00000000 dec1de70 00000014 00000000 a3051a15 00000008 00000000 00000000
dea0: dec1ded7 df2a7c00 df26d080 df391864 00000000 c03199b4 df26d0b8 c01aa491
dec0: 00000001 00000000 df2dc180 00000000 00000002 df26d001 df26d1e0 df2a7c00
dee0: df2a7a80 df26d080 00000000 c0175683 df26d1e0 00000000 df26d080 df26d0b0
df00: df26d0ec 00000004 df27f488 c019f81b c019f6f1 df26d080 df481180 df27f480
df20: 00000000 df489f00 df848550 c01b6b61 c01b6b3d df481180 00000000 c01731db
df40: c01733e5 df4811a0 00080000 c01733ed c01733e5 c0065259 00000000 00000000
df60: dedfd0c0 00000000 dedfce00 c031b800 dec1dfb0 dec1c000 00000000 c002469b
df80: df27f480 dec1c000 dec1c000 dec1c000 c000cca4 c000e3ab 0010d3f0 00000003
dfa0: 00000000 00000006 c000cca4 c000cb53 00000000 00000001 fbad2400 00064340
dfc0: 0010d3f0 00000003 00000000 00000006 00000000 001099b0 0010b060 0010d358
dfe0: 00000000 beda9bc4 00065d44 00064350 60070010 00000003 00000000 00000000
[<c01989fc>] (__ip_make_skb+0x200/0x280) from [<c0198acf>] (ip_push_pending_frames+0xf/0x24)
[<c0198acf>] (ip_push_pending_frames+0xf/0x24) from [<c0198cf5>] (ip_send_unicast_reply+0x179/0x198)
[<c0198cf5>] (ip_send_unicast_reply+0x179/0x198) from [<c01a992d>] (tcp_v4_send_reset+0x10d/0x138)
[<c01a992d>] (tcp_v4_send_reset+0x10d/0x138) from [<c01aa491>] (tcp_v4_do_rcv+0x6d/0x168)
[<c01aa491>] (tcp_v4_do_rcv+0x6d/0x168) from [<c0175683>] (release_sock+0x63/0xe0)
[<c0175683>] (release_sock+0x63/0xe0) from [<c019f81b>] (tcp_close+0x12b/0x33c)
[<c019f81b>] (tcp_close+0x12b/0x33c) from [<c01b6b61>] (inet_release+0x25/0x44)
[<c01b6b61>] (inet_release+0x25/0x44) from [<c01731db>] (sock_release+0xf/0x5c)
[<c01731db>] (sock_release+0xf/0x5c) from [<c01733ed>] (sock_close+0x9/0xc)
[<c01733ed>] (sock_close+0x9/0xc) from [<c0065259>] (__fput+0x5d/0x17c)
[<c0065259>] (__fput+0x5d/0x17c) from [<c002469b>] (task_work_run+0x53/0x78)
[<c002469b>] (task_work_run+0x53/0x78) from [<c000e3ab>] (do_work_pending+0x5f/0x74)
[<c000e3ab>] (do_work_pending+0x5f/0x74) from [<c000cb53>] (work_pending+0x9/0x1a)
Code: 321b 2b01 f63f af65 (f8da) 3010
---[ end trace 0000000000000002 ]---
Kernel panic - not syncing: Fatal exception
