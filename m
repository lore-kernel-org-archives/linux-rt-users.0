From: Lukas Erlinghagen <lukas.erlinghagen@x2e.de>
Subject: Kernel panic with PREEMPT_RT_FULL and UIO driver
Date: Wed, 21 Dec 2011 11:48:36 +0100
Message-ID: <4EF1B984.4010102@x2e.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from netserv06.tekuso.de ([188.40.128.203]:41530 "EHLO
	netserv06.tekuso.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390Ab1LULAh (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 21 Dec 2011 06:00:37 -0500
Received: from kandel.x2e.de ([80.150.235.150]:55321 helo=srv3.kandel.x2e.de) by netserv06.tekuso.de with esmtpsa (Exim 4.72 #1 (Debian))
	id 1RdJWk-0000x1-Ai
	for <linux-rt-users@vger.kernel.org>; Wed, 21 Dec 2011 11:36:02 +0100
Received: from [192.168.0.150]
	by srv3.kandel.x2e.de with esmtpsa (Exim 4.69 #1 (Debian))
	id 1RdJh0-0001uL-49
	for <linux-rt-users@vger.kernel.org>; Wed, 21 Dec 2011 11:46:38 +0100
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Dear list,

we're getting the kernel panic postet below on our system (Kernel 
version is 3.0.3-rt11, the platform is an embedded PowerPC 440 in a 
Virtex 5 FPGA, the device controlled by the UIO driver is a Freescale 
MFR4310 controller, and the interrupt is triggered by a high-active 
interrupt pin). This panic only occurs when using 
CONFIG_PREEMPT_RT_FULL, and only under high interrupt load on the MFR.

I've also included our IRQ handler (registered with IRQF_ONESHOT) and 
IRQ control function.

Is there something fundamentally wrong we're doing, and if so, where can 
I find information on The Right Way to write UIO drivers for the RT kernel?

Thanks in advance for any insight you can provide.

Kernel panic:

------------[ cut here ]------------
kernel BUG at kernel/rtmutex.c:724!
Oops: Exception in kernel mode, sig: 5 [#1]
PREEMPT Xilinx Virtex440
Modules linked in:
NIP: c02f20a0 LR: c02f2058 CTR: c026e064
REGS: c9ff3e40 TRAP: 0700   Not tainted  (3.0.3-mfrtest-rt11)
MSR: 00021000 <ME,CE>  CR: 82042442  XER: 00000000
TASK = c908daa0[1133] 'app' THREAD: c908e000
GPR00: 00000001 c9ff3ef0 c908daa0 00000000 c908daa0 00000000 00000001 
00000000
GPR08: c908daa0 c908daa0 c908daa0 c908daa1 82042448 101c9c54 00000000 
00000001
GPR16: 1017e908 00000002 101c1ec0 00000160 1017e8d4 c0350f40 00000001 
c0350f7c
GPR24: c0500000 00000004 c03d137c 00000001 00000026 c908daa0 00000000 
c9bf3fb4
NIP [c02f20a0] rt_spin_lock_slowlock+0x98/0x260
LR [c02f2058] rt_spin_lock_slowlock+0x50/0x260
Call Trace:
[c9ff3ef0] [c02f2058] rt_spin_lock_slowlock+0x50/0x260 (unreliable)
[c9ff3f50] [c0029a70] __wake_up+0x24/0x58
[c9ff3f70] [c02548f8] uio_event_notify+0x3c/0x64
[c9ff3f80] [c0254970] uio_interrupt+0x50/0x68
[c9ff3f90] [c006a6cc] handle_irq_event_percpu+0x68/0x174
[c9ff3fd0] [c006a82c] handle_irq_event+0x54/0x8c
[c9ff3fe0] [c006cf30] handle_edge_irq+0xa8/0x1a8
[c9ff3ff0] [c000b5e4] call_handle_irq+0x18/0x28
[c908fda0] [c000360c] do_IRQ+0xf0/0x14c
[c908fdd0] [c000caf8] ret_from_except+0x0/0x18
--- Exception: 501 at add_wait_queue+0x40/0x60
     LR = add_wait_queue+0x28/0x60
[c908fe90] [c006a1a8] __irq_put_desc_unlock+0x24/0x78 (unreliable)
[c908fea0] [c025474c] uio_read+0x88/0x1b4
[c908fef0] [c00a50e8] vfs_read+0xc0/0x16c
[c908ff10] [c00a51e0] sys_read+0x4c/0xa4
[c908ff40] [c000c498] ret_from_syscall+0x0/0x3c
--- Exception: c01 at 0xffd5b48
     LR = 0xffd5b30
Instruction dump:
70090004 408201a8 80010064 bb61004c 38210060 7c0803a6 4e800020 801f0008
5400003c 7fa00278 7c000034 5400d97e <0f000000> 7c000146 38600001 4bd37b05
Kernel panic - not syncing: Fatal exception in interrupt
Call Trace:
[c9ff3c90] [c0006890] show_stack+0x44/0x154 (unreliable)
[c9ff3cd0] [c02f2aa4] panic+0xac/0x1d0
[c9ff3d20] [c0008dac] die+0x11c/0x1cc
[c9ff3d40] [c0008f58] _exception+0xa4/0x11c
[c9ff3e30] [c000caac] ret_from_except_full+0x0/0x4c
--- Exception: 700 at rt_spin_lock_slowlock+0x98/0x260
     LR = rt_spin_lock_slowlock+0x50/0x260
[c9ff3f50] [c0029a70] __wake_up+0x24/0x58
[c9ff3f70] [c02548f8] uio_event_notify+0x3c/0x64
[c9ff3f80] [c0254970] uio_interrupt+0x50/0x68
[c9ff3f90] [c006a6cc] handle_irq_event_percpu+0x68/0x174
[c9ff3fd0] [c006a82c] handle_irq_event+0x54/0x8c
[c9ff3fe0] [c006cf30] handle_edge_irq+0xa8/0x1a8
[c9ff3ff0] [c000b5e4] call_handle_irq+0x18/0x28
[c908fda0] [c000360c] do_IRQ+0xf0/0x14c
[c908fdd0] [c000caf8] ret_from_except+0x0/0x18
--- Exception: 501 at add_wait_queue+0x40/0x60
     LR = add_wait_queue+0x28/0x60
[c908fe90] [c006a1a8] __irq_put_desc_unlock+0x24/0x78 (unreliable)
[c908fea0] [c025474c] uio_read+0x88/0x1b4
[c908fef0] [c00a50e8] vfs_read+0xc0/0x16c
[c908ff10] [c00a51e0] sys_read+0x4c/0xa4
[c908ff40] [c000c498] ret_from_syscall+0x0/0x3c
--- Exception: c01 at 0xffd5b48
     LR = 0xffd5b30

Interrupt handler:
static irqreturn_t x2e_flexray_mfr4310_irq_handler (int irq, struct 
uio_info *dev_info)
{
	struct FlexRaymfr4310* mfr = dev_info->mem[0].internal_addr;

	struct mfr4310_interrupt_flag_register* intr_flags =
			(struct mfr4310_interrupt_flag_register*)dev_info->mem[1].addr;

	// acknowledge clock and reset interrupts
	if (mfr->CRSR.R & CRG_RESET_MASK)
	{
		mfr->CRSR.R |= CRG_RESET_MASK;
	}

	// save all flags
	intr_flags->GIFER = mfr->GIFER.R;
	intr_flags->PIFR0 = mfr->PIFR0.R;
	intr_flags->PIFR1 = mfr->PIFR1.R;

	// acknowledge everything
	mfr->GIFER.R |= 0xFFFFFF00;
	mfr->PIFR0.R |= 0xFFFFFFFF;
	mfr->PIFR1.R |= 0xFFFFFFFF;

	// save cycle counter
	intr_flags->CYCTR = mfr->CYCTR.R;

	// Disable interrupt, user-space driver is responsible for re-enabling 
the interrupt
	if (!test_and_set_bit(0, dev_info->priv))
	{
		disable_irq_nosync(irq);
	}

	// Have the UIO system propagate the interrupt to user-space
	return IRQ_HANDLED;
}

Interrupt control function:
static int x2e_flexray_mfr4310_irq_control(struct uio_info* dev_info, 
s32 irq_on)
{
	if (irq_on)
	{
		if (test_and_clear_bit(0, dev_info->priv))
		{
			enable_irq(dev_info->irq);
		}
	}
	else
	{
		if (!test_and_set_bit(0, dev_info->priv))
		{
			disable_irq(dev_info->irq);
		}
	}

	return 0;
}

Greetings,
Lukas Erlinghagen

