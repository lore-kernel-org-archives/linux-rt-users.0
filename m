From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: rt5, sleeping function called from invalid context
Date: Thu, 28 Jul 2011 12:37:24 -0700
Message-ID: <4E31BA74.3070102@am.sony.com>
References: <4E31B6F3.80602@am.sony.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Rowand, Frank" <Frank_Rowand@sonyusa.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from am1ehsobe005.messaging.microsoft.com ([213.199.154.208]:19782
	"EHLO AM1EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754934Ab1G1TiJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 28 Jul 2011 15:38:09 -0400
In-Reply-To: <4E31B6F3.80602@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 07/28/11 12:22, Frank Rowand wrote:
> Thomas,
> 
> Here is one of my current BUGs, from rt5 (same panda board, same config):

And some from rt3 (I don't know if they are still valid, just documenting
them because they reproduce reliably on rt3):

---------------------------------------------------------------------------

Running bash on the console:

BUG: sleeping function called from invalid context at kernel/rtmutex.c:645
in_atomic(): 1, irqs_disabled(): 128, pid: 1, name: swapper
3 locks held by swapper/1:
 #0:  (&sig->cred_guard_mutex){+.+.+.}, at: [<c015270c>] prepare_bprm_creds+0x20/0x58
 #1:  (&p->alloc_lock){+.+...}, at: [<c0152afc>] flush_old_exec+0x2dc/0x5d4
 #2:  (cpu_asid_lock){......}, at: [<c006d158>] __new_context+0x14/0xbc
irq event stamp: 475085
hardirqs last  enabled at (475084): [<c0484800>] _raw_spin_unlock_irqrestore+0x60/0x74
hardirqs last disabled at (475085): [<c0152b04>] flush_old_exec+0x2e4/0x5d4
softirqs last  enabled at (0): [<c009d9cc>] copy_process+0x364/0xf84
softirqs last disabled at (0): [<  (null)>]   (null)
[<c00681b8>] (unwind_backtrace+0x0/0xf0) from [<c0483ce0>] (rt_spin_lock+0x24/0x5c)
[<c0483ce0>] (rt_spin_lock+0x24/0x5c) from [<c006d104>] (set_mm_context+0x1c/0x5c)
[<c006d104>] (set_mm_context+0x1c/0x5c) from [<c006d198>] (__new_context+0x54/0xbc)
[<c006d198>] (__new_context+0x54/0xbc) from [<c0152d8c>] (flush_old_exec+0x56c/0x5d4)
[<c0152d8c>] (flush_old_exec+0x56c/0x5d4) from [<c01918e4>] (load_elf_binary+0x220/0x12d0)
[<c01918e4>] (load_elf_binary+0x220/0x12d0) from [<c0152450>] (search_binary_handler+0x258/0x388)
[<c0152450>] (search_binary_handler+0x258/0x388) from [<c018fef8>] (load_script+0x22c/0x244)
[<c018fef8>] (load_script+0x22c/0x244) from [<c0152450>] (search_binary_handler+0x258/0x388)
[<c0152450>] (search_binary_handler+0x258/0x388) from [<c0153a54>] (do_execve+0x1e0/0x250)
[<c0153a54>] (do_execve+0x1e0/0x250) from [<c00645a8>] (kernel_execve+0x34/0x80)
[<c00645a8>] (kernel_execve+0x34/0x80) from [<c00556f0>] (init_post+0x74/0x140)
[<c00556f0>] (init_post+0x74/0x140) from [<c0008430>] (kernel_init+0xfc/0x13c)
[<c0008430>] (kernel_init+0xfc/0x13c) from [<c0061e30>] (kernel_thread_exit+0x0/0x8)
BUG: sleeping function called from invalid context at kernel/rtmutex.c:645
in_atomic(): 1, irqs_disabled(): 0, pid: 0, name: swapper
1 lock held by swapper/0:
 #0:  (cpu_asid_lock){+.+...}, at: [<c006d158>] __new_context+0x14/0xbc
[<c00681b8>] (unwind_backtrace+0x0/0xf0) from [<c0483ce0>] (rt_spin_lock+0x24/0x5c)
[<c0483ce0>] (rt_spin_lock+0x24/0x5c) from [<c006d104>] (set_mm_context+0x1c/0x5c)
[<c006d104>] (set_mm_context+0x1c/0x5c) from [<c006d198>] (__new_context+0x54/0xbc)
[<c006d198>] (__new_context+0x54/0xbc) from [<c0481fe0>] (__schedule+0x720/0x800)
[<c0481fe0>] (__schedule+0x720/0x800) from [<c0098e2c>] (schedule+0x34/0xb8)
[<c0098e2c>] (schedule+0x34/0xb8) from [<c0482740>] (schedule_preempt_disabled+0x14/0x20)
[<c0482740>] (schedule_preempt_disabled+0x14/0x20) from [<c0062530>] (cpu_idle+0xb4/0x104)
[<c0062530>] (cpu_idle+0xb4/0x104) from [<c0008980>] (start_kernel+0x278/0x31c)
[<c0008980>] (start_kernel+0x278/0x31c) from [<80008040>] (0x80008040)
BUG: sleeping function called from invalid context at kernel/rtmutex.c:645
in_atomic(): 1, irqs_disabled(): 0, pid: 0, name: swapper
1 lock held by swapper/0:
 #0:  (cpu_asid_lock){+.+...}, at: [<c006d158>] __new_context+0x14/0xbc
[<c00681b8>] (unwind_backtrace+0x0/0xf0) from [<c0483ce0>] (rt_spin_lock+0x24/0x5c)
[<c0483ce0>] (rt_spin_lock+0x24/0x5c) from [<c006d104>] (set_mm_context+0x1c/0x5c)
[<c006d104>] (set_mm_context+0x1c/0x5c) from [<c006d198>] (__new_context+0x54/0xbc)
[<c006d198>] (__new_context+0x54/0xbc) from [<c0481fe0>] (__schedule+0x720/0x800)
[<c0481fe0>] (__schedule+0x720/0x800) from [<c0098e2c>] (schedule+0x34/0xb8)
[<c0098e2c>] (schedule+0x34/0xb8) from [<c0482740>] (schedule_preempt_disabled+0x14/0x20)
[<c0482740>] (schedule_preempt_disabled+0x14/0x20) from [<c0062530>] (cpu_idle+0xb4/0x104)
[<c0062530>] (cpu_idle+0xb4/0x104) from [<c0008980>] (start_kernel+0x278/0x31c)
[<c0008980>] (start_kernel+0x278/0x31c) from [<80008040>] (0x80008040)


---------------------------------------------------------------------------

And when I telnet to the panda:

BUG: sleeping function called from invalid context at linux-3.0/kernel/rtmutex.c:645
in_atomic(): 1, irqs_disabled(): 128, pid: 602, name: telnetd
4 locks held by telnetd/602:
 #0:  (&sig->cred_guard_mutex){+.+.+.}, at: [<c015270c>] prepare_bprm_creds+0x20/0x58
 #1:  (&mm->mmap_sem){+++++.}, at: [<c0152adc>] flush_old_exec+0x2bc/0x5d4
 #2:  (&p->alloc_lock){+.+...}, at: [<c0152afc>] flush_old_exec+0x2dc/0x5d4
 #3:  (cpu_asid_lock){+.+...}, at: [<c006d158>] __new_context+0x14/0xbc
irq event stamp: 2089
hardirqs last  enabled at (2088): [<c0484800>] _raw_spin_unlock_irqrestore+0x60/0x74
hardirqs last disabled at (2089): [<c0152b04>] flush_old_exec+0x2e4/0x5d4
softirqs last  enabled at (0): [<c009d9cc>] copy_process+0x364/0xf84
softirqs last disabled at (0): [<  (null)>]   (null)
[<c00681b8>] (unwind_backtrace+0x0/0xf0) from [<c0483ce0>] (rt_spin_lock+0x24/0x5c)
[<c0483ce0>] (rt_spin_lock+0x24/0x5c) from [<c006d104>] (set_mm_context+0x1c/0x5c)
[<c006d104>] (set_mm_context+0x1c/0x5c) from [<c006d198>] (__new_context+0x54/0xbc)
[<c006d198>] (__new_context+0x54/0xbc) from [<c0152d8c>] (flush_old_exec+0x56c/0x5d4)
[<c0152d8c>] (flush_old_exec+0x56c/0x5d4) from [<c01918e4>] (load_elf_binary+0x220/0x12d0)
[<c01918e4>] (load_elf_binary+0x220/0x12d0) from [<c0152450>] (search_binary_handler+0x258/0x388)
[<c0152450>] (search_binary_handler+0x258/0x388) from [<c0153a54>] (do_execve+0x1e0/0x250)
[<c0153a54>] (do_execve+0x1e0/0x250) from [<c006462c>] (sys_execve+0x38/0x5c)
[<c006462c>] (sys_execve+0x38/0x5c) from [<c0060da0>] (ret_fast_syscall+0x0/0x3c)
BUG: sleeping function called from invalid context at kernel/rtmutex.c:645
in_atomic(): 0, irqs_disabled(): 128, pid: 602, name: login
2 locks held by login/602:
 #0:  (tty_mutex){+.+.+.}, at: [<c02b975c>] tty_open+0x4c/0x4c4
 #1:  (big_tty_mutex){+.+.+.}, at: [<c04849f4>] tty_lock+0x2c/0x54
irq event stamp: 18907
hardirqs last  enabled at (18906): [<c0484800>] _raw_spin_unlock_irqrestore+0x60/0x74
hardirqs last disabled at (18907): [<c02d6870>] serial_omap_console_write+0x28/0x230
softirqs last  enabled at (0): [<c009d9cc>] copy_process+0x364/0xf84
softirqs last disabled at (0): [<  (null)>]   (null)
[<c00681b8>] (unwind_backtrace+0x0/0xf0) from [<c0483ce0>] (rt_spin_lock+0x24/0x5c)
[<c0483ce0>] (rt_spin_lock+0x24/0x5c) from [<c02d6a1c>] (serial_omap_console_write+0x1d4/0x230)
[<c02d6a1c>] (serial_omap_console_write+0x1d4/0x230) from [<c009fa50>] (__call_console_drivers+0xcc/0xf4
)
[<c009fa50>] (__call_console_drivers+0xcc/0xf4) from [<c009fce0>] (console_unlock+0x158/0x210)
[<c009fce0>] (console_unlock+0x158/0x210) from [<c00a0020>] (console_device+0x54/0x60)
[<c00a0020>] (console_device+0x54/0x60) from [<c02b9ac8>] (tty_open+0x3b8/0x4c4)
[<c02b9ac8>] (tty_open+0x3b8/0x4c4) from [<c014fc28>] (chrdev_open+0x180/0x260)
[<c014fc28>] (chrdev_open+0x180/0x260) from [<c014a6f8>] (__dentry_open+0x1d4/0x348)
[<c014a6f8>] (__dentry_open+0x1d4/0x348) from [<c014a938>] (nameidata_to_filp+0x5c/0x64)
[<c014a938>] (nameidata_to_filp+0x5c/0x64) from [<c0158a34>] (do_last+0x180/0x698)
[<c0158a34>] (do_last+0x180/0x698) from [<c015a738>] (path_openat+0xb8/0x3f8)
[<c015a738>] (path_openat+0xb8/0x3f8) from [<c015ab60>] (do_filp_open+0x30/0x84)
[<c015ab60>] (do_filp_open+0x30/0x84) from [<c014a36c>] (do_sys_open+0xf4/0x188)
[<c014a36c>] (do_sys_open+0xf4/0x188) from [<c0060da0>] (ret_fast_syscall+0x0/0x3c)
login[602]: root login on 'pts/0'



-Frank

