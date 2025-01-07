Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B994B1E9B15
	for <linux-rt-users@vger.kernel.org>; Tue,  7 Jan 2025 09:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736242907; cv=none; b=nnK2KYHpqwe2wd5aULw1tTwLppJ9/WfxFAVjWbgpRhxVsJ/12NPr7A5x/LEdMoZ3+MNwwlIlhM0hRn+U3i6tlaG+OkIAiGhBzWgMYzQkfHABeyjfLaMAbiqlRPQffVMxbKOh968mnFyO5b8LsiUNrEKbKUfuCoRtMLwb4y4s4kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736242907; c=relaxed/simple;
	bh=XivbYUdJm4Wj9gDCkEu9esleTbuB0idHkALvrA5xONc=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M/H8KtxmlHPTmm/+sTDal5ppTWhbIhrRdl+ZLFR5FfUMZBMn4/BElbBLHGmQguHxBYyZZmYAKBO/KxpRYdrCRG2eA+Tfn9T4+oacc4WxDXF9Fs/AOqnQ04XBP5U5j5V5SFJFFtyuFVag3sktHGyYJHQcZywpQzXa0rdvoy+wR/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IeMczBq4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VISVHSWT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IeMczBq4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VISVHSWT"
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736242898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XivbYUdJm4Wj9gDCkEu9esleTbuB0idHkALvrA5xONc=;
	b=IeMczBq4aZAgWbQgOG025Ve1IDtXjzUf6ap9DQMNa6kYD+McPErSwJURi5Guu4dvYIQ/BV
	xLyMxi9ca3ShxvSxv7tojSDg17uRulRe/8r2kzC3RHErPPn+1PLXYPsq+wJF17tZ6Lq7a3
	6K84plVgVcSaDL68A03879a+JsKltnW6p2XyACW+PLUtq8Fi2Ea6PmG6JqId+3pkdp5nLW
	DkGzZCC3AZegNKNlJOciguczQtwDzpssilpyF6OWCL+F1ZxZ7UgsmNDiszH6wk9TeYoE+Y
	jf4SRY9PUV+OzZsKLfnVkh5cJ7BzbuFm60aOSgXzw5Zz/5/KeDXmsUD5Io2mIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736242898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XivbYUdJm4Wj9gDCkEu9esleTbuB0idHkALvrA5xONc=;
	b=VISVHSWTgis9Jk8TBVeuFOqkoUP5mPcGURvL6PhbqIFIH3rqW2zCXeEG4/yWP4UlB8YYNT
	tb7OzyKbewDiD3Dw==
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-rt-users@vger.kernel.org
Subject: Re: rt-tests release tarball location
In-Reply-To: <20241228114346.6020d6b0@windsurf>
References: <20241228114346.6020d6b0@windsurf>
Date: Tue, 07 Jan 2025 10:41:37 +0100
Message-ID: <87h66b2c6m.fsf@kurt.kurt.home>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

On Sat Dec 28 2024, Thomas Petazzoni wrote:
> Hello,
>
> I am one of the co-maintainers of Buildroot, an embedded Linux build
> system. Among many other packages, we obviously have rt-tests as one of
> our packages. When rt-tests is built, we download it from kernel.org.
> Unfortunately, the rt-tests tarballs are moved around: the latest
> release is available at https://www.kernel.org/pub/linux/utils/rt-tests/,
> but as soon as another newer release is available, the older release
> tarballs get moved to
> https://www.kernel.org/pub/linux/utils/rt-tests/older/.
>
> This breaks the build for build systems such as Buildroot, that expect
> a release tarball to stay at a given location, and not being moved
> around.
>
> Would it possible to keep the tarballs at the same location? Either by
> not having the older/ folder entirely, or by populating it immediately
> with the latest release, so that all releases are always available from
> the older/ folder?

+1

For Gentoo I had to add both URLs to SRC_URI in the ebuilds. It first
tries rt-tests/ and then rt-tests/older/ location, which is also not
ideal.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmd89tETHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgjQED/9r9OWMyd44XAsBh9h74ku+3gDfE5pm
ykzvPBkC7H6LvV8eJ6mXsdwePUHiPJr3soYfjBw5pZTndCkqI8YT0Zgn4bd9UNwr
MDeM4RRAK2xivBOgjuTxuCMietP5mnzdulSXVaCUAWY9gTWrHQWIDFOtSzCOvCwW
cQu1UvAVt9fhCcROcYTflFvMs9gZbNnHAtyLPBdtcdt/+Ad2dDiTO5mSpjpk+RSD
0uuspfplm9YMZrJujU2aSnfgWkyE9W6XT3Qgi1GQoKlmWG/ggqjWfaWTcqTMoBfh
5DizxnkM0DqEfwWS77F38iZLMnypWq/OTOMcBmdSuVD7hxaA5v+y47QW52OGIj0W
8WLNIRcGkl2jPr4x3IzBottS7IcvWEm+FyDDanh3iHQHYRM9t1gBwYb94jXOwSjh
Krq8EvKvyhBR01XCt9z4SQP8wDO97AzsmnjemDD2npNQeLbdpxaR4Wcsya6DZ4gq
ErCu289I85IM2cbNEaJ5yNmK+d8+aAin2k4y6k/31/emGfWLR2qQIjsdv9V77b1R
J5V6FCTrOjg+nD4mLmMtTryiDxBQCzAYp8FclcmlSHWKXuvbWDE4gJWZqXHaQUBP
zdyRw8vWDaqXqh4vI93ZG3+JbmE4OpyzuTlQM+mixDP5GBD1pLUwvFdMHm2FKYDN
a58Dz8gffnUogg==
=PH5X
-----END PGP SIGNATURE-----
--=-=-=--
