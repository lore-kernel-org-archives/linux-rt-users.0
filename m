Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAB823A562;
	Fri,  2 May 2025 10:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746181167; cv=none; b=irWUtuM/5KdLykq1UzkV1Cw9ltGDhFl2bMvurZ4NtTUzlVF2AvCr7bs4XGQhZaesUvXTaNKDbxLNduCSYsO+QQsUcnDonL5cccpZVxXNcXUA97+z5kGX6R9H023J9fKFLi3K7g5LMJ0u8wzufc4mcFUmUIQfyIe2VTinlfAG1x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746181167; c=relaxed/simple;
	bh=V/aX7grjyAbnUBNF8gEJ3pf29B1wtQkLIJ8GWeo81oA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1kj3OWFb7NNzZMBnXH5ZaY1S5fVT+fuY2aObw8VMRIhdMbs9pC3mtCeEvDR0bmxIlqxyf1CimLKfCqPKVmw8WWZUZnWeRjZDJ1YSKR5G+r79jMWOQcaKr1Okt1WE9DlZcBnAm1kzPoIrwVhtEJ2DxgKj1KxSucJ6xha4n/p0CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=DIqVbSUj; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="DIqVbSUj"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7678910267FBE;
	Fri,  2 May 2025 12:19:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1746181162; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=OqNM1WJXeRbDYTb+XCGZDpJOZ5winGgziTp4vKwJsdU=;
	b=DIqVbSUjPvdqVnGTHoWmtUzZozPYBMGgUVS9/eEiESke1uRAIffFioceetMJ1pNuzCUc6F
	9aKnG6Was5aLEMf+E/4gD0zn7Pe56k5xwTlwSL5ZPet4GRUCGlQAAeV6JbvBTcnposxq6J
	NgNac+j5Q3Ms9iYjfW/lDOQzeAZykAftgnz+iMwUDXrVwnrwjdoQ3y/6EUd51WoPqyNU5t
	ySzATta8dg8r9J0x75MLQyFSffKquDifMJG/25yCVeDhNnobtpUieydvzBsQEIWDDrqXN/
	8MiurPuyHoqUrd6oiHs+mKXBvcbVzUIjxnsSzMK7axB/5NFr/09DdB9d8YU5NQ==
Date: Fri, 2 May 2025 12:19:15 +0200
From: Pavel Machek <pavel@denx.de>
To: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	cip-dev@lists.cip-project.org, bigeasy@linutronix.de,
	tglx@linutronix.de, rostedt@goodmis.org,
	linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 4.4 4.9 v1 0/2] Fix repeated WARNING in
 unpin_current_cpu()
Message-ID: <aBScIx13vT5c1i8V@duo.ucw.cz>
References: <1738629964-11977-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RB7aPg18wey2WPOX"
Content-Disposition: inline
In-Reply-To: <1738629964-11977-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
X-Last-TLS-Session-Version: TLSv1.3


--RB7aPg18wey2WPOX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is a patch series for v4.4-rt and v4.9-rt to resolve problem that
> WARNING in unpin_current_cpu() happens repeatedly while kernel is booting.
> Please see commit message of the second patch (2/2) for more details about
> the problem and how it's resolved. The first patch (1/2) is a preparation
> for the fix (2/2), considering compatibility issue in future updates.
>=20
> As the both v4.4-rt and v4.9-rt have been EOL already, it's not expected
> that this series is applied to the branches anymore.
> On the other hand, the Civil Infrastructure Platform Project (CIP)
> has been maintaining its 4.4 SLTS RT kernel[1][2] based on v4.4-rt,
> and needs to fix the problem above by this series.
>=20
> It is much appreciated if RT experts could take a look at the series
> and give feedbacks about its way to resolve the problem, which is
> based on the same approach as changes happend around v4.14-rt.

Thanks for patches, and sorry for the delays. 4.4.302-cip98-rt55 is
out, and it should contain your fixes.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--RB7aPg18wey2WPOX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaBScIwAKCRAw5/Bqldv6
8r6uAJ0Wfp1mrQfZbs5JoLLK1Gy932Kv/ACeN4n7KoD7fon814lWlDROkejw4Do=
=szFd
-----END PGP SIGNATURE-----

--RB7aPg18wey2WPOX--
