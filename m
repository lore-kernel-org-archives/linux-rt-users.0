Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22A912CD8A
	for <linux-rt-users@vger.kernel.org>; Tue,  2 Apr 2024 15:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712071213; cv=none; b=kQ45kpj1p9EL/GPdfKtahejusH0Uw6k0j09S2yhi7XwelLoe5ogUHO8JJ6ZTkf9qdNSwkxqaKsGnh8+s1FOX5gjzVXY8Jh1YVvyuip9iwBaLwY1CmnVyuQHTHRnEgl02fqGzpyn7qqUUchC9GfwY+ALo6WO4JPgRGbzue8+WgPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712071213; c=relaxed/simple;
	bh=MZFcjFHP1LHHd/HDIu910NNmnXUHw/NbvXJ1QzqfBjY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kXOJBAv6ib7vhU3KfDEkZNDJ86zwcY48UUyYN7RPD3+cdspoqdps7SwQw3pHl+opnnZ8WiK7LbEeupVuytXf74y0Nlop+rdD/oXnkPixkW+g1uutZjAx+xt5l3WpoPyEz1C+COMxx/NhQ2TmqcFA5G44iTa4O8IBhRHpYp06hdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fLYv3kJ1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GQEthbB8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fLYv3kJ1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GQEthbB8"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712071210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xlyGpK+v9Tk76oONLw/YHim6rQOuHw8/SKg+Q4hcUIY=;
	b=fLYv3kJ1D8TFannk+XVCtRuOu5vVEWLmsoOgV1WGobUaG+qVuFd2Y1sIsIdHiqTVNf0/20
	x9NAKcpHfV3GdgZCLKmXMdgLlE19d13QfQSs5xvOkKfSAZS9TmDMchsBEOISzluaYuSA/m
	WF68EmOaSC5SvCy9UtorrS2Onrvl+YPpn6qG80vUYCWBoIX0GEQsILkboWa/Vp1HhooI3D
	XNVf9wZdEkH7OMxGFmdVpHm78ebru5WwOQy/7TtZh36wGd64XdXl81IoG79g4ZXSPuyVNy
	CjY6GOkP1BdJwm42dHV4uu4E2p0Qvlun5NoxQQAEhceDATTGARy/J4fAhicWOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712071210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xlyGpK+v9Tk76oONLw/YHim6rQOuHw8/SKg+Q4hcUIY=;
	b=GQEthbB86Q/LevnmKg5bPhhJ22Jl/cZnsKG2WmrXIvkjO2mAKzSRAhlM9TJ+rymxvrB5uh
	6dZEQ3dUP4P+JhAg==
To: Esben Haabendal <esben@geanix.com>
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 linux-rt-users@vger.kernel.org, Martin =?utf-8?Q?Hundeb=C3=B8ll?=
 <martin@geanix.com>
Subject: Re: [PATCH 1/2] printk: export pr_flush()
In-Reply-To: <87zfubesih.fsf@geanix.com>
References: <d65ca57567e245aa99a944cefc195f2bc6974384.1712051763.git.esben@geanix.com>
 <874jckqcxu.fsf@jogness.linutronix.de> <87jzlgf1w2.fsf@geanix.com>
 <87wmpfq4p1.fsf@jogness.linutronix.de> <87zfubesih.fsf@geanix.com>
Date: Tue, 02 Apr 2024 17:26:07 +0206
Message-ID: <87o7arpza0.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-04-02, Esben Haabendal <esben@geanix.com> wrote:
> Are there any other examples other than 8250 for how to port a driver to
> nbcon?

No. 8250 is the first example. And even this example is changing a bit
with each new RT version as the underlying APIs and semantics have been
changing.

> What is the plans for porting all of this to mainline?  Should all
> drivers be ported first, or will a solution to prevent this type of
> regression be implemented at some later time?

First off, I want to mention that this behavior is only with the
PREEMPT_RT preemption model. And it has been this way for a long
time. The behavior of legacy consoles for other preemption models is the
same as mainline now. So from a mainline perspective, I would not
consider it a regression.

It is hard to say how this will actually play out though. We are
bringing the printk/console rework to mainline piece by piece. Until now
every piece has needed significant modifications in order to be accepted
mainline. (This is the main reason the 8250 driver keeps needing
changes.)

The updated 8250 driver will be the last piece to go mainline. Only then
would all the APIs, semantics, and documentation be official. Hopefully
it is quite similar to what we have in the PREEMPT_RT tree now.

I hope that once the printk/console rework is complete, there will be a
big push to port over the other serial drivers. Most of them are just
copy/paste of each other, which should simplify the porting. And since
the new nbcon consoles provide real advantages, there will also be
incentive to take on the porting effort.

Finally, if someone wanted to try porting another driver for PREEMPT_RT
(for example, the imx serial console), I would certainly be interested
in reviewing and integrating the patches for the PREEMPT_RT tree.

John Ogness
