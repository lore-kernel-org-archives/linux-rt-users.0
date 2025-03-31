Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014D4AD23;
	Mon, 31 Mar 2025 09:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743412081; cv=none; b=QHgN0avs4HBr2BwGgLQXmCzUEKUJgEQ/zU7xbZZOZgZwHWlVGAlHmvyX2EuGa+2j11+flayc0hqL53yrZCBN92n4mDY1/xnOgBSN3p+4U86QT9DtOpJS9pQ9Ye+HmYZ8o8an5eQtxYRnqLziCpJ/fwk8gIVteyIAExlmadjgZ+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743412081; c=relaxed/simple;
	bh=cJpsG0NuVPyTrNtoLgQWDGGd++w5Px7qO6TwmxaM6KA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4HFzwnQ7jeg/7y4+AU+WAjix9pdM204nspRRLC3Ei4eSsM9gEgcCR6vPrb40mXJ/iP/goWEISxNQrxfztWKosH1pxzwyq79SMe2HyVQzpPGkJW7d5cMj88y+mhTYoUuF2NZiTzOEQo3ZFfgpEbsHaX0H6JIuzySoDsdixECt0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ljapDT1U; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q66gDQxo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ljapDT1U";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q66gDQxo"
Date: Mon, 31 Mar 2025 11:07:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743412077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cJpsG0NuVPyTrNtoLgQWDGGd++w5Px7qO6TwmxaM6KA=;
	b=ljapDT1U59tqFPqTNSUBYDGOV93YFhboQJkTd95+tbNoESkCXOr+YiUuFn/HZRdQ+7GZeg
	HapYHJNVe9jzE2X5qk9aUdQAB2X1im997mh73gLD+XelCoPFM35X/WsbzfSK8K6JzkQtwX
	IRiT9Ks+43+UXItNNPFdbvMp8l8od3ikZI0p8+9vkrgt5AyjsUxcSu6SnOYwHIO92wITeC
	x9SI+r5n4EHS4/O6qmXbem1GgMXoZmpMvWgUMOfFkGCed5jnAcf25yN2QOeYC8SvPdguw1
	r3HbnhdPv4GLMkRygqm7XSGKOsP9f1XPm4UI6lD4vR1Kqm8uKffUfriEgIORvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743412077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cJpsG0NuVPyTrNtoLgQWDGGd++w5Px7qO6TwmxaM6KA=;
	b=Q66gDQxoAFrIFRlfBtupn6o7SJo99Hdz2bxCh9rlU+qsBsGft9E9GEVtc1hjd8p3pXzf+T
	M/ISyYGZwoFeOQAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Valentin Schneider <vschneid@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Mike Galbraith <efault@gmx.de>,
	Peter Collingbourne <pcc@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Kristina Martsenko <kristina.martsenko@arm.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Juri Lelli <juri.lelli@redhat.com>, Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH 1/1] arm64: enable PREEMPT_LAZY
Message-ID: <20250331090756.L7iXi1Ee@linutronix.de>
References: <20250305104925.189198-1-vschneid@redhat.com>
 <20250305104925.189198-2-vschneid@redhat.com>
 <Z8hAZ09Q40fxLJSk@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z8hAZ09Q40fxLJSk@J2N7QTR9R3>

On 2025-03-05 12:15:35 [+0000], Mark Rutland wrote:
> Catalin, Will, given this is small and self-contained, I reckon it makes
> sense to pick this up ahead of Jinjie's series to move arm64 over to the
> generic entry library (which is on my queue of things to review). Even
> if we pick up both, it'll be easier to bisect and debug issues caused by
> this patch alone.

Any updates here? I know it is the merge window but I don't know if
upstream considers this or wants to sit on it until the generic entry
gets in.
In the meantime I stuff it into my RT tree so it does not get lost.

> Mark.

Sebastian
