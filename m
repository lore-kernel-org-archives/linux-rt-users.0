Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342F9215F58
	for <linux-rt-users@vger.kernel.org>; Thu,  9 Jan 2025 10:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736419796; cv=none; b=nrLZsACdmHW7NrRyjgiwABnSTvwKJf8jcE8SWV5flHtHHXa+NMWp0yq8Mxuuy9vIT8n3b4z8Ui+tNrk0KIDDmjmbujmkXtkR131vJe8GX6T7mVKAgmoXfu53Yh3c0xYRKrszh0ZemOFxjDm4kkEqikt830/kEQ9ZjLTDFvHlE10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736419796; c=relaxed/simple;
	bh=s9kTdXumcjrFopGqGNOu8kIzKgC1OV3LwiOgRYi06YQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+Fod9XiPEHTM9p5W3+qrz25rSv6ibmCaUeYyeWdQ+UWWroAPHGVQM4kbcVIMbJpV87R5C5Rz4mAlRy53b6ZXxGSW1TaSxGZghbrwI4ed5Mm8/aE4UHI5Ez+kRP9E6776lWVVAzTik0pJLQcOqCDuwWQThqjHBOv9Kh+7ypaZsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3Fl8xBqI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cS8H/Ebg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3Fl8xBqI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cS8H/Ebg"
Date: Thu, 9 Jan 2025 11:49:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736419793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1XZYGPpdnn0WkW1AQSG61BrHsUXWejImi7NVr0On94Y=;
	b=3Fl8xBqI4yBcea3SoIXeHnPdLalQQWRoON7jcA6UQUpxV7gC6JhzhJXObPtGvz/WNlv5Re
	Kac85ZHQ+nTDxjbYG9gCuEOCbMLbSIz0Gcehc5bEGN5L0peGaE0wC7YHdTGUgKCD7D8P7m
	Wa6FEoEQCN8u8KEjnGV3mp0SPmR7MDvNIjhUeRdItR+NMtkZveGf3LPQojEwtncWPogQoC
	w/RixUaVTiu+KOwMVqwVZpkbYoXZqABE2Gd5HDg6VAEBbOw/XNqoqI2Lok8r5WOKZVVkgZ
	YNYkYefo7zyBPSc3PevKvYGI7J/S/Njsh+hrxqzS6euuqg1XFJOV9W4WXT+kmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736419793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1XZYGPpdnn0WkW1AQSG61BrHsUXWejImi7NVr0On94Y=;
	b=cS8H/EbgEJGFfwBEKyRjH3+DbZJc6tLjTkShwUIfqqNNAWqhnQ8MlUaliAPfEv9WF3N9i+
	r0nnkYAvjFf2vVDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Tomas Glozar <tglozar@redhat.com>
Cc: John Kacur <jkacur@redhat.com>, Kurt Kanzenbach <kurt@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: rt-tests release tarball location
Message-ID: <20250109104951.j_au4J3w@linutronix.de>
References: <20241228114346.6020d6b0@windsurf>
 <87h66b2c6m.fsf@kurt.kurt.home>
 <20250107141424.EoC5uS6y@linutronix.de>
 <f87b2d77-7925-8678-d0fe-9a0d471a38f1@redhat.com>
 <20250109080555.WpQmRgu0@linutronix.de>
 <CAP4=nvTmQFPrv=FtJAy_g2xxsqBSfHE1mne5sEBrsDGKVAs5+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAP4=nvTmQFPrv=FtJAy_g2xxsqBSfHE1mne5sEBrsDGKVAs5+g@mail.gmail.com>

On 2025-01-09 11:13:50 [+0100], Tomas Glozar wrote:
> =C4=8Dt 9. 1. 2025 v 9:06 odes=C3=ADlatel Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> napsal:
> >
> > What I am asking is to either please keep all rt-tests releases in
> >         https://www.kernel.org/pub/linux/utils/rt-tests/
> >
> > but this would also mean that the older folder becomes removed and this
> > might upset more people.
>=20
> Can't we symlink the older directory to its parent, so that all
> releases will be available under both
> https://www.kernel.org/pub/linux/utils/rt-tests/ and
> https://www.kernel.org/pub/linux/utils/rt-tests/older/? Yes, it's a
> bit ugly, but it would ensure the downloads keep working for everyone.

kup supports a ln command so that would work, yes.

> Tomas

Sebastian
