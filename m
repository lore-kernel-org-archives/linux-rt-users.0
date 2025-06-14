Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177652E11CB;
	Sat, 14 Jun 2025 18:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749924795; cv=none; b=k4W4mM+9JkqXjqO1KWzuraYMFD0iABEEmrv6whs8QEy3H+aO41TPQRGT1TrxwvoiqzRII2pE7RNVmOlXKCIe/FEQfzuObWs8vl3cDSmhFGKXGcMK1bpJGXhOsZ41OeLgRU62K+fwAuw+Lw1O90N2vSKbE2CJx7pI1bn5h5rotRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749924795; c=relaxed/simple;
	bh=rlmbF4zigqLq6m1FmysOfquTnG8xp6m9P7s7mkUUx8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVYQsXzCoZRt/jkyRm4a7eg5/0OYY/5KjRyF8hIwGcfYvwRqTDIJ1tFobwQFOpcRV1HErTwE3RQcMttKThCBBWdh/1LnKWeGGBCWXw4C4RXfR/ouW/vsQ4Jz2QjobU2YigyCnjM96BKhOh0xUHWTFZP8X/awhTS+h1I61vueoHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m5dftfq4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J0pKpUa4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m5dftfq4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J0pKpUa4"
Date: Sat, 14 Jun 2025 20:13:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749924792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rlmbF4zigqLq6m1FmysOfquTnG8xp6m9P7s7mkUUx8o=;
	b=m5dftfq4HEtKgx+K919pvAHVnLGK1Lcxv7bu0rVqUD7P9eLCtqR4IfIZygyL4ghqBzXPmp
	51YXYE/WwVi1t3RMRft7CADmxsVvAZYai8wGEDZxPZbz5hcWXICJbLyqq3ojONE6CuJYZK
	XfaU4wjxHdtWowog0Lrj4tOVbA6In1wQSCejaNrPC0UGpLX2vLLbEo8DWpmijJmyY4l7wS
	bVAdIWnX/7ydikgKZeO25+bnAee/Fke1HVfEPM8oTmzEOah75nu9yYStQgIsttt4MRoEVD
	7uLcp9WllmcL1hoCwBzAx3Xs0udVg85uVDoNv6tKxU509RjjY5ld6UAwn+/vEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749924792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rlmbF4zigqLq6m1FmysOfquTnG8xp6m9P7s7mkUUx8o=;
	b=J0pKpUa47IxJcLnVy/GIcFx4ZphfRJEEZVrA8f1PqJqm5HaLAEU1tszcYHvTjTQU97F+AB
	ZhOLOngoQQXonaBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Marc =?utf-8?Q?Str=C3=A4mke?= <marc.straemke@eltropuls.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: Latency spikes on V6.15.1 Preempt RT and maybe related to intel
 IGB
Message-ID: <20250614181310.08nm0KnL@linutronix.de>
References: <cb0d6ffc-acb3-4974-8f93-c86a6479109b@eltropuls.de>
 <20250613145434.T2x2ML8_@linutronix.de>
 <522704b0-5a35-42c3-9bcc-627b487b740c@eltropuls.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <522704b0-5a35-42c3-9bcc-627b487b740c@eltropuls.de>

On 2025-06-14 14:59:43 [+0200], Marc Str=C3=A4mke wrote:
> Hello Sebastian,
Hi,

> Am 13.06.2025 um 16:54 schrieb Sebastian Andrzej Siewior:
> > > I have attached my config for reference.
> > There is nothing wrong with it. You might want to disable NO_HZ (and use
> > PERIODIC) and use HZ=3D250 (or less)
>=20
> I am a bit puzzled by that. Most advise I have read suggests disabling the
> periodic ticks to decrease jitter in an RT Application. What is the trade=
off
> here?

TICK =3D periodic does HZ timer interrupts a second. Each timer interrupt
serves possible timer_list timers within the kernel (not user space
timers such as clock_nanosleep()/ sleep from userland - those are
scheduled accurate). It also does some time keeping and accounting.

TICK =3D nohz makes it possible to skip ticks if the CPU is idle. A
notebook CPU which has nothing to do and goes idle could stay longer
idle because the HZ interrupt will not wake it up on the next tick. So
it can stay longer idle and safe energy.
If the CPU does not go idle the timer tick fires every tick.

TICK =3D no_hz_full you can disable the tick if the CPU remains in
userland for longer period of time. Remains in userland means it does
not call into the kernel.

State tracking is higher with nohz, higher with no_hz_full. Most RT
applications are periodic. Cyclictest should show you lower numbers with
periodic than with nohz.

You can monitor the timer interrupts in /proc/interrupts and compare an
idle CPU vs one that runs an application (which does a busy loop).

> Marc

Sebastian
