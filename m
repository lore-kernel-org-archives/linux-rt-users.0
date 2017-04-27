From: Julia Cartwright <julia@ni.com>
Subject: Re: [PATCH 1/2] raid5: Use raw_spinlock for stripe management.
Date: Thu, 27 Apr 2017 10:43:17 -0500
Message-ID: <20170427154317.GQ25232@jcartwri.amer.corp.natinst.com>
References: <1493040816-24038-1-git-send-email-gq@cs.msu.su>
 <20170425154646.GK25232@jcartwri.amer.corp.natinst.com>
 <20170425210929.GN25232@jcartwri.amer.corp.natinst.com>
 <20170427183407.6b6c9d47@brick.gerasiov.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SNIs70sCzqvszXB4"
Cc: <linux-rt-users@vger.kernel.org>
To: Alexander Gerasiov <gq@redlab-i.ru>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:48158 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S968653AbdD0PnY (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 27 Apr 2017 11:43:24 -0400
Content-Disposition: inline
In-Reply-To: <20170427183407.6b6c9d47@brick.gerasiov.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--SNIs70sCzqvszXB4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 27, 2017 at 06:34:07PM +0300, Alexander Gerasiov wrote:
> Hello Julia,
>=20
> On Tue, 25 Apr 2017 16:09:29 -0500
> Julia Cartwright <julia@ni.com> wrote:
>=20
> > Looking at this some more, I imagine the callpath which is problematic
> > is:
> >=20
> >    <writeback kworker>
> >    ...
> >    add_stripe_bio()
> >      stripe_add_to_batch_list()
> >        lock_two_stripes()
> >          local_irq_disable()
> >          spin_lock(&sh{1,2}->stripe_lock) --> ___might_sleep() -->
> > BOOM
> >=20
> > That is, it's the local_irq_disable() in lock_two_stripes() which is
> > the problem.  That's my gut feel, anyway. Can you give this patch a
> > try and see if works?  You'll probably still want the second patch in
> > your series.
>=20
> Ouch, you are absolutely right, it was not atomic context this time, so
> changing spinlocks from mutex to real ones is not necessary. My fault.
>=20
> Do you want me to resubmit the patch, or do it yourself?

If you can confirm that the proposed patch fixes the problem you are
seeing, I'll send a proper patch.

Thanks,
   Julia

PS. Also, interestingly, this is not an altogether uncommon problem:

   virtual report

   @r exists@
   position p1;
   position p2;
   @@

   (
   local_irq_disable@p1
   |
   local_irq_save@p1
   )(...);
   ... when !=3D local_irq_enable(...)
       when !=3D local_irq_restore(...)
   (
   spin_lock@p2
   |
   spin_lock_irq@p2
   |
   spin_lock_irqsave@p2
   )(...);

   @script:python depends on r && report@
   p1 << r.p1;
   p2 << r.p2;
   @@

   msg=3D"ERROR: sleeping spinlock acquired, though interrupts disabled on =
line %s" % (p1[0].line)
   coccilib.report.print_report(p2[0], msg)

Reports:

   drivers/tty/serial/pch_uart.c:1672:2-11: ERROR: sleeping spinlock acquir=
ed, though interrupts disabled on line 1662
   drivers/tty/serial/st-asc.c:812:2-11: ERROR: sleeping spinlock acquired,=
 though interrupts disabled on line 806
   drivers/tty/serial/meson_uart.c:497:2-11: ERROR: sleeping spinlock acqui=
red, though interrupts disabled on line 491
   drivers/tty/serial/bcm63xx_uart.c:713:2-11: ERROR: sleeping spinlock acq=
uired, though interrupts disabled on line 706
   drivers/tty/serial/ar933x_uart.c:555:2-11: ERROR: sleeping spinlock acqu=
ired, though interrupts disabled on line 548
   drivers/tty/serial/stm32-usart.c:940:2-11: ERROR: sleeping spinlock acqu=
ired, though interrupts disabled on line 934
   drivers/net/ethernet/tehuti/tehuti.c:1632:1-10: ERROR: sleeping spinlock=
 acquired, though interrupts disabled on line 1631
   drivers/tty/serial/pxa.c:659:2-11: ERROR: sleeping spinlock acquired, th=
ough interrupts disabled on line 653
   drivers/tty/serial/lpc32xx_hs.c:153:2-11: ERROR: sleeping spinlock acqui=
red, though interrupts disabled on line 147
   arch/x86/kernel/reboot.c:98:1-10: ERROR: sleeping spinlock acquired, tho=
ugh interrupts disabled on line 86
   net/core/drop_monitor.c:171:1-10: ERROR: sleeping spinlock acquired, tho=
ugh interrupts disabled on line 169
   drivers/tty/serial/sh-sci.c:2800:2-11: ERROR: sleeping spinlock acquired=
, though interrupts disabled on line 2791
   drivers/usb/gadget/udc/dummy_hcd.c:755:1-10: ERROR: sleeping spinlock ac=
quired, though interrupts disabled on line 754
   arch/alpha/kernel/srmcons.c:81:1-10: ERROR: sleeping spinlock acquired, =
though interrupts disabled on line 74
   lib/dma-debug.c:946:2-11: ERROR: sleeping spinlock acquired, though inte=
rrupts disabled on line 943
   arch/mn10300/kernel/mn10300-serial.c:1594:2-11: ERROR: sleeping spinlock=
 acquired, though interrupts disabled on line 1587
   arch/metag/kernel/smp.c:451:2-11: ERROR: sleeping spinlock acquired, tho=
ugh interrupts disabled on line 446

There isn't an entirely straightforward way to fix each of these; it will
require some auditing, if anyone is looking for more work to do :).

--SNIs70sCzqvszXB4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEgKAEF431w1EL96k9jNrC4UVNdG8FAlkCEZIACgkQjNrC4UVN
dG+r8gf/XLPZOzhF/L+J5M/zO0Zn4588cHLrLExFljN2lPa0BRil7EjYtoDGvgP0
SGwaqYrdtfp+k1d28HJIkqLQjJn8/ZAi9PgJBdHe82HC3Xo4iwMkwBG7W1Gjm42a
kPRkipfjMn1BGw3W1fKJji0XqRgut80lrUATvaVDNMCrcAetXpCt0MLScSauRwKP
v8wAUCU2WHYFXLOmvi8WIVYwzhv5QSFB3c0EOMyx3Q7Rri2czePobrq2PGJrGTj7
ZUzpXY/dfDJPU5jf2gp+HAMdqoEYOHEp3Ts2XGb+CPMgQtmVMZLNVUnDhbFdVCRD
96IupyxJOCTkr37smuQnGLGUMh4N+Q==
=bXQo
-----END PGP SIGNATURE-----

--SNIs70sCzqvszXB4--
