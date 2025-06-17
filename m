Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BD028C5CE;
	Tue, 17 Jun 2025 09:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750152498; cv=none; b=SDxCj/LyxfmUBIpRwvW+F6gN8m4nQ9Bo5Ltc7XOd6LG8ue3pQHfo1/+XzfE6nVMVj+3CaAMdHCY9IJjWiydJh13QLe2+US8qq4CFK+okPN5YwxYnGB0JaCfLOt/RovkYo0DPk5l8CVxMJsXu+7adY8vBowmPbe36XmnT/IWq3n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750152498; c=relaxed/simple;
	bh=T3wum0enJG064nH8zdAJ4uRXmehFM7Vl31QCgPqyNKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cuLlLN8BbegkMNWRAacD+o4yfQ3qnunktj0A/6Njzp73mJyo2CxiVqqG8FSLKie6kTsTYNUAcq1fC4fApBg3OgKkEEC0apD0xxlaK2GMNqT2whZLlNeVlsEKCk1QcMh68/xO6mmqGB9fUdsBEvBDHzS6au2ZjB+xSzTRwhzsf9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MUhaeE1Q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BvhEgKhz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MUhaeE1Q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BvhEgKhz"
Date: Tue, 17 Jun 2025 11:28:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750152495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y9RvSFaMft5Al1I2SaDO+RM8Vki7rQQ2Bs5hM3aiiPA=;
	b=MUhaeE1QgdkPinYBC3+Jdg66DjXhdQAYTE3HauZXGpKz2fVIIxzoHzGF1/kmMc72ZmlKjE
	LILpD+8iT811B3x4Yg3yUIYZRPSCmD7Q7BgHYFuVmsW/0ztPgny4Jx34M9UcqKIpIXau4h
	W9cvexecDhbv3Tz2nj+ubKs8ZKixJM0BZp1nDtgclPvVwbY/7za5fBwq1RdwgBi63UouCf
	hbcY34TNFnmHcpKzA5Ed+UQ/+/iZMvwdVg6eCDMylHfITXxIzzEY9R20w5LJMaVLHicTvc
	lMhBwL02gwccHlt/xfA1elIQlXK3nxpYo7e+hpzfEd/AXzlBheXGE19AOchOAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750152495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y9RvSFaMft5Al1I2SaDO+RM8Vki7rQQ2Bs5hM3aiiPA=;
	b=BvhEgKhz3tE1rF/1NpKOLu7AJWCxxkCy4SpNStthqPwKFPpsQO89tSmVTMqdPZ9eFZop/P
	r1wQOr/sAM5I9dBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Marc =?utf-8?Q?Str=C3=A4mke?= <marc.straemke@eltropuls.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: Latency spikes on V6.15.1 Preempt RT and maybe related to intel?
 IGB
Message-ID: <20250617092814.vqKdu23w@linutronix.de>
References: <20250613145434.T2x2ML8_@linutronix.de>
 <E1uQ6I0-000000003aa-37uJ@smtprelay05.ispgateway.de>
 <20250613195838.0-gZ6bqS@linutronix.de>
 <97638b0b-cd96-40e2-9dc2-5e6f767b90a4@eltropuls.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <97638b0b-cd96-40e2-9dc2-5e6f767b90a4@eltropuls.de>

On 2025-06-14 10:52:36 [+0200], Marc Str=C3=A4mke wrote:
>               ip-4931    [001] b...3   700.149995: igb_update_mc_addr_lis=
t <-igb_set_rx_mode
>               ip-4931    [001] Dn..3   700.150795: irq_disable: caller=3D=
irqentry_enter+0x2a/0x60 parent=3D0x0

Between those two functions you have 800us delay. Interrupts are not
disabled so the CPU stalls. As explained earlier, I expect the read on
the bus flushes the writes causing the spike.

Sebastian
