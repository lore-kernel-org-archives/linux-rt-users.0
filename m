Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59F942AAB
	for <linux-rt-users@vger.kernel.org>; Tue, 17 Dec 2024 08:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734425442; cv=none; b=LMmYCRhVdmgDKTSWxuyH4d3NXbUx0lfOd0j8MB6w8tXg/N8xII2ArfWOfLHGn5WsK4pz8pP/cwc1qkYW6wND7B5KszWPbZAeQAB4zAk48hBjN9RNfp95ZCU6qR6cg4Cgs8J1QmXwhN9f8g18ZZUjw2BOYrdSOOCDP95KQjUGMxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734425442; c=relaxed/simple;
	bh=QuaSrJV7c/VMGNw8yhUNA7qbqfXHWaTPvdqlWMWSdJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qh+XrB2nd2/SXBZwn9sXZJW7/C4aYBzsjwP9Bfqzga6DMgj0FzZAgPSOE/qXvtyez+kInQOLSyBm51IhURSJ18Cw0FITDNM6Yqydlko+N+CrUQqEi1SlspDosEGtxySuuWse86ThitfJPIyCKzVxJb8DOmWTMvJtjq20Zyz3kfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BdJzbatK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=88CPMBTm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BdJzbatK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="88CPMBTm"
Date: Tue, 17 Dec 2024 09:50:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734425432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PVbFtGa+oz544YtTIdlW/emfzXs4T7WCrxR+60fQ0RU=;
	b=BdJzbatKiR3nsO2VhfZbs2TMO/RabEz89AYHBEbux/aicjwY9FebkqjUZz5j1CbVXQQBnZ
	YMZdHMu08K+X+dBG1F+vUGbrcGuPygiWEchC2pv36TqZBbtjbnPdk7f6F5/61uqsPC7oQy
	I+ZbtwFVDQRamKJ1v+Ti7DYw9vr/gii1jB75EkHmHTi+B3s+IB716ZRCj6Hyl4a6MADz93
	zQDtX1lJISE5e2onZNdpEcViMUklurD4qrNshhPhIzR3sWHOcbIF9CvVBWheN7picDJMUV
	QdkZy2mmzxZQcxnYLa5r0b9drfumU34RPnfe1qHlntLfjnc0tO1dwXXWN5hPlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734425432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PVbFtGa+oz544YtTIdlW/emfzXs4T7WCrxR+60fQ0RU=;
	b=88CPMBTmOS9NvtIoNQjLOuguj6yEoePhW52QkB7jUvUaIbSyG7Ho69jvXQNJZi65joyJzQ
	Jo5BMfCIGtM8h/AQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Petr Tesarik <ptesarik@suse.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-rt-users@vger.kernel.org
Subject: Re: Lazy preemption on arm64
Message-ID: <20241217085031.Wh45Bd2r@linutronix.de>
References: <20241216190451.1c61977c@mordecai.tesarici.cz>
 <Z2B5y3HiLuRHPfdv@J2N7QTR9R3.cambridge.arm.com>
 <20241217073151.5aa2352a@mordecai.tesarici.cz>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241217073151.5aa2352a@mordecai.tesarici.cz>

On 2024-12-17 07:31:51 [+0100], Petr Tesarik wrote:
> V Mon, 16 Dec 2024 19:04:43 +0000
> Mark Rutland <mark.rutland@arm.com> naps=C3=A1no:
>=20
> > On Mon, Dec 16, 2024 at 07:04:51PM +0100, Petr Tesarik wrote:
> > > Hi all,
> > >=20
> > > what is the plan for implementing PREEMPT_LAZY on arm64?
> > >=20
> > > There used to be RT patch series which enabled lazy preemption on
> > > arm64, but this architecture was "sacrificed" in v6.6-rc6-rt10, as
> > > collateral damage of switching to PREEMPT_AUTO.
> > >=20
> > > IIUC lazy preemption is currently implemented only for architectures
> > > with CONFIG_GENERIC_ENTRY, but there is no inherent dependency on it.
> > > So, is the plan to convert arm64 to GENERIC_ENTRY (and then get
> > > PREEMPT_LAZY for free), or is somebody working on CONFIG_PREEMPT_LAZY
> > > for arm64 without that conversion? =20
> >=20
> > I don't think there's an agreed upon plan either way.
> >=20
> > Jinjie Ruan has been looking to move arm64 over to GENERIC_ENTRY:
> >=20
> >   https://lore.kernel.org/all/20241206101744.4161990-1-ruanjinjie@huawe=
i.com/
> >=20
> > AFAICT, the only bits that we get "for free" from GENERIC_ENTRY would be
> > the logic in raw_irqentry_exit_cond_resched() and
> > exit_to_user_mode_loop(), and all we'd need to enable this on arm64
> > as-is would be as below.
>=20
> @bigeasy: Would it be OK for you to add the below patch to the next
> 6.13 RT patches?

This bits below are actually the same ones I made last week. I stopped
there because it was late and I didn't find GENERIC_ENTRY nor a
TIF_NEED_RESCHED check in arm64 so I paused. Where is this?

Other than that I would be happy to take it then hoping arm64 does the
same.

> Mark tagged it with "HACK", but to me it actually looks just as good as
> the good old (pre-PREEMPT_AUTO) arm64 patch. ;-)

The old lazy-preempt had also tweaks in should_resched() and
__preempt_count_dec_and_test(). So it is slightly different.

> Petr T

Sebastian
