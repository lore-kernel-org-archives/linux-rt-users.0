From: Belser Florian <Florian.Belser@sensor-technik.de>
Subject: AW: Kernel Oops caused by high uart write loads
Date: Wed, 6 Feb 2013 06:36:33 +0000
Message-ID: <5EC8D4ACC923FE4D871AFFACC976127959E9B8@stwexdb.stww2k.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Waibel Georg <Georg.Waibel@sensor-technik.de>
To: "'linux-rt-users@vger.kernel.org'" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.sensor-technik.de ([80.150.181.156]:62518 "EHLO
	mail.sensor-technik.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252Ab3BFGrH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 6 Feb 2013 01:47:07 -0500
Received: from stwkeys.sensor-technik.de (localhost [127.0.0.1])
	by stwkeys.sensor-technik.de (Postfix) with ESMTP id CDAE518C073
	for <linux-rt-users@vger.kernel.org>; Wed,  6 Feb 2013 07:37:01 +0100 (CET)
Received: from mail.sensor-technik.de (unknown [172.25.2.15])
	by stwkeys.sensor-technik.de (Postfix) with ESMTP id 9F41818C054
	for <linux-rt-users@vger.kernel.org>; Wed,  6 Feb 2013 07:36:39 +0100 (CET)
Content-Language: de-DE
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,
here is the solution for the kernel oops. As tglx mentioned, the kernel=
 crashed because of recursive spin_locking.=20
Here's a patch to fix this issue in the mpc52xx_uart driver. It just re=
leases the lock before calling uart_write_wakeup.
Our kernel version 3.4.17-rt28.=20
What would we have to do to get this bug fix mainline?

Regards,
=46lorian

Index: drivers/tty/serial/mpc52xx_uart.c =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- drivers/tty/serial/mpc52xx_uart.c
+++ drivers/tty/serial/mpc52xx_uart.c
@@ -1053,8 +1053,11 @@
 	}
=20
 	/* Wake up */
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS) {
+		spin_unlock(&port->lock);
 		uart_write_wakeup(port);
+		spin_lock(&port->lock);
+	}
=20
 	/* Maybe we're done after all */
 	if (uart_circ_empty(xmit)) {


-----Urspr=FCngliche Nachricht-----
Von: linux-rt-users-owner@vger.kernel.org [mailto:linux-rt-users-owner@=
vger.kernel.org] Im Auftrag von Thomas Gleixner
Gesendet: Montag, 4. Februar 2013 12:45
An: Belser Florian
Cc: 'linux-rt-users@vger.kernel.org'; linux-serial@vger.kernel.org; lin=
ux-bluetooth@vger.kernel.org
Betreff: Re: Kernel Oops caused by high uart write loads

On Wed, 30 Jan 2013, Belser Florian wrote:

> I'm running 3.4.17-rt28 on my mpc5200 based system. =A0The complete=20
> system works pretty good until I select the "Fully Preemptible Kernel=
"
> option in the kernel settings.  In that case, if I generate a high=20
> uart write load (sending a lot of stuff via Bluetooth) I get the=20
> following kernel Oops:

> # ------------[ cut here ]------------ Kernel BUG at c03d1728 [verbos=
e=20
> debug info unavailable]

I bet this is: BUG_ON(rt_mutex_owner(lock) =3D=3D self);

> Oops: Exception in kernel mode, sig: 5 [#1] PREEMPT=20
> mpc5200-simple-platform Modules linked in:
> NIP: c03d1728 LR: c03d170c CTR: c01efc78
> REGS: c716fd30 TRAP: 0700=A0=A0 Not tainted=A0 (3.4.17-rt28/STW-V3.00=
r0+)
> MSR: 00029032 <EE,ME,IR,DR,RI>=A0 CR: 88002022=A0 XER: 00000000 TASK =
=3D=20
> c7125880[633] 'irq/129-mpc52xx' THREAD: c716e000
> GPR00: 00000001 c716fde0 c7125880 00000000 c7125880 00000000 00000001
> 00000000
> GPR08: c7125880 c7125880 c7125880 c7125881 88002022 fbfdffff 07fff000
> 00000004
> GPR16: 00000024 00000000 000000c0 00000000 c0537e70 00000004 00000000
> 00000004
> GPR24: c716ad5c c0537e8c c7a73000 00000000 c7bb2a00 c7125880 c78b9800=
=20
> c0537e8c NIP [c03d1728] rt_spin_lock_slowlock+0x78/0x1e0 LR [c03d170c=
]
> rt_spin_lock_slowlock+0x5c/0x1e0 Call Trace:
> [c716fde0] [c03d170c] rt_spin_lock_slowlock+0x5c/0x1e0 (unreliable)=20
> [c716fe40] [c01efcd4] uart_write+0x5c/0x114 [c716fe70] [c028f3f4]=20
> hci_uart_tx_wakeup+0xe0/0x1fc [c716fea0] [c01d3398]=20
> tty_wakeup+0x78/0xac [c716feb0] [c01ee9e0] uart_write_wakeup+0x24/0x3=
4=20
> [c716fec0] [c01f1c38] mpc52xx_psc_handle_irq+0x3f8/0x4b0
> [c716ff20] [c01f13e4] mpc52xx_uart_int+0x38/0x60 [c716ff30] [c005f660=
]=20
> irq_forced_thread_fn+0x38/0x9c [c716ff50] [c005f42c]
> irq_thread+0x13c/0x1c0 [c716ff90] [c00391d4] kthread+0x8c/0x90=20
> [c716fff0] [c000dd4c] kernel_thread+0x4c/0x68 Instruction dump:
> 7fe3fb78 7fa4eb78 38a00000 38c00001 4bc86591 2f830000 409e0134
> 801f0018 5400003c 7fa00278 7c000034 5400d97e <0f000000> 3bdd0418
> 3b810008 7fc3f378

> If I switch the preemption modelt o "Preemptible Kernel (Basic RT)"
> everything works fine.

By some definition of works. It works w/o RT_FULL because locks are NOP=
s on uniprocessor, except you enable lock debugging.

This is a classic recursive dead lock. If you enable CONFIG_PROVE_LOCKI=
NG, then you should see the same issue even on a completely unpatched m=
ainline kernel.

> Hope someone already had the same or similar problem and can help me =
solving it.
> Maybe a update to 3.4.27-rt39 helps?

No, wont help.

The problem is:

mpc52xx_uart_int()

  lock(port->lock);

    mpc52xx_psc_handle_irq()

      mpc52xx_uart_int_tx_chars()

        uart_write_wakeup()

          tty_wakeup()

            hci_uart_tx_wakeup()

              len =3D tty->ops->write(tty, skb->data, skb->len);

	      The associated write function is uart_write

	      uart_write()

		lock(port->lock)  --> deadlock

I have no idea how that bluetooth "uart" gets connected to the physical=
 uart, but the backtrace is pretty obvious. What are you doing to repro=
duce this?

Thanks,

	tglx
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
