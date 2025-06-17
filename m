Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07F228B3F9;
	Tue, 17 Jun 2025 10:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750154418; cv=none; b=oZRvkX78N58lBx9YvxTdK756K7t2Xt/zDsSxu3tq4brtHf0KYbUkxXxHT9k3oXEw6KKeHXvZSSInxq47mB5I9W6LOZFNiGpnxbR1S4hte9JIqdZno2rMPsfap00r46t8yNSpsd/3wYtzypdP6+dMlFVqwvyZ4p+oQIZ+6wO17vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750154418; c=relaxed/simple;
	bh=f19g9E++oiCOV6aofv7KnqVQbAFQx7H7h2E49vXYj94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmV4heB1ePGFmznmeMJ12o0wbehggKOmTugs5SGG6gfBFooDUs0rFd6umo+3ssZZL/AyWsRkbllW9cefl4IQ1tdlmwm6NSyxSopnh1ITVGCCUMHDAzdbl0RH7VJFFJ/bYr5+LOD0fZN5bba5Z34df4QMFvjSUCSJMrBLPFtBxxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qu3ksYk6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=khnOWno4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qu3ksYk6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="khnOWno4"
Date: Tue, 17 Jun 2025 12:00:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750154415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f19g9E++oiCOV6aofv7KnqVQbAFQx7H7h2E49vXYj94=;
	b=qu3ksYk6SV7x0SKs36RpIvZACWbB2Rz/S2aDdiuTpwo9RMpRgpUtKy19jYQJZUSTj05zgg
	9ebqZeO+X3AZJypTuwFmp2Fn7+/vBKxPnvr10EZ3fKLzw4AxEpAuAXes5wDMYZcG8SOoaQ
	nG0hpPcZL3EfOVL0Rtz8Q2JYVwD445cdSt1NI31wKC9uyt3PBrsEHuWD0ogfwGt5iYr/Is
	iPPKB7c9x6Zs3GmZxhjPaquRzhfKiRJG+Ur/7jhuvCvJf9pF+OEhwXDySysqY+RkEtx5CT
	RVx848A95jbzZQN9IUAziMuqTSY5RIy0LDmxWLwijEFyPkL7GisF5KFpBJmRng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750154415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f19g9E++oiCOV6aofv7KnqVQbAFQx7H7h2E49vXYj94=;
	b=khnOWno4XKhgKO2W5Q2ioFlopW34PvODVzBDHUWjBid+rb6SNJ4vHh4TjVtsZ6Z4hxEYfr
	/EEqLPIt2w12QkDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Marc =?utf-8?Q?Str=C3=A4mke?= <marc.straemke@eltropuls.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: Latency spikes on V6.15.1 Preempt RT and maybe related to intel?
 IGB
Message-ID: <20250617100013.1o5lsPLq@linutronix.de>
References: <20250613145434.T2x2ML8_@linutronix.de>
 <E1uQ6I0-000000003aa-37uJ@smtprelay05.ispgateway.de>
 <20250613195838.0-gZ6bqS@linutronix.de>
 <97638b0b-cd96-40e2-9dc2-5e6f767b90a4@eltropuls.de>
 <20250617092814.vqKdu23w@linutronix.de>
 <bb74b5b6-bc23-4aa4-83df-449dc7c9006b@eltropuls.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <bb74b5b6-bc23-4aa4-83df-449dc7c9006b@eltropuls.de>

On 2025-06-17 11:45:52 [+0200], Marc Str=C3=A4mke wrote:
> Hi Sebastian,
Hi Marc,

> On 17.06.25 11:28, Sebastian Andrzej Siewior wrote:
> > Between those two functions you have 800us delay. Interrupts are not
> > disabled so the CPU stalls. As explained earlier, I expect the read on
> > the bus flushes the writes causing the spike.
> >=20
> So the delay you think is really the hardware(CPU) being stalled on the b=
us
> for so long? Or do you mean that this is the reason for the long runtime =
of
Yes.

> the IGB function only?
Both. The bus is flushed, the CPU stalls until the end and then the
function takes long _and_ the due to the stall the interrupt can not
fire any sooner.

> Shouldn't the other core (it is 2 core machine) still be able to handle t=
he
> timer interrupt then? (I did some testing with isolating IP on one core a=
nd

You have two cores and two cyclictest threads - one on each CPU. This is
explicit per-CPU. No migration between those two cores. Timers for CPU0
are always handled by CPU0.
Even if CPU1 would handle CPU0's timers then it would wake cyclictest on
CPU0 but that thread would have to wake until CPU0 is done with the PCI
bus. CPU1 knows nothing about it.

> cyclictest on the other, I am not sure if I moved the timer IRQ to the
> second core)

> My mistake was to search for where the Interrupt was being disabled in
> Kernelspace (I did not think that the hardware could introduce and IRQ de=
lay
> for 800us..)

Yeah.=20

> Marc

Sebastian
