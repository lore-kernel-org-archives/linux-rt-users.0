Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D83B2C189
	for <linux-rt-users@vger.kernel.org>; Thu,  4 Apr 2024 08:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712218527; cv=none; b=p/Z81yyPCwX60LIMH/VK7JRUCGK4i8e9cKkyWqHpt1OjzfEYAkVNSWr36VZXLm1+m8QFh95GppZXmsuaoRUC1vLce6XAyAIG6aTlZNE5Y88yn+m3c9nmYYbPp7eomhSqyM4iqo5udNTM/EycVKrrG9xJat98Ln99ooqovUdA/qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712218527; c=relaxed/simple;
	bh=u96uKREgKW8kKtPAqlXAvEREo3rQeCHWpUkI8z4dU5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=POOe6umKZCF5/YaeZS3G9kAr+R82iuT+wJ68e9HitYV9zI/GvAGhJKESzurHolPl6XfyHg61S1W58e5uTf423esLFLqsolkoxFwkDxFYmEkeKGoj5apf4L6uElJXrNHKi3E/VRbkmmVoL7vXRrsX4QEUFIKLbftYOqaOhbGemGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rsIFi-00079B-TL; Thu, 04 Apr 2024 10:15:18 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rsIFi-00AKh1-Ex; Thu, 04 Apr 2024 10:15:18 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id DB6BE2B1B3B;
	Thu,  4 Apr 2024 08:15:17 +0000 (UTC)
Date: Thu, 4 Apr 2024 10:15:17 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Esben Haabendal <esben@geanix.com>
Cc: linux-rt-users@vger.kernel.org, 
	John Ogness <john.ogness@linutronix.de>
Subject: Re: [RFC PATCH 1/2] serial: imx: Avoid busy polling for transmitter
 to become empty
Message-ID: <20240404-wobbling-cyclic-90880ac17562-mkl@pengutronix.de>
References: <cover.1712156846.git.esben@geanix.com>
 <9895c8f9553523d158f47a9718bd24f22dbe0455.1712156846.git.esben@geanix.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s326pxqs3nwq66wn"
Content-Disposition: inline
In-Reply-To: <9895c8f9553523d158f47a9718bd24f22dbe0455.1712156846.git.esben@geanix.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-rt-users@vger.kernel.org


--s326pxqs3nwq66wn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 03.04.2024 17:22:52, Esben Haabendal wrote:
> Busy polling with readl() is a rather harsh way to wait for a potentially
> long time.

This read_poll_timeout_atomic() is compiled to an
imx_uart_readl()/udelay()/cpu_relax() loop. Does the introduction of
udelay() bring any advantages?

> While there, introduce a 10 ms timeout on this waiting, similar to what
> many other serial drivers do.

But you don't handle the return value...

> Signed-off-by: Esben Haabendal <esben@geanix.com>

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--s326pxqs3nwq66wn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmYOYZIACgkQKDiiPnot
vG/D1gf+LOVU6gLzeznJSRXGS8vI581RMkaH20WhKbpXoBUkFdFj88TNtAR/pTFC
+11yPiEkO+VedJmIROtuR4VO12ZdHatjCMKW7rB8whGn98G9DqrijvblJhkihZ7y
qGdhLkJm5CwYnfiyJziN3trdSM/eUkpSaBuhGp3U43OFode8L6BhomdhMvEHJXkq
GDDvwqMt05mbIjafsAeXMnBVqaCVMN9mDewKO1+UAFRbo4fGy5U17FFScTcMEwho
SE3hmoywKsvrOK1fpdzWtb48YZ4Yn239AGfsi1B6WknX+SG+BD+GwhWD7+3kUwGT
R1tKCEEut+1GRoe5FgrC5rwKe7NTRg==
=WIGk
-----END PGP SIGNATURE-----

--s326pxqs3nwq66wn--
