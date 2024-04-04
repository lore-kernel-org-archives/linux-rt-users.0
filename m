Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB15E433AE
	for <linux-rt-users@vger.kernel.org>; Thu,  4 Apr 2024 11:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712230444; cv=none; b=WK8EW63RbVBRO3gEiB74HjBpVo7MTxlexdS0vNdlPEER0pQEHeQ8/p77L74g7NdQvD/O9ekwsXe8S/p4xH2bo9okUMS+s8w6sycDZeLNvcsEsRtIjjzkzV2jP3zoZYLOV+TtteFs1zI+614pcCqACnO7aOvq1vl99x7rJm0BFAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712230444; c=relaxed/simple;
	bh=4BaF/rFdnvhVHr7ulnCzwg1AZETHHmLIew3/B7qKIWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVHNw5T4G2s0n6EAQaW2CJ0LXCwi9J1dZaAr3NmFSintfs3lxpkFhL88FMkO2cnAPriVoOHT1EwsaTStKvv5hEzZ6nWpet+EuN9YNMnS3lihCDjooWrLTTLv61wKFVlXYG5D8EkM0tT7wtltT5inIt9mQEo+a+kXBgGIgLfRVIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rsLLv-0001nW-1k; Thu, 04 Apr 2024 13:33:55 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rsLLu-00AMPs-J5; Thu, 04 Apr 2024 13:33:54 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 435922B1D6C;
	Thu,  4 Apr 2024 11:33:54 +0000 (UTC)
Date: Thu, 4 Apr 2024 13:33:53 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Esben Haabendal <esben@geanix.com>
Cc: linux-rt-users@vger.kernel.org, 
	John Ogness <john.ogness@linutronix.de>
Subject: Re: [RFC PATCH 1/2] serial: imx: Avoid busy polling for transmitter
 to become empty
Message-ID: <20240404-preseason-varied-75427e223409-mkl@pengutronix.de>
References: <cover.1712156846.git.esben@geanix.com>
 <9895c8f9553523d158f47a9718bd24f22dbe0455.1712156846.git.esben@geanix.com>
 <20240404-wobbling-cyclic-90880ac17562-mkl@pengutronix.de>
 <87bk6pl77o.fsf@geanix.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cn7et4dqhtq6bqpr"
Content-Disposition: inline
In-Reply-To: <87bk6pl77o.fsf@geanix.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-rt-users@vger.kernel.org


--cn7et4dqhtq6bqpr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 04.04.2024 13:04:27, Esben Haabendal wrote:
> Marc Kleine-Budde <mkl@pengutronix.de> writes:
>=20
> > On 03.04.2024 17:22:52, Esben Haabendal wrote:
> >> Busy polling with readl() is a rather harsh way to wait for a potentia=
lly
> >> long time.
> >
> > This read_poll_timeout_atomic() is compiled to an
> > imx_uart_readl()/udelay()/cpu_relax() loop. Does the introduction of
> > udelay() bring any advantages?
>=20
> Good point. Probably not. I can set sleep_us 0 to go back to a tight
> loop.

Sounds good

> >> While there, introduce a 10 ms timeout on this waiting, similar to what
> >> many other serial drivers do.
> >
> > But you don't handle the return value...
>=20
> True. But this is similar to all the different wait_for_xmitr()
> functions, which does basically the same. They are all void, so the
> timeout is handled in same happy-go-lucky style.

IMHO the patch description should mention that the driver now ignores
the state of the transmitter after the timeout.

> I think the best we could do would be to show an error message. But
> maybe that is not the most sane thing to do to report a problem with
> writing error messages. I don't know, but maybe that is why most the
> other serial drivers are handling it like this.

Writing an error message within the console driver could lead to a
positive feedback loop :)

> In fsl_lpuart.c and uartlite.c a warning message is printed if/when this
> timeout occurs. I am fine with doing that here as well...
>=20
> On a related note. I am unsure if 10 ms is a good choice for timeout. I
> picked it because it seems like a common value used in many/most
> drivers. But at least some drivers use something like 1 s, which to me
> sounds more sane given that we cannot do any meaningful error handling
> on timeout.

Not having any experience with console drivers, I think the time to
empty the FIFO depends on the size of the TX FIFO and the speed of the
UART.

With some numbers (FIFO size and UART speed) pulled out of thin air (and
neglecting start/stop/parity bits):

    32 bytes * 8 bit/byte / 9600 bit/s =3D 26.7ms

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--cn7et4dqhtq6bqpr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmYOkB4ACgkQKDiiPnot
vG8yUwf8CYHqVZwfInUmuvvPNpTm8+Jd0keBhN+tfAuHt2OmNFMQNZSpqjJ8KS/p
SsnzZQhCeYXM6D52Z9BgzTVP3qIgfmKA4uGjNYw/wWDBll72t56No3/9THiJx2rJ
4Pae5hIjxv92kesA9D+qNrN5zMH/Dbw7r5iy6idH3j3SmRNn+J+IJQaH0LlM6Wit
QjTp7RvazkJI+wuYWblVe/2pad9txaLcUNZlp8U53HW35aUCr6Wcj4jt8DQNXNzq
PJEDqUIJw7hEHIXf/1m3spHFvFrq7uMoN1KXjsgb+DuJM+3YnyuO3FvQnNggkljg
+YqpAk5K6QVrM6dIToCr+y16kE8AjA==
=NFhh
-----END PGP SIGNATURE-----

--cn7et4dqhtq6bqpr--
