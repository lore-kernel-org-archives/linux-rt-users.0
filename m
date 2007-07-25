From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Kernel Bug when entering something after login
Date: Wed, 25 Jul 2007 21:06:38 +0200
Message-ID: <1185390398.3227.8.camel@chaos>
References: <200707251900.47704.juergen127@kreuzholzen.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Juergen Beisert <juergen127@kreuzholzen.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:56790 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752692AbXGYTGr (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 25 Jul 2007 15:06:47 -0400
In-Reply-To: <200707251900.47704.juergen127@kreuzholzen.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2007-07-25 at 19:00 +0200, Juergen Beisert wrote:
> [c0245db0] [c01bdb98] rt_spin_lock_slowlock+0x4c/0x224 (unreliable)
> [c0245e10] [c011823c] uart_start+0x24/0x48
> [c0245e30] [c0113ff4] n_tty_receive_buf+0x170/0xfd4
> [c0245ef0] [c010f0dc] flush_to_ldisc+0xe0/0x130
> [c0245f20] [c011b51c] mpc52xx_uart_int+0x194/0x350
> [c0245f50] [c0046dfc] handle_IRQ_event+0x6c/0x110
> [c0245f80] [c00475ec] thread_simple_irq+0x90/0xf8
> [c0245fa0] [c00479a0] do_irqd+0x34c/0x3cc
> [c0245fd0] [c0033380] kthread+0x48/0x84
> [c0245ff0] [c00104ac] kernel_thread+0x44/0x60
> Instruction dump:
> 70090008 40820144 80010064 bb410048 38210060 7c0803a6 4e800020 801c0010
> 5400003a 7c001278 7c000034 5400d97e <0f000000> 39600004 91610008 80010008
> note: IRQ-131[93] exited with preempt_count 1

Yup. That's a deadlock. In mainline this does not happen, as the
spinlock is a NOP. Turn on CONFIG_PROVE_LOCKING in mainline and you see
the problem as well.

Solution below

	tglx

Index: linux-2.6.22/drivers/serial/mpc52xx_uart.c
===================================================================
--- linux-2.6.22.orig/drivers/serial/mpc52xx_uart.c	2007-07-09 01:32:17.000000000 +0200
+++ linux-2.6.22/drivers/serial/mpc52xx_uart.c	2007-07-25 21:06:11.000000000 +0200
@@ -501,7 +501,9 @@ mpc52xx_uart_int_rx_chars(struct uart_po
 		}
 	}
 
+	spin_unlock(&port->lock);
 	tty_flip_buffer_push(tty);
+	spin_lock(&port->lock);
 
 	return in_be16(&PSC(port)->mpc52xx_psc_status) & MPC52xx_PSC_SR_RXRDY;
 }
