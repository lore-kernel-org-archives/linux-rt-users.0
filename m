Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792566630;
	b=dpFewf/eZVRzp420FTlYrN9aaIBChNpEnENxOemjZcjVfVHWsoXhyhOdXiL1obINtFCI
	 hDgCNxiReIwqp/tUbiSOLhfb+CJDY/eXLeub/payd+uAvIZx7rRsGX845PhHpTOznECGA
	 dTvMxMLnCfUiaKsvIQDJjoRw7v5xY+SAvxJZ3dfTDstCLHm8UsRGDP0uYdInvA5DAAal4
	 cin6P1kixu9AV5aMJDzHoAEFjEbHfpKtVE+vKRkNoplWIZxD43rgJnJBAjrzykoX3IV/E
	 q7drYISBsGqEX4yfThaf3pBPk8Wsa4b848zfXAg2Txj7tVSGBxzx2X6C+j+7NYgwbcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792566630;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=xeNt4R0xDucZ+gJnCGHpqHZfVfY0vFtT83s+UQUMF3c=;
	b=qO8//hf5QYPjeMDyvXHGML/fR8H87VvhO67keEfRvCm7f+0O3mJZLJndx7VokzSNCcOV
	 r5J3mGobCA8NQYSkwwjBmVNXQfszioub5nZg5eXkQcNe4jl3g/9h2SeWekkhBVuyYoHkp
	 mRltULqW+gCdUgGGjvzLuT/7I3t3KOK+qdISECKqISw+TyL0+goxMC3JUy+Jc7jv480Ct
	 mpBpo+031l6lWm2ppQJVVkruVShm8H3KHLhZ7hXhpgajk0M4asUaOuVJQbPKI+JvA3Zxy
	 sFBwi98N70H50ZsudA1d1yhajY8/uKsGveMVYcGTvEbmd+cPtUNrJBnpdFRdIXSQVGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=a92ecQry;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=DbCuzHic;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41808606A31C
	for <linux-rt-users@vger.kernel.org>; Wed, 21 Oct 2026 07:10:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41808606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=a92ecQry;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=DbCuzHic
Date: Wed, 21 Oct 2026 09:10:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792566628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xeNt4R0xDucZ+gJnCGHpqHZfVfY0vFtT83s+UQUMF3c=;
	b=a92ecQryF6o/pKxVdK5Ni7Dl5Mv7sK42d3rQ5QKBHLK7Brt2xkh9CFtVYhY7LopWJJIVLA
	bWgk50G850DMHe2k6XX5wrO1wDclTIhidvyKgc6ASk4QGbJzw/bVaNnDawx2z8R/PYbwTp
	Z+BJuOtp4KzwCS9DVih3kDDYlydei4Ht+tUdvkVxO7GUGs6Mae/ILE8PAdKYO30yfmR1hS
	/wq5l2KJRlCeTgbNvpYLn6xnJxd/CRlwtExJdWCEvSUfQwaFu2R9DMtnoCnkFi8zDTmz03
	PeHFrJTxZwarWl23ohvXai8tL8NhJOs0f5WzHkylegE72zDmqlZjGaXGZNjdEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792566628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xeNt4R0xDucZ+gJnCGHpqHZfVfY0vFtT83s+UQUMF3c=;
	b=DbCuzHicX7X6fpYCiZacGs3f3MuioRBQv8TcS/q6ewBoUunB3drRVqM42IkSGp49h7FqwN
	D9mv8l3f2huyK9Ag==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: John Kacur <jkacur@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Bart Wensley <bartwensley@gmail.com>,
	Crystal Wood <crwood@redhat.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH v2] rt-tests: hwlatdetect: Restore tracing parameters
Message-ID: <20261021071027._D_w339N@linutronix.de>
References: <20261019102909.3339372-1-costa.shul@redhat.com>
 <20261020101646.Xb1lEbqY@linutronix.de>
 <CADDUTFyDT4Bx_MEpF9tCZfm9ECP33WatpfBjQ=2WH0dpRrXodA@mail.gmail.com>
 <20261021064844.SBwm7htb@linutronix.de>
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Post: <mailto:linux-rt-users@vger.kernel.org>
List-Help: <mailto:linux-rt-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rt-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261021064844.SBwm7htb@linutronix.de>

On 2026-10-21 08:48:45 [+0200], To Costa Shulyupin wrote:
> On 2026-10-20 20:39:27 [+0300], Costa Shulyupin wrote:
> > On Tue, 20 Oct 2026 at 13:16, Sebastian Andrzej Siewior
> > <bigeasy@linutronix.de> wrote:
> > > Could you please get rid of the DebugFS class in it?
> > > The tracing folder should be auto-mounted at /sys/kernel/tracing by the
> > > distribution. Currently it is also auto mounted at
> > > /sys/kernel/debug/tracing if something is accessing this folder and this
> > > is subject to vanish. Mounting it does not help then either.
> > 
> > In the OpenShift/Kubernetes containers tracefs by default is at
> > /host/sys/kernel/tracing and /host/sys/kernel/debug/tracing.
> > Therefore, only the DebugFS mount and umount are redundant.
> 
> Interesting.
> But how does this even work without extra glue around it? Is this the
> global tracefs or per-namespace tracefs?
> Does this still work with CONFIG_TRACEFS_AUTOMOUNT_DEPRECATED=n ?
> 
> Be aware that this is the only tool in rt-tests that still uses the
> debugfs path.

There is src/hwlatdetect/hwlat.txt which refers to debugfs at / and more
importantly to hwlat.ko which is not a thing since commit 7c10eeecf93f4
("hwlatdetect: modify hwlatdetector.py to use the ftrace
hwlatdetector").
The whole usage paragraph looks outdated and
https://docs.kernel.org/trace/hwlat_detector.html is probably a better
source.
I don't know how accurate the remaining part of the document is. It
starts with "The module hwlat" which is not the case.  It does
refer to itself as SMI detector which was its thing before the rename.
I don't think it ever did detect SMIs the way cyclictest does (by
reading the MSR (well on x86)) it only did try to find execution gaps
the way the hwlat-traces does it today. This might be misleading.
From a quick look, the man-page looks up-to-date. It mentions at
hwlat_detector.ko at the bottom - other than that, it looks okay.

> > Costa

Sebastian
