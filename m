Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794BE304969
	for <linux-rt-users@vger.kernel.org>; Mon,  3 Nov 2025 15:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762185208; cv=none; b=CH3/OtD/CjDIn9YL03GFS2UUSN41LLIPTO8eOdml0gR5BIV3ULnbezHYFomXkg7boc+fPX7XoaOTkYk1LEliULfhecE9wlJuxu2XX721G7AUEdeIit5zL57tAdQ21lbp0QuYd8YS9qqrVVI8GIz2yQ3XijA95eM3RBR8zReNIDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762185208; c=relaxed/simple;
	bh=lJqu835B4EzGvTzKx+ZjIyars1vD6234BREEDpyz+bA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n3GkpPT7N4eh5zdevm5X7P4OeI2KS4yZeL2ZaMqq3uLmb6Wv8zXZ0LABjSSO5DllUnLcbqEp6Y8gMTgD4UUb416TZ9fN3z3PsWyjVNzH7VeZTuzk+RsILpyqjKYP//vs7WW4TCbBJDXBglJeczjb5zR/D73sLkKjH6RMFRzlluc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BZI8G/3S; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ltBnQNxI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BZI8G/3S";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ltBnQNxI"
Date: Mon, 3 Nov 2025 16:53:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762185204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3E1GtNQYV+kGIkU3B8Igowdv9Wtu09ZylhEKDlLBaFY=;
	b=BZI8G/3SsRhodVRtKDcNulxC4TJRt1ozww9E6N1doTk6qr9MjBCdt8Z4Oi61jaIdTWh89G
	qCcKL/8KpxsOcUztjafp6USncXbIeMuYwgwOzhTSKyjnOe+rm+PnYDps/nJN4S0HYnHJYo
	18s0kNg7nAS44q7P1NmS1R2ogI9Kf5Zt/2Mz2kC7mZsRrwEr28kqIkPPH1RAttq8xTtPcP
	s0cGpooXU6TTavvT/X5ET+wVAsbljWmz1KlE3J40RHIt5x3wPPhAdWLXlRhpjKg9cTxJab
	W6gSizgJCiRkgExIf9nHnB0VoMW8AZCrDpsMB2ZhOQMJKWV1B8joVc2ptVLkcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762185204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3E1GtNQYV+kGIkU3B8Igowdv9Wtu09ZylhEKDlLBaFY=;
	b=ltBnQNxINT7P1mXXHflKpRYf/h93N0FvsDVta3D5dHoMjtBnZQvqH0Roi23BDkEt78lJG0
	ZZ9rPPS4A17AKdBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Preclik, Tobias" <tobias.preclik@siemens.com>
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: Re: Control of IRQ Affinities from Userspace
Message-ID: <20251103155322.Aw9MSNYv@linutronix.de>
References: <a0cad8314124ca98d7c6763e3e08d7192598cf92.camel@siemens.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a0cad8314124ca98d7c6763e3e08d7192598cf92.camel@siemens.com>

On 2025-10-30 14:20:01 [+0000], Preclik, Tobias wrote:
> Dear Linux RT Experts,
> 
> the Linux kernel exposes two userspace interfaces to control IRQ
> affinities in the procfs [1]. First, /proc/irq/default_smp_affinity
> specifies the default affinity mask which gets applied as initial
> affinity mask for newly registering IRQs. Second,
> /proc/irq/${IRQ_NO}/smp_affinity which can be used to specify an
> affinity mask for a given IRQ.
> 
> For tuning the I/O path of RT applications we use the second interface
> to relocate IRQs to cores dedicated to run RT applications. However, we
> have observed that certain situations, such as interface bring-up or
> loading BPF/XDP programs, can cause the IRQ affinity mask to be lost.
> Specifically, some network drivers, particularly those based on stmmac,
> ignore the IRQ affinity mask set from userspace and overwrite it with
> decisions from IRQ rebalancing [2]. This driver behavior prevents
> consistent control of IRQ affinities from userspace, impacting the
> tuning of the I/O path for RT applications.
> 
> I would greatly appreciate any comments or guidance on this issue.

The usage of irq_set_affinity_hint() is not uncommon within the
networking drivers. It is probably a pity if the request happens on each
ifdown/ up but in this case it happens each time you add/ remove a XDP
program.

But the interrupt should be managed by the kernel. Looking at
irq_do_set_affinity() there is:
|         if (irqd_affinity_is_managed(data) &&
|             housekeeping_enabled(HK_TYPE_MANAGED_IRQ)) {
|                 const struct cpumask *hk_mask;
|
|                 hk_mask = housekeeping_cpumask(HK_TYPE_MANAGED_IRQ);
|
|                 cpumask_and(tmp_mask, mask, hk_mask);
|                 if (!cpumask_intersects(tmp_mask, cpu_online_mask))
|                         prog_mask = mask;
|                 else
|                         prog_mask = tmp_mask;
|         } else {

so if the IRQ is managed and you have IRQ isolation enabled then it
should exclude the non-isolated CPUs. Would that work?

> Best regards,
> Tobias Preclik

Sebastian
