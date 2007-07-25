From: Juergen Beisert <juergen127@kreuzholzen.de>
Subject: Kernel Bug when entering something after login
Date: Wed, 25 Jul 2007 19:00:47 +0200
Message-ID: <200707251900.47704.juergen127@kreuzholzen.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from bill.weihenstephan.org ([82.135.35.21]:35585 "EHLO
	bill.weihenstephan.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932545AbXGYR15 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 25 Jul 2007 13:27:57 -0400
Received: from jupiter.intranet.kreuzholzen.de (p5B0C723B.dip.t-dialin.net [91.12.114.59])
	by bill.weihenstephan.org (Postfix) with ESMTP id 91BB351C06B
	for <linux-rt-users@vger.kernel.org>; Wed, 25 Jul 2007 19:00:46 +0200 (CEST)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

I try to run kernel 2.6.22.1 plus -rt8 on my PowerPC MPC5200C based system.
The kernel comes up, userspace comes up, and I can log in via serial console. 
*After* login, it see bash's prompt. But then when I press any key I get the 
following output (every time):

[...]
phyCORE-MPC5200B-tiny login: root
root@phyCORE-MPC5200B-tiny:~
------------[ cut here ]------------
kernel BUG at kernel/rtmutex.c:682!
stopped custom tracer.
Oops: Exception in kernel mode, sig: 5 [#1]
PREEMPT pcm030
Modules linked in: mpc52xx_can mscan can_raw can eeprom rtc_pcf8563 rtc_core 
rtc_lib
NIP: c01bdbe4 LR: c01bdb98 CTR: c0118260
REGS: c0245d00 TRAP: 0700   Not tainted  (2.6.22.1-rt8)
MSR: 00021032 <ME,IR,DR>  CR: 22004042  XER: 20000000
TASK = c3fa9660[93] 'IRQ-131' THREAD: c0244000
GPR00: 00000001 c0245db0 c3fa9660 00000000 c3f22800 c3cf8521 00000001 00000005
GPR08: c3fa9660 00000000 c028b498 c3fa9660 22004042 ffffbfff 03fbe000 ffffffff
GPR16: 00000001 00000000 007ffc00 00000000 c027a000 c025e09c c0260000 c0210000
GPR24: c0210000 00000000 c3cf8421 00000000 c028b488 c3f22800 c0244000 00009032
NIP [c01bdbe4] rt_spin_lock_slowlock+0x98/0x224
LR [c01bdb98] rt_spin_lock_slowlock+0x4c/0x224
Call Trace:
[c0245db0] [c01bdb98] rt_spin_lock_slowlock+0x4c/0x224 (unreliable)
[c0245e10] [c011823c] uart_start+0x24/0x48
[c0245e30] [c0113ff4] n_tty_receive_buf+0x170/0xfd4
[c0245ef0] [c010f0dc] flush_to_ldisc+0xe0/0x130
[c0245f20] [c011b51c] mpc52xx_uart_int+0x194/0x350
[c0245f50] [c0046dfc] handle_IRQ_event+0x6c/0x110
[c0245f80] [c00475ec] thread_simple_irq+0x90/0xf8
[c0245fa0] [c00479a0] do_irqd+0x34c/0x3cc
[c0245fd0] [c0033380] kthread+0x48/0x84
[c0245ff0] [c00104ac] kernel_thread+0x44/0x60
Instruction dump:
70090008 40820144 80010064 bb410048 38210060 7c0803a6 4e800020 801c0010
5400003a 7c001278 7c000034 5400d97e <0f000000> 39600004 91610008 80010008
note: IRQ-131[93] exited with preempt_count 1

The system runs glibc 2.5 and busybox shell.

Any idea? Same behavior with -rt4. But command line works with a plain vanilla 
2.6.22.1 kernel.

BTW: Working with the shell via telnet is possible without such an error 
message.

Juergen
