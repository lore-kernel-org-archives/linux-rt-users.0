From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: Re: Kernel Oops caused by high uart write loads
Date: Tue, 5 Feb 2013 22:51:41 -0800
Message-ID: <5EA2FB66-D058-4E9D-8712-026A13576C96@thebigcorporation.com>
References: <5EC8D4ACC923FE4D871AFFACC976127959E9B8@stwexdb.stww2k.local>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "'linux-rt-users@vger.kernel.org'" <linux-rt-users@vger.kernel.org>,
	Waibel Georg <Georg.Waibel@sensor-technik.de>
To: Belser Florian <Florian.Belser@sensor-technik.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:47700 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751932Ab3BFGvr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 6 Feb 2013 01:51:47 -0500
Received: by mail-pa0-f41.google.com with SMTP id fb11so618651pad.14
        for <linux-rt-users@vger.kernel.org>; Tue, 05 Feb 2013 22:51:44 -0800 (PST)
In-Reply-To: <5EC8D4ACC923FE4D871AFFACC976127959E9B8@stwexdb.stww2k.local>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Feb 5, 2013, at 10:36 PM, Belser Florian <Florian.Belser@sensor-tech=
nik.de> wrote:

> Hi,
> here is the solution for the kernel oops. As tglx mentioned, the kern=
el crashed because of recursive spin_locking.=20
> Here's a patch to fix this issue in the mpc52xx_uart driver. It just =
releases the lock before calling uart_write_wakeup.
> Our kernel version 3.4.17-rt28.=20
> What would we have to do to get this bug fix mainline?

IIUC this should also trigger lockdep warning in mainline.

If you can reproduce the lockdep warning in mainline, then send that an=
d the patch

Sven


>=20
> Regards,
> Florian
>=20
> Index: drivers/tty/serial/mpc52xx_uart.c =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- drivers/tty/serial/mpc52xx_uart.c
> +++ drivers/tty/serial/mpc52xx_uart.c
> @@ -1053,8 +1053,11 @@
> 	}
>=20
> 	/* Wake up */
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS) {
> +		spin_unlock(&port->lock);
> 		uart_write_wakeup(port);
> +		spin_lock(&port->lock);
> +	}
>=20
> 	/* Maybe we're done after all */
> 	if (uart_circ_empty(xmit)) {
>=20
>=20
> -----Urspr=FCngliche Nachricht-----
> Von: linux-rt-users-owner@vger.kernel.org [mailto:linux-rt-users-owne=
r@vger.kernel.org] Im Auftrag von Thomas Gleixner
> Gesendet: Montag, 4. Februar 2013 12:45
> An: Belser Florian
> Cc: 'linux-rt-users@vger.kernel.org'; linux-serial@vger.kernel.org; l=
inux-bluetooth@vger.kernel.org
> Betreff: Re: Kernel Oops caused by high uart write loads
>=20
> On Wed, 30 Jan 2013, Belser Florian wrote:
>=20
>> I'm running 3.4.17-rt28 on my mpc5200 based system.  The complete=20
>> system works pretty good until I select the "Fully Preemptible Kerne=
l"
>> option in the kernel settings.  In that case, if I generate a high=20
>> uart write load (sending a lot of stuff via Bluetooth) I get the=20
>> following kernel Oops:
>=20
>> # ------------[ cut here ]------------ Kernel BUG at c03d1728 [verbo=
se=20
>> debug info unavailable]
>=20
> I bet this is: BUG_ON(rt_mutex_owner(lock) =3D=3D self);
>=20
>> Oops: Exception in kernel mode, sig: 5 [#1] PREEMPT=20
>> mpc5200-simple-platform Modules linked in:
>> NIP: c03d1728 LR: c03d170c CTR: c01efc78
>> REGS: c716fd30 TRAP: 0700   Not tainted  (3.4.17-rt28/STW-V3.00r0+)
>> MSR: 00029032 <EE,ME,IR,DR,RI>  CR: 88002022  XER: 00000000 TASK =3D=
=20
>> c7125880[633] 'irq/129-mpc52xx' THREAD: c716e000
>> GPR00: 00000001 c716fde0 c7125880 00000000 c7125880 00000000 0000000=
1
>> 00000000
>> GPR08: c7125880 c7125880 c7125880 c7125881 88002022 fbfdffff 07fff00=
0
>> 00000004
>> GPR16: 00000024 00000000 000000c0 00000000 c0537e70 00000004 0000000=
0
>> 00000004
>> GPR24: c716ad5c c0537e8c c7a73000 00000000 c7bb2a00 c7125880 c78b980=
0=20
>> c0537e8c NIP [c03d1728] rt_spin_lock_slowlock+0x78/0x1e0 LR [c03d170=
c]
>> rt_spin_lock_slowlock+0x5c/0x1e0 Call Trace:
>> [c716fde0] [c03d170c] rt_spin_lock_slowlock+0x5c/0x1e0 (unreliable)=20
>> [c716fe40] [c01efcd4] uart_write+0x5c/0x114 [c716fe70] [c028f3f4]=20
>> hci_uart_tx_wakeup+0xe0/0x1fc [c716fea0] [c01d3398]=20
>> tty_wakeup+0x78/0xac [c716feb0] [c01ee9e0] uart_write_wakeup+0x24/0x=
34=20
>> [c716fec0] [c01f1c38] mpc52xx_psc_handle_irq+0x3f8/0x4b0
>> [c716ff20] [c01f13e4] mpc52xx_uart_int+0x38/0x60 [c716ff30] [c005f66=
0]=20
>> irq_forced_thread_fn+0x38/0x9c [c716ff50] [c005f42c]
>> irq_thread+0x13c/0x1c0 [c716ff90] [c00391d4] kthread+0x8c/0x90=20
>> [c716fff0] [c000dd4c] kernel_thread+0x4c/0x68 Instruction dump:
>> 7fe3fb78 7fa4eb78 38a00000 38c00001 4bc86591 2f830000 409e0134
>> 801f0018 5400003c 7fa00278 7c000034 5400d97e <0f000000> 3bdd0418
>> 3b810008 7fc3f378
>=20
>> If I switch the preemption modelt o "Preemptible Kernel (Basic RT)"
>> everything works fine.
>=20
> By some definition of works. It works w/o RT_FULL because locks are N=
OPs on uniprocessor, except you enable lock debugging.
>=20
> This is a classic recursive dead lock. If you enable CONFIG_PROVE_LOC=
KING, then you should see the same issue even on a completely unpatched=
 mainline kernel.
>=20
>> Hope someone already had the same or similar problem and can help me=
 solving it.
>> Maybe a update to 3.4.27-rt39 helps?
>=20
> No, wont help.
>=20
> The problem is:
>=20
> mpc52xx_uart_int()
>=20
>  lock(port->lock);
>=20
>    mpc52xx_psc_handle_irq()
>=20
>      mpc52xx_uart_int_tx_chars()
>=20
>        uart_write_wakeup()
>=20
>          tty_wakeup()
>=20
>            hci_uart_tx_wakeup()
>=20
>              len =3D tty->ops->write(tty, skb->data, skb->len);
>=20
> 	      The associated write function is uart_write
>=20
> 	      uart_write()
>=20
> 		lock(port->lock)  --> deadlock
>=20
> I have no idea how that bluetooth "uart" gets connected to the physic=
al uart, but the backtrace is pretty obvious. What are you doing to rep=
roduce this?
>=20
> Thanks,
>=20
> 	tglx
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
