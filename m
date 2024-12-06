Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9E21F9A81
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Dec 2024 11:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733485925; cv=none; b=QG0sckEth0ocgUjQLRZXn18yD/h7w1+WGTfoLR9TadtrWA9zjrqbHDfZ+8XSgcv0BUiI3LPCVgosuQLoKi9TNAQRWa0r1VpZM1gLiNpe433Ylnq9/vH6lXhP8v65+TDXL5XPzWUuAd2TtSRQNqQ1RQUDQGicaTM4ZPnRjna3m8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733485925; c=relaxed/simple;
	bh=/AcXyvj/qNjcLGn2tO25kiMOGwGp7vvb9pFj5OGU0Go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VaPMLSsnQZX2W8+NBpJaXHJpRQhNSKIkBnLt3R1zkARsKlQDHG52thS2XEgR227TeVOpiEsBmO5lmA6PpbO0x4tvHBsJzIqrPUzEM5AaJAa43XRIP30SLx/2XkQDZzfo4B2Tn0nw/g9OcLc+U32Y6+jYv6rVgLcG8VIVVg2LyUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kljeo0zB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2LD+amO8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kljeo0zB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2LD+amO8"
Date: Fri, 6 Dec 2024 12:52:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733485922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/AcXyvj/qNjcLGn2tO25kiMOGwGp7vvb9pFj5OGU0Go=;
	b=kljeo0zBYrraNHlYGdj73dEhD/dO/bpPNYJtGjd1JiGDd3MkucDENt+u+G8pSas7MeTGB0
	YQX2wCQLU6zyyiJ+UYuXMs+ZtclhiYMKpy6VcgR79qqFA0esKMzLjz6lGGfiYbh7bX1dB8
	ZI5LswmlppwwpmIvNw1TAL/zZvIQFs3QoKFu7w6XvB43tJ4H/z9MBP8irl4ufvZ6fjj6MP
	dMhlSHkCX7XJOy3W5S3oU7NOj8XLf2HpAWqTMyfdZ+kxLlI7Md8UeN/gpLuUC9OJyrj5LU
	g0mr4/UwHSVw98uOic+WKl3HPr1/lGwLrD7I2L4srpU2zuxLizg/vfAWFbIAvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733485922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/AcXyvj/qNjcLGn2tO25kiMOGwGp7vvb9pFj5OGU0Go=;
	b=2LD+amO8oZN2ydWyNsVfuCeUKa+D9OL3NHWEmebNkWc5Q/WZ2YxubIbDe9mgRKsV9JUCi9
	uMyRKFYJX3/YX8DQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Crystal Wood <crwood@redhat.com>, John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org, williams@redhat.com
Subject: Re: [PATCH v2 2/3] rt-tests: cyclictest: Support idle state
 disabling via libcpupower
Message-ID: <20241206115201.RJsDmOXi@linutronix.de>
References: <20241113114509.1058593-1-tglozar@redhat.com>
 <20241113114509.1058593-3-tglozar@redhat.com>
 <c0bf98ab-ac45-eb0f-e239-47e235465ab0@redhat.com>
 <0da561414289c7b929da1513962756bb8630e32f.camel@redhat.com>
 <CAP4=nvTZ5nLrP6O7rSU+c269M-=OFTX=3zNSp6TDDxzg2Fq2fg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAP4=nvTZ5nLrP6O7rSU+c269M-=OFTX=3zNSp6TDDxzg2Fq2fg@mail.gmail.com>

On 2024-11-27 10:45:49 [+0100], Tomas Glozar wrote:
> st 27. 11. 2024 v 1:09 odes=C3=ADlatel Crystal Wood <crwood@redhat.com> n=
apsal:
> >
> > This could be said about the laptop and power_management checks too...
> > I'd go with verbose info prints rather than warnings for all three, if
> > anything.
> >
>=20
> I agree. I believe my code is consistent with what we already have.
> When you do cyclictest --default-system, you also get a warning about
> not setting cpu_dma_latency, despite it being what you have explicitly
> requested. My patch just does the same thing for --deepest-idle-state.

What is the default behaviour and what is the intended behaviour?
Couldn't we somehow avoid adding yet another option?

> I suggest deferring this to a future patch that would remove the
> warnings and another one to refactor the code.

Sebastian
