Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEF91CA8B
	for <linux-rt-users@vger.kernel.org>; Thu,  4 Apr 2024 16:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712248779; cv=none; b=SO8xug1WKApqguAuHEvWHWs7hq9mqUIN+swurzxtCYy5UarksKZi/Talt4xv8Tnan3r7ALmI9IPfm0gDErrNlZGEF7QMF8382wis5bxSABT1q7KAlbkSiKKlf999spuMKrl+4z7s+oMX2djFCFXWyOxDVYg7YxE5zrZyBucT7Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712248779; c=relaxed/simple;
	bh=XAVmowGJGqaELh+ZVECqG1KQt0ObuRfOFJsY96LlWkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5tg3q1pCmdmFiQIhzYhvGBYIVFhyIl1ftjZNYKFQWkxdDs5O/jH9xDTG0iFoxtGwqhwpRFHVnw5HbMD2goG0Z6XvcbVB5tsZ5VMZGIe48TjiCqkBuF8cFVvt2XFESuaTjpj92A4Gww4bSgQ0IAfUPqIZA1EleQE0fxmYN2d/yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rsQ7h-0003Hq-Ar; Thu, 04 Apr 2024 18:39:33 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rsQ7g-00APWW-Rq; Thu, 04 Apr 2024 18:39:32 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 84B592B212A;
	Thu,  4 Apr 2024 16:39:32 +0000 (UTC)
Date: Thu, 4 Apr 2024 18:39:31 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Esben Haabendal <esben@geanix.com>
Cc: linux-rt-users@vger.kernel.org, 
	John Ogness <john.ogness@linutronix.de>
Subject: Re: [RFC PATCH 1/2] serial: imx: Avoid busy polling for transmitter
 to become empty
Message-ID: <20240404-sandbank-kindred-18c183b0ea45-mkl@pengutronix.de>
References: <cover.1712156846.git.esben@geanix.com>
 <9895c8f9553523d158f47a9718bd24f22dbe0455.1712156846.git.esben@geanix.com>
 <20240404-wobbling-cyclic-90880ac17562-mkl@pengutronix.de>
 <87bk6pl77o.fsf@geanix.com>
 <20240404-preseason-varied-75427e223409-mkl@pengutronix.de>
 <877chdl4wh.fsf@geanix.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o45kag5ovtharge7"
Content-Disposition: inline
In-Reply-To: <877chdl4wh.fsf@geanix.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-rt-users@vger.kernel.org


--o45kag5ovtharge7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 04.04.2024 13:54:22, Esben Haabendal wrote:
> >> In fsl_lpuart.c and uartlite.c a warning message is printed if/when th=
is
> >> timeout occurs. I am fine with doing that here as well...

You mean the read_poll_timeout() in fsl_lpuart.c in
lpuart_global_reset()? This looks like a totally different codepath to
me.

https://elixir.bootlin.com/linux/v6.8/source/drivers/tty/serial/fsl_lpuart.=
c#L2793

In the write callback the fsl_lpuart.c does a readb(); cpu_relax();
while loop.

https://elixir.bootlin.com/linux/v6.8/source/drivers/tty/serial/fsl_lpuart.=
c#L629
https://elixir.bootlin.com/linux/v6.8/source/drivers/tty/serial/fsl_lpuart.=
c#L636

The other driver is ma35d1_serial.c and uses a timeout of 10ms and
ignored the return value :/

> >> On a related note. I am unsure if 10 ms is a good choice for timeout. I
> >> picked it because it seems like a common value used in many/most
> >> drivers. But at least some drivers use something like 1 s, which to me
> >> sounds more sane given that we cannot do any meaningful error handling
> >> on timeout.
> >
> > Not having any experience with console drivers, I think the time to
> > empty the FIFO depends on the size of the TX FIFO and the speed of the
> > UART.
> >
> > With some numbers (FIFO size and UART speed) pulled out of thin air (and
> > neglecting start/stop/parity bits):
> >
> >     32 bytes * 8 bit/byte / 9600 bit/s =3D 26.7ms
>=20
> I assume that typical console usage will have messages much larger than
> 32 bytes. But on the other hand, most use cases will be 115200 bit/s.

I think it's about the length of the TX FIFO, not the full console
message. And yes, while 115200 bps is typical, the corner cases should
work too.

> But in general, I would be more comofortable with a 1 second timeout. It
> should be more than large enough to handle all realistic cases. But
> will avoid spinning forever if uart for some reason does never clear the
> TXD bit.

makes sense

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--o45kag5ovtharge7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmYO18EACgkQKDiiPnot
vG+CcAf9GWneyczW/twTr+0uVE7BfcXU0Y43/fDOZkk0IYTv6z/+4MPQrTtoxpnY
AT4fAn8jHuVmgViyjt/VEUXYmsS11hPVjeqrvWyF6jDm6j4UMhPWCLBp/CBYPEfO
PI8nXh5ifF2cPO+uLZgRu2tOUVvfY7fPTZIr6NhSOIzhshXoBm/LrgLAFH56yhUf
kQ7tPNZipj23hbybn/hfLUXtaASBSz3AyR5nqcecRChxIO7VTZaLE1XIjf4WP7gP
lF79Cm0/2mBtRsqI130npDL8X9HIbNjW9Iysstq0fh94IZmIZI5WGA/kbqAncmrF
VjEfLE8YUwQ+IcbNFlOcMJUWKOGLTw==
=cNcS
-----END PGP SIGNATURE-----

--o45kag5ovtharge7--
