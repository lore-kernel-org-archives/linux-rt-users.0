Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF3A155359;
	Wed, 18 Dec 2024 19:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734550062; cv=none; b=I+xWuXdTumNMhsObjSz9zRpcWfQHYUrMW6K3usrSjClOF7KqwATuQJ6o4Nhe+pvQPP1YCZnretkAp6AIsTdttWRWleFX2QGy325aZYW1nbOExm0i1nmdDNIpDScYDe6vWAs/OQtF05QXYSvYryOWmvMMSL+/ldeGhpu7tst0cVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734550062; c=relaxed/simple;
	bh=KhECKM0samNlWrQIOwYOZO6uiKr/dROPi7J2XHKPe30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNDkYMhhnlg90MSGrj3xkfYO+Pk13ua1+mZ734mSliSQjwboWSb2lBXi/sl082lk0ZBossr0fPdJah2FWYt2tQY1LQBytp9UXmLRG/Gbwf3y2B8x1jQkC3RDZyHqoiTEUrpj9Nwmlb+1oeMzvEdFYXhpIj3l/IJ5cjJ+BqT5rBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=L0ASOdkU; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="L0ASOdkU"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D8FD31048AF7E;
	Wed, 18 Dec 2024 20:27:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1734550057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1cb1B+a6cAYhNf22hk4INTJ+JJHIcWBYrdspPdtcKRI=;
	b=L0ASOdkUwaU6pvfDndwcFkZdoZ+t5TOEkBhvHQjYBLYIF7zaafZh9KoUZJ9lh0ZAWeXXny
	PKzR+fILZU99iszOTgwhkZ3vRkiSEx+5niPBBzHLcki3U4XwSf1xM24HHysx77MeDNXK5p
	262Mx3zmRGIp6smvfk4RzGK1tzV+NIrjyRQEF/AvnD8iHNbUNOEl/k7qjXIR6rrrDwRxjq
	c/0G4YVJaVFF7CFJ3DEtRJlP8v2V8wLkRphihHABbRD/nYNjcEIXnQkYdrUIPhcVri6Dxk
	JZD6/O23ReTppc3w27r8fz7T3NHszVENR521rYMj1ZnGrGUlHTR9SpkQtVOkuA==
Date: Wed, 18 Dec 2024 20:27:32 +0100
From: Pavel Machek <pavel@denx.de>
To: Daniel Wagner <wagi@monom.org>
Cc: Pavel Machek <pavel@denx.de>, LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users@vger.kernel.org, stable-rt@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Clark Williams <williams@redhat.com>
Subject: Re: [PATCH RT 0/1] Linux v4.19.324-rt139-rc1
Message-ID: <Z2MiJAL3xvnrqgGX@duo.ucw.cz>
References: <20241124190222.112239-1-wagi@monom.org>
 <Z1GOZVPb3Gzz30zh@duo.ucw.cz>
 <36387dd6-d21b-49f0-bdcb-0a36e7f49c3c@monom.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xjvExj2uKCFiAdKq"
Content-Disposition: inline
In-Reply-To: <36387dd6-d21b-49f0-bdcb-0a36e7f49c3c@monom.org>
X-Last-TLS-Session-Version: TLSv1.3


--xjvExj2uKCFiAdKq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > This is the RT stable review cycle of patch 4.19.324-rt139-rc1.
> > >=20
> > > Please scream at me if I messed something up. Please test the patches
> > > too.
> >=20
> > 4.19.324-rt139 would be very useful for our -cip-rt release, can we
> > hope to get it soon? :-).
>=20
> Ah sorry, didn't see your email in time.

No problem.

> > We can also help, if required.
>=20
> BTW, I understand CIP will take over v4.19-rt after the last release whic=
h I
> queued up last week. I am supposed to release in on Thursday.

Yes, we'll be maintaining that for few more years.

Best regards,							Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--xjvExj2uKCFiAdKq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ2MiJAAKCRAw5/Bqldv6
8sTSAJ4y+YSK+yLroRyxYZMk8Fa4UXU7hQCeNMZFXf5vj7PwN9dXI4r7hQVLbzU=
=hul3
-----END PGP SIGNATURE-----

--xjvExj2uKCFiAdKq--
