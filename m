Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C1E14A08B
	for <linux-rt-users@vger.kernel.org>; Fri,  5 Jul 2024 14:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720191382; cv=none; b=u+1ncyedVWYCcpS8wb7xBwviqn5rNNUAQWUEZyMK5jflYhb+hdmVbuBgQ1NG6luIsdG0/QwNsjDPg+afK94LO/PgFagbqTXM0lC2XKeAc9auA/bXVpaCL0PdlX/83TGt7ph7YX8yeg4FI1XKJAwmQQ9LMzetOmgmsgJeOaur2VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720191382; c=relaxed/simple;
	bh=LzpzVkeMBI++ZInXIdHdGeAWPpRTANA0l1aq1MRS8IA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9Ye8qho2fzGgbIjJQOiuD4/16Kh0l/3Tc9zpOMZZFhvTqYufcU2Yi7rtleDGnEfAqibFztFo9UI+3XNJ8wSXcqNuLgbquMrWHSSJyjbz9uPrCok/P9I60YDIbv84pqsRwLB3jv0CvGt3z2ivrPBZtiPjlSrBJUWaNv0UZeh7QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oticwmGE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=msrsayCg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oticwmGE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="msrsayCg"
Date: Fri, 5 Jul 2024 16:56:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720191378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AahIyeUxEOXPkcxh7Z9J8AR0Ba4a05ciMN96FSEh7YU=;
	b=oticwmGE7ffUIiZmtThnWE0NyHzxRZ6x5tkuszzwRQE8e/4i1MM5fzBTmfInJXG/N1lNDY
	BY4lP4trde/zlHfw9BZf5BshzQnDv+3XcKqZmUkJUgc9bIt6tkcELjiUMPaz9bVjw0Xucm
	lYh4yHtJ6SAqvIYwVDVr9byZ49nvukNwnXMFSxtcUVI9jz58nJXC0oocmyJIxTIwFoy+iT
	l/Bbc1SfrlwUrG681DZ+HiwE5Ou27ljqwHVJMKUAjF6XzX4iimYE9lzCkt1ORqZg4NVFaz
	2yE0Lv30CEdqsfAU2wcr4dJpdfL5ftItshaaIMWm9+hr68VNBntkYKEo05/JnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720191378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AahIyeUxEOXPkcxh7Z9J8AR0Ba4a05ciMN96FSEh7YU=;
	b=msrsayCg6+hc3nNKtVEXcAPQwQJBcaoiLKkmY58j9jHhGXM2C9lMscoGkZzoVmVAkGMJFL
	c7nAL+t2kKm7qrBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Riccardo Laiolo <laiolo@leaff.it>
Cc: Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>,
	linux-rt-users@vger.kernel.org
Subject: Re: Kernel instability using Marvell mv88e6xxx DSA
Message-ID: <20240705145617.JvhFKYFV@linutronix.de>
References: <e0fda694-ed7e-4f88-980b-f8a955ede802@leaff.it>
 <875xu6fi42.fsf@kurt.kurt.home>
 <301ffa8d-554a-47b8-9fc6-e510308d378c@leaff.it>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <301ffa8d-554a-47b8-9fc6-e510308d378c@leaff.it>

On 2024-07-01 08:23:26 [+0200], Riccardo Laiolo wrote:
> Hi, sorry for my late reply,
Hi,

> Enabling CONFIG_DEBUG_ATOMIC_SLEEP and CONFIG_PROVE_LOCKING the kernel im=
age became too big and overlapped the DT once loaded.
> So I went through menuconfig and disabled many unused drivers and feature=
s.
>=20
> Then for some days, I couldn't get any kernel panics at all (I think I ha=
dn't left the system running long enough).
> In the past week, I've collected the three attached panic logs.
> I can't see any correlation among the logs. I'd say there are some hardwa=
re issues,
> but it couldn't be the case since I know the same board works fine with a=
 non-RT image.
>=20
> [ 2857.996307] ------------[ cut here ]------------
> [ 2857.996316] Current state: 0
> [ 2857.996336] WARNING: CPU: 0 PID: 0 at kernel/time/clockevents.c:319 cl=
ockevents_program_event+0x124/0x130

This is odd. According to this warning, the clockevent device unused
(CLOCK_EVT_STATE_DETACHED).

> [ 2857.996479] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff80000=
9d41500
> [ 2857.996488] Call trace:
> [ 2857.996489]  clockevents_program_event+0x124/0x130
> [ 2857.996493]  tick_program_event+0x58/0xa4
> [ 2857.996499]  hrtimer_start_range_ns+0x304/0x34c
> [ 2857.996506]  tick_nohz_stop_tick+0x108/0x1d0
> [ 2857.996511]  tick_nohz_idle_stop_tick+0x78/0xd4
> [ 2857.996516]  do_idle+0x244/0x310
=E2=80=A6
> [ 2857.996592] Unable to handle kernel execute from non-executable memory=
 at virtual address ffff80000aa4bc20
=E2=80=A6
> [ 2857.996666] pstate: a00000c5 (NzCv daIF -PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--)
> [ 2857.996671] pc : __key.3+0x0/0x10
> [ 2857.996678] lr : clockevents_program_event+0xa8/0x130
=E2=80=A6
> [ 2857.996747] Call trace:
> [ 2857.996748]  __key.3+0x0/0x10
> [ 2857.996753]  tick_program_event+0x58/0xa4
> [ 2857.996757]  hrtimer_start_range_ns+0x304/0x34c
> [ 2857.996763]  tick_nohz_stop_tick+0x108/0x1d0
> [ 2857.996768]  tick_nohz_idle_stop_tick+0x78/0xd4
> [ 2857.996773]  do_idle+0x244/0x310
And this occurred right after. That `__key' should be in the data
section, not .text. I guess it jumped to the wrong thing but then the
whole struct clock_event_device is probably garbage.


> [ 4386.503700] Unable to handle kernel paging request at virtual address =
0000000000003fb8
Okay. NULL pointer=E2=80=A6
> [ 4386.503733] Unable to handle kernel NULL pointer dereference at virtua=
l address 00000000000000b0
another=E2=80=A6
=E2=80=A6
> [ 4386.504061] Insufficient stack space to handle exception!
finally an end

> [ 4386.504174] Kernel panic - not syncing: kernel stack overflow
=E2=80=A6
> [ 4386.504178] SMP: stopping secondary CPUs
> [ 4387.504180] SMP: failed to stop secondary CPUs 0-2
> [ 4387.504188] Kernel Offset: disabled
> [ 4387.504190] CPU features: 0x00000,00800084,0000420b
> [ 4387.504192] Memory Limit: none
> [ 4387.504197]=20
> [ 4387.504198] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [ 4387.504199] WARNING: inconsistent lock state
> [ 4387.504201] 6.1.55-rt16 #1 Tainted: G        W        =20
> [ 4387.504203] --------------------------------
This report does not make sense=E2=80=A6
=E2=80=A6

> [ 1073.126275] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
let me ignore this one
=E2=80=A6
> [ 1247.450882] BUG: spinlock bad magic on CPU#1, ktimers/1/25
> [ 1247.450894]  lock: 0xffff0001f6fa8a08, .magic: 00000000, .owner: <none=
>/-1, .owner_cpu: 0

magic zero? Not initialized?

=E2=80=A6
> [ 1247.450917] Call trace:
=E2=80=A6
> [ 1247.450952]  do_raw_spin_lock+0x108/0x130
> [ 1247.450959]  _raw_spin_lock_irqsave+0x78/0xb0
> [ 1247.450965]  rt_spin_lock+0x64/0x10c
> [ 1247.450970]  __run_timers+0x60/0x3c0

This is likely to be the timer_base::lock which is unlikely to be not
initialized.

=46rom what I have seen here, I would assume it is a hardware issue and
the memory seems to become zero initialized.

Sebastian
