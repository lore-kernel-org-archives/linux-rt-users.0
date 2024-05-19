Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2E873163
	for <linux-rt-users@vger.kernel.org>; Sun, 19 May 2024 22:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716157741; cv=none; b=PeNyPqxDsmJZRmIPFpPkfuCkaRn8Tc1L1lKz8uUNzLLzaeZjAUkhIe5inwbIbwvHHQEPESjiQe3aIu61FHtNqfTceRMLo+I7ZSNxEZD3odhtKfe5qGk95LrsvR9nGQ8DKr1UXKRkugVr1AO68MPDh93B2vVNlY/Jfzofl2kCBbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716157741; c=relaxed/simple;
	bh=lTfLym4W4Ayf1mnU8fJ8gnQ1nII4kxA5BCjktuXBz+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=okv2ikO4rEBobgN7H/jN68p1+liknTzmMzNrHRAy9R0z6VIT7a/70xEZYKhpgxASHTVZvhd5bJV9L/QarUzkOho1FT3hhlgHZuxuFWZl5OUAmnTCikfkIixuKsZhlpWDm/jCyWKTdgjFQCeh12m0kag/Yw47ElWfJbzksUPCXN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=XzvGZyhh; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="XzvGZyhh"
X-Envelope-To: linux-rt-users@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1716157735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DWfHTJMo3tauTNkkGSoccqUIZEHQ8fMJM6+GOmwkYT8=;
	b=XzvGZyhhrJBA5MA9VYpQiUqR/6aKfQRep28nRlYTxlDF6gnhbn+i12brzUSJrLFK7jJZBS
	sm6NsvT9xb+iitKxBNkc4gJj4zoQqQ9ttiaxc+qwpmGekf+jahmOo32TFU//kXXjPmtUAS
	HZg6T4oG9tNqcSgGry1Cdm4BY1SIB2Ku8gMnevNnok15sHSgv2YdZlIdOIMjqga1GN5Kkw
	z9e4nOJ0QkTcNZ2y+FqLzQMmaquQMNMUzvlehUM6b3gxWohrbQL/CmtNeO2B09vQDufUW7
	AbVthqdbFOcn4WNwTj2aS5J/Bd6sSs2t/+hOAPPqhsmZpf9YQPseeODPIU/s8w==
X-Envelope-To: didi.debian@cknow.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Diederik de Haas <didi.debian@cknow.org>
To: linux-rt-users@vger.kernel.org
Cc: didi.debian@cknow.org
Subject: Re: Build failure with 6.9-rt5 on arm64;
 works on amd64 and 6.9-rc6 on arm64
Date: Mon, 20 May 2024 00:28:43 +0200
Message-ID: <5880304.cvb1nHMhLa@bagend>
Organization: Connecting Knowledge
In-Reply-To: <131999629.KQPSlr0Zke@bagend>
References: <131999629.KQPSlr0Zke@bagend>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2545507.DIRTduETlc";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Migadu-Flow: FLOW_OUT

--nextPart2545507.DIRTduETlc
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Diederik de Haas <didi.debian@cknow.org>
To: linux-rt-users@vger.kernel.org
Cc: didi.debian@cknow.org
Date: Mon, 20 May 2024 00:28:43 +0200
Message-ID: <5880304.cvb1nHMhLa@bagend>
Organization: Connecting Knowledge
In-Reply-To: <131999629.KQPSlr0Zke@bagend>
References: <131999629.KQPSlr0Zke@bagend>
MIME-Version: 1.0

On Friday, 17 May 2024 15:08:36 CEST Diederik de Haas wrote:
> In file included from
> /home/diederik/dev/debian/salsa/kernel-team/linux/debian/build/source_rt/=
in
> clude/linux/rwsem.h:15, from
> /home/diederik/dev/debian/salsa/kernel-team/linux/debian/build/source_rt/=
in
> clude/linux/notifier.h:15, from
> /home/diederik/dev/debian/salsa/kernel-team/linux/debian/build/source_rt/=
in
> clude/linux/clk.h:14, from
> /home/diederik/dev/debian/salsa/kernel-team/linux/debian/build/source_rt/=
dr
> ivers/pinctrl/renesas/pinctrl-rzg2l.c:10:
> /home/diederik/dev/debian/salsa/kernel-team/linux/debian/build/source_rt/=
dr
> ivers/pinctrl/renesas/pinctrl-rzg2l.c: In function =E2=80=98rzg2l_gpio_ir=
q_restore=E2=80=99:
> /home/diederik/dev/debian/salsa/kernel-team/linux/debian/build/source_rt/=
dr
> ivers/pinctrl/renesas/pinctrl-rzg2l.c:2072:52: error: =E2=80=98spinlock_t=
=E2=80=99 {aka
> =E2=80=98struct spinlock=E2=80=99} has no member named =E2=80=98rlock=E2=
=80=99; did you mean =E2=80=98lock=E2=80=99? 2072 |
>                 raw_spin_lock_irqsave(&pctrl->lock.rlock, flags);
>       |                                                    ^~~~~
>=20
> /home/diederik/dev/debian/salsa/kernel-team/linux/debian/build/source_rt/=
inc
> lude/linux/spinlock.h:244:48: note: in definition of macro
> =E2=80=98raw_spin_lock_irqsave=E2=80=99 244 |                 flags =3D
> _raw_spin_lock_irqsave(lock);   \
>=20
>       |                                                ^~~~
>=20
> /home/diederik/dev/debian/salsa/kernel-team/linux/debian/build/source_rt/=
dri
> vers/pinctrl/renesas/pinctrl-rzg2l.c:2076:57: error: =E2=80=98spinlock_t=
=E2=80=99 {aka
> =E2=80=98struct spinlock=E2=80=99} has no member named =E2=80=98rlock=E2=
=80=99; did you mean =E2=80=98lock=E2=80=99? 2076 |
>                 raw_spin_unlock_irqrestore(&pctrl->lock.rlock, flags);
>       |                                                         ^~~~~
>=20
> /home/diederik/dev/debian/salsa/kernel-team/linux/debian/build/source_rt/=
inc
> lude/linux/spinlock.h:282:45: note: in definition of macro
> =E2=80=98raw_spin_unlock_irqrestore=E2=80=99 282 |               =20
> _raw_spin_unlock_irqrestore(lock, flags);       \
>       |                                             ^~~~
>=20
> make[8]: ***
> [/home/diederik/dev/debian/salsa/kernel-team/linux/debian/build/source_rt=
/s
> cripts/Makefile.build:249: drivers/pinctrl/renesas/pinctrl-rzg2l.o] Error=
 1

https://salsa.debian.org/kernel-team/linux/-/merge_requests/1081#note_492742
pointed me to the following 2 commits which got added in 6.9-rc7:

https://git.kernel.org/linus/aa43c15a790cf083a6e6a7c531cffd27a5e1fd4f
https://git.kernel.org/linus/02cd2d3be1c31a3fd328ee83e576340d34bc57d9

I'm inclined to think those are very relevant, but I don't know enough
about this material to be sure.

Cheers,
  Diederik
--nextPart2545507.DIRTduETlc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZkp9GwAKCRDXblvOeH7b
bmPrAP9B7bGJvx06H1EbB0GQeUmtdsWh+CBA2L5uRaXX7JBmWQD+LRUx8sGW9Nmu
7o69Hn9TEplRAyv9MdLdJO83c1HW5w4=
=qb+f
-----END PGP SIGNATURE-----

--nextPart2545507.DIRTduETlc--



