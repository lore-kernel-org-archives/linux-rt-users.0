Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EA82D97BE
	for <linux-rt-users@vger.kernel.org>; Tue, 11 Nov 2025 13:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762869521; cv=none; b=h3rxAD+FoF7uIUQCv/YvRizc0hA9slGM06f/nGgKdIGfnC7WMn02y/DuNcRf3S+urcVHb0HasX7I1CQFJZd5aoum50k779+XXKGo+OSHkSYlUuXp1lTZQddJyTqlPYxIlclCje/BAPJwjQxHkxK/nu3TSoD6D8vXgIJlTV6uBgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762869521; c=relaxed/simple;
	bh=GfIiiWg6XJAhqM2bYjOwjWHy46cmykTxSQ49Vu/As+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRcj/1/UcuHq8QAy3wDHvSvn1JVfVLVoQZTPCf/lObhGXFJipgr6J2iv8F+m+9mucXqp0WprYWM1BngjLDA1GwLxStyH2inLCTnCyZvK/eNFAgGrQs2AhiTkvpVDPG2aVWyC31Q7QEhByMatCO+/6RD1kPfYFXlFEpsfuY4TxDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UCLdiMle; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qygg5L0a; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UCLdiMle";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qygg5L0a"
Date: Tue, 11 Nov 2025 14:58:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762869517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=84MhAG8Klw6HKIW7fNjqmMtQzTRayKTfMI7/B9erLzs=;
	b=UCLdiMleDQ9BkPRTiOI6gStbzC0EYzHwSaX+Jwj3IFbT+EErIwXwx/svTAtQVVEom0nXOv
	P+qU+vO76fSb7jZmiAAsTrQOKw07YtJrxjdD/0MwoXaR5mXtQg5UeIy9XBDTiyy3p/JNr2
	609MaWje6UR1ASeGApxzl8c02JkIiQFla9qL+QGKGiALi6nBV5aJEHqLn/FZrBIIkdht83
	p/0eHY3aBRvadnYI31rkgZ34s1GqectUCqsqks5o7GawwlC6pMUhRg6X21Yww9CVoDtl/U
	zoD/3bmpDhjzm/OXONhxNld3wNbk3oy1XmmbUh6uDRaQnX+nryY+g0zrlTgYNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762869517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=84MhAG8Klw6HKIW7fNjqmMtQzTRayKTfMI7/B9erLzs=;
	b=Qygg5L0aExWRVz6KCtmKfBzwhsaBLMD1f5KAKpPmQTjMZbIIO8Ih2Eb9uQWpPqvDqEfpeu
	Z95CChPJDMuNFPAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: "Preclik, Tobias" <tobias.preclik@siemens.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: Control of IRQ Affinities from Userspace
Message-ID: <20251111135835.EXCy4ajR@linutronix.de>
References: <a0cad8314124ca98d7c6763e3e08d7192598cf92.camel@siemens.com>
 <20251103155322.Aw9MSNYv@linutronix.de>
 <3cbc0cf5301350d87c03b7ceb646a3d7c549167b.camel@siemens.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3cbc0cf5301350d87c03b7ceb646a3d7c549167b.camel@siemens.com>

On 2025-11-03 18:12:48 [+0100], Florian Bezdeka wrote:
> I'm trying to jump in and adding some thoughts and results we got while
> analyzing this issue:
> 
> What stmmac (and some more drivers) are trying to achieve here is some
> kind of handcrafted IRQ balancing, like the good old irqbalanced did in
> the past from usermode. Turns out that the situation about IRQ balancing
> is a bit inconsistent. Some IRQ chips (like the APIC on x86 do that
> "automatically" on driver level, many others don't. So drivers end up
> fiddling with affinities.

Doing it once during startup is probably okay. The problem is probably
that it forgets everything while it removes the IRQ and requests it
again during down/ up. It guess this is simpler because the number of
interrupts can change if the networking queues have been changed. And
this is probably also invoked in that case.

> We can nicely tune IRQs and affected affinities that that have been
> requested during system boot. Tools like tuned can configure them using
> the APIs Tobias described. IRQs that are requested / setup after boot,
> during runtime, are kind of "problematic" for us, as there is no API
> that informs about new IRQ. We would have to rescan /proc. But even if
> there would be such an API: That would be too late. The IRQ might have
> fired already.
> 
> Once an affinity has been set (e.g. by tuned) this affinity is being
> restored when the IRQ comes back after a link up/down or bpf load. But:
> It might have happened that the situation on the system has changed.
> Even the default affinity could be different now. In case of the stmmac
> - and probably way more drivers - the default affinity is not taken into
> account anymore. The previous affinity is being restored
> unconditionally.
> 
> I tried to modify stmmac and let it evaluate the default affinity while
> doing the IRQ balancing dance. That turned out to be working at the end,
> but each line violated several coding/style/abstraction rules. There is
> no API at driver level to read the current default affinity - or I
> missed it. I could sent that hack out as RFC if requested. Just let me
> know.

Several driver tune the affinity based on what they think is best. The
usual is we start with current CPU and increment the CPU with each
queue. This is not unique to networking but also happen with storage.

But we do have the "managed API" already.

> Thinking more about this problem - and trying to abstract that in a
> generalized way - triggered some ideas about "IRQ namespaces", similar
> to what we have for CPUs/Memory/... in the cgroup world. Devices, or
> classes of devices could be moved into namespaces, instead of
> configuring them one by one. Thoughts welcome. The main challenge here
> is that we do not think about rt vs. non-rt. It's more about multiple RT
> applications running in parallel, well isolated from each other and the
> non-rt world.

The excluded "affinity" would be a good place to start. So if you have
16 CPUs but declare only two CPU as housekeeping it would sense to limit
it to two interrupts if possible. Otherwise shuffle them among the two
available CPUs.

> Florian
Sebastian
