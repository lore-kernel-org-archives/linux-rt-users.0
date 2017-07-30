From: Jacek Konieczny <jajcus@jajcus.net>
Subject: Re: [BUG] x86/mm: Found insecure W+X mapping at address
 ffff88000005f000/0xffff88000005f000
Date: Sun, 30 Jul 2017 19:23:52 +0200
Message-ID: <3ae082de-d4cd-64d7-0ab2-3196e6678d44@jajcus.net>
References: <20170718085034.GA6388@piotrpc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: hpa@zytor.com
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from tropek.jajcus.net ([31.179.132.94]:41362 "EHLO
        tropek.jajcus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754171AbdG3RYA (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 30 Jul 2017 13:24:00 -0400
In-Reply-To: <20170718085034.GA6388@piotrpc>
Content-Language: en-GB
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-07-18 10:50, Piotr Gregor wrote:
> Hi Thomas,
> 
> Dmesg reports insecure W+X mapping found at address
> ffff88000005f000/0xffff88000005f000
> 
> on 4.4.70 kernel patched with -rt83 patch:

I got something similar on 4.4.75-rt88 (I don't think I have seen that
on other of my kernels):


Jul 30 19:01:27 localhost kernel: ------------[ cut here ]------------
Jul 30 19:01:27 localhost kernel: WARNING: CPU: 2 PID: 1 at
arch/x86/mm/dump_pagetables.c:225 note_page+0x635/0x7e0()
Jul 30 19:01:27 localhost kernel: x86/mm: Found insecure W+X mapping at
address ffff880000088000/0xffff880000088000
Jul 30 19:01:27 localhost kernel: Modules linked in:
Jul 30 19:01:27 localhost kernel: CPU: 2 PID: 1 Comm: swapper/0 Not
tainted 4.4.75-rt88-1 #1
Jul 30 19:01:27 localhost kernel: Hardware name: Acer Aspire
E5-575/Ironman_SK  , BIOS V1.25 03/03/2017
Jul 30 19:01:27 localhost kernel:  0000000000000286 c0f497dec3146f27
ffff880246a47d40 ffffffff8133c614
Jul 30 19:01:27 localhost kernel:  ffff880246a47d88 0000000000000009
ffff880246a47d78 ffffffff810809e2
Jul 30 19:01:27 localhost kernel:  ffff880246a47e90 8000000000000163
0000000000000004 0000000000000000
Jul 30 19:01:27 localhost kernel: Call Trace:
Jul 30 19:01:27 localhost kernel:  [<ffffffff8133c614>] dump_stack+0x65/0x91
Jul 30 19:01:27 localhost kernel:  [<ffffffff810809e2>]
warn_slowpath_common+0x82/0xd0
Jul 30 19:01:27 localhost kernel:  [<ffffffff81080a8c>]
warn_slowpath_fmt+0x5c/0x80
Jul 30 19:01:27 localhost kernel:  [<ffffffff81074f35>]
note_page+0x635/0x7e0
Jul 30 19:01:27 localhost kernel:  [<ffffffff810753f8>]
ptdump_walk_pgd_level_core+0x318/0x450
Jul 30 19:01:27 localhost kernel:  [<ffffffff81075567>]
ptdump_walk_pgd_level_checkwx+0x17/0x20
Jul 30 19:01:27 localhost kernel:  [<ffffffff8106ad7c>]
mark_rodata_ro+0xec/0x100
Jul 30 19:01:27 localhost kernel:  [<ffffffff8164f940>] ?
rest_init+0x90/0x90
Jul 30 19:01:27 localhost kernel:  [<ffffffff8164f95d>]
kernel_init+0x1d/0xe0
Jul 30 19:01:27 localhost kernel:  [<ffffffff8165bc8f>]
ret_from_fork+0x3f/0x70
Jul 30 19:01:27 localhost kernel:  [<ffffffff8164f940>] ?
rest_init+0x90/0x90
Jul 30 19:01:27 localhost kernel: ---[ end trace 0000000000000002 ]---
Jul 30 19:01:27 localhost kernel: x86/mm: Checked W+X mappings: FAILED,
179927 W+X pages found.

Jacek
