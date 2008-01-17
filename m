From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [BUG] Oops while running Specjbb on -rt kernel
Date: Wed, 16 Jan 2008 20:42:23 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0801162037000.19540@gandalf.stny.rr.com>
References: <20080114075551.GD7141@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Dinakar Guniguntala <dino@in.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>
To: Chirag Jog <chirag@linux.vnet.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:65413 "EHLO
	ms-smtp-01.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753AbYAQBpZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 16 Jan 2008 20:45:25 -0500
In-Reply-To: <20080114075551.GD7141@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Peter,

Could you take a look at this?

-- Steve


On Mon, 14 Jan 2008, Chirag Jog wrote:

> Hi,
>         On Running Specjbb on the latest kernel [2.6.24-rc7-rt1], I
>         get the following oops.
>
>         This is reproducible easily. I have seen it on the
>         2.6.24-rc5-rt1.
>         Although I didn't see it on 2.6.23.11-rt14.
>         Also I haven't seen it on 2.6.24-rc6 [Mainline].
>
>
> Unable to handle kernel NULL pointer dereference at 0000000000000060 RIP:
>  [<ffffffff8022d353>] pick_next_task_fair+0x2d/0x3f
> PGD 236ce9067 PUD 23851d067 PMD 237cf4067 PTE 0
> Oops: 0000 [1] PREEMPT SMP
> CPU 2
> Modules linked in: ipv6 autofs4 i2c_dev i2c_core hidp rfcomm l2cap bluetooth sunrpc dm_mirror dm_multipath dm_mod sbs sbshc dock battery ac power_supply parport_pc lp parport sg bnx2 button serio_raw shpchp k8temp rtc_cmos rtc_core pcspkr hwmon rtc_lib mptsas mptscsih mptbase scsi_transport_sas sd_mod scsi_mod ext3 jbd ehci_hcd ohci_hcd uhci_hcd
> Pid: 3905, comm: java Not tainted 2.6.24-rc7-rt1 #1
> RIP: 0010:[<ffffffff8022d353>]  [<ffffffff8022d353>] pick_next_task_fair+0x2d/0x3f
> RSP: 0018:ffff8101d2c7bc48  EFLAGS: 00210046
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff8101d2c794e0
> RDX: 0000000000000004 RSI: 0000000000000001 RDI: ffff81000e8a98e0
> RBP: ffff8101d2c7bc58 R08: ffff81000e8a5a40 R09: 0000000000000002
> R10: ffff810236c7d1a0 R11: 0000000000000001 R12: ffff81000e8a5a40
> R13: 0000000000000001 R14: ffff81000e8a9880 R15: 00000001000481a6
> FS:  00002ac153330090(0000) GS:ffff81023fc057c0(0063) knlGS:0000000097effb90
> CS:  0010 DS: 002b ES: 002b CR0: 000000008005003b
> CR2: 0000000000000060 CR3: 000000023981d000 CR4: 00000000000006e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> Process java (pid: 3905, threadinfo ffff8101d2c7a000, task ffff8101d2c794e0)
> Stack:  ffffffff8022ced1 ffff8101d2c794e0 ffff8101d2c7bcf8 ffffffff80486345
>  ffff8101d2c7bcc0 0000000000000000 ffff8101d2c7be08 ffff81023f526040
>  ffff8101d2c794e0 ffffffff80257b15 ffff8101d2c79760 0000000200402040
> Call Trace:
>  [<ffffffff8022ced1>] put_prev_task_rt+0xd/0x18
>  [<ffffffff80486345>] __schedule+0x3d6/0x6fc
>  [<ffffffff80257b15>] __rt_mutex_adjust_prio+0x11/0x24
>  [<ffffffff80258285>] task_blocks_on_rt_mutex+0x103/0x1bf
>  [<ffffffff8048697d>] schedule+0xdf/0xff
>  [<ffffffff804874d8>] rt_mutex_slowlock+0x1c3/0x29d
>  [<ffffffff80487175>] rt_mutex_lock+0x28/0x2a
>  [<ffffffff8025850f>] __rt_down_read+0x47/0x4b
>  [<ffffffff80258529>] rt_down_read+0xb/0xd
>  [<ffffffff80256c8f>] do_futex+0x753/0xb1d
>  [<ffffffff8020a76e>] __switch_to+0x11a/0x2a0
>  [<ffffffff80232b8b>] finish_task_switch+0x2b/0x98
>  [<ffffffff8025758c>] compat_sys_futex+0xd8/0xf6
>  [<ffffffff8020f573>] syscall_trace_enter+0x95/0x99
>  [<ffffffff80225534>] cstar_do_call+0x1b/0x65
>
>
> Code: 48 8b 7b 60 48 85 ff 75 e0 48 8d 43 b8 41 58 5b c9 c3 55 48
> RIP  [<ffffffff8022d353>] pick_next_task_fair+0x2d/0x3f
>  RSP <ffff8101d2c7bc48>
> CR2: 0000000000000060
>
>
> Here is the config file.
>

[snipped - see linux-rt-users]
