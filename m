Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61A71FDE0E;
	Fri, 17 Jan 2025 11:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737112419; cv=none; b=tWMmieJqR8OcFjmtdqHHYdZj52wanbZhTvoyqoIyZsdyNd1iGzxIIY5ufrFbiHZ0v/N9eJ01PO6JXzG993T8ur387pTvp4zXdP7emyyWQrQ2wDXWGCrU5e7nPw7WI86VSm0T3HHJ4r3R+dERXPC4nCahUl29azfCfkPfQRGdVFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737112419; c=relaxed/simple;
	bh=vmTPRlHUWsglSavttEgPzVV8SwQc+OkNe+fJpJV5Jzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=in1+Kx4azpoWmv/dDablU61YdrGrQUhfkFYDeSsbxhK0EyiB1lId4zmPUW7gzY/vrirz09r6e72AueXOhQp/HxrSQIwC00YMOv52pNzdvguRlVDFTVNOJziepkkOTogFCGC75oaxdciqywvqfjElOZIHcs/2vDsf8dju7QPuuSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=gNioikie; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="gNioikie"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E0F451047DC3B;
	Fri, 17 Jan 2025 12:13:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1737112408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kaMd5uZxpLK37ZyGeUkfviUI3jHmmz8gmyV71snLwWs=;
	b=gNioikieXNgk+Cd0vJWdHRmlLu1JVDLVtnNZ/ypAhE2qDwvTxahEBo8FP39hkHj3VJ+HJv
	oO1Tsr/D2B0GYE8wiuHsaf2dax/uLz5g/+k4NqMXyaAhSVXwtIKMTY097fEULB+azvqVfU
	cAI27LfNbIAsN9CwU7XeHJjlflO/PkLcJJTph0Qd/UQuEuZMOpWKRBN+7eUF6eA1UwhPzw
	zylPbWzh7NAvhTdYmenZUpLWX683YNHEGRGOOmYd7R3ytyDtAtr8ZE1LJedeQKaNyM/0vz
	ou02bM3znsOsKQAHKiRcZjd8KOuDoyJZMEDfJN85hI9KpiCEah2Vd9t7stWhAw==
Date: Fri, 17 Jan 2025 12:13:22 +0100
From: Pavel Machek <pavel@denx.de>
To: Clark Williams <williams@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Wagner <daniel.wagner@suse.com>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Pavel Machek <pavel@denx.de>,
	Joseph Salisbury <joseph.salisbury@oracle.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: Re: [ANNOUNCE] 6.1.120-rt46
Message-ID: <Z4o7Usi2t3LFKwXC@duo.ucw.cz>
References: <173446426761.810839.10241405280484476684@demetrius>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bvwe3v5G1Wdg8JF3"
Content-Disposition: inline
In-Reply-To: <173446426761.810839.10241405280484476684@demetrius>
X-Last-TLS-Session-Version: TLSv1.3


--Bvwe3v5G1Wdg8JF3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!
>=20
> I'm pleased to announce the 6.1.120-rt46 stable release.
>=20
> You can get this release via the git tree at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
>=20
>   branch: v6.1-rt
>   Head SHA1: 061eae4897c2fee62fed3f946864107faf3292b7
>=20
> Or to build 6.1.120-rt46 directly, the following patches should be applie=
d:
>=20
>   https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz
>=20
>   https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.1.120.xz
>=20
>   https://www.kernel.org/pub/linux/kernel/projects/rt/6.1/patch-6.1.120-r=
t46.patch.xz

Are there any plans for 6.1.124-based -rt? It would be useful for me
in context of -rt project.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Bvwe3v5G1Wdg8JF3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ4o7UgAKCRAw5/Bqldv6
8jLEAJ44SxWljd4/sq/Jd1E8JU6IZ17EoACeKBqUgIa+r9MbaMYIhUHgCIZMGqA=
=Gcj2
-----END PGP SIGNATURE-----

--Bvwe3v5G1Wdg8JF3--
