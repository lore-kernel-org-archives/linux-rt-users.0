Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C352F56
	for <linux-rt-users@vger.kernel.org>; Thu, 10 Jul 2025 15:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752160813; cv=none; b=iXP6CHsdO+tSkhWKXn2RBsshncIoUnzX7pEaLpq9khe7WF56aRgQ7abpp/Ou9nBaFZmnqxoDtVRI7hlGd3w7vmeOtszAxYuArtgWa89zauzezwQsqlirbDm5/MEt0m2U+lLbpF27SIFlayWqqJ4CrN+FoRelfRrsUTrt/q/xkZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752160813; c=relaxed/simple;
	bh=5pL1qSY8fecIxP7Zg8RFZCNvEuRoU2WKs5prcrns6UQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWvmm5HxLKIdJZnsh1T0QTYetXRS50/Nuiz+JZrk69Kc7AdTE9ouVDK4qyTk1Uv7JJxIDV2bqTeC9QL5p6zucVYHZ5rY7OlrhxjpX8yiCe010rq5X57GlTnvI1qKATI5AdKJedv9aXlZeGw8nqRFDTG3JeUQVqZOkK4+TioSJXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qv4yLZCQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TTErbF4W; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qv4yLZCQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TTErbF4W"
Date: Thu, 10 Jul 2025 17:20:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752160810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5pL1qSY8fecIxP7Zg8RFZCNvEuRoU2WKs5prcrns6UQ=;
	b=qv4yLZCQM7ccpCIKJSdU1FLXRokDLVdPjGav8PDWyuMNLy5IMGfuUpelAfIwDqr5kYiJmN
	7BSYgrQDs4yUGs9B59N5seLjuACgAIhwiSAdkGS0xknnugvFKgCfzcsouUanWt8j1+/Pm4
	V282M5KiSj2yq9+bNFjIYkKnhqJbZucooUszu9XPz3aPOx+ST9TbbL8wUFWN/1FhE3N81+
	nzlAK5pk2IP5Ssd42LATUj2XyTIzpTQOcuYArOiHyjieql5lQxhfXxZCbt1T64u5U9o5nv
	kAS/u6dyIiyScyxVpyUYEbbJ3qsz8dz9dTUJ0QHlgr/69574Ov+yaWj4AfnMiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752160810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5pL1qSY8fecIxP7Zg8RFZCNvEuRoU2WKs5prcrns6UQ=;
	b=TTErbF4W9MbNM19uoYSRqeCfRQc6/tTonFfjuXM4xtNBGHuaKNYC2BN21NGZQp0m9g8btA
	+vigLs1XrtH7MAAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Ben Hutchings <ben@decadent.org.uk>, linux-rt-users@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	Debian kernel maintainers <debian-kernel@lists.debian.org>
Subject: Re: PREEMPT_RT vs i915
Message-ID: <20250710152008.ZyaHjC3w@linutronix.de>
References: <7c42fe5a6158445e150e7d63991767e44fc36d3d.camel@decadent.org.uk>
 <aG6nMhimN1lWKAEP@intel.com>
 <20250709194443.lkevdn6m@linutronix.de>
 <aG7MckLkTuzZ5LBe@intel.com>
 <20250710064136.rur6FoOU@linutronix.de>
 <aG_VzpXaYRCQQGYt@intel.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aG_VzpXaYRCQQGYt@intel.com>

On 2025-07-10 18:04:42 [+0300], Ville Syrj=C3=A4l=C3=A4 wrote:
>=20
> When this was last discussed I suggested that there should be a
> versions of the tracepoint macros that do the sampling outside
> the lock, but that wasn't deemed acceptable for whatever reason.
> I don't even know why the current macros are doing the
> sampling while holding the lock...

Any objections to me sending the batch and we figure out later how get
the tracepoints for i915 enabled again on RT?
It would be an improvement because you could take a vanilla kernel and
enable PREEMPT_RT and you would only miss the tracepoints while now you
can't enable i915 at all and XE either doesn't compile or spills
warnings at runtime due to the code it shares with i915.

Sebastian
