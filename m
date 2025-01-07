Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596F61F237A
	for <linux-rt-users@vger.kernel.org>; Tue,  7 Jan 2025 14:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736260782; cv=none; b=rz3loGAS8wd3b5yZYqVTcv2XvgagaqVe6cfUGecOHl7XqLSNmf6QUOPXX5rZ2zZn5hEbfA03asL+OiyP98jgyr4XEwGmMd8tEcCfnC/gYeqXVAIRukXoLCIm078AUBlyKbEqWk3xJjTkCVge9/XzqeMQz8ysu/FbgHCn5yzTjUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736260782; c=relaxed/simple;
	bh=1cGaMRW0t2sqChUL23mVs4LMUvE5VvfnKWa0j5AINX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VFm/4qxOvfQ9rcTE+GpDLlD/psjGhqixDDwmMioo5Y/0LXuI6z3FNoxMaZeb5Xf9/cQnifuxf4+fhioCpQnQnp6I1Q5o/sQUYyyTFxpZ8FtvcfaiFB5ij9IyLU8K2N+6T3eHigkmvzM7/AGnAgyc5g45sSO4rbl1LUjNRGkbv+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rAjkh3ks; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iw7ycnmL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rAjkh3ks";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iw7ycnmL"
Date: Tue, 7 Jan 2025 15:39:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736260778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9dgYQS+2HsQZvlQIA2VO6ZpPUh52r6FanSmbzfGhYeM=;
	b=rAjkh3kskQdfMElh6wLV1/efzjt0oFkvRC719IxBsxbGETBPAjfIBS5YMzxGJ/W/RsWGTD
	YB2gk/G19wXQ7sq+qrCARq0QGdGn+cXcBMwYtk/JBH4+piHDilgn7C6Fr/1uZ0EoozQ6Ce
	eHGdSDaXWOHQdQ5sHEQ5Gu17N6bVfMG+VD58pUXqMQ4KVY6jOxI70Zgb2tUZXX1neOIf1w
	GNXtEDykhlhHUgGP8sdlVHKm/FlZUXFNl8+E4+43b9LehgSsMKyQqT9QMcUyt3CKr0gEEL
	E4d+PUKH4xitTt5SCyfjZaDkU/MBIYtoOKTKPEl3ooWI3o+1RnMWIV1b+a+n3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736260778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9dgYQS+2HsQZvlQIA2VO6ZpPUh52r6FanSmbzfGhYeM=;
	b=iw7ycnmL0i6d+Dc4nRn5WlY4tfmOW8+6GzH1rpj6lQoS1uRRQ2z4AKp1xq/okwR0dhUECu
	LhoBoInJ275EndBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Florian Paul Schmidt <mista.tapas@gmx.net>
Cc: linux-rt-users@vger.kernel.org
Subject: Re: Raspberry Pi 5 and PREEMPT_RT (6.13.0-rc3)
Message-ID: <20250107143937.d_ho7CXb@linutronix.de>
References: <d445e582-4e49-4135-9d94-f52d72ec5df6@gmx.net>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <d445e582-4e49-4135-9d94-f52d72ec5df6@gmx.net>

On 2024-12-20 14:18:43 [+0100], Florian Paul Schmidt wrote:
> Hi!
Hi,

> I'm playing around with a Raspberry Pi 5 and a PREEMPT_RT kernel (raspber=
ry
> pi 6.13.y branch) and wonder about the latencies I see. First I tried
> cyclictest and saw latencies in the upper 50s up to 80s or so under a
> kernel compile load.
>=20
> So I compiled the kernel with timerlat and osnoise tracers and ran a bit =
of
>=20
> rtla timerlat top -a 60 --dma-latency 0
>=20
> and I get traces like the following:
=E2=80=A6
> ## CPU 3 hit stop tracing, analyzing it ##
>   IRQ handler delay:                                         0.00 us (0.0=
0 %)
>   IRQ latency:                                               5.16 us
>   Timerlat IRQ duration:                                    47.41 us (42.=
53 %)
>   Blocking thread:                                          50.50 us (45.=
30 %)
>                           stress:278226                     50.50 us
>     Blocking thread stack trace
>                 -> timerlat_irq
>                 -> __hrtimer_run_queues
>                 -> hrtimer_interrupt
>                 -> arch_timer_handler_phys
>                 -> handle_percpu_devid_irq
>                 -> generic_handle_domain_irq
>                 -> gic_handle_irq
>                 -> call_on_irq_stack
>                 -> do_interrupt_handler
>                 -> el1_interrupt
>                 -> el1h_64_irq_handler
>                 -> el1h_64_irq
>                 -> folios_put_refs
=E2=80=A6
>   Thread latency:                                          111.47 us (100=
%)

The backtrace appears long but everything up to folios_put_refs()
appears preemtible. Then there is the interrupt handler. This looks
okay.

> Max timerlat IRQ latency from idle: 1.98 us in cpu 3
>   Saving trace to timerlat_trace.txt
>=20
>=20
> OK, here at least something related to virtual memory is happening.
> I still wonder though: How come the latencies are so large? Is the
> raspberry pi platform just not suited to reach lower latencies? Is
> everything working as expected? Are maybe the raspberry pi
> patches responsible for latency sources which are invisible in the
> traces? I there any hope for getting these latencies a little more
> under control?

Based on this trace, I don't see a section which disables preemption/
interrupts and be the reason for the interrupt happening.

One thing that could delay your doing are small caches.
Then there is looking within the system: An inaccurate/ low resolution
clocksource and/ or timer device.

> Kind regards,
> FPS

Sebastian
