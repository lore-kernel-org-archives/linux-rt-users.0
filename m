From: "Justin Mattock" <justinmattock@gmail.com>
Subject: Re: Can't boot 2.6.26-rt1
Date: Sat, 2 Aug 2008 14:31:48 -0700
Message-ID: <dd18b0c30808021431m12b1600en7f52eb825d27ed76@mail.gmail.com>
References: <520f0cf10808021416n286855f9s126d416230aee249@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	"Steven Rostedt" <rostedt@goodmis.org>,
	"Ingo Molnar" <mingo@elte.hu>,
	"Thomas Gleixner" <tglx@linutronix.de>
To: "John Kacur" <jkacur@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.247]:6783 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752001AbYHBVbt (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 2 Aug 2008 17:31:49 -0400
Received: by an-out-0708.google.com with SMTP id d40so240893and.103
        for <linux-rt-users@vger.kernel.org>; Sat, 02 Aug 2008 14:31:49 -0700 (PDT)
In-Reply-To: <520f0cf10808021416n286855f9s126d416230aee249@mail.gmail.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, Aug 2, 2008 at 2:16 PM, John Kacur <jkacur@gmail.com> wrote:
> VFS: Cannot open root device
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
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Hello; I was receiving this last week,
wasn't receving this:
Pid:1,comm:swapper Not tainted
> 2.6.26-rt1-default#1linux-rt-users@vger.kernel.org
> [< ffff ffff 8046 c149 >] rt_mutex_lock+0x22/0x50
> [< ffff ffff 8046 cae6 >] _mutex_unlock+0xe/0x10
> [< ffff ffff 8020 cb00 >] exit_intr+0x10/0x1e
> [< ffff ffff 8028 633d >] trace_hardirqs_on_caller+0x1e/0x133
> [< ffff ffff 8020 d608 >] child_rip+0xa/0x12
> [< ffff ffff 8020 cb69 >] restore_args+0x0/0x30
> [< ffff ffff 8020 d5fe >] child_rip+0x0/0x12

but was having this:
 VFS: Cannot open root device
what was causing this is grub from dapper,feisty,etc..
if you compile you're kernel with initrd.img then will work,
but if you: make you're kernel statically(make, make install)
it will produce unable to mount vfs.
downgrade grub or use grub2.
if you've already did that, then I don't know.
regards;
-- 
Justin P. Mattock
