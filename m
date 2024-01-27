Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7C117721
	for <linux-rt-users@vger.kernel.org>; Sat, 27 Jan 2024 08:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706344868; cv=none; b=K7FMJEajDrY5UdhlwS+P+ajzHAVn5biBWAn3FSVmotNrBpeg3eMj53WqSf3YyqUl91LFEk3/WFh8aACoENGo208p2YDE/pDFsnlyNs+GqFMX2sZX6rjuDzDnDthm77R09p7SVOfaOjCPEv4ojIheH9qEcqM96LgqqtTihvhjAzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706344868; c=relaxed/simple;
	bh=BOCVcgEiOjcn22dH2DMdD9RGoWw7Vyeamd14aUEG6DA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JnR7NeSSeNoAdKiwMU9Ub4z1oabn5SfA55KxqYSBza0BfLtlXWZBNokzSmyrHY+knrgTiKoe67v7g0mxL8nYtHgzeBOtgYfFR1vaAkn9soSVzQ/RsqAFxWWQT9liyS7RD2WRb3f0A7iHnDVYLagXROxXs/GfjBQPzPxT3IoOZMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E3Ixjx9p; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1TSlJ3pY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E3Ixjx9p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1TSlJ3pY"
Date: Sat, 27 Jan 2024 09:41:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706344862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f1xXYCs1RO4Eo/Cj/0RqmEflysMy6RqM29l1YXvUmdA=;
	b=E3Ixjx9pHx27NHP80XP+7xDAgkfKwqp34GEv/vRN0QAUbMMXz6ljWch5LIZ9kr56mhgJ6E
	E6mM2dmCpv48lb57mkNhYu9vTlUutr286FxWV3FePc+I7oNjX6MPEtMspR4EQo8RNPV5HB
	FqktzXLQ7pO7LYM5XcZx/pZuu1rdCxRWdgOkblfAiUPui3qBbPZeavItoZT21qMJiSPepQ
	4wox4B5Dfrwt0npvfoC/Peufl23uaR4yn/6vOkVvT/C8LKlOQIruaEQgh+qMGvYASqzDHx
	GHS/Mhp9Qt8bz4vo17V+ZBOgV8aPvNp3Yc4IrtHBXy5KklqxBsYUXFOoE3KVNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706344862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f1xXYCs1RO4Eo/Cj/0RqmEflysMy6RqM29l1YXvUmdA=;
	b=1TSlJ3pYvAwKgnB+c9kr9M1yvVekj0ft3V6CeKRMyuUDR8wa4KX53hmIDRhB7w4fOpgZOh
	pvsuiMByDx+SDhDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Mike Galbraith <efault@gmx.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-rt-users@vger.kernel.org
Subject: Re: [ANNOUNCE] v6.8-rc1-rt2
Message-ID: <20240127084101.f73kztDS@linutronix.de>
References: <20240126163725.kQgJktTk@linutronix.de>
 <c6aae9bc01baa058c2e572a8b27b44f0e6ec7ae3.camel@gmx.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c6aae9bc01baa058c2e572a8b27b44f0e6ec7ae3.camel@gmx.de>

On 2024-01-27 05:38:25 [+0100], Mike Galbraith wrote:
> git@homer:..git/linux-2.6> git describe linux-rt-devel/linux-6.8.y-rt
> v6.8-rc1-rt1
> 
> Hm, git.kernel.org must be doing its nails or something.

it wasn't the nails, forgot to push.

> 	-Mike

Sebastian
