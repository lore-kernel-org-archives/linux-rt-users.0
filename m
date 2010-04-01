From: "Darcy L. Watkins" <dwatkins@tranzeo.com>
Subject: Kernel 2.6.33.1-rt11 on PPC405 UIC spinlock and serial input
 overruns
Date: Thu, 01 Apr 2010 11:15:58 -0700
Message-ID: <1270145758.27946.48.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from isa.tranzeo.com ([64.114.87.10]:59520 "EHLO mail2.tranzeo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754792Ab0DASbH (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 1 Apr 2010 14:31:07 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

I have kernel 2.6.33.1-rt11 running on a Powerpc 405EP based system and
have seen the following in the dmesg...

[   11.908590] BUG: sleeping function called from invalid context at kernel/rtmutex.c:684
[   11.908636] pcnt: 10002 0 in_atomic(): 1, irqs_disabled(): 1, pid: 0, name: swapper
[   11.908661] Call Trace:
[   11.908708] [c034de20] [c0007938] show_stack+0x40/0x15c (unreliable)
[   11.908765] [c034de50] [c002cbc8] __might_sleep+0xfc/0x100
[   11.908817] [c034de60] [c025ad44] rt_spin_lock+0xa0/0xa4
[   11.908858] [c034de70] [c001a638] uic_mask_ack_irq+0x50/0xa0
[   11.908908] [c034de90] [c006af68] handle_level_irq+0x3c/0x17c
[   11.908948] [c034deb0] [c0005380] do_IRQ+0x98/0xb4
[   11.908996] [c034ded0] [c00103f4] ret_from_except+0x0/0x18
[   11.909038] [c034df90] [c0008ac0] cpu_idle+0x58/0x114
[   11.909075] [c034dfb0] [c00029e4] rest_init+0x90/0xa4
[   11.909124] [c034dfc0] [c03117c4] start_kernel+0x264/0x2ac
[   11.909162] [c034dff0] [c0002254] start_here+0x44/0xb0

In arch/powerpc/sysdev/uic.c changing all the spinlock functions for
&uic->lock to their raw_ equivalents appears to fix it.  Also since the
invoking code appears to already have an rtmutex locked already whenever
any of these paths are executed, I also tried simply commenting out the
whole UIC spinlock altogether and that works too.

Perhaps someone more familiar with the powerpc kernel code can advise me
as to whether or not the uic->lock spinlock in uic.c is redundant (i.e.
correct to remove it) or the raw spinlock is still needed.

I have also observed the following type of errors in dmesg output...

[  145.583931] ttyS0: 1 input overrun(s)

I observe these whether I have the earlier BUG present or either of my
changes to get rid of the BUG error messages.

All of these conditions also appear when I build kernel 2.6.31.12-rt21
for the same hardware.

They do NOT appear when I build kernel 2.6.29.6-rt24 for the same
hardware.  They also do NOT appear for kernel 2.6.30, 2.6.31 or 2.6.33
when build without the RT-Preemption patches applied.  (I also don't see
it in way older kernel versions with RT preemption patches applied,
2.6.26, 2.6.25, 2.6.24, 2.6.23).

The input overrun errors are quite reproducible when I up arrow (i.e.
back up through history in the shell on the target).  I see "A" or "[A"
echo back or sometimes the shell steps back in history (the normal
expected result).  This is using 115200 bit rate on the serial port.
When the "A" or "[A" is echoed, I see the overrun error messages.

If someone can shed some light on this I'd appreciate your comments.  It
might save me some time and of course helps to improve the RT support
for PPC405 targets.

----
Other relevant info for type of linux build ...
buildroot-2010.02 based cross build set up using:
  gcc-4.3.4
  binutils-2.20
  uclibc-0.9.30.2
  busybox-1.15.3


Regards,

Darcy


