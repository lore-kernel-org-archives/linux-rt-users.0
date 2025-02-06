Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986FD18B477
	for <linux-rt-users@vger.kernel.org>; Thu,  6 Feb 2025 12:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738843531; cv=none; b=IowdB/az0YXplqMJTUBKtQm0YhlJPy9+MLB9ayuUNRtEbHajvaw8oU74w5N7oWNBRxXSZQf/+Ev6r3/IOVtUU/lFvvlRNlp+lQTxAS+qX9JVKM9fubHDv7zq+ZrthN0lHi84h2bHL2k/0+hLZkoIAQpzYBzSDydqqsMq1RRA7ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738843531; c=relaxed/simple;
	bh=fdoMBK9Yz+J9z5x/02ARsjqr5iN/5OUaxfi40djSlU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=muedbp+4e89A+wDmbDkT3nUZb3T1cRAaztdFmEr6bt4UasGJhBrtCgffq03X4MAuCNMceL4jieK1pwyYK3jl4QIcG+d1Yo5wCu2h8QIlZPx3TFCgtmTxSsY+2F2TPf2q1U56LhAZQgVMVS+e+yk5nU+l+TFUDOp49vntKM4dp1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XEprdHSd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o/LBw5DG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XEprdHSd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o/LBw5DG"
Date: Thu, 6 Feb 2025 13:05:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738843526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IGGdAYsAMU22HAmzcs2VnFsXwLPTZ4BPWuAn/QYssQY=;
	b=XEprdHSdEHkS38s3nk64x0zYS1Q58aE7dDCPzwbijzDmONMYiB/mu03it65w2DwflrpW4o
	ZrhrxjGQAlVfzWHq/xl76nvvsgMK4OpQp2w+glv19khotoLOiL1quvpIT3r3fBhawsTNq2
	ZlTiGHvNOs7PTkqAwh+u/QHEjC+fAZP8j7WVTs60o1u/kR7gXJALCRcWmnRYg7GQKLJ1HJ
	sLEbdR9pLNwSw39tZR0+/6JvBHyplZ0VBVauU4If3YkZIx0UEI9soxaQfZ+NUHaMFMkb2z
	WCi5M4Nfc2CsreMOVsb8SKlxqvRhItF2Y+ZlbU8iS/vh+8y9zq30D7TvMAMiJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738843526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IGGdAYsAMU22HAmzcs2VnFsXwLPTZ4BPWuAn/QYssQY=;
	b=o/LBw5DG8AzSCsn4zA7A6c7M0xxdFlL0+AD/jxyNHHOzr2SNjOTjDdYwrcezyEIjgrQSIQ
	gGLtetm39t6wDRAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jillian Donahue <jilliandonahue58@gmail.com>
Cc: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Petr =?utf-8?B?VGVzYcWZw61r?= <petesarik@suse.de>,
	linux-rt-users@vger.kernel.org
Subject: Re: Spinlock in f_midi_transmit causing kernel crash
Message-ID: <20250206120525.3yeIJrEw@linutronix.de>
References: <CAArt=LjxU0fUZOj06X+5tkeGT+6RbXzpWg1h4t4Fwa_KGVAX6g@mail.gmail.com>
 <20250123142324.449f21ba@mordecai.tesarici.cz>
 <CAArt=Li11gQ1XsfpsZuV8afd4E5UjcuHa=r1Ng9q6HG6AjxJWg@mail.gmail.com>
 <20250129103925.7TEmpCt_@linutronix.de>
 <CAArt=Lj5byHfx7SJXzHiB0ecFDWjhjODyM05=5y27PYj8bGaUQ@mail.gmail.com>
 <20250130075026.RVen6mGf@linutronix.de>
 <CAArt=LgTQHaHmBQZkY3APwuRAH=f-4ABW-8f0joQs3JLocZarA@mail.gmail.com>
 <Z6C6ZHQh3jc_iJLk@uudg.org>
 <20250203132232.ZLq9fj5q@linutronix.de>
 <CAArt=Lgo=mXXoFLZx1b0pGruiP2r9g-dmTnfEGzX5N6=+3cmcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAArt=Lgo=mXXoFLZx1b0pGruiP2r9g-dmTnfEGzX5N6=+3cmcQ@mail.gmail.com>

On 2025-02-03 10:50:57 [-0700], Jillian Donahue wrote:
> From a97fceb3e51c478dee6d63caafb92c867432c042 Mon Sep 17 00:00:00 2001
> From: Jill Donahue <jilliandonahue58@gmail.com>
> Date: Mon, 3 Feb 2025 10:46:31 -0700
> Subject: [PATCH] f_midi_complete to call tasklet_hi_schedule
> 
> When using USB MIDI, a spinlock is hit causing a kernel oops. This

It is not an oops, it is a deadlock and in general a lock-up. On
PREEMPT_RT you see this backtrace. Non-RT with lockdep should report
something. I would stay with deadlock.

> happens because a lock is attempted to be acquired twice through
> f_midi_transmit. The fix lies in calling tasklet_hi_schedule() in
> f_midi_complete to remove the repeated call to f_midi_transmit.

s/The.*

Use tasklet_hi_schedule() to schedule f_midi_transmit() via a tasklet
from the completion handler.

> Link: https://lore.kernel.org/all/CAArt=LjxU0fUZOj06X+5tkeGT+6RbXzpWg1h4t4Fwa_KGVAX6g@mail.gmail.com/
> 
> Fixes: d5daf49b58661 ("USB: gadget: midi: add midi function driver")

Way better. Please run it via ./scripts/check_patch.pl. It will tell you
that you need a sign-of-by line. Please check what it means and if you
agree with it.

Please run it via scripts/get_maintainer.pl and send it to that list.

Thank you.

Sebastian
