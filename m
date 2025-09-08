Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A347021D3F3
	for <linux-rt-users@vger.kernel.org>; Mon,  8 Sep 2025 09:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757324167; cv=none; b=XCdtDqzSO7cUpKa/aSuV6SuDA/zwBD27qJ1VLkLRpx5jw/mxXz8lp6rBMXhp9e3a/XQdaA8o8XKmNd7TTJOrcrWcXBvY1D24AAp5tojDYNwgav70uwHnYluaW/UZua528iEiColZNNJEldEcZrajlzDHi1dKxEjwsnnM4QIqVKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757324167; c=relaxed/simple;
	bh=Zu4d+5WdEEQ+vgX8XhTDb30oJnASoAwEexXKzTI4Wqs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IhWAxPUeanBEDkEaLx3ibH2Li7KceHlMZH6HI1VBwq/K01cdZSHq81aGGz+RHFtOUgvhcdZaDOKoNZ/MZK349OgudI2/G+YUgGcTnY0f4pUlvV43mDSZ/SMvPIAgrqkN6ErwNIkuu92P9TstsOnqPke3POiWpwsvZTEGgfGuBJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hoMcVyUy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7Ned0q29; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hoMcVyUy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7Ned0q29"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757324161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MNEzy6jsnkSX/5Dj+dP6WwlonvGBXIJ9uMu8giG/mZs=;
	b=hoMcVyUygkA9tE43NXRS4Gmi8yXW4egG32RGgqwoeBwj0Nz1+oMd6UFdrq3zekSgX6VK1L
	Jw8qFQSEAtu5GMKsytwvEOAzcK15qOyO7PnqTQ+VVuOM3VpD8tNimzSG1GONxIar+PHAc0
	7whpToUbbPmB1gZ5uWbh5nA7iiko2etFBobUeQ654PU2FqWbhT0w0hMr0gJ9xuaDHBZN6G
	oAD8ws+uSe7vX8KLT8bFrFD0ToPhclTGw28PpO6/EmZ5JFxMDgXT4LiIz+mAoPetEV1pEz
	F+vMibtpObMo+2sX3+JRTxyWgJHSDwh15n1mMAzPpj9CJz6yWN9o2wn6wpP/Ew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757324161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MNEzy6jsnkSX/5Dj+dP6WwlonvGBXIJ9uMu8giG/mZs=;
	b=7Ned0q29SaiJTnQZfjwUsvrlAOnVXUDLnn1F9+hwq7eEagUcXAjx7u6bvlktzI82ZdH57r
	1XbccGjKgq3sSrAg==
To: Marc Gonzalez <marc.w.gonzalez@free.fr>, Daniel Wagner <dwagner@suse.de>
Cc: linux-rt-users@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Daniel Wagner <daniel.wagner@suse.com>, Clark
 Williams <williams@redhat.com>, Pavel Machek <pavel@denx.de>, Luis
 Goncalves <lgoncalv@redhat.com>, John McCalpin <mccalpin@tacc.utexas.edu>
Subject: Re: Large(ish) variance induced by SCHED_FIFO
In-Reply-To: <3f1d4229-a95c-4d99-a98f-249d9e488b32@free.fr>
References: <5f7496eb-bf62-4cc9-bef0-9cae97a93dca@free.fr>
 <ac1ef5df-aa30-4b63-9beb-3e0522dd3cec@flourine.local>
 <afc4c145-4758-4924-b106-e7844624d269@free.fr>
 <841polf13z.fsf@jogness.linutronix.de>
 <42c5fb53-d423-41a5-80d9-557ff2a3e804@free.fr>
 <84ldmsevcm.fsf@jogness.linutronix.de>
 <3f1d4229-a95c-4d99-a98f-249d9e488b32@free.fr>
Date: Mon, 08 Sep 2025 11:42:00 +0206
Message-ID: <84ldmp8ewv.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-09-05, Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
>>> Could you provide some insight as to why CLOCK_MONOTONIC is preferable?
>> 
>> CLOCK_MONOTONIC is tracking in time units as defined by humans.
>> CLOCK_MONOTONIC_RAW is tracking in time units defined by some hardware.
>
> I'm not sure I understand what that implies.
>
> Eventually, clock_gettime stores whatever it measured in struct timespec,
> with tv_sec & tv_nsec, right?

I would phrase it differently, but generally speaking, correct.

> Are you saying that if I have 2 identical timespecs,
> one from CLOCK_MONOTONIC, one from CLOCK_MONOTONIC_RAW,
> they might not measure the same time interval?

I assume you mean 2 _sets_ of timespecs (so that you have 2 intervals to
compare). Correct.

> Are you perhaps saying that NTP can (ever so slightly) tweak
> a clock to bring its frequency closer to "reality", but if
> CLOCK_MONOTONIC_RAW ignores such tweaks, it might count time
> slightly too fast or too slow?

Correct.

This is also valid for other clocks. For example, the kernel logs
(printk) and ftrace default to the CPU local clock. These timestamps
cannot be compared to CLOCK_MONOTONIC timestamps... just as
CLOCK_MONOTONIC_RAW timestamps cannot be compared to CLOCK_MONOTONIC
timestamps.

There are still reasons why CLOCK_MONOTONIC_RAW might be
interesting. For example, if you want a very stable timesource to
compare intervals, but do not care so much about the real world time
lengths of those intervals (i.e. where is the greatest latency vs. what
is the value of the greatest latency). Although even here, I doubt
CLOCK_MONOTONIC_RAW has a practical advantage over CLOCK_MONOTONIC.

John
