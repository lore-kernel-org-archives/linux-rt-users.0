Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A641442F
	for <linux-rt-users@vger.kernel.org>; Tue, 17 Dec 2024 11:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734435295; cv=none; b=MB20W7oYJPo4SO3XyiQB3t22OzM881+17jXccFXRD0G1UqsgqRuQIUwdlL7F+hitUOr3EVff04IHbXSdzrzbVvAtfzj0bIIBo+xZK8Hn9zItwjGKe1lDRD4EG4QzWwdGbJe4b7SPy0rABZtiC5WkN6OVtfIBaA0dWLek0JarzFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734435295; c=relaxed/simple;
	bh=AFo4NNY+5EcHbSx4900xLjFw9jEw92fpoT3CYU/iItY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dGi0GyWnG4oaalhInS+zbxLANH79C7YOfMhxBCfaJJA+957Ix/5xmbN8Okqm6YGHCFy2v9auYLTGiv++WksR/yUF+Cuz4IHTJKUulZxTC5BnQTvqRIrGBY1q+/Zx5/GPcdGgZzQZ5kn9BBPHZnua9PaMv8zTCGjk0B6CxRfehqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 968BC1063;
	Tue, 17 Dec 2024 03:35:19 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BAD563F528;
	Tue, 17 Dec 2024 03:34:50 -0800 (PST)
Date: Tue, 17 Dec 2024 11:34:43 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Petr Tesarik <ptesarik@suse.com>, linux-rt-users@vger.kernel.org
Subject: Re: Lazy preemption on arm64
Message-ID: <Z2Fh09GyYx09Mx1_@J2N7QTR9R3>
References: <20241216190451.1c61977c@mordecai.tesarici.cz>
 <Z2B5y3HiLuRHPfdv@J2N7QTR9R3.cambridge.arm.com>
 <20241217073151.5aa2352a@mordecai.tesarici.cz>
 <20241217085031.Wh45Bd2r@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241217085031.Wh45Bd2r@linutronix.de>

On Tue, Dec 17, 2024 at 09:50:31AM +0100, Sebastian Andrzej Siewior wrote:
> On 2024-12-17 07:31:51 [+0100], Petr Tesarik wrote:
> > V Mon, 16 Dec 2024 19:04:43 +0000
> > Mark Rutland <mark.rutland@arm.com> napsáno:
> > 
> > > On Mon, Dec 16, 2024 at 07:04:51PM +0100, Petr Tesarik wrote:
> > > > Hi all,
> > > > 
> > > > what is the plan for implementing PREEMPT_LAZY on arm64?
> > > > 
> > > > There used to be RT patch series which enabled lazy preemption on
> > > > arm64, but this architecture was "sacrificed" in v6.6-rc6-rt10, as
> > > > collateral damage of switching to PREEMPT_AUTO.
> > > > 
> > > > IIUC lazy preemption is currently implemented only for architectures
> > > > with CONFIG_GENERIC_ENTRY, but there is no inherent dependency on it.
> > > > So, is the plan to convert arm64 to GENERIC_ENTRY (and then get
> > > > PREEMPT_LAZY for free), or is somebody working on CONFIG_PREEMPT_LAZY
> > > > for arm64 without that conversion?  
> > > 
> > > I don't think there's an agreed upon plan either way.
> > > 
> > > Jinjie Ruan has been looking to move arm64 over to GENERIC_ENTRY:
> > > 
> > >   https://lore.kernel.org/all/20241206101744.4161990-1-ruanjinjie@huawei.com/
> > > 
> > > AFAICT, the only bits that we get "for free" from GENERIC_ENTRY would be
> > > the logic in raw_irqentry_exit_cond_resched() and
> > > exit_to_user_mode_loop(), and all we'd need to enable this on arm64
> > > as-is would be as below.
> > 
> > @bigeasy: Would it be OK for you to add the below patch to the next
> > 6.13 RT patches?
> 
> This bits below are actually the same ones I made last week. I stopped
> there because it was late and I didn't find GENERIC_ENTRY nor a
> TIF_NEED_RESCHED check in arm64 so I paused. Where is this?

Currently arm64 doesn't use GENERIC_ENTRY; people are working on that
(see the link above), but it's likely to take a short while. IIUC
there's no strict dependency on GENERIC_ENTRY here, unless I'm missing
something?

For TIF_NEED_RESCHED, arm64 relies upon the core code to call
set_preempt_need_resched() (e.g. via preempt_fold_need_resched()) to
fold that into thread_info::preempt::need_resched. That's checked by
arm64_preempt_schedule_irq(), which reads thread_info::preempt_count,
which is unioned with thread_info::preempt::{count,need_resched} such
that the two fields can be checked together.

> Other than that I would be happy to take it then hoping arm64 does the
> same.

If PREEMPT_LAZY is something that people need urgently then I can go
turn the hack into a proepr patch and see if we can queue that ahead of
the larger rework for GENERIC_ENTRY.

> > Mark tagged it with "HACK", but to me it actually looks just as good as
> > the good old (pre-PREEMPT_AUTO) arm64 patch. ;-)
> 
> The old lazy-preempt had also tweaks in should_resched() and
> __preempt_count_dec_and_test(). So it is slightly different.

Hmm... what needed to change there?

Currently we're relying on the union trick to check both
thread_info::preempt::{count,need_resched}, where the latter should have
TIF_NEED_RESCHED folded in (but not TIF_NEED_RESCHED_LAZY), which IIUC
is sufficient?

Mark.
