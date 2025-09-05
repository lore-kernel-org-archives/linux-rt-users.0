Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30F321FF33
	for <linux-rt-users@vger.kernel.org>; Fri,  5 Sep 2025 16:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757088463; cv=none; b=IlBR+SxzDlTZUPYrRYrjGxXgBt7DYLplTnsg+4BMRGUDkS+vXAJ5Ndd8DdSvgh97P/ABoG4O52TaSDboDMVZ8ehyj20DYKe8Ox5Z7mKpG1KUtoDNseM0SG8T4bOh+wQZ9wpiaq8tkOGcjTt8+d9K833uAcavG4CLM5JdcwF+B8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757088463; c=relaxed/simple;
	bh=WECVg+IYJGbdMp4S7vwLHgSbY7woQhqjoQF/7T9F2Iw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kpjmA97P7aLdrEufcmaoDymTW9jNA3bH2DPN0l23d9obKq+itAgjKMG9JggiiOXe9+zzea0RMt2bUEKQ8rphJL3TLJqCFo6nvhtgIjO+08uB7Tf9ihuG+ZPlcf6y8nHsIFkuJpZmqbvZEMASuh3+E7JHQb9Gi1ZYbR1AR4xUx04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JQyMnj/s; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U0OhuL0l; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JQyMnj/s";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U0OhuL0l"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757088458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w70u4cgFzxEBXT3sf3NwfOJfES+PMdtL03PKnbJzbXo=;
	b=JQyMnj/s5XJxvyS3zkvJjVsoVPZpuXjWjhK1s5wi3p5M3Cc1c06DsH3cf6Up6Tw6eo0aQh
	dUrmnaZtKiHRuGzTT5/r7JkQQ+NYA9+6OdINZ5FBWWUfb/Fjt/ehthWENCf1f8MoC9uqqz
	A6kuc5LDYHCrTF41Jxt9r5x3C5fh300jGrgQmz4GUmBSFLOOzyrh+W3In76P5Y0LZp6s1C
	uQWqonSmV9iJDAH1zbRWxRyqBMuZ0RsKvySthN1NkUreuaReJQOTCwE1Y/GzugB20zkDOi
	RCxrRAXwtIIpzN6UGcm04LLmRFWsqeKKOsl/hJP+9Zb24BTVBE1InxlQK5Conw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757088458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w70u4cgFzxEBXT3sf3NwfOJfES+PMdtL03PKnbJzbXo=;
	b=U0OhuL0l/+BZgfsItrexVD0V85PPKOOSfHm30H8jVYG4TNHsLSqFNb+t/P0IvDL7T0vUG7
	5Z2Q8TbWp5DggsBg==
To: Marc Gonzalez <marc.w.gonzalez@free.fr>, Daniel Wagner <dwagner@suse.de>
Cc: linux-rt-users@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Daniel Wagner <daniel.wagner@suse.com>, Clark
 Williams <williams@redhat.com>, Pavel Machek <pavel@denx.de>, Luis
 Goncalves <lgoncalv@redhat.com>, John McCalpin <mccalpin@tacc.utexas.edu>
Subject: Re: Large(ish) variance induced by SCHED_FIFO
In-Reply-To: <42c5fb53-d423-41a5-80d9-557ff2a3e804@free.fr>
References: <5f7496eb-bf62-4cc9-bef0-9cae97a93dca@free.fr>
 <ac1ef5df-aa30-4b63-9beb-3e0522dd3cec@flourine.local>
 <afc4c145-4758-4924-b106-e7844624d269@free.fr>
 <841polf13z.fsf@jogness.linutronix.de>
 <42c5fb53-d423-41a5-80d9-557ff2a3e804@free.fr>
Date: Fri, 05 Sep 2025 18:13:37 +0206
Message-ID: <84ldmsevcm.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-09-05, Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
>>> (I used CLOCK_MONOTONIC_RAW.)
>> 
>> Not really relevant to your issue, but you should always use CLOCK_MONOTONIC.
>
> Could you provide some insight as to why CLOCK_MONOTONIC is
> preferable?

CLOCK_MONOTONIC is tracking in time units as defined by
humans. CLOCK_MONOTONIC_RAW is tracking in time units defined by some
hardware.

John
