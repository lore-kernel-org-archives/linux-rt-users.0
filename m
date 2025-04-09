Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2984C80;
	Wed,  9 Apr 2025 13:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744204914; cv=none; b=XdeRuMIQbZO2+C0qiXyupe99YAOEFqK9eBERKJDnC34bCZnTlVW9/WDh9h/9Bn2WTuy0KXxfQIbrXdKGizcDpIadRPE5Cbim1FEVQaolxvIE5jQM2s128cnOu1Qi0vqqm3Jg3olsgJq1Qe4CcM0j+e6Zp6DABHJk8euqfSOXKwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744204914; c=relaxed/simple;
	bh=hkkkXU0rPXOW0FHwk4UkS9j/YrFARBVXCZRGq/oo8ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4a3vHgL/ivDsXrPcxN4nn4sxOXP11/IBsHUG65oVYA9fZJHG9jPVGeWTbNjHV4lqb522MddbvPBB1n4n66qCZQT3A2KBnjhVMV/E8/LsuZFp3tQZH1597wbkQTh9nzQ9TORBj4Bmsn4kv7MGLrAA865zX5lDIoGgrl/foCDk7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uPIEbTbA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WH3yhCDs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uPIEbTbA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WH3yhCDs"
Date: Wed, 9 Apr 2025 15:21:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744204910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iMwQCoiALCNgWaYTDJpegtVRqt9rDoY6rGfEceo5S9k=;
	b=uPIEbTbAXea1Pk78zz2srCANqqBb+FipN9mltrJ9HaLxRm4/egfHhFBuSZo+jlH1tu8JVK
	u8/L5RqwSGSeLCVRPPOwz5fi9EJfEtbCkAaXjY9hiuBjhkHM1oHKn5dMkzVhOhSi84MoE3
	c6719RwcN2Jyvz0eREZ83LCjs9NLNOp7yJHczlbjF8hKL/IjD9HYO3tGUuCGidzIFB8uRD
	dpz1oX/DdAeT9zHzIJ7TY4o2yRMYt80ZBqI4WU74924VUz5wrSa7PMeL3BnDUi1Yg9Hzm3
	U8WG93dzIHKMwDubH4i66Gn9yiCBVgTe4JDix5sQbFBXeDAtLbIxkv10ntyI6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744204910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iMwQCoiALCNgWaYTDJpegtVRqt9rDoY6rGfEceo5S9k=;
	b=WH3yhCDsCGnrn0Dgp8DOitWlcaLqmRxWjuCp+BvgpJgV132yYRa33D1v144UvDdbZrvY5o
	AgLNVB2lGVP7nqAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Valentin Schneider <vschneid@redhat.com>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	kprateek.nayak@amd.com, Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Andreas Ziegler <ziegler.andreas@siemens.com>,
	Felix Moessbauer <felix.moessbauer@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: Re: [RT BUG] Stall caused by eventpoll, rwlocks and CFS bandwidth
 controller
Message-ID: <20250409132149.rFrzBCrP@linutronix.de>
References: <xhsmhttqvnall.mognet@vschneid.remote.csb>
 <3f7b7ce1-6dd4-4a4e-9789-4c0cbde057bd@siemens.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <3f7b7ce1-6dd4-4a4e-9789-4c0cbde057bd@siemens.com>

On 2025-04-09 08:41:44 [+0200], Jan Kiszka wrote:
> We are hunting for quite some time sporadic lock-ups or RT systems,=20
> first only in the field (sigh), now finally also in the lab. Those have=
=20
> a fairly high overlap with what was described here. Our baselines so=20
> far: 6.1-rt, Debian and vanilla. We are currently preparing experiments=
=20
> with latest mainline.
>=20
> While this thread remained silent afterwards, we have found [1][2][3] as=
=20
> apparently related. But this means we are still with this RT bug, even=20
> in latest 6.15-rc1?

Not sure the commits are related. The problem here is that RW locks are
not really real time friendly. Frederick had a simple fix to it
	https://lore.kernel.org/all/20210825132754.GA895675@lothringen/

but yeah. The alternative, which I didn't look into, would be to replace
the reader side with RCU so we would just have the writer lock. That
mean we need to RW lock because of performance=E2=80=A6

> Jan
>=20
> [1] https://lore.kernel.org/lkml/20231030145104.4107573-1-vschneid@redhat=
=2Ecom/
> [2] https://lore.kernel.org/lkml/20240202080920.3337862-1-vschneid@redhat=
=2Ecom/
> [3] https://lore.kernel.org/lkml/20250220093257.9380-1-kprateek.nayak@amd=
=2Ecom/
>=20

Sebastian
