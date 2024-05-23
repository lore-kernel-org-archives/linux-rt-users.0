Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C62813CFA2;
	Thu, 23 May 2024 09:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716456430; cv=none; b=bSkQo3qGuHicrzQlkrVlZEbav5ge8eBKAoh+5RaSwuTCLTooy7yFfFahIeLFFTgXMPzDNJ0pWu6ERPjKYNAN9bhaMYNHvhNTLS2Un8ibOr8xBnbBaj1erAk6QPRKI6WyiuFBNOr/rcDmYBfouNEc36Mp9c7nmqHHKmWV5UfCBt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716456430; c=relaxed/simple;
	bh=Jk2s0XLPuHA3YyAidzLdf7ogEZoebdsJWq5du8Mqp2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HyojxfqlLpbRV7/QHdsNlgIzGMmbVqvlCpwmrYqDVmxHYMdA5PePCA7eueh7GJh6Sw+8beo8umU61rLRrXoYy+Y8CcJEjngUW1UxcpqsH+QV2irIftY9RMU5AhBDGSsfUBzSCdP41TtKWej1HF+DC+D7Z1DFu7Kxq0kcxpeOWek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 0FBB71C0081; Thu, 23 May 2024 11:26:59 +0200 (CEST)
Date: Thu, 23 May 2024 11:26:58 +0200
From: Pavel Machek <pavel@denx.de>
To: Daniel Wagner <wagi@monom.org>
Cc: Pavel Machek <pavel@denx.de>, LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Clark Williams <williams@redhat.com>
Subject: Re: 4.19-rt in May? Re: [ANNOUNCE] 4.19.269-rt119
Message-ID: <Zk8L4jU3n7pAVR6+@duo.ucw.cz>
References: <167144069993.3503.13484547425689613996@beryllium.lan>
 <ZjSoeyEnkJPY7ST3@duo.ucw.cz>
 <ahybli5jks4jfco7kiuotvukseqvg4vxxnlw522vs22cn5w7ok@qm5nmcskbh3j>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FlkwNOZsC275/c1z"
Content-Disposition: inline
In-Reply-To: <ahybli5jks4jfco7kiuotvukseqvg4vxxnlw522vs22cn5w7ok@qm5nmcskbh3j>


--FlkwNOZsC275/c1z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > I'd like to do 4.19-cip-rt release "soon". Is there chance to get
> > updated -rt tree? Last I see is:
>=20
> Sorry, got interrupted and didn't finish the last release. I've to fixup
> the rebase branch before the next release. I'll see what I can do next we=
ek.

Thank you, I see the release in -git now, and am preparing -cip-rt
based on that.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--FlkwNOZsC275/c1z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZk8L4gAKCRAw5/Bqldv6
8qZUAJ9VeyLA/MN6mbx7NylV6MV12/A0sQCfbra0XK3PQecor5Qi4JMDPqLidGs=
=dlV3
-----END PGP SIGNATURE-----

--FlkwNOZsC275/c1z--
