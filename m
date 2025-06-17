Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E75269CF0;
	Tue, 17 Jun 2025 13:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750167309; cv=none; b=sBtqWVNGxvy8r38zIWKgWGBtwk9KEU49WdK1dPtOs3LWApSAVMiFDEyWSqb5OSnu+nDXaQlMFcWZaJ6KEl4uFtzbXuEr4txM/AyOTEU3fNX9SOTii3/6IGG7FIQEwOOETK/YOSS+ejD+wsgl8RKWCvvKF7xm5++No5RDPG6tE/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750167309; c=relaxed/simple;
	bh=4GnMChYZ859nCJCN1piCqEZeHco0KjO/v6zHU+fvsTk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CzNoArlNz1EhZfgTkiPV9H90S1VJ1Y9rKFZY+DofM/QbUoRw+X28HVz+svA/fQl51FOt8i3kw1zBMuuK71GxXyrHoywTL6HGQQaE5DDxIvyF13UXxjfSrbDrsCkqk+/r+2uAGZSKOIUILMGhlPBFMEDfxGk3WVfHFn6RtX+DeI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mwWc+jtO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7JpNvPqt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mwWc+jtO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7JpNvPqt"
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750167305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4GnMChYZ859nCJCN1piCqEZeHco0KjO/v6zHU+fvsTk=;
	b=mwWc+jtO0EL+s3NZP9Z52AznBBTIoMuNIF5GhIJMZE7V2sJx749KMcKZvdfB4wP43lVDq8
	84v97VmC2EGwHxXg2Cy6vBADl+pMim9SaHH3j5mMlmGm/iCFjz486pBtLsqT9HR+nBjze5
	4DQIjVMyEkymXmo1Nu4AnUGGDGXVLImdVF3LkFFhZnWoZl1W/Iez5ofVrAJfvwN65dx0oI
	R6ZRfMB1iD6JjYxE0wXKrh8JaRqguoRZaXXMA9aHBnfgNznRoWsvlJZ+bZ037t70hva16K
	ip3VaPaZG30rLR1BfwOfLAZLJQZRIw+NPmAxokU6+9lslAVVPV7nVmeymoZlfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750167305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4GnMChYZ859nCJCN1piCqEZeHco0KjO/v6zHU+fvsTk=;
	b=7JpNvPqtL1cK8IuFdiKGRKLO2h+WW24bZEhSFTssxtq2UTYXNUnx89ED7pBHeUaqTbsE/+
	L/HBD5y6pJ7Ht+CA==
To: Marc =?utf-8?Q?Str=C3=A4mke?= <marc.straemke@eltropuls.de>, Sebastian
 Andrzej Siewior
 <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: Latency spikes on V6.15.1 Preempt RT and maybe related to
 intel? IGB
In-Reply-To: <19a46896-3d26-415b-9820-730a42b0702e@eltropuls.de>
References: <20250613145434.T2x2ML8_@linutronix.de>
 <E1uQ6I0-000000003aa-37uJ@smtprelay05.ispgateway.de>
 <20250613195838.0-gZ6bqS@linutronix.de>
 <97638b0b-cd96-40e2-9dc2-5e6f767b90a4@eltropuls.de>
 <20250617092814.vqKdu23w@linutronix.de>
 <bb74b5b6-bc23-4aa4-83df-449dc7c9006b@eltropuls.de>
 <20250617100013.1o5lsPLq@linutronix.de>
 <b7179ac8-c64b-44dd-b25a-62b34eb49c24@eltropuls.de>
 <20250617101507.jU00mupE@linutronix.de> <87v7ou7i4i.fsf@jax.kurt.home>
 <19a46896-3d26-415b-9820-730a42b0702e@eltropuls.de>
Date: Tue, 17 Jun 2025 15:35:03 +0200
Message-ID: <87plf27apk.fsf@jax.kurt.home>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue Jun 17 2025, Marc Str=C3=A4mke wrote:
> Hi Kurt,
> On 17.06.25 12:54, Kurt Kanzenbach wrote:
>>> You don't have to live with it. You could add a read after the writes in
>>> the loop (wrfl()). This should help.
>> Something like this, which was done for Intel e1000?
>>
>> https://lore.kernel.org/intel-wired-lan/20241219192743.4499-1-gerhard@en=
gleder-embedded.com/
>>
>> Thanks,
>> Kurt
>
> This works wonders (Latency spike down to 120 us from 700) ! I will=20
> prepare a patch and submit it to LKML.

Great :-)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmhRbwcTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgh7iD/9AhKQvwYw7NbR2KFo0qxCOmiopk+C1
pi7nFjIGbwEVhTR5MykXg7wbsgq6H/CB1UEQj6GLCfEs4t0gg1pSso2gbcDmJucS
Co2TSy3NTSy25P7Gz9WcklCS5H7p1xH78Ih7oMtI0AZF829f74OL0HUo65EwdJaq
zYk6plJFQu0L0wG42unWZbhySgTP+jAkx3EYIOlc/k1gTU4yslhgFcGqqCxtaR+4
J/zkzF8WQ8U1tcFjwkE2z3YdDppZ+IFU/R3/IyMCo9C7FzcpoxJak0QeowUQiiPP
ULlgvDhaoXXQcwAhLuf1kLS08UxCJPw4gj9sxAJA6aWazP2fQquzByjQbsHCV5WL
ldT6bsSQxGorpHMWD0UyyQeOIegJOJSWPppfDi0XZCIW+1B1iXKRLhRgr5P/B4Ca
r81pLACZ81EBsVJA1PUzfSRmbMa5rXVWbPkGRfXgwMdIrGdlpWVd//7EAI0aBXP+
MFT7hqE5CB4dzmrEPt2Zv8lHZ1n+ZXa9pS2UDy4+xwRnnSRqGvxkLKs0awJH1Fmc
P7PFoOgD35fgJCQEkik0CV0mvHSE3lFNvpD6a6J/NTN5O/+d16RL2oeirqrbPVbh
bQuDIpYmlnef5m9xn4S9LZls7V6Ot3WIBgoQcyrHej8YXph5YTDPoMrD5F8t6NZm
1+rf8IF1PJyffA==
=sHup
-----END PGP SIGNATURE-----
--=-=-=--
