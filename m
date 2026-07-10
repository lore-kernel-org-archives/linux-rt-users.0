Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244AC4343F9
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 15:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783699072; cv=none; b=sKas006Fu/P15Au40WHHsgUApTw9GUGOowXk/4GJfjBFrKE8N5uuC1Jqxuew/rn3cBp9TtWyCW5ViDGXh5Kn1OnEv5VYG9r6jpKyuwbI28ikh9cnjqyHWGGkGTZwsam4V0pJlLFxiubOZsJBkflBg44ExWsl8NRVj1xpIZymo/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783699072; c=relaxed/simple;
	bh=DdZkj1t+YTdv4lhLH0M2y9omD0U+OijZxhEEAiSHUW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCBjPBl+G8aEAGTjkL6mPUPVKWXs18qDJboDs7EF4Z2ME+BH0i4rMHs4S1p+B2AHPCvY48GPT5ZlWBf42XCIyNVQt9j49qnSD1SkWIJcj0NzPyoB7spwx55dSLp0mqQDXRSRL/IIHu5I64jecxBAAOt9HXMZM5jO2YHJV5fd2eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QIpR1Grh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OusP/pyX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QIpR1Grh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OusP/pyX"
Date: Fri, 10 Jul 2026 17:57:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783699069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+PWBQnjpjM3noppY6fe5xm8QlJvFDQRgM8OSC4p6tbo=;
	b=QIpR1GrhFCHRbIiqPrab0c6viqd3sfuUb8yHBKY9lyjKnfnMuTx6RWB1EtuZrNSZibkRKA
	lKpF+Py03NcCqJV1FbA4UncwpvuojxHTnL4G0Ix0e3wXRDazRjLdKOi2s7f/FJCz6yBNq3
	m2RYcuNwswQTsYZkikdLq3bmaQM9zj8F/qAz6W5tNX+PBCWNJNOBSwTC5LRFE9GliqKfv8
	ghyu+JrG2Ie9yIfga2Ggluv1Ivgua+B2CFGR6kJ5Nu6ueuKO/l6FJRoOoCIUrynDlAwsvT
	p0DSOnc6d4Jsvis5Gs5zCh8mjSwTFqPLTb4XthF2yFz1MNeDARRaiwBL36puiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783699069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+PWBQnjpjM3noppY6fe5xm8QlJvFDQRgM8OSC4p6tbo=;
	b=OusP/pyXcFU/Govzi/x77zqVmOfBkl5Bpeqq46ohtMWLj7tL701EM9yr08qyUyNeG+xAiS
	asLQ/QAYRp6owTBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	driver-core@lists.linux.dev, linux-rt-devel@lists.linux.dev,
	linux-rt-users@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Clark Williams <williams@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [RFC PATCH] sysfs: Add /sys/kernel/realtime entry
Message-ID: <20260710155747.0HAm5jm5@linutronix.de>
References: <20260709143108.UYeCUUcd@linutronix.de>
 <2026070922-kilowatt-matador-5e1c@gregkh>
 <20260709152214.rH1O_8SM@linutronix.de>
 <748a489687000b21d0e8f961fc2f9f963b0bc1d1.camel@siemens.com>
 <20260710115145.32729a7c@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260710115145.32729a7c@gandalf.local.home>

On 2026-07-10 11:51:45 [-0400], Steven Rostedt wrote:
> On Fri, 10 Jul 2026 09:23:16 +0200
> Florian Bezdeka <florian.bezdeka@siemens.com> wrote:
> 
> > uname might qualify, yes, but keep in mind that this sysfs based API is
> > already used, so a removal might break applications. Yes, userspace can
> > be fixed / adjusted, but it remains bad style, no?
> 
> Then at most it will likely just stay in the -rt patch set. As it was never
> mainlined, it's not breaking any user space that uses only the mainline
> kernel.

And I am thinking about dropping it from -RT queue.
The -RT queue has the 8250 (which days are numbered) and i915 which is
making progress towards upstream. Therefore I want to clarify the status
of this.

> -- Steve

Sebastian
