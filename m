From: Gregory Haskins <ghaskins@novell.com>
Subject: Re: 2.6.29-rt1+ irqbalance = OOPS
Date: Fri, 27 Mar 2009 12:49:46 -0400
Message-ID: <49CD03AA.4030000@novell.com>
References: <49CCFBCA.6050702@gareus.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig36DD2609EF8214909B5FC198"
Cc: linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: Robin Gareus <robin@gareus.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:49271 "EHLO
	victor.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754064AbZC0Qrc (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 27 Mar 2009 12:47:32 -0400
In-Reply-To: <49CCFBCA.6050702@gareus.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig36DD2609EF8214909B5FC198
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Robin Gareus wrote:
> Hello,
>
> Starting the irqbalance daemon ( http://www.irqbalance.org/ ) on
> 2.6.29-rt1 causes the system to OOPS and freeze. irqbalance works fine
> with previous realtime kernels (2.6.24.7-rt27).
>
> The OOPS seems to be caused by the PID of the [timer] IRQ-1
This in of itself might be part of the problem.  I didn't think the
timer was supposed to be threaded.  Thomas?

> . However the
> OOPS message is too long and I can't read the beginning lines on the
> terminal. The system hangs so I can't scroll back and it's not written
> to any log. SysRq does also not work after the OOPS.
>
> A bit off topic, but how can I capture those OOPSes?
>  =20
A serial-console or netconsole is generally better than a VT for
catching the whole output.

> I could get a larger screen and a digital camera ;) The lkcd.sf.net
> patch does not apply to 2.6.29. Running a realtime kernel in qemu does
> not make much sense, although it may be sufficient to reproduce this OO=
PS.
> Is there a way to use USB as serial console using a hub and two
> computers?
I think so, though I have never tried.

> I guess I'll need a dongle or sth. Besides would a printk()
> to a serial port work even if some IRQ handler hangs?
>  =20
Usually yes.  Of course, it depends on what is actually broken, but
*most* issues still allow the printks to work.

Good luck!
-Greg




--------------enig36DD2609EF8214909B5FC198
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAknNA6oACgkQlOSOBdgZUxmpaACfaNgXWz8kCsD1pkv6ixytPaCO
EqUAn3RpAiaJrNRi+OjEzXAhgtDtmYsp
=qIX4
-----END PGP SIGNATURE-----

--------------enig36DD2609EF8214909B5FC198--
