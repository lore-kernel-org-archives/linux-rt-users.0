Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B443615FCF4
	for <linux-rt-users@vger.kernel.org>; Fri,  5 Apr 2024 08:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712306599; cv=none; b=kaRBrt+AJPkJYMyaKEfHJCVXsqqrJPYu4R38Zvz7ZEOeVHHma9x/VCPQkyHrGAKkgF2gbt33X1SwoofaCGy51f5WDEJp3vbtyLeS9lorBYrASVPb45X3TlBMM9nX9aR6owZ9mGOh8qx5H6Ra8k7Swd3+3MhfiKUMTPfMQ8Aj6F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712306599; c=relaxed/simple;
	bh=nA2kW2bkqVf4Bwn6xpGuTHDN3Qt4ZjAwdSm/XJdqMnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8KxI9fLSkVI7DqTaCM4J7YRzLBowo49gpIzU4SVQJb+ANXG03oya0BkRRcF2oSx64O/rq1X9b45pQoP/obzyqdcUSjdOKgNoM3lGGarZl7EFr1f6qFkEs6Og6Jh4031P53UxSCYKKTWlkyO6wrnFfIuLQU/Ix0O52mCqZ7jyp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rsfAD-00022k-4r; Fri, 05 Apr 2024 10:43:09 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rsfAC-00AXLZ-O5; Fri, 05 Apr 2024 10:43:08 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 685B72B2778;
	Fri,  5 Apr 2024 08:43:08 +0000 (UTC)
Date: Fri, 5 Apr 2024 10:43:07 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Esben Haabendal <esben@geanix.com>
Cc: linux-rt-users@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/2] serial: imx: Switch to nbcon console
Message-ID: <20240405-brush-unroll-47fba20825aa-mkl@pengutronix.de>
References: <cover.1712303358.git.esben@geanix.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7q5d7smwypezauau"
Content-Disposition: inline
In-Reply-To: <cover.1712303358.git.esben@geanix.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-rt-users@vger.kernel.org


--7q5d7smwypezauau
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 05.04.2024 09:56:36, Esben Haabendal wrote:
> This is a first attempt at porting another serial console driver to nbcon.
>=20
> The first patch is a preparatory patch, thought to be suitable for mainli=
ne
> inclusion now, while the second patch is for rt only for now.
>=20
> The second patch does have quite a copy-paste feeling to it.
>=20
> The imx_uart_console_write_atomic() and imx_uart_console_write_thread()
> includes copies of code from the old imx_uart_console_write() function.
> This is similar to current status of nbcon support in 8250 driver.
>=20
> The midle part of imx_uart_console_write_thread() is identical to the
> middle part of serial8250_console_write_thread() in
> drivers/tty/serial/8250/8250_port.c, except for the arguments to
> uart_console_write() function.
>=20
> There is clearly potential for writing some common code to avoid both cas=
es
> of copy-paste code.
>=20
> I am unsure about what the plan is for keeping the legacy console code in
> the drivers. Are we going to drop that before submitting the code to
> mainline?

Some additional thoughts:
- Code duplication should be avoided.
- You can remove the first "ifdef" if you mark the functions as __maybe_unu=
sed.
- Use get_maintainer.pl to address all relevant parties and discuss if
  you should keep the legacy console. You should do this next, as the
  above gets irrelevant if the legacy console can be removed.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--7q5d7smwypezauau
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmYPuZgACgkQKDiiPnot
vG96CAf+NU/4rKHT336N53eJof6rFhFYHF5SjikCJurk+2x0VpyH6Gz7zz4hULgx
oyFD0zMqDM4ITHiT1/63NmfvgM0C6NNsKBgTSGOgEfo82NQHvmybx/a45HQhr8I+
rcCaQrHIlmyaNb1rwVK6JcalQU+dJ4S8KiBJjdNm3cs/7mtyP58OPs2ZvPR+Q/V7
CJ+gic+bzQdMVZVwYT9YcJBrCCy2psn1DwbsUAgBbhyhTCqISjS3him3zoF9/jwD
4BgdpHryiorTl74NW93ycVpbTE8UPdRElgI3I7lM0eIEwHgCqkytFAy6YMMkvpg4
s9Z3wPQ31M3tD263OTUMZt/9ANHoyA==
=Pg3K
-----END PGP SIGNATURE-----

--7q5d7smwypezauau--
