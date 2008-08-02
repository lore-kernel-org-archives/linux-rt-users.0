From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Can't boot 2.6.26-rt1
Date: Sat, 2 Aug 2008 17:31:58 -0400 (EDT)
Message-ID: <alpine.DEB.1.10.0808021731010.15392@gandalf.stny.rr.com>
References: <520f0cf10808021416n286855f9s126d416230aee249@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: John Kacur <jkacur@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.124]:64430 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753767AbYHBVcA (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 2 Aug 2008 17:32:00 -0400
In-Reply-To: <520f0cf10808021416n286855f9s126d416230aee249@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Sat, 2 Aug 2008, John Kacur wrote:

> VFS: Cannot open root device

Do you use an initrd boot disk? If so make sure the initrd is correct. 
Sometimes it is best to first get a 2.6.26 kernel booting without initrd 
and then use that same config on the -rt kernel.

-- Steve


> "disk/by-id/scsi-SATA_WDC_WD1600BEVS-WD-WXEZ07100576-part 7" or
> unknown block(0,0)
> Please append a correct "root = " boot option; here are the available
> partitions.
> Pid:1,comm:swapper Not tainted
> 2.6.26-rt1-default#1linux-rt-users@vger.kernel.org
> [< ffff ffff 8046 c149 >] rt_mutex_lock+0x22/0x50
> [< ffff ffff 8046 cae6 >] _mutex_unlock+0xe/0x10
> [< ffff ffff 8020 cb00 >] exit_intr+0x10/0x1e
> [< ffff ffff 8028 633d >] trace_hardirqs_on_caller+0x1e/0x133
> [< ffff ffff 8020 d608 >] child_rip+0xa/0x12
> [< ffff ffff 8020 cb69 >] restore_args+0x0/0x30
> [< ffff ffff 8020 d5fe >] child_rip+0x0/0x12
> 
> preempt count 00000001
> 1-level deep critical section nesting
> [< ffff ffff 8047 43e2 >] .... panic +0x43/0x167
> [< ffff ffff 8073 6338 >] (<= mount_block_root+0x258/0x26f
> 

