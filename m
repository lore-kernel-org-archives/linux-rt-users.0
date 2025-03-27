Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8EF1482E7;
	Thu, 27 Mar 2025 09:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743068560; cv=none; b=garC+I179itrLiqk8LC/H0X5tSdY3H/U1/BiHA/DNukZY0UNkz4WiDRXBeAkbVgTo2ZubTU6MCd5jTkYhs0h+Cdp7UKuJqEyh0GcExHkRixY/pc4eKf9zPdv3PWAxi9BwIgE+tgKz2O3c/Y7culFSHIoT69GxnUd8tfkAsMtua4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743068560; c=relaxed/simple;
	bh=KUvjtgFESozOCVhk6gc946bOYRryku7PZ7BF3vqTv3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mv7MXABoJzZkVbTOMmwQIekgcQOjnMdl8q/fZwQ09iCJ6MUs18Ne3RhUl24kepScAE7JHiilUodVB5dyf0M071IPJ0/Ot7VoqwXnX9cIzv3Ot62xFhcsAFfHu/QirNe84H/MC3pCt1hkXj7iXED16nusfeSB1qzxJGi7ht7tJSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=DuwZxVMe; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="DuwZxVMe"
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 652F41C00EF; Thu, 27 Mar 2025 10:42:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1743068548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TgWAlIrkZR4hJ4WarQEwsPmAzFkrsZtxh5149Xr1POc=;
	b=DuwZxVMe0RF6jW91bf43uKoDiO4x4mK1xiEUGi7xFG3tzRfjBCfzTZnHwD8nJyTK9ofh+w
	jIoiH9kwmP5Ak1B1Lx8GqCvKFEBsRztZ4VluDXUiE4cLWzAr5XPo5YVOy3QulagcSmbs7n
	vNNTwtkBiTm5/C/QYZz4UnoGBGYxX6k=
Date: Thu, 27 Mar 2025 10:42:27 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Clark Williams <williams@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Wagner <daniel.wagner@suse.com>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Joseph Salisbury <joseph.salisbury@oracle.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: Re: [ANNOUNCE] 6.1.128-rt49
Message-ID: <Z+Udg9qlQL2Z/aZX@duo.ucw.cz>
References: <173930775249.796803.15441220010102177762@demetrius>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gWEQOM0S4GcZQLoH"
Content-Disposition: inline
In-Reply-To: <173930775249.796803.15441220010102177762@demetrius>


--gWEQOM0S4GcZQLoH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I'm pleased to announce the 6.1.128-rt49 stable release.
>=20
> You can get this release via the git tree at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
>=20
>   branch: v6.1-rt
>   Head SHA1: 7faf422b9217de411f016245ab3f2f5e03c9899c

CIP project would like to do 6.1-cip-rt release approximately once a
month. Is there chance to get 6.1-rt "soon"?

Is there some kind of schedule for 6.1-rt? IOW should I try to adjust
6.1-cip-rt releases to once a two months?

Best regards,
								Pavel
--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, and Musk!

--gWEQOM0S4GcZQLoH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ+UdgwAKCRAw5/Bqldv6
8t/PAKCgiJV/mcCCdzZubU54sYe3SDTcsQCeKx94B7ikV5/1PjC0+nSwSux9wNs=
=Cw2g
-----END PGP SIGNATURE-----

--gWEQOM0S4GcZQLoH--
