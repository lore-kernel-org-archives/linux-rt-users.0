Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C298B379C5E
	for <linux-rt-users@vger.kernel.org>; Tue, 14 Jul 2026 11:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784027243; cv=none; b=f21m3+9TT6Xz6vrc+1C//CrPhNbaiNEGGRcJ9davnA1Hjn6rL3bzp8hQDpPtJnoEDP+N9jv7352HMCM5sxnOIr15NU1zwCSZ1k4goktDQJc9d/GGJOpE7VEl4JMXBv5TnQASVB3CpXTMhzucOX4uUNAtE9ddRQMJ/hzb56GkKTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784027243; c=relaxed/simple;
	bh=5Gic6jFqDAw2jFM2Jd/b6j2X3I/6cTrDW6/5MaQqIHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EyzTFvJumc8VrDlR+mo/OeYChbPaluKdkYZIKJdymkOjLY2Y6Inf+nUgQNdtM2WFNjlHq0EciUmrqfbQ28dwlMDdxN5OUUMOicdlQuLikFirxewmd/PfT6/jNaFDTZ18HTWfoeg60hc3lMUOrzwXzluU/+augT5ZlQuM/8iqgR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nKWMmgeO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c3tDafPm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nKWMmgeO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c3tDafPm"
Date: Tue, 14 Jul 2026 13:07:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784027239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Gic6jFqDAw2jFM2Jd/b6j2X3I/6cTrDW6/5MaQqIHI=;
	b=nKWMmgeOZusGz4tUgy+jHb8f7dPLZ6VmnGW/lJa6oQfWarzLUflFbamW/ZR1RsNbBnu43L
	9Qwg8/+OsvuWBSp4e23ZNGDzVih7J7h3DZYae6lHi1IO0ah/xSAPjkPofGtRDmqk9ofnvF
	G1WmNrle4tTx2BDqy+qtMg4TuTSoR70R70aF9YFEGzxxuzNqRG2NVPKYp2nEbQ2QIArpV+
	U7XIClgPkKwYdq6Sqrw1uCC3Cdf+2SQJJkBk1fV8VawzRb1ldJ1UhZHjnIETEHEkM+l1Cr
	DGNnMiFN8bvQW8fj+1xZ0vQcHOLKVbf6E2OIbFuhbEMBqZSVcO+G1BuA6BHZlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784027239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Gic6jFqDAw2jFM2Jd/b6j2X3I/6cTrDW6/5MaQqIHI=;
	b=c3tDafPmqOjhcblwv6ldGP21Lj7aKhxu0ykVLDb560LIUJ8tcB6SNF/u6uo8PqjAfVqy2L
	30NxFxsnSeF12qDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	driver-core@lists.linux.dev, linux-rt-devel@lists.linux.dev,
	linux-rt-users@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Clark Williams <williams@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [RFC PATCH] sysfs: Add /sys/kernel/realtime entry
Message-ID: <20260714110718.E5qV5-Hf@linutronix.de>
References: <20260709143108.UYeCUUcd@linutronix.de>
 <2026070922-kilowatt-matador-5e1c@gregkh>
 <20260709152214.rH1O_8SM@linutronix.de>
 <748a489687000b21d0e8f961fc2f9f963b0bc1d1.camel@siemens.com>
 <20260710115145.32729a7c@gandalf.local.home>
 <ae96c274f166301aba762d97caccddf176ad7968.camel@siemens.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ae96c274f166301aba762d97caccddf176ad7968.camel@siemens.com>

On 2026-07-10 18:01:20 [+0200], Florian Bezdeka wrote:
> Depends on what you consider a valid update scenario. Updating from 6.1-
> rt with sysfs available to something like 6.18 (no sysfs anymore) will
> still break - as long as you do not (force) update userspace in
> lockstep.

v6.1-RT to v6-18 no-rt will not provide the file. Also will not provide
ARM, PowerPC or 8250-nbcon support. So it is not just that single thing
that you "lose" if you don't apply the RT patch. It is just what you
notice because you don't use the other things.

> I learned meanwhile that our detection moved to uname meanwhile, so this
> is not a problem for us anymore.

Okay. So you yelled loudly that you need it, now not anymore.

So can we state that this it does not provide anything of value, is not
considered needed and can be dropped?

Clark, what is the status on your end?

I can postpone this and get back in a month or so if we need thinking
time.

> Florian

Sebastian
