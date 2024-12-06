Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6941F149E0E
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Dec 2024 14:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733496096; cv=none; b=YyOZaIQgonnofr8/5kdck3MxXg4idj960mIxi9Yd5RYXzoedE49PGOY7usnSD7XjonfHQ4ofsG+G0LkpnuAt8O1ugf0ifn884P7SywgZWw0EN+ELZ05SKuU2jAGj4YIiFw7I4yEPH9TENc86OHeFVFulF4KD381HVMZXYUuMnsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733496096; c=relaxed/simple;
	bh=7eXQpasf+bv1g4e3QuM9UngsIW4f6AEE3R15fmE36Vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UfoskkV27R/VdHo8UVGcc/I9++euwx4/K5t4Z/nQf/egosI7gp3Nu4SJeNtvORlaTJRz1+PD6wypHwNGhg6G3JGIb80Ww/BTseD1QMtMsl4vwQ/3pH4zKza6UAWB5zXPkJPfX88jDPrYhf03tfixIdP75WyHnRCW1aAH5aAeRFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ertCHce0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T5EHfQ/w; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ertCHce0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T5EHfQ/w"
Date: Fri, 6 Dec 2024 15:41:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733496085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7eXQpasf+bv1g4e3QuM9UngsIW4f6AEE3R15fmE36Vs=;
	b=ertCHce0LosglRiaAjvTAyNDZlacc8uoZWeutz2Kbwdv9OEmqC+yUC2sudjOGE6/BnSKPd
	oSFwWuEYMkj9E94OeO88hlZxMltBhVBCsJbDz2+XQ/3A3vDo5PH5ryqAMiw7AHcjKjqWTm
	oujkYVbaG505p7auiYdcpfUYDYZs1tVBosqlRTQlXNYYcl9WsxISYhaM9iq0OAQ0gWFMvb
	AHhRVkn8EZhsaJityIdr+TrM88B8Z5R6T0KC7sXBFZ6y7bjJzjAZjpyRbULTn6WEhGGEsl
	Qc2p+QQ6irYA9sUdj1c7c+AygvL0uPykUDjwZWbcQYUOMk6Famd57MjYv5TL8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733496085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7eXQpasf+bv1g4e3QuM9UngsIW4f6AEE3R15fmE36Vs=;
	b=T5EHfQ/wNeYl1rXJwUVzUPNQEBoyUKRFEvd6fyhh/6uFrSbcaqbz0aLXcCDfWWMcb0592D
	r5XMBO6gryd+RzAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Crystal Wood <crwood@redhat.com>, John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org, williams@redhat.com
Subject: Re: [PATCH v2 2/3] rt-tests: cyclictest: Support idle state
 disabling via libcpupower
Message-ID: <20241206144124.dd-I-U47@linutronix.de>
References: <20241113114509.1058593-1-tglozar@redhat.com>
 <20241113114509.1058593-3-tglozar@redhat.com>
 <c0bf98ab-ac45-eb0f-e239-47e235465ab0@redhat.com>
 <0da561414289c7b929da1513962756bb8630e32f.camel@redhat.com>
 <CAP4=nvTZ5nLrP6O7rSU+c269M-=OFTX=3zNSp6TDDxzg2Fq2fg@mail.gmail.com>
 <20241206115201.RJsDmOXi@linutronix.de>
 <CAP4=nvSjcZ14e_bpGaab-Epu_FupXzCi0ovG5hbih1fjhwOTOg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAP4=nvSjcZ14e_bpGaab-Epu_FupXzCi0ovG5hbih1fjhwOTOg@mail.gmail.com>

On 2024-12-06 13:14:02 [+0100], Tomas Glozar wrote:
> p=C3=A1 6. 12. 2024 v 12:52 odes=C3=ADlatel Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> napsal:
> > What is the default behaviour and what is the intended behaviour?
> > Couldn't we somehow avoid adding yet another option?
>=20
> The default behavior is to hold /dev/cpu_dma_latency at zero, which
> disables all idle states on all CPUs, not only those on which
> cyclictest measurements are running. This has the disadvantage of a
> higher power consumption than needed in most cases. With
> --deepest-idle-state, idle states are limited only on CPUs cyclictest
> is running on.

This is a real use case? /dev/cpu_dma_latency is a big hammer to disable
everything that might cause latency.
So you have 4 CPUs, CPU0 is getting idle from time to time and CPU1-3 is
doing RT work so it can't take sleep?

> There are two reasons why we can't just use the latter and have to
> have options for both. Firstly, some hardware does not support
> disabling idle states on individual CPUs via the cpuidle sysfs
> interface, which is used by --deepest-idle-state. Secondly, latencies
> measured with --deepest-idle-state might still be higher in some cases
> compared to holding /dev/cpu_dma_latency.

Yes. Especially if you find power management thingy that is covered by
cpu_dma_latency but not by this new switch.
=20
> Tomas

Sebastian
