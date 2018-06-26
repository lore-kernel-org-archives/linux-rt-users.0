Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:34473 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965341AbeFZDqn (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 25 Jun 2018 23:46:43 -0400
Message-ID: <1529984793.7358.8.camel@gmx.de>
Subject: Re: [patch-rt] arm/efi: use a local_lock() in efi_virtmap_load()
From: Mike Galbraith <efault@gmx.de>
Date: Tue, 26 Jun 2018 05:46:33 +0200
In-Reply-To: <1529980339.7358.4.camel@gmx.de>
References: <20180518091936.j5ep2tqvhba5lta7@linutronix.de>
         <1529980339.7358.4.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>

On Tue, 2018-06-26 at 04:32 +0200, Mike Galbraith wrote:
> On Fri, 2018-05-18 at 11:19 +0200, Sebastian Andrzej Siewior wrote:
> > 
> >   - Add a locallock during saving/restoring of SIMD registers on ARM64.
> >     On RT we are preemptible there so extra protection is required.

Crap, disregard.  Woulda sworn 4.18-rc2 worked, but off we go... 

[    1.946864] WARNING: CPU: 1 PID: 1 at kernel/sched/core.c:7267 migrate_enable+0x2c4/0x3c8
[    1.946954] Modules linked in:
[    1.947246] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.16.17-rt7-rt #5
[    1.947263] Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
[    1.947370] pstate: 60000005 (nZCv daif -PAN -UAO)
[    1.947397] pc : migrate_enable+0x2c4/0x3c8
[    1.947414] lr : migrate_enable+0x2c4/0x3c8
[    1.947426] sp : ffff00000949bbc0
[    1.947445] x29: ffff00000949bbc0 x28: ffff092a443527a8 
[    1.947490] x27: ffff092a44862f08 x26: ffff00000949bda0 
[    1.947506] x25: ffff96d3be37c000 x24: ffff00000949bda0 
[    1.947521] x23: 0000000000000000 x22: ffff00000949bd08 
[    1.947535] x21: ffff96d3be37c000 x20: 0000000000000000 
[    1.947565] x19: ffff96d3be5f0000 x18: ffffffffffffffff 
[    1.947615] x17: 000000000000000e x16: 0000000000000007 
[    1.947675] x15: ffff092a4472ec88 x14: ffff092ac48ede97 
[    1.947715] x13: ffff092a448edea5 x12: ffff092a44753000 
[    1.947762] x11: 0000000000000001 x10: 0000000000000c40 
[    1.947825] x9 : ffff00000949bb40 x8 : ffff96d3be5f0ca0 
[    1.947858] x7 : ffff96d47ff34e40 x6 : 0000000000000000 
[    1.947910] x5 : 0000000000000000 x4 : 0000000000100000 
[    1.947945] x3 : 0000000000000000 x2 : 0000000000000000 
[    1.947965] x1 : ffff96d3bfc10608 x0 : 0000000000000001 
[    1.948093] Call trace:
[    1.948138]  migrate_enable+0x2c4/0x3c8
[    1.948165]  rt_spin_unlock+0x48/0x90
[    1.948204]  efi_virtmap_unload+0x70/0xa0
[    1.948225]  virt_efi_get_next_variable+0x88/0xc8
[    1.948235]  efivar_init+0xb0/0x380
[    1.948253]  efisubsys_init+0xd4/0x26c
[    1.948264]  do_one_initcall+0x58/0x168
[    1.948275]  kernel_init_freeable+0x1e0/0x284
[    1.948285]  kernel_init+0x18/0x118
[    1.948294]  ret_from_fork+0x10/0x18
[    1.948361] ---[ end trace 0000000000000001 ]---
