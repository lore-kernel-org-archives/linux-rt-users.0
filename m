Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794310600;
	b=FzsvNg5ZGZFaQDgVC1VF/xWzA1hQcOKpLS4BO3dnRsvszv4Cc42KWHo/ziFIOtjhr8zz
	 BYLY16ITDhozrS+gW1kQ5ch2sTN3Kp4dc2KUfJNGsvMi6zG2lwr5OroaYEly35RYkdnoA
	 AL7ZiSsxuqK0S9dcsNWgYiZK8Ky2rZ7yJw1EexRoq4jD+F58W5+XUHY79B+7ZSOBi8XHX
	 XfUvLq/rHuskkQ0qLhOFNwaukgCr+h9kK2DC4pZ+vPA3vXqOZsISBjtWTDCiY3z+/kEm9
	 px3o1H2XptVJCC4UJ58oj2Wbg10B1KaYsbypTT5sCGcE4q5a9ZEJPfsTB2PRKUImD3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794310600;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:To:Subject:
	 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
	bh=ukpOlcp/FfhU5zgXyoHTlrx1T9o7wZwJ24wDtRneZa0=;
	b=DDUuJeANjG4Ff9UEiaN+u6JR5Gq0EL/EmqvQNZ5dfrVQq9nCEX3fuX4XBJzWW30wBx0j
	 CL9p4f736CG/r8LA5f+TLY/KM+WghS8T6yV8rqBnSj89PgIMq9Nu98MAJgqF2JfVF411z
	 Q/LDf9SsvGU99PC167cst613n/tcr7gpbNSsECGeDwmro9IdGWQIuEEF4Cz+YOZE10amR
	 ufgoqYZwcFgZ5QJ9BmwKqKMMTzonoOkXp4UZgpT3JSPDtxnJ454f6cW+qX0nmYIM7k0Kx
	 DF+Y+v2dcCCydAL0KifOokf5wLo/zrF2T5Mda7GO8Y2i4UcdT+28l9SihUYI6VPmxMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=LQPvm70L;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=LO3KZAl3;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA45606A325
	for <linux-rt-users@vger.kernel.org>; Tue, 10 Nov 2026 11:36:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DA45606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=LQPvm70L;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=LO3KZAl3
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794310597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ukpOlcp/FfhU5zgXyoHTlrx1T9o7wZwJ24wDtRneZa0=;
	b=LQPvm70LkEvwZCKfKGy/4c+s3dUplCxdiGAkRp8ntBV5oPanVH0GAw3n0d09m28mP7FAh7
	0VliCiqbXDYf/aHz/+2xgLeFBXPYp6Wi8oOPky7FrxXrwOcwhFNt0Ot8mql2SYhYV5lQ4c
	0BtYyWDYvB5D5q8mndwfe5QicgL8DYLWAHgwDC5i8sOXZtw7s9r/L5KbWbOiOOP+/pdeak
	+hzKvmPBhENKjebbJbo38DZPkL0PsJmNrHOFAe73AtOh6dQY4w5pDZhsVrBo9HqIHy4XG7
	/hmne2SWwPOLSyI1xAPub1NzsoqhYwJz/hRhVyfJp7SoZroQeP0u3W5keWsDlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794310597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ukpOlcp/FfhU5zgXyoHTlrx1T9o7wZwJ24wDtRneZa0=;
	b=LO3KZAl3GqIpKulSdaxOYYLTrSO8xfi19Jz6QVpfeAP5FH8BfHImB357VpNhPMdCLD+ZqL
	r2k7CGqTj7W4NSAg==
To: Simon Maurer <dev@maurer.systems>, linux-rt-users@vger.kernel.org
Subject: Re: Real-Time Inter-process Communication
In-Reply-To: <14a6b7b2-8b73-4905-9aad-c2bbdc78f4cd@maurer.systems>
References: <14a6b7b2-8b73-4905-9aad-c2bbdc78f4cd@maurer.systems>
Date: Tue, 10 Nov 2026 12:42:36 +0106
Message-ID: <87bj7wj4u3.fsf@jogness.linutronix.de>
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Post: <mailto:linux-rt-users@vger.kernel.org>
List-Help: <mailto:linux-rt-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rt-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Hi Simon,

On 2026-11-10, Simon Maurer <dev@maurer.systems> wrote:
> I'd like to introduce a project I've been working on: RTIPC, a
> real-time inter-process communication library with implementations in
> C11 and Rust. The C11 implementation also provides C++ and Python
> bindings.

I recommend running real-time tests with your library (and each of the
bindings) with the RV mon rtapp enabled. This is easy to do:

1. Build your kernel with rtapp, sleep, wakeup RV monitors:

CONFIG_RV_MON_RTAPP=y
CONFIG_RV_MON_SLEEP=y
CONFIG_RV_MON_WAKEUP=y

2. Enable the rtapp monitor on the running RT system:

# echo printk > /sys/kernel/tracing/rv/monitors/rtapp/reactors
# echo 1 > /sys/kernel/tracing/rv/monitors/rtapp/enable

3. Run your real-time tests and see if anything shows up in dmesg.

I recently gave a talk about this at the Linux Real-Time Users Forum in
Prague:

https://www.youtube.com/watch?v=jO4M5dx52Vw

It checks if real-time applications do anything that could lead to
priority inversion / unbounded latencies.

It would be nice if your examples worked out-of-the-box without
triggering any violations (even with things like the OOM killer being
triggered).

John Ogness
