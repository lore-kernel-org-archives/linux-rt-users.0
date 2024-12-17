Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7A81D5CE5
	for <linux-rt-users@vger.kernel.org>; Tue, 17 Dec 2024 11:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734436777; cv=none; b=nLHd2f7QKwqHxAUEmkkAPh1WkZndjh8cPUgJLXmaYufimsqmQaqI2NBoSx4Jpy/b0slp01bcORdF3Ep8CvPLLX93LooMyl42ojktM1m1ybFrx8vh18KofPnWdQrU0NE3/0I6O2w6NNKjyqAoasLS2UZ8plNZ7zfnRZxLeAEHi18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734436777; c=relaxed/simple;
	bh=BMb9HZWnjbnX8hCQW7YgDXh+lTwIEhfCc9zfBEPdlUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kW6/MAgLuhsArFRFVegkkTHgLOKfUXRI/tX11ITqeXuu+rjlIEkJmGoJkElZ6Fvmz1fiN2UMZpijTAPXEw4//YYJJPZbZx1lwQHWWp2gBQDzuM4yQ4/de61VhSj1UwvT9mhtrw6yj3+4DEsbFNRRj9QV34QXdZ+aNRvkVjHJlRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bF+LcpWF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lq5Zx2C6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bF+LcpWF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lq5Zx2C6"
Date: Tue, 17 Dec 2024 12:59:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734436772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=20QSZtgHIIujBdj4akBuAKdKN9MGbWufaS2p56atdO8=;
	b=bF+LcpWFIRhLgbtwEs6xgVxUH3MpXrwQ6p4K+cC4IlQtdlJVge3CyB59vd9Xig4D/w8bUF
	k7jbKJqGGSnIp/ld5fnvLx4jxLnEE7yEOB5PWOb4ZmebfkVbhq9cEfAA8C6rrbSqeKnMxA
	efwMl9WiXwsaI/Emai5wQvXaAdTXi9LZiErEgaDYeyQxdCEFQAiXEaD7L8WTA57854lAHU
	ijS8x1lxWvnbWndUuHnoW6qFTghtlx2YrSO9JbfnWInMWHgR7vC0QLlyEqdTMO0FQnUEGx
	uDuIkUes7aDIC7fg5yIGO4rTd2DEZ01iknNzzNDjqOc67c4xxmwLIF8Xp+A6QQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734436772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=20QSZtgHIIujBdj4akBuAKdKN9MGbWufaS2p56atdO8=;
	b=lq5Zx2C6ELefd2JKCwZzV2lwaiS+XHI5jovey0Ix0UKM5GhQXguqHRdiP6eRNHAfM+HUXW
	XB7hEM5qlFCcLDBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Petr Tesarik <ptesarik@suse.com>, linux-rt-users@vger.kernel.org
Subject: Re: Lazy preemption on arm64
Message-ID: <20241217115931.wjw_HO2V@linutronix.de>
References: <20241216190451.1c61977c@mordecai.tesarici.cz>
 <Z2B5y3HiLuRHPfdv@J2N7QTR9R3.cambridge.arm.com>
 <20241217073151.5aa2352a@mordecai.tesarici.cz>
 <20241217085031.Wh45Bd2r@linutronix.de>
 <Z2Fh09GyYx09Mx1_@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Z2Fh09GyYx09Mx1_@J2N7QTR9R3>

On 2024-12-17 11:34:43 [+0000], Mark Rutland wrote:
> On Tue, Dec 17, 2024 at 09:50:31AM +0100, Sebastian Andrzej Siewior wrote:
> > On 2024-12-17 07:31:51 [+0100], Petr Tesarik wrote:
> > > V Mon, 16 Dec 2024 19:04:43 +0000
> > > Mark Rutland <mark.rutland@arm.com> naps=C3=A1no:
> > >=20
> > > > On Mon, Dec 16, 2024 at 07:04:51PM +0100, Petr Tesarik wrote:
> > > > > Hi all,
> > > > >=20
> > > > > what is the plan for implementing PREEMPT_LAZY on arm64?
> > > > >=20
> > > > > There used to be RT patch series which enabled lazy preemption on
> > > > > arm64, but this architecture was "sacrificed" in v6.6-rc6-rt10, as
> > > > > collateral damage of switching to PREEMPT_AUTO.
> > > > >=20
> > > > > IIUC lazy preemption is currently implemented only for architectu=
res
> > > > > with CONFIG_GENERIC_ENTRY, but there is no inherent dependency on=
 it.
> > > > > So, is the plan to convert arm64 to GENERIC_ENTRY (and then get
> > > > > PREEMPT_LAZY for free), or is somebody working on CONFIG_PREEMPT_=
LAZY
> > > > > for arm64 without that conversion? =20
> > > >=20
> > > > I don't think there's an agreed upon plan either way.
> > > >=20
> > > > Jinjie Ruan has been looking to move arm64 over to GENERIC_ENTRY:
> > > >=20
> > > >   https://lore.kernel.org/all/20241206101744.4161990-1-ruanjinjie@h=
uawei.com/
> > > >=20
> > > > AFAICT, the only bits that we get "for free" from GENERIC_ENTRY wou=
ld be
> > > > the logic in raw_irqentry_exit_cond_resched() and
> > > > exit_to_user_mode_loop(), and all we'd need to enable this on arm64
> > > > as-is would be as below.
> > >=20
> > > @bigeasy: Would it be OK for you to add the below patch to the next
> > > 6.13 RT patches?
> >=20
> > This bits below are actually the same ones I made last week. I stopped
> > there because it was late and I didn't find GENERIC_ENTRY nor a
> > TIF_NEED_RESCHED check in arm64 so I paused. Where is this?
>=20
> Currently arm64 doesn't use GENERIC_ENTRY; people are working on that
> (see the link above), but it's likely to take a short while. IIUC
> there's no strict dependency on GENERIC_ENTRY here, unless I'm missing
> something?

No, not really, that is perfect.

> For TIF_NEED_RESCHED, arm64 relies upon the core code to call
> set_preempt_need_resched() (e.g. via preempt_fold_need_resched()) to
> fold that into thread_info::preempt::need_resched. That's checked by
> arm64_preempt_schedule_irq(), which reads thread_info::preempt_count,
> which is unioned with thread_info::preempt::{count,need_resched} such
> that the two fields can be checked together.

All sounds fine. Now, if that bit is set, we need schedule() before
returning to userland. I didn't it initially but now I did:

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-com=
mon.c
index b260ddc4d3e9a..2e2f13ce076da 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -132,7 +132,7 @@ static void do_notify_resume(struct pt_regs *regs, unsi=
gned long thread_flags)
 	do {
 		local_irq_enable();
=20
-		if (thread_flags & _TIF_NEED_RESCHED)
+		if (thread_flags & _TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY)
 			schedule();
=20
 		if (thread_flags & _TIF_UPROBE)

With that piece we should be fine.

> > Other than that I would be happy to take it then hoping arm64 does the
> > same.
>=20
> If PREEMPT_LAZY is something that people need urgently then I can go
> turn the hack into a proepr patch and see if we can queue that ahead of
> the larger rework for GENERIC_ENTRY.

I would appreciate it. However if there is reason to delay it I could
hold to it for some time=E2=80=A6

> > > Mark tagged it with "HACK", but to me it actually looks just as good =
as
> > > the good old (pre-PREEMPT_AUTO) arm64 patch. ;-)
> >=20
> > The old lazy-preempt had also tweaks in should_resched() and
> > __preempt_count_dec_and_test(). So it is slightly different.
>=20
> Hmm... what needed to change there?
>=20
> Currently we're relying on the union trick to check both
> thread_info::preempt::{count,need_resched}, where the latter should have
> TIF_NEED_RESCHED folded in (but not TIF_NEED_RESCHED_LAZY), which IIUC
> is sufficient?

The old lazy-preempt dates back to around v3.0-RT+. The logic back then
was slightly different and had also a counter (similar to the counter
used by preempt_disable()) so we had to ensure preempt_enable() does not
schedule if the lazy-counter > 0 and the caller was not a RT task.
With the improvements over time and the current design a lot of the old
cruft simply removed. So nothing to worry :)

> Mark.

Sebastian
