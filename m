From: Frank Rowand <frank.rowand@am.sony.com>
Subject: rt5, sleeping function called from invalid context
Date: Thu, 28 Jul 2011 12:22:27 -0700
Message-ID: <4E31B6F3.80602@am.sony.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>,
	<linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ch1ehsobe005.messaging.microsoft.com ([216.32.181.185]:55494
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754799Ab1G1TW4 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 28 Jul 2011 15:22:56 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thomas,

Here is one of my current BUGs, from rt5 (same panda board, same config):


BUG: sleeping function called from invalid context at kernel/rtmutex.c:645
in_atomic(): 0, irqs_disabled(): 128, pid: 599, name: bash
2 locks held by bash/599:
 #0:  (tty_mutex){+.+.+.}, at: [<c02b7600>] tty_open+0x4c/0x4c4
 #1:  (big_tty_mutex){+.+.+.}, at: [<c048005c>] tty_lock+0x2c/0x54
irq event stamp: 18015
hardirqs last  enabled at (18014): [<c047fe68>] _raw_spin_unlock_irqrestore+0x60/0x74
hardirqs last disabled at (18015): [<c02d4714>] serial_omap_console_write+0x28/0x230
softirqs last  enabled at (0): [<c009d0d0>] copy_process+0x364/0xf84
softirqs last disabled at (0): [<  (null)>]   (null)
[<c00681b8>] (unwind_backtrace+0x0/0xf0) from [<c047f348>] (rt_spin_lock+0x24/0x5c)
[<c047f348>] (rt_spin_lock+0x24/0x5c) from [<c02d48c0>] (serial_omap_console_write+0x1d4/0x230)
[<c02d48c0>] (serial_omap_console_write+0x1d4/0x230) from [<c009f154>] (__call_console_drivers+0xcc/0xf4
)
[<c009f154>] (__call_console_drivers+0xcc/0xf4) from [<c009f3e4>] (console_unlock+0x158/0x210)
[<c009f3e4>] (console_unlock+0x158/0x210) from [<c009f724>] (console_device+0x54/0x60)
[<c009f724>] (console_device+0x54/0x60) from [<c02b796c>] (tty_open+0x3b8/0x4c4)
[<c02b796c>] (tty_open+0x3b8/0x4c4) from [<c014dac8>] (chrdev_open+0x180/0x260)
[<c014dac8>] (chrdev_open+0x180/0x260) from [<c0148598>] (__dentry_open+0x1d4/0x348)
[<c0148598>] (__dentry_open+0x1d4/0x348) from [<c01487d8>] (nameidata_to_filp+0x5c/0x64)
[<c01487d8>] (nameidata_to_filp+0x5c/0x64) from [<c01568d4>] (do_last+0x180/0x698)
[<c01568d4>] (do_last+0x180/0x698) from [<c01585d8>] (path_openat+0xb8/0x3f8)
[<c01585d8>] (path_openat+0xb8/0x3f8) from [<c0158a00>] (do_filp_open+0x30/0x84)
[<c0158a00>] (do_filp_open+0x30/0x84) from [<c014820c>] (do_sys_open+0xf4/0x188)
[<c014820c>] (do_sys_open+0xf4/0x188) from [<c0060da0>] (ret_fast_syscall+0x0/0x3c)


-Frank

