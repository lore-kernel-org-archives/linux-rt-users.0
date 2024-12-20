Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F63215F4F
	for <linux-rt-users@vger.kernel.org>; Fri, 20 Dec 2024 14:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734703558; cv=none; b=Z58hfGyRlR2kVMbpJLTl2FOLe9M1AUlUItJmM5fS4//uvHw6GIlRxi0ziwpKMao3Ks7fehsyPPJyzYMqayZjn6ZEHzxx2injUkcoA/C8jwsi4z6X4qS9f8R7WJ7QFd4wGXRGiQ3qIoh75rtFJqu887ECUZK3XUROFN7PoAN1EaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734703558; c=relaxed/simple;
	bh=RzqfmRRJWIUVtoDBrOogKEl5EWjv8icFOyGwtNs9hlQ=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PxTLVyxKoBMpIfGSbrBhMyLQ4ibxtbqyiPZT6M94VyelKtSJdfkdPHSFFZNRFWTe4fNiP0Db5Zz+zmfhil8xSB2jm5nbCvq+BvofJmVyaKqNSWIgXTIGbsKlW0osX6jf0Xb482OxNrV8xNvfqX48to6DnAGIKv+iFWRyrkRkDX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R53i/X03; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v+yF2Rq1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R53i/X03";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v+yF2Rq1"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734703554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RzqfmRRJWIUVtoDBrOogKEl5EWjv8icFOyGwtNs9hlQ=;
	b=R53i/X03S9q0jd0fXWF3nAldYEcE/Bo9z4EQr72egOk1uXXPxgu0Wie0BclV9HLRiF0u1x
	aTg72zHJt1aKc9BDW0BMC2wvaTY5IGNFG3CIgr4zinT9hZL4vy30EVWahw0Y4zj7FwqJXT
	sUAVP1YsjWvkTMQ6wzYLlQm7Jf7D8acgrA1F/5wJ8B6fk1Uve+rkG2IDfKbMvL8GQgSNs/
	SgIG48Ym/YGVi6U20G0gZs+f13UKc05sgd3Q180GG7Ln6aeaFuvTqMryhXCAfcPbaeezRS
	PeOpTlXqz+e9bIuc80YIz8332WQYz4oqb9TFxpAqKTkP7fRcEymDxu3pVpqNAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734703554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RzqfmRRJWIUVtoDBrOogKEl5EWjv8icFOyGwtNs9hlQ=;
	b=v+yF2Rq1u0fGKQz2efk8COjdmGtfNLmfkqe3Jz4aAmC99Q/XwLImexX1qToIad3Ae7ynN/
	u494HXumu9/eBYDQ==
To: Florian Paul Schmidt <mista.tapas@gmx.net>, linux-rt-users@vger.kernel.org
Subject: Re: Raspberry Pi 5 and PREEMPT_RT (6.13.0-rc3)
In-Reply-To: <d445e582-4e49-4135-9d94-f52d72ec5df6@gmx.net>
References: <d445e582-4e49-4135-9d94-f52d72ec5df6@gmx.net>
Date: Fri, 20 Dec 2024 15:11:54 +0106
Message-ID: <84bjx6h2kd.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Florian,

On 2024-12-20, Florian Paul Schmidt <mista.tapas@gmx.net> wrote:
> I'm playing around with a Raspberry Pi 5 and a PREEMPT_RT kernel (raspberry
> pi 6.13.y branch) and wonder about the latencies I see. First I tried
> cyclictest and saw latencies in the upper 50s up to 80s or so under a
> kernel compile load.

...

> I still wonder though: How come the latencies are so large? Is the
> raspberry pi platform just not suited to reach lower latencies? Is
> everything working as expected? Are maybe the raspberry pi
> patches responsible for latency sources which are invisible in the
> traces? I there any hope for getting these latencies a little more
> under control?

There are various kernel configurations that affect latency. But I am
curious... Why do you think a maximum latency of 80us on an $80 board is
large? What maximum latencies are you expecting? And why do you think it
is not "under control"?

John Ogness
