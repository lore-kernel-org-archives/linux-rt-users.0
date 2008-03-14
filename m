From: Juergen Beisert <jbe@pengutronix.de>
Subject: NULL pointer when calling spin_lock_irqsave()
Date: Fri, 14 Mar 2008 13:18:47 +0100
Message-ID: <200803141318.48207.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:49678 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752053AbYCNMoW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 14 Mar 2008 08:44:22 -0400
Received: from themisto.extern.pengutronix.de ([83.236.181.29] helo=localhost)
	by metis.extern.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <jbe@pengutronix.de>)
	id 1Ja8s5-0000Ps-Q8
	for linux-rt-users@vger.kernel.org; Fri, 14 Mar 2008 13:18:53 +0100
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

in my 2.4.24.3-rt3 kernel when the mii_queue() function shown below is =
called
the *second* time it crashes it calls spin_lock_irqsave(). The first ti=
me the
mii_queue() gets called it runs through spin_lock_irqsave() and at the =
end
through spin_unlock_irqrestore() without any error.
&fep->lock pointer is the same in all calls. And it only happens when
"Complete Preemption (Real-Time)" is active. It works fine when
"Preemptible Kernel (Low-Latency Desktop)" is active. Architecture is A=
RM
(in my case an i.MX27 CPU).

Any idea?

=46EC ENET Version 0.2
Unable to handle kernel NULL pointer dereference at virtual address 000=
00000
pgd =3D c0004000
[00000000] *pgd=3D00000000
Internal error: Oops: 805 [#1] PREEMPT
Modules linked in:
CPU: 0    Not tainted  (2.6.24.3-rt3 #22)
PC is at rt_spin_lock_slowlock+0x98/0x1f4
LR is at rt_spin_lock_slowlock+0x5c/0x1f4
pc : [<c01e5ee4>]    lr : [<c01e5ea8>]    psr: 60000093
sp : c7dd9e58  ip : c7de9cc2  fp : c7dd9eac
r10: 00000032  r9 : c7dea800  r8 : c7dead64
r7 : c7dead64  r6 : c7deac20  r5 : a0000013  r4 : c7dd8000
r3 : c7de9cc0  r2 : c7de9cc0  r1 : c7dead74  r0 : 00000000
=46lags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 0005317f  Table: a0004000  DAC: 00000017
Process IRQ-50 (pid: 176, stack limit =3D 0xc7dd8268)
Stack: (0xc7dd9e58 to 0xc7dda000)
9e40:                                                       c7dd9e7c c7=
dd9e68
9e60: c0082e94 c005e908 00000000 c7dd9ea4 0011b3f5 c78017a8 c7dd9e94 c7=
dd9e88
9e80: 00000000 c7de9cf8 00000000 600e0000 c7deac20 c014b528 c7dead64 00=
000032
9ea0: c7dd9ebc c7dd9eb0 c01e6340 c01e5e5c c7dd9ecc c7dd9ec0 c01e6354 c0=
1e62e4
9ec0: c7dd9ef4 c7dd9ed0 c014a920 c01e6354 00000000 c7deac20 00000001 d4=
02b000
9ee0: c7dead64 c028bfd0 c7dd9f0c c7dd9ef8 c014b664 c014a904 c028bedc 60=
0a0022
9f00: c7dd9f54 c7dd9f10 c014ab7c c014b5f0 c7dd9f2c d402b000 00800000 c0=
05f16c
9f20: c7dd9f54 c7dd9f30 c004cb80 c7d3d960 00000000 c7dd8000 00000032 00=
000000
9f40: 00000000 00000032 c7dd9f84 c7dd9f58 c005ae70 c014a9f8 00000000 ff=
fffffc
9f60: c7dd8000 c0268668 00000032 c7d3d960 00000000 c02686b4 c7dd9fac c7=
dd9f88
9f80: c005b5ac c005ae2c c7dd9fac fffffffc c0268668 c7dd8000 00000032 60=
000013
9fa0: c7dd9fdc c7dd9fb0 c005bfb8 c005b514 00000000 00000032 fffffffc c0=
05bcc4
9fc0: 00000000 00000000 00000000 00000000 c7dd9ff4 c7dd9fe0 c0046dec c0=
05bcd4
9fe0: 00000000 00000000 00000000 c7dd9ff8 c0033fa8 c0046dac 00000000 00=
000000
Backtrace:
[<c01e5e4c>] (rt_spin_lock_slowlock+0x0/0x1f4) from [<c01e6340>] (__rt_=
spin_lock+0x6c/0x70)
[<c01e62d4>] (__rt_spin_lock+0x0/0x70) from [<c01e6354>] (rt_spin_lock+=
0x10/0x14)
[<c01e6344>] (rt_spin_lock+0x0/0x14) from [<c014a920>] (mii_queue+0x2c/=
0xac)
[<c014a8f4>] (mii_queue+0x0/0xac) from [<c014b664>] (mii_discover_phy+0=
x84/0x9c)
 r8:c028bfd0 r7:c7dead64 r6:d402b000 r5:00000001 r4:c7deac20
[<c014b5e0>] (mii_discover_phy+0x0/0x9c) from [<c014ab7c>] (fec_enet_in=
terrupt+0x194/0x550)
 r5:600a0022 r4:c028bedc
[<c014a9e8>] (fec_enet_interrupt+0x0/0x550) from [<c005ae70>] (handle_I=
RQ_event+0x54/0xec)
[<c005ae1c>] (handle_IRQ_event+0x0/0xec) from [<c005b5ac>] (thread_simp=
le_irq+0xa8/0x110)
[<c005b504>] (thread_simple_irq+0x0/0x110) from [<c005bfb8>] (do_irqd+0=
x2f4/0x390)
 r8:60000013 r7:00000032 r6:c7dd8000 r5:c0268668 r4:fffffffc
[<c005bcc4>] (do_irqd+0x0/0x390) from [<c0046dec>] (kthread+0x50/0x7c)
[<c0046d9c>] (kthread+0x0/0x7c) from [<c0033fa8>] (do_exit+0x0/0x7a8)
 r5:00000000 r4:00000000
Code: e5973010 e594200c e3c33003 e1530002 (05800000)
---[ end trace 3c5ae69ea88154b1 ]---
note: IRQ-50[176] exited with preempt_count 1

[...]
static int mii_queue(struct net_device *dev, int regval, void (*func)(u=
int, struct net_device *))
{
	struct fec_enet_private *fep;
	unsigned long	flags;
	mii_list_t	*mip;
	int		retval;

	/* Add PHY address to register command.
	*/
	fep =3D netdev_priv(dev);
	regval |=3D fep->phy_addr << 23;

	retval =3D 0;

	spin_lock_irqsave(&fep->lock,flags);

	if ((mip =3D mii_free) !=3D NULL) {
		mii_free =3D mip->mii_next;
		mip->mii_regval =3D regval;
		mip->mii_func =3D func;
		mip->mii_next =3D NULL;
		if (mii_head) {
			mii_tail->mii_next =3D mip;
			mii_tail =3D mip;
		}
		else {
			mii_head =3D mii_tail =3D mip;
			fep->hwp->fec_mii_data =3D regval;
		}
	}
	else {
		retval =3D 1;
	}

	spin_unlock_irqrestore(&fep->lock,flags);

	return(retval);
}
[...]

--=20
Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=A0Pengutronix - Linux Solutions for Science and Industry
=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=A0 =A0 =A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
