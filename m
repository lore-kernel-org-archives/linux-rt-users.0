Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2F0207671;
	Thu,  5 Dec 2024 11:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733398121; cv=none; b=pwRmZab9tptwyfzIZxDGqUoqhai88yQsw9OPb17pQ8HeRLrxrHbG13nf31VFt+FP1tgVJZfpdneUzFEj2lKCGcDGnuEriEk9eyPDDVxIOcUhd1dUOtEyIbZ7NYG18VOuIV6sIeDEgBpGLcWij16jef8CQcM75c0XOSKGrUv2pZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733398121; c=relaxed/simple;
	bh=HFn7iATAqCVpJC0l5cIdf6N7vw9PX93mh3A7G0DoPA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwi5RHjHl+CfulNNZCjw/n6FOgEFcgzRd+ATK7b/qe6Tb7JxilhsKl9I1GGkdXkRTXLHO0tmBzG6nGuUoDe8USwPAZke2EdM3LV07CnliFUlMTPGtr5LT4inaGppMnXDvmlqy1lOoWYOkDsG8OlYPeSMUo/IGnw39FrS92ZAIbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id C8F071C00A0; Thu,  5 Dec 2024 12:28:37 +0100 (CET)
Date: Thu, 5 Dec 2024 12:28:37 +0100
From: Pavel Machek <pavel@denx.de>
To: Daniel Wagner <wagi@monom.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	stable-rt@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Clark Williams <williams@redhat.com>
Subject: Re: [PATCH RT 0/1] Linux v4.19.324-rt139-rc1
Message-ID: <Z1GOZVPb3Gzz30zh@duo.ucw.cz>
References: <20241124190222.112239-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gus0nIABdJ4LkyaY"
Content-Disposition: inline
In-Reply-To: <20241124190222.112239-1-wagi@monom.org>


--gus0nIABdJ4LkyaY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the RT stable review cycle of patch 4.19.324-rt139-rc1.
>=20
> Please scream at me if I messed something up. Please test the patches
> too.

4.19.324-rt139 would be very useful for our -cip-rt release, can we
hope to get it soon? :-).

We can also help, if required.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--gus0nIABdJ4LkyaY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ1GOZQAKCRAw5/Bqldv6
8uAEAJ9ICGjrx3Io6PHMscGb3JZGVBpaXwCcDGXyvQUpZnurblH0ND8Wte40U4I=
=bMIj
-----END PGP SIGNATURE-----

--gus0nIABdJ4LkyaY--
