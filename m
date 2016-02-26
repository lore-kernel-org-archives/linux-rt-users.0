From: Josh Cartwright <joshc@ni.com>
Subject: Re: [PATCH] tty: serial: sc16is7xx: use threaded interrupts instead
 of homegrow
Date: Fri, 26 Feb 2016 13:00:48 -0600
Message-ID: <20160226190048.GC12917@jcartwri.amer.corp.natinst.com>
References: <56CDCCE6.5020801@prevas.dk>
 <56CDEAE2.9050102@prevas.dk>
 <20160224223547.GF9598@jcartwri.amer.corp.natinst.com>
 <20160226114340.GC8318@linutronix.de>
 <20160226114809.GD8318@linutronix.de>
 <C32FB8B0-21F8-4C84-9F77-20F3CD43E3D4@wp.pl>
 <20160226165228.GA17178@jcartwri.amer.corp.natinst.com>
 <835668C1-5DDB-4495-AD00-4EE8DDD0D146@wp.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="raC6veAxrt5nqIoY"
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sean Nyekj?r <sean.nyekjaer@prevas.dk>,
	linux-serial@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Jon Ringle <jringle@gridpoint.com>,
	Thomas Gleixner <tglx@linutronix.de>
To: Kuba Kicinski <kubakici@wp.pl>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:36564 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753495AbcBZTBD (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 26 Feb 2016 14:01:03 -0500
In-Reply-To: <835668C1-5DDB-4495-AD00-4EE8DDD0D146@wp.pl>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--raC6veAxrt5nqIoY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 26, 2016 at 01:26:27PM -0500, Kuba Kicinski wrote:
> On 26 February 2016 11:52:28 GMT-05:00, Josh Cartwright <joshc@ni.com> wrote:
[..]
> > Instead, the driver needs to implement it's own oneshot-like
> > handling at the device-level: in the registered irq handler, capture
> > triggered interrupt state, squelch/mask, and enqueue the
> > kthread_work.  In the tail-end of the kthread_work, re-enable
> > interrupts at the device level.
>
> The problem there being IIRC that i2c doesn't provide async writes so
> we can't mask from irq callback. The only option would be
> disable_irq/enable_irq, right?

Ah, yes, that is a problem.  If by disable_irq(), you mean
disable_irq_nosync(), then yes, I think that'd work.

  Josh

--raC6veAxrt5nqIoY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJW0KDdAAoJEKp7ZBKwQFArWr4IAK1ANSbAaVJvmDf13bxs5aQf
M025I3rfb2ZMx5QkJTP8vIX/1rtosDO6K9zWfglutAKw9Bpati3Xkx1Z+a0q9II8
X2OqIyirGcjVkcAWpIl40b8OmUgnBXCvYGftrDgEzPzmfd+fHdDaVu16OzqNJLRf
xv97LcBmmWrxL2HljdI2o17CLu/O86LH9SrEeDfsGYj/bbxNBTefl726XuTBVXuI
1uDInCnZTtaestF/y4oBMgsTbtThGBxgINyyYCtJ8VxKRadAsqz2aJwGA3aiwFvM
LQ+LAth1eNAu25oRZfEloF/bxL4brDmKAGm6jaoWv2P4naDJaSWkYYKtDi9nlVs=
=vjE6
-----END PGP SIGNATURE-----

--raC6veAxrt5nqIoY--
