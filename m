Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC541F16B;
	Mon, 15 Apr 2024 07:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713167794; cv=none; b=mU54FDnP+J2Q6QzKA+wztiWOlPyR88ZcecG9OzQDnjPcKPQIrA4VV2qq6hkbYsZtveYvTYFEO9vQTytEzb8sX+Rpi14l9pUHD7hieH8ydZTZy1RS5SZiJIyQXAwo6ny81nTMmOpbd5+3IasJdZGE6BDmuh2C/CmyROkJAl+vR/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713167794; c=relaxed/simple;
	bh=S324kEgCuhI/VRe9Fz0tirH7HrFyKJZFebNrYDHytn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXUw1Xe3KXSQbUv0vGrFxKinliPM6dJRTNS1ckoSRYTLTzW5kBikxcxOUwu5hSfQJl9zd3shznMqjOOTxof7MnRxNe6Zp8pskrFMQU83Gs+SQdVYqi9oa9h4Z6bw1Oqhf7gNgNNlswB/UhgJAu1AoK9cA7MGn1iHuZhy+KZHahE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=KnZxMYqs; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="KnZxMYqs"
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id B648D1C007F; Mon, 15 Apr 2024 09:56:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1713167787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WjfMW+NA/CnSQotoTVzRdyimGwWSKCreZbaAXRI+G10=;
	b=KnZxMYqsLqcB75iP5P6dBUnN189g6ARNATtxXQYnU0MC6S1l81LkMNYw73a3dAkv0SK0B+
	SxdW537XZbJslbH2KvqCFxH0ItKMEA4EEeA8TofmcZioW+RDU+h7nM/LCDFrO7vstLSdXi
	pBwR/U2uRCkc7cIxCTu/VGlFqIqrYZ0=
Date: Mon, 15 Apr 2024 09:56:27 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	stable-rt <stable-rt@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Wagner <daniel.wagner@suse.com>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	Mark Gross <markgross@kernel.org>, Pavel Machek <pavel@denx.de>,
	Jeff Brady <jeffreyjbrady@gmail.com>
Subject: Re: [ANNOUNCE] 5.10.213-rt105
Message-ID: <ZhzdqyqZrjhXs7ZJ@duo.ucw.cz>
References: <ZgFy9au0Gvkzr6gZ@uudg.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ioEvBMbk+BU4Wpfr"
Content-Disposition: inline
In-Reply-To: <ZgFy9au0Gvkzr6gZ@uudg.org>


--ioEvBMbk+BU4Wpfr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I'm pleased to announce the 5.10.213-rt105 stable release.
>=20
> This release is an update to the new stable 5.10.213 version and no extra
> changes have been performed.

Thanks for release.

I see v5.10.214-rt106-rc1 is out there and now v5.10.215-rt107-rc1,
but I don't see v5.10.214-rt106 (which would be useful to me).

Is it a mistake or should I plan for v5.10.215-rt107?

Thanks and best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--ioEvBMbk+BU4Wpfr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZhzdqwAKCRAw5/Bqldv6
8s16AKCCORSigOjFdUBW/JSDdMs6H2UTtgCfYavhz8dojqsBLVcXSYxU0kR4X+I=
=MGB3
-----END PGP SIGNATURE-----

--ioEvBMbk+BU4Wpfr--
