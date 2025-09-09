Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABB623D7FB
	for <linux-rt-users@vger.kernel.org>; Tue,  9 Sep 2025 12:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757421301; cv=none; b=Q38kVkU7Ubp9wp/txa+rEjf4ymABDYRSj+XwhwbQFGuTFmzVeYdyTP5RcYqDCY8R6lzAOojbRX3z4r6n3Z0UmCDr+QyFbpENkf+3OJd/sRVxBzqYfkGuragkjFBiUDmEzlMhalbBZgdyoRD1hiVZfe3lc8mVtJTl7otff8sbyXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757421301; c=relaxed/simple;
	bh=omKdstwL77RPXtZIEzJXBRsX/3EnRMsRF7nu2mdihMs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fAvBhE4r6asF8TFEzyZBDiGVO+S1mMIBmNqd9fP0eSvRi4kOm3UVhPnuxilTlKFkxHYwH3PoMFYTw+TS2/ZtTO51H2T1OCfwQWZKxQEFjH1fGZSYEkO7WLPtaTARUFc0dxXkz3CG8kJujw2mkizc6H9NkVHm0q3Ev7qtZLEZJTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FMQItb42; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X2e6Mxz1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FMQItb42";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X2e6Mxz1"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757421298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=omKdstwL77RPXtZIEzJXBRsX/3EnRMsRF7nu2mdihMs=;
	b=FMQItb422JjDZeZx2wo/yCybobtGu+LVkiDJBBYUJzEqLxEWzMqkyWtZwb5DOBXRJ+rVFL
	LwGOZjpUBu7Ubu4KXiUJS88MrsvLbZuHX/hM9wy2+V9D+LTJSnNh4te2AoJ8Jg4fE6ZER5
	iZSoDADPLVBHRh4TV9yrRPuIfrJnfGVZR3tH2mNmDTl7PLzbr7cR5aSpzOpvThyq/EjSwX
	UdNy4NWiFpp7Ozl4kdN0puRq+QvnZIkrShSdSPgdpxrddHUsoWod4Aau3IHpVNLZBBYy2j
	Q1f5WjdzKJ4aNJCqnkv3qx4aLZtoLInZdrUZQvhm8uo+yHDv0DHjD7N2RReAvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757421298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=omKdstwL77RPXtZIEzJXBRsX/3EnRMsRF7nu2mdihMs=;
	b=X2e6Mxz177hfO5TSwM33+qiApv+YbFcIySdJrQSWGZKtIj4sLLoTle6qVyIuR5B+E2Ai/2
	NRcLFU6krTwoAvDA==
To: Marc Gonzalez <marc.w.gonzalez@free.fr>, linux-rt-users@vger.kernel.org
Cc: Daniel Wagner <dwagner@suse.de>, Leon Woestenberg <leon@sidebranch.com>,
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner
 <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <williams@redhat.com>, Pavel Machek <pavel@denx.de>, Luis
 Goncalves <lgoncalv@redhat.com>, John McCalpin <mccalpin@tacc.utexas.edu>,
 Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: Unexplained variance in run-time of trivial program
In-Reply-To: <0d87e3c3-8de1-4d98-802e-a292f63f1bf1@free.fr>
References: <5f7496eb-bf62-4cc9-bef0-9cae97a93dca@free.fr>
 <ac1ef5df-aa30-4b63-9beb-3e0522dd3cec@flourine.local>
 <afc4c145-4758-4924-b106-e7844624d269@free.fr>
 <841polf13z.fsf@jogness.linutronix.de>
 <42c5fb53-d423-41a5-80d9-557ff2a3e804@free.fr>
 <84ldmsevcm.fsf@jogness.linutronix.de>
 <3f1d4229-a95c-4d99-a98f-249d9e488b32@free.fr>
 <84ldmp8ewv.fsf@jogness.linutronix.de>
 <3fe55967-b4fa-4bc1-ae2b-58b5d1bbf3ea@free.fr>
 <d5f3d4c1-714b-46d4-99e6-c71ebf64e76b@flourine.local>
 <3220a6ab-19e5-4705-865a-1e1c37b67ccf@free.fr>
 <0d87e3c3-8de1-4d98-802e-a292f63f1bf1@free.fr>
Date: Tue, 09 Sep 2025 14:40:57 +0206
Message-ID: <84ms73kdn2.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-09-09, Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
> I captured a full trace of this occurrence with
> echo *:* > $TRACING/set_event
> cat $TRACING/per_cpu/cpu$CPU/trace > trace.$CPU

...

> But there is absolutely NOTHING traced between 4606.628019 & 4606.811832.

I recommend using the function tracer:

# echo function > $TRACING/current_tracer

It should not affect your timings for pure-userspace code. This should
catch any unintentional kernel activity.

John
