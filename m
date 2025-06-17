Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7550F21C9FF;
	Tue, 17 Jun 2025 10:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750157699; cv=none; b=sQAbnLY8ziP47BDWVo/8hpFF2sz6wvL3XGDRnGpkPN3Pg8k1IG+O0C0bLb2/9budp0fdumA3csxjQOKj0xhV+Zot9OiQZfyj3woUwQLNS27TtUSBKiM3GfKbWUiYG8RXgOFlgsFQFYjeLCzIgxpHph7sQLIvuU1LQjXP3XcSPPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750157699; c=relaxed/simple;
	bh=x3JRQH8niRtAFZyeQUyetaHm46/MXx+Fttu75P73mkQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Gymap9piT3yaa1iQ0z5wk0aqdJfROz6m5447+62uKKaQikS1f60bodmftgwZ84rWqHV9iUx1uR3yV25arWO/1uMQGvzD/STEywO0fJGjeMwrLyhiLY8hOJd1e+Q6s6ASQqiAIy/nOGAzSpmRbPzbQmX2Q3dmc7264sIvigoeBck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eBUhnSz1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iFe6w24G; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eBUhnSz1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iFe6w24G"
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750157695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x3JRQH8niRtAFZyeQUyetaHm46/MXx+Fttu75P73mkQ=;
	b=eBUhnSz1A1tVqLrAOT/WARW2n885Lw/tG3tdwYIAEe3SsGHKaS7fHwCPWW/ICf3GUfHk0R
	SLKrbHQUitLfGt1mQmCPhDcowQbassMjf+IBdCPAk4sDiWkUEtqG2mUyuP+w2+zaeL29Jm
	Iv7kzOjKETEc2Ka5WVX9U26HUyE1FMJYhDAi1ZkC4HpBxVz/dl65JzYVxcrt+2uAMKM7pz
	YbNVIRLvrAdSGJmu4zliN50NqU7jXXaBd7SE2o2/bvFlTjuKURAx/a+qXBqqbZh+oKFVyx
	G5YkYCMlmJDzowKqw87lUKBby/IfqG7uSiadTRnj7nICsQ2TYrYeR9gdE5fS9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750157695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x3JRQH8niRtAFZyeQUyetaHm46/MXx+Fttu75P73mkQ=;
	b=iFe6w24GtplauDSfHxnh+rUFXKSO0nj6s0ef4xpiNqm6gbgiiUNbrc9oByMjHT4bq2BFMc
	QsGftWU8StJud8CA==
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Marc =?utf-8?Q?Str?=
 =?utf-8?Q?=C3=A4mke?=
 <marc.straemke@eltropuls.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: Latency spikes on V6.15.1 Preempt RT and maybe related to
 intel? IGB
In-Reply-To: <20250617101507.jU00mupE@linutronix.de>
References: <20250613145434.T2x2ML8_@linutronix.de>
 <E1uQ6I0-000000003aa-37uJ@smtprelay05.ispgateway.de>
 <20250613195838.0-gZ6bqS@linutronix.de>
 <97638b0b-cd96-40e2-9dc2-5e6f767b90a4@eltropuls.de>
 <20250617092814.vqKdu23w@linutronix.de>
 <bb74b5b6-bc23-4aa4-83df-449dc7c9006b@eltropuls.de>
 <20250617100013.1o5lsPLq@linutronix.de>
 <b7179ac8-c64b-44dd-b25a-62b34eb49c24@eltropuls.de>
 <20250617101507.jU00mupE@linutronix.de>
Date: Tue, 17 Jun 2025 12:54:53 +0200
Message-ID: <87v7ou7i4i.fsf@jax.kurt.home>
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

On Tue Jun 17 2025, Sebastian Andrzej Siewior wrote:
> On 2025-06-17 12:03:31 [+0200], Marc Str=C3=A4mke wrote:
>> Anyway: Thanks for your help Sebastian! I can probably live well with th=
ese
>> spikes in latency. I was more concerned that there is a deeper issue wit=
h my
>> config and the response time could be unbounded.
>
> You don't have to live with it. You could add a read after the writes in
> the loop (wrfl()). This should help.

Something like this, which was done for Intel e1000?

https://lore.kernel.org/intel-wired-lan/20241219192743.4499-1-gerhard@engle=
der-embedded.com/

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmhRSX0THGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgvMPEACWgIzrHO4Cph0hIe7lPJdWBqZJ9xVO
qeZa/IcH4J/HexhqRwutvevUK3z8PHNE9I9+CtxzsuLBpbTIJkw9yD28/EmskpkW
bIwolohpUHrmkqGD28sH5eB/g287SNOFAyQ+HmavjW6Qv5890j/xXKFziz80EtoU
f6pzyuayc+Up7fCwRhPt7beWwZ4YJ2JMSaVMiFtrdXpgiaeB2FJNBkXWiQtu8dRd
U9aiOoBnP8OnTz9HZMtloKlEf+JUVSNfo8Det/6f1TEs2Tbmp/BbN3RpjPdsBTeU
5xyqQWnSB9P+WHsU7hEonU26Wky1LYjzdTQOHmOnmv3a89p2aebncZ5CR38LmggA
UrJ2QyYU2zUPjx76qnh6LqDRF/w3vab/FHgnEu4VO62dIm2K++C+KTwpqT3nIVkn
dhZ05bXKOtGo5tUzIUzFnyhzxqeec/B6/qPRDIDV3CwUB0EtU01ilx1a0DtvDqqW
HiCWT36TPP8TPcl6j9IZqpG+LtkmN91rwnAZvi1oO4VYl2SJy7Z+MAsFkAfBkRjI
dYPPS3SGv/UXUeepx2o588tSKSx/VdhhyX5zuSQnMZLCw0QpDM1KSjhuknxCPE+U
pNIIZA4FDFhWWfJcosa315IvhrcSHBoQYnjfHgGrIyQQoOQRQlWN4lYSPdDAIfeg
T+wYDtIb2qc5VQ==
=CsxQ
-----END PGP SIGNATURE-----
--=-=-=--
