Received: from mail.sleepmap.de (sleepmap.de [85.10.206.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99B23C1413
	for <linux-rt-users@vger.kernel.org>; Tue, 21 Jul 2026 09:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.206.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784625022; cv=none; b=osUCvU6+N1UP6hRU4f1usoHZT/FffGipL5oG+S3BnfTPcLqj5lQcgfJaYkJWaQiBA5UJGaFtZukj3FFDbg9AkUUe3DrE5CIuQPNvb91P3eekDyMZa3IihFH4od6ZniPQ9Z8rzPZAL2rdgbo37/sLn66JY8EgAVRAFQafmGkedsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784625022; c=relaxed/simple;
	bh=CwgGn4yaBSyqygZmlddmFoNL/Og8hqgBtU5S37gcenw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+HrQc7AZLSGuRM+wqB2H0C4l8d0y+4V7M7UqPRWXys7FggHZ6841SUSsV4lTs8DP4vhMb60uH9rcMLmXg1f1aGV80NGWa2fLkIbvD+voMmh28KlasScjLFWayAd1s5t9FGBKusyeHKkcSQRZFbHAGeL3fLW8JOrPjF6VuILxKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sleepmap.de; spf=pass smtp.mailfrom=sleepmap.de; dkim=pass (1024-bit key) header.d=sleepmap.de header.i=@sleepmap.de header.b=LZRZYyiw; arc=none smtp.client-ip=85.10.206.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sleepmap.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sleepmap.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sleepmap.de header.i=@sleepmap.de header.b="LZRZYyiw"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=sleepmap.de;
	s=RzV2MS86Cdvz; t=1784625012;
	bh=CwgGn4yaBSyqygZmlddmFoNL/Og8hqgBtU5S37gcenw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LZRZYyiwRJ5ce39RkTWZ5wlzr/Zy/XTgIs+sJzmV2w8PaJXnDi5zGoN42fLuPTr0Z
	 1LaSP6TpXRnujIhGP/M89JJaLNKPF9qGG73TnmCuk8HQrViCWb4Loo3D1x1NOPcxoP
	 5kotnuM6isMR89mpQSXSsDGk6UDZ471uhXIkKyWQ=
Date: Tue, 21 Jul 2026 11:10:02 +0200
From: David Runge <dave@sleepmap.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-users@vger.kernel.org
Subject: Re: Issues building RT patchset v6.18.13-rt4-rebase on top of
 v6.18.39
Message-ID: <al83asltX9snvqq1@hmbx>
References: <al3YymTiIicX2Vin@hmbx>
 <20260720125805.wN3NFiBj@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QubuJ83SEyMb2IxQ"
Content-Disposition: inline
In-Reply-To: <20260720125805.wN3NFiBj@linutronix.de>

--QubuJ83SEyMb2IxQ
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 11:10:02 +0200
From: David Runge <dave@sleepmap.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-users@vger.kernel.org
Subject: Re: Issues building RT patchset v6.18.13-rt4-rebase on top of
 v6.18.39

On 2026-07-20 14:58:05 (+0200), Sebastian Andrzej Siewior wrote:
> It is there
>    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/=
log/?h=3Dlinux-6.18.y-rt
>    https://www.kernel.org/pub/linux/kernel/projects/rt/6.18/patches-6.18.=
37-rt6.tar.xz
>=20
> the problem is probably that it is not in the stable tree=E2=80=A6

Hi Sebastian,

thanks for pointing me to the custom source tarballs and the relevant data =
in
the linux-rt-devel repository.

To understand this better: Is the 6.18 release series (and future release s=
eries
=66rom then on) going to be developed in the linux-rt-devel repository, not=
 the
linux-stable-rt repository?
As downstream package maintainer I am currently relying on the relevant git=
 tags
to be available.

The linux-rt-devel repository seems to cover all new versions, but
linux-stable-rt appears to lack behind the upstream advertised LTS release
series.

In general, I would very much welcome a single repository, instead of the
current situation with two repositories, in case that is feasible for you.
Is there policy around when a specific release series is used in which
repository?

Best,
David

--QubuJ83SEyMb2IxQ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQR8efy7g3Ll3lsX4JqQ1LlkHgkpcQUCal83agAKCRCQ1LlkHgkp
ca+4AQCPkHVxJnwRPth+QJ0SSfuV+PTSkHSQdxv+/J7MJPOdRQD8CBlFPCl6aK9d
H73SF5+PZsFtCPN3KZ4cQK/z/F5LygI=
=YWlb
-----END PGP SIGNATURE-----

--QubuJ83SEyMb2IxQ--
