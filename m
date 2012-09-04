From: Josh Cartwright <josh.cartwright@ni.com>
Subject: Re: TI wl1271 wireless bug with 3.4-rt17
Date: Tue, 4 Sep 2012 09:11:38 -0500
Message-ID: <20120904141138.GA14942@beefymiracle.amer.corp.natinst.com>
References: <1310590111-11484-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20120902194911.GT28643@pengutronix.de>
 <50444D2F.3040607@gentil.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Cc: linux-rt-users@vger.kernel.org
To: Gregoire Gentil <gregoire@gentil.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailserver5.natinst.com ([130.164.80.5]:46042 "EHLO
	spamkiller05.natinst.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757123Ab2IDP5w (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 4 Sep 2012 11:57:52 -0400
In-Reply-To: <50444D2F.3040607@gentil.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 02, 2012 at 11:24:47PM -0700, Gregoire Gentil wrote:
> Hello,
>=20
> I'm trying to debug a wifi bug with 3.4-rt17 applied, running on an
> OMAP4 ARM board such as Pandaboard.
>=20
> Wi-Fi works perfectly well without rt patches. It also works quite
> well with rt patches AND without wifi module loaded. But with both
> rt patches and wifi module, the system is very flaky and even if I
> manage to launch a big download, I get a kernel hang. I managed to
> get a trace:
>=20
> BUG: scheduling while atomic: irq/213-wl12xx/1588/0x00010002
> Modules linked in: omapdce(C) wl12xx wlcore omaprpc(C) mac80211 d
> [<c001beb4>] (unwind_backtrace+0x0/0xf0) from [<c0613548>] (dump)
> [<c0613548>] (dump_stack+0x20/0x24) from [<c0073908>] (__schedul)
> [<c0073908>] (__schedule_bug+0x54/0x60) from [<c0614818>] (__sch)
> [<c0614818>] (__schedule+0x74/0x6c0) from [<c0614f60>] (schedule)
> [<c0614f60>] (schedule+0xa0/0xb8) from [<c0615eb8>] (rt_spin_loc)
> [<c0615eb8>] (rt_spin_lock_slowlock+0x198/0x288) from [<c06160a8)
> [<c06160a8>] (rt_spin_lock+0x18/0x1c) from [<bf0c6b24>] (wl12xx_)
> [<bf0c6b24>] (wl12xx_hardirq+0x2c/0xa4 [wlcore]) from [<c00bd4f0)
> [<c00bd4f0>] (handle_irq_event_percpu+0xac/0x24c) from [<c00bd70)
> [<c00bd70c>] (handle_irq_event+0x7c/0x9c) from [<c00c08f0>] (han)
> [<c00c08f0>] (handle_level_irq+0xe4/0x134) from [<c00bcf58>] (ge)
> [<c00bcf58>] (generic_handle_irq+0x34/0x3c) from [<c03217e8>] (g)
> [<c03217e8>] (gpio_irq_handler+0x160/0x1a4) from [<c00bcf58>] (g)
> [<c00bcf58>] (generic_handle_irq+0x34/0x3c) from [<c001449c>] (h)
> [<c001449c>] (handle_IRQ+0x88/0xc8)
>=20
> Source code including the function wl12xx_hardirq is here:
> http://dev.omapzoom.org/?p=3Dintegration/kernel-ubuntu.git;a=3Dblob;f=3Dd=
rivers/net/wireless/ti/wlcore/main.c;h=3D45fe911a6504f92dddff5a9415bb77a643=
b3c4a9;hb=3Df84c72f6b36418ff11d16808c16a7c3216730bb0
>=20
> Any idea what could be wrong and how I could debug and fix this situation?

On first glance, it looks like the driver uses request_threaded_irq(),
to register its handlers, but is trying to acquire a regular spin_lock
in its primary handler.  That's bad news, since spin_locks' can
schedule() when contended with CONFIG_PREEMPT_RT.

And it's not just that, unfortunately, since the primary handler also
complete()s a completion, which also can schedule().

It looks like the overall interrupt handling strategy of this driver
probably needs to be revisited. :(.

--=20
          joshc

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQRgwaAAoJEEef0niEbw+litUQAIdS5s4IZqSYmrf9yt+j/xYs
7TCUJwZP6CwNwOGpVzCC3TEYx25qeeFg+lNONEnEGPCeEwDiQRWrOy8R5vHuLEtO
s0nFbTCmw2mW0hA3j901Ciil0QH4TXO9fgtpbt+ipeUR6Np431gWwH2a8JOhLwF6
N7qvkDt3urHRwLyGsrOkSAJAWQkr4YMsKCAwVC7nX0Xngzrx58Yjez76hLrWmkF7
eMrCxjPKij7+qx76Gg4sDqyH4rtAXkGFXUe+bBWEu+JoeL1QxxZBCEJgD/4uUPlP
oYS/leA5BGmfaHntW6l5NQQvBP2m8xsZ/uoveF4DTrb8ysns4t1Of5MstR3FEXds
wD1j3cwZUnXx9PZhkZqcTuyG3bUcwXyzyvDNz2+5ScP4duHWVX9Kcll25rf439I5
S6605rLUQqu4WkP9deeFp+H9y9pwIQBQ53s4vSZuxD2m/PemIzFjvq/TX/SpMdNV
U+ShXu3vN65MmSSWO61LjZgmioZCbfXkeyDakikK+td4NZ5ppKlpjCRARiSPciZR
PVZBtLny4ICjFt/uGVcGEAIxHouweCuPRmxjFq5N05mWSXql4xWvPT3rrIKiVRwy
2WZcVKG/r0RgVe4gTpPd+Vjih4+HjWrgYyc5o8WjhL2OrUskcSXUQUZjx9Wp3TSW
O4xznY7tZMEzbILuK+EG
=DWDw
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
