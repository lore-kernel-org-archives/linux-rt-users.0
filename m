Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E6F175A87;
	Tue,  5 May 2026 15:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777993278; cv=none; b=N1+00ow7fA5cJURK1Ew9zWoQiKE8MhBzzIN2VZmd98+TtpslE8QMwApVfWaufgGaf19T5Hbb/QxtxjY/lP59ET8PyoRNcC93Ew6TpR5KvG02780UPwdr6mwikfUjs1ukpI2NeAxEvQ20GZ1QOzVhulAbilEv+EtSVVJSfcVRfp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777993278; c=relaxed/simple;
	bh=eFexIphFIcEkKC2V2JM8pxqEzU9n1hayUv5BMJqhZBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LeCAY6O5CpT825JqRiXQYoiYudgDvgH653ZxgdNy8ts7lshHCvOPLhYim6L0wUkP1Yyk2BAWT2phmEUw6yY7u4FMpYBU884UHmJ8raBc5eep67VoGDutukLUPVfJXRkvBPxP4kIkrHmFzCiIgwOOnUmKTR57co1Tj5f7LtsjQoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cxxjGI1r; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EpjFWuLl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cxxjGI1r";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EpjFWuLl"
Date: Tue, 5 May 2026 17:01:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1777993275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=atK6weT1XGLpCL/zvS+Ix4Qs1ew7l+7MZ9kenS/ecH4=;
	b=cxxjGI1rcuDdvKbZhUMn6eippEjydDu36epvjqggDsCdaVHD/SjNdrXCMbh1o/1RKIess0
	18pD1aS6V6mW9mLjzGMP1AkXCQ1/rW7s/zl15pzDOx9VULX34R27FEkIW9Y8JdniPw1J0H
	oN+t7Yf6f27P2y51kQ8cBCu2Aep6CKlSdsbgjLw73m+l0yWPA+63YqMdrE7ucLPJ43vfDk
	C9dHiIgcUI6WZ0tn+GunT3AsEavV+Q7Po7HJOUsbZZy2wzsCSwwKOySBZbGG2teZFSk6HP
	MT/3JRLyGGMA7/aBfTQMD7TIkDnTLG4j7x4tVbEAqHjIhFcfNH6Kyn/BL0+5Gw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1777993275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=atK6weT1XGLpCL/zvS+Ix4Qs1ew7l+7MZ9kenS/ecH4=;
	b=EpjFWuLl5vM3NMqIGc9C/nm9Gp0DlLYD+ZfhBDFGolVnavriD//XSwROZl20ffzuwIelfq
	opING8tSpod9R2BA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Ionut Nechita <ionut.nechita@windriver.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	x86@kernel.org, mario.limonciello@amd.com
Subject: Re: [Question] Core-to-core CAS latency spikes on AMD EPYC 8534P
 (Siena) cross-CCD
Message-ID: <20260505150114.lvv5rFW5@linutronix.de>
References: <20260429162736.339322-1-ionut.nechita@windriver.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260429162736.339322-1-ionut.nechita@windriver.com>

On 2026-04-29 19:27:36 [+0300], Ionut Nechita wrote:
> Hi all,
Hi,

> Kernel
> =3D=3D=3D=3D=3D=3D
>=20
>   Version:      6.12.57-1.stx.136 (PREEMPT_RT)
>   cpuidle:      driver=3Dnone (idle uses mwait, C1 only)
>   cpufreq:      acpi-cpufreq, performance governor, boost enabled (~3.1GH=
z)

not related to _this_ but boost is usually not ideal since changing CPU
frequency requires some time before the CPU gets operational again.
AMD's document
	https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/tunin=
g-guides/56263-EPYC-performance-tuning-app-note.pdf

suggest to disable boosting.

> Questions
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> 1. Are multi-us latency spikes on cross-CCD atomic operations a known
>    characteristic of Infinity Fabric under heavy coherency traffic
>    from all CCDs simultaneously?
>=20
> 2. For RT workloads requiring cross-CCD communication, is there any
>    kernel-side mitigation (scheduler hints, IF QoS, bandwidth
>    partitioning via MBA/L3 CAT) beyond pinning to a single CCD?

Not sure what you mean here but CAT (or PQoS as AMD calls it) via
resctrl interface might help if you put the task communicating into the
same cache domain.

I do remember that on a Zen 2 (I think) I observed larger latencies when
the (huge) L3 cache was written back to main memory and the CPU blocked.
This was visible since it was in the ms range. You have here ns range
so=E2=80=A6 The resctl interface mitigated this to some degree. There were =
news
sites claiming that this kind of latency was solved in a later
generation but I don't find the details now.

I find however https://hothardware.com/news/zen-5-c2c-latency-bug-fixed
where they claim firmware upgrade went from ~180 to ~80 on cross CCD
communication but they don't talk about spikes (also Zen5).

> 3. Could this be related to snoop filter capacity on the IO die
>    (given the 16MB L3 per CCX), or is IF arbitration the more likely
>    bottleneck?
>=20
> Not reporting a bug - looking for confirmation that this is expected
> hardware behavior and any guidance for multi-CCD RT deployments on
> EPYC Siena.
>=20
> Thanks,
> Ionut Nechita

Sebastian
