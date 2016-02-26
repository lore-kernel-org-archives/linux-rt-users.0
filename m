From: Josh Cartwright <joshc@ni.com>
Subject: Re: [PATCH] tty: serial: sc16is7xx: use threaded interrupts instead
 of homegrow
Date: Fri, 26 Feb 2016 10:52:28 -0600
Message-ID: <20160226165228.GA17178@jcartwri.amer.corp.natinst.com>
References: <56CDCCE6.5020801@prevas.dk>
 <56CDEAE2.9050102@prevas.dk>
 <20160224223547.GF9598@jcartwri.amer.corp.natinst.com>
 <20160226114340.GC8318@linutronix.de>
 <20160226114809.GD8318@linutronix.de>
 <C32FB8B0-21F8-4C84-9F77-20F3CD43E3D4@wp.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sean Nyekj?r <sean.nyekjaer@prevas.dk>,
	linux-serial@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Jon Ringle <jringle@gridpoint.com>,
	Thomas Gleixner <tglx@linutronix.de>
To: Kuba Kicinski <kubakici@wp.pl>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:43884 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932177AbcBZQwp (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 26 Feb 2016 11:52:45 -0500
In-Reply-To: <C32FB8B0-21F8-4C84-9F77-20F3CD43E3D4@wp.pl>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 26, 2016 at 09:34:57AM -0500, Kuba Kicinski wrote:
> On 26 February 2016 06:48:09 GMT-05:00, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> >This ONESHOT + workqueue combo is something that is not required
> >because
> >we have infrastrucure for this kind of things: threaded interrupts.
> >
> >This is compile tested only due to -ENODEV.
> >Now that we that sc16is7xx_irq() is an actual interrupt handler
> >sc16is7xx_port_irq() could be improved so the former can return
> >IRQ_NONE
> >if nothing has been done.
> >
> >Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>
> The reason why this driver is not using threaded irqs is that it
> already has a kthread to handle other things.

The core problem here is still the use of IRQF_ONESHOT.  The semantics
of IRQF_ONESHOT are only defined w.r.t. the irq core's threaded
interrupt handling.

If the driver isn't going to make use of the existing irqthread
functionality, then it _also_ should not be making use of IRQF_ONESHOT.

Instead, the driver needs to implement it's own oneshot-like handling at
the device-level: in the registered irq handler, capture triggered
interrupt state, squelch/mask, and enqueue the kthread_work.  In the
tail-end of the kthread_work, re-enable interrupts at the device level.

Now, with forced_irqthreads, this still isn't ideal, as we'd have two
threads, but perhaps the right way forward there is to be more clever at
the kthread_worker() layer to make it's work list management amenable to
being done under a raw spinlock.

  Josh

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJW0ILJAAoJEKp7ZBKwQFArAcEIAKBxSehsudgHKRavFNYsYAEJ
zNMI0eM6U27wsDSOOuh2gc15AjrRsq8h6rYGF9cEUtpY3dJPv+VbzLILrfYzvEDz
Vgfd/Q7errhB+tpCGOpHTDxlgmoxXGgRBc9lk9Mcx9Y6m9Y+E281Jh5aZJhWJYGq
eR+R5tjWcznr1PRPLmvVuwJCE5CBihj1RuIPVcbMilaUukEUDLxWuHFAjyBD3/yj
IJHdlt9+Hmhz+srKQz0SFUgHgcmSFhQKhPcMboXTgoCSLIXfENHbfEB7+7KWB+tg
x0NsvBXNngDtD9CtQTLek4Jd8mjLkXzi0GtAN56u+KWQqVRF8ECfTHcYuqYsrok=
=tSzP
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
