Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02B73BB9E0
	for <linux-rt-users@vger.kernel.org>; Tue, 21 Jul 2026 10:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784630844; cv=none; b=HGlTtGQnFDJ60SPbwkKlwWyP4q52ee2dZkilccY0POfEebIZSDAjzzi8MzwpO24u1785cO/mvYoXnEZ7DEc5ygci97oBeEuIBphJVxZcgL6JGiVfM8+gW1ILwKWZfCrzLZ51NhC5bViS/2UZOyzMdXnqZOUMBKd2x7ojT94Z2Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784630844; c=relaxed/simple;
	bh=ZzwtnDOfwwKMWvL5PCL0DV/GUB8uosMdTvSaM3Sw0P4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YoUlUMy3J+0uxav4oxQ2bVMssQxK9SczAKCM8t5/IZK/pFkYU6zT4hplSk7gYPkr/D+F5oCdQLIqDlbxoHZFOBlzyca/4okBg4uWIOFBIRGvecV1wTL8Eoy2qutyLGQJTGQht3MS27OEO6eCntc4bwqvynEPuvMYXFEQ3IOm7VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XK77qYyS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nO7qTxDL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XK77qYyS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nO7qTxDL"
Date: Tue, 21 Jul 2026 12:47:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784630828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xLj6FV9Jxrp8DvTwMMuXcd5j/P99v341bwMPCjaISns=;
	b=XK77qYySiBmDo5j2U9cnTuS7eTFTFq6nvR2S0Gps9EVPU23OfBlAwLY31VQCRXMQgvVqUQ
	Iy1CZ7g5Rbv9otBqDmEprqmW/R0YH+4NIxN5Qj2jQhOrtcifqGwgo/3eCZLy9P4HJjrchq
	bRym27ESZitaezchVi6oADOdhxiiPFMHh7tUQ+kUbkSzFlhf2DROIOdKKnAGX3t3HU3opG
	oMbRtFgjfQwYc5lg4PD3kVyiNK24B1MR7AZmZd2slBNzdLgoEsKJ229IN9akYr+1/EAziP
	v5n+2rI44ueOY3XO2FbjofELbu1e9yX7REpVw7PuYS8PT9hY+6G7KNUUAEAiPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784630828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xLj6FV9Jxrp8DvTwMMuXcd5j/P99v341bwMPCjaISns=;
	b=nO7qTxDLTYOVY4HmIz5Q+n0ivGSEGRf+75t2Rh8WMcColrEGzD2G9YiAScVllsj8mcE3FT
	9IR7QkRn0JgHmoBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: David Runge <dave@sleepmap.de>
Cc: linux-rt-users@vger.kernel.org
Subject: Re: Issues building RT patchset v6.18.13-rt4-rebase on top of
 v6.18.39
Message-ID: <20260721104706.qSVhG51k@linutronix.de>
References: <al3YymTiIicX2Vin@hmbx>
 <20260720125805.wN3NFiBj@linutronix.de>
 <al83asltX9snvqq1@hmbx>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <al83asltX9snvqq1@hmbx>

On 2026-07-21 11:10:02 [+0200], David Runge wrote:
> On 2026-07-20 14:58:05 (+0200), Sebastian Andrzej Siewior wrote:
> > It is there
> >    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.gi=
t/log/?h=3Dlinux-6.18.y-rt
> >    https://www.kernel.org/pub/linux/kernel/projects/rt/6.18/patches-6.1=
8.37-rt6.tar.xz
> >=20
> > the problem is probably that it is not in the stable tree=E2=80=A6
>=20
> Hi Sebastian,
Hi,

> thanks for pointing me to the custom source tarballs and the relevant dat=
a in
> the linux-rt-devel repository.
>=20
> To understand this better: Is the 6.18 release series (and future release=
 series
> from then on) going to be developed in the linux-rt-devel repository, not=
 the
> linux-stable-rt repository?
> As downstream package maintainer I am currently relying on the relevant g=
it tags
> to be available.

That is somehow odd. I just pushed to the stable-rt repository.

> The linux-rt-devel repository seems to cover all new versions, but
> linux-stable-rt appears to lack behind the upstream advertised LTS release
> series.
>=20
> In general, I would very much welcome a single repository, instead of the
> current situation with two repositories, in case that is feasible for you.
> Is there policy around when a specific release series is used in which
> repository?

This should have been handed over but it did not happen. So it remained
in this state. I'm sorry.

I will try to update it once it clashes or needs attention otherwise.
Feel free to ping should I fall behind.

> Best,
> David

Sebastian
