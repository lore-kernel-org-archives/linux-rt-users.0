Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D551C7005
	for <linux-rt-users@vger.kernel.org>; Tue, 20 May 2025 07:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747726046; cv=none; b=bGQdQ6CmTaAzM3oxYkAyNSFqKyVC385I6fX2DUP+dfY2p70L7DeN3WeeEgVGtYXXMxs0JMU6STUB3aklkNXz7/p/pAob/Bji0yyiQe8Mdo7dArUIRambAAKT5XDU+bfSZWxrcCQ+0xV/MhduMAKP+SJjPfZJhQosmXqGmkAck3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747726046; c=relaxed/simple;
	bh=LaEa8RCyU9j6OQMzxAI1MRu8QYGUJc0iH6cM5GIq9QU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mjFu4g3akUWFBmJvkw/2cbvhrlMAo9VU9empVZFm16YioDgVVCZOWwWt40saL2InDvvomolezLQpS3zZt3ijbD1SmPsMFk6eXgKrcUl75h2E5X3pnTEivJBf8wWRxSXn/oeWrFeMDjIVkfWwX9rIe9REvDq2PNpUjS2GRwAM7Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0BQn5ZsO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BCzRpkra; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0BQn5ZsO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BCzRpkra"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747726036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LaEa8RCyU9j6OQMzxAI1MRu8QYGUJc0iH6cM5GIq9QU=;
	b=0BQn5ZsOUNcOqHAThrHsVhYBgTPutvv5AN0KAssdkLJs/y/zsHlZ1ju1XND4j5U1iLDcpy
	9Y3h1h6hU3suPSggCmMoZSOyDGlW6zqoC+NBeETwHUsQieRmdiKrHUUvvDHHuS0ZpRRA2q
	2TSSe+jOJWiqQDJHEZKYpV9+McJU4ANbI0wIqN7okC6gYydZWVK1bccS4BzUNfxR55f/pc
	h5R2i7ZRpvPuQX50A9PHGHe4d/jMB3CsBBUcdQ05igMfHCNhWapFs4kKm6C8o4piX1Li3A
	lJi4MWDK8uZeUm5FZoRbsSrd7qce8Zx0087SiIQ7si0dzCYe9y2XLMm0ybdopg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747726036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LaEa8RCyU9j6OQMzxAI1MRu8QYGUJc0iH6cM5GIq9QU=;
	b=BCzRpkrapEoeOe4FLOx4mjs3jzcZvXACAPNjPN2BvgPAPCpNl4hHg5SxsO9bRnM4RSZ6PS
	XxlDE6z52G7dWLDQ==
To: Leonardo Bras <leobras@redhat.com>, Clark Williams
 <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Cc: Leonardo Bras <leobras@redhat.com>, rt-users
 <linux-rt-users@vger.kernel.org>, Sana Sharma <sansshar@redhat.com>
Subject: Re: [RFC PATCH] cyclictest: Add skip_sec option
In-Reply-To: <20250520035641.533706-1-leobras@redhat.com>
References: <20250520035641.533706-1-leobras@redhat.com>
Date: Tue, 20 May 2025 09:33:16 +0206
Message-ID: <84msb7g2sr.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-05-20, Leonardo Bras <leobras@redhat.com> wrote:
> When running cyclictest with break trace (-b) option, wait for skip_sec
> seconds before issuing the break.
>
> Cyclictest may present high latency on the initial cycles, which can be
> caused by initial resource allocations, and may not represent the
> expected latency for the running workload.

If cyclictest is programmed correctly, this will not happen. Can you
provide a technical explanation for high latencies on initial cycles?

John Ogness
