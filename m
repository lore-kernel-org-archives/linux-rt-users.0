Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EE322331C
	for <linux-rt-users@vger.kernel.org>; Tue, 17 Jun 2025 10:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750154725; cv=none; b=nPPQkJdrw2ytpfDZ+LPTC8n/4BvQvhEnsKtkcfj0Jwn0C840BZwB2BKEmcJkcRXRdkaNOrdn07HU2BIM8Y3zMvdQVu4abrfanRLyLA1lOvLYoJeF6lrRF+GS0vFKwfLFM81En0pxUIacZE4WDmotxTmB7UwOtCNCxUSIlyoumoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750154725; c=relaxed/simple;
	bh=EsMA+7Y9M3LQd4bBYbIadK9NgUCB9gFU8G5GWSwt+O4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=neCQA1sDBAxIO81Uj/7goit4yVzJsIgLsVX4aUvhSOrC/sqObDKObb38lGiUifDwqUw8hlYU2nNlI1V5/vSbyzRICsFnMo5oR96N66Wb9zp03uYEDZx+rFwrc7uj2YEHqXCzM3ZRlwIXSKuxm7ZV3kY9RLBWQahFYccD37Co0W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3b9hoqIv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lrDAecHd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3b9hoqIv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lrDAecHd"
Date: Tue, 17 Jun 2025 12:05:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750154722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aUIoEXLtTFyLBrKCun0iiqrAXJT8m9HK4EwKs78wal4=;
	b=3b9hoqIvxY3SL+L+drVfNdVob4LUzmCUI9Z7IUPOo8mTPu0RI1wkAdn+cE9ius2IsJfIe3
	GkmyVvuRqcnV7jDy1LHwsZ414EpQeE65YJc2H1ixjNmPIAt1DMVGMRGXzVX5v4A6so05WZ
	mzYLmVmSF0ug3STwfLHnJJjgQXok68Ber3xvYKWqaxISJ6tVHuwHbi8E0iLInP6ntT/Vgl
	p5Htb4XZr5aN+3pGx1VE6wZRQy92NlYsTZFyzF6WQrIkZkCi71LzqmIJOErmXIlac9G/Xg
	HOmUoHE9l95xTo/Is4evKqoB3gMUOD/cpLw+WAp5miMDsu8VbOiTE9shQz5LhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750154722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aUIoEXLtTFyLBrKCun0iiqrAXJT8m9HK4EwKs78wal4=;
	b=lrDAecHdYg0vtTDsdbXVQU6yJTBxn/1ToA+NggtQq8qR1tp/26R+CHRng1zrWXWU4upPee
	ui6/EFldxN0254Cg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Michael Schanne <michael.schanne@gmail.com>
Cc: linux-rt-users@vger.kernel.org
Subject: Re: liveloock using PREEMPT_RT with i915 driver
Message-ID: <20250617100521.6EW6IWXh@linutronix.de>
References: <CAC_kJhQcdP5=0fcWAuXaJ=3Hxx1TwX5WR-UgS=EHuQeqckhZmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAC_kJhQcdP5=0fcWAuXaJ=3Hxx1TwX5WR-UgS=EHuQeqckhZmg@mail.gmail.com>

On 2025-06-15 22:06:31 [-0400], Michael Schanne wrote:
> Hi all,
Hi,

> I am trying to use the 6.12.28-rt10 patch in order to have both the i915
> driver and CONFIG_PREEMPT_RT enabled.  I'm encountering an issue where my
> application's GUI thread is pegging its cpu core.  The event loop keeps
> waking up although there are no events to process.  A vanilla 6.12.28
> kernel does not exhibit this issue (both with PREEMPT_RT/no i915, or with
> i915/no PREEMPT_RT).

Do you use any realtime priorities here or is this all "normal"
SCHED_OTHER processing with no extra tweaks?

> Some things I have tried:
> - Blacklist i915 module (corrupts display)
> - Pass i915.enable_psr=0 and i915.enable_dc=0 boot parameters (no effect)
> - Force software rendering with LIBGL_ALWAYS_SOFTWARE=1 (no effect)
> 
> The target system is an Intel Skylake i5-6500TE CPU (I also tried a
> Kabylake i5-7500T and it also shows this lockup).
> 
> I have attached my kernel config for reference.
> 
> Does anyone have any suggestions on how to debug this lockup?

If nothing pops up in dmesg, could add CONFIG_DEBUG_ATOMIC_SLEEP and
later maybe CONFIG_PROVE_LOCKING to see if the kernel complains?

> Thanks,
> Mike Schanne

Sebastian
