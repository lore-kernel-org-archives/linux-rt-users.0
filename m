Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056D813A3ED
	for <linux-rt-users@vger.kernel.org>; Tue, 17 Dec 2024 12:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734438206; cv=none; b=qciZJGAY3nDzxckEhAVT8G4RSnFcMZqi/n8GU6Ws807kQaKu82EoaVCn6PhsI+e1N0CDdJqQlLzls4SiHVRI8wNFkf067SHXvAZFPclfuCxqpKWzrfI/1hN9DZ57HETt3OYBj2okfudirT0lXbucHps7a4EBtSL3iLuBVBQtyVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734438206; c=relaxed/simple;
	bh=JqMhS3PgjEkVymZf3fcYcdzoYu0N0kmWK6juW1t9kVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EjRwkdpeeuwD8jDDQ1hcNdxBCOjtnrfpUmqRV9VgOYUtfWm8ckd2ELKLHHwe74TIGchyQ+cg/sic1RyeZStxim/ypMVEOzBPq8HaG/o0qQJC3cvPivesb1QJe5MmpCdnaz7pe7LuUAUcDH8BqjqfoPLkDLrjnh2NWzc8niJueiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43CCF1063;
	Tue, 17 Dec 2024 04:23:50 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 51BA73F58B;
	Tue, 17 Dec 2024 04:23:21 -0800 (PST)
Date: Tue, 17 Dec 2024 12:23:18 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Petr Tesarik <ptesarik@suse.com>, linux-rt-users@vger.kernel.org
Subject: Re: Lazy preemption on arm64
Message-ID: <Z2FtNgp_OVIy0D36@J2N7QTR9R3>
References: <20241216190451.1c61977c@mordecai.tesarici.cz>
 <Z2B5y3HiLuRHPfdv@J2N7QTR9R3.cambridge.arm.com>
 <20241217073151.5aa2352a@mordecai.tesarici.cz>
 <20241217085031.Wh45Bd2r@linutronix.de>
 <Z2Fh09GyYx09Mx1_@J2N7QTR9R3>
 <20241217115931.wjw_HO2V@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241217115931.wjw_HO2V@linutronix.de>

On Tue, Dec 17, 2024 at 12:59:31PM +0100, Sebastian Andrzej Siewior wrote:
> On 2024-12-17 11:34:43 [+0000], Mark Rutland wrote:
> > On Tue, Dec 17, 2024 at 09:50:31AM +0100, Sebastian Andrzej Siewior wrote:
> > > This bits below are actually the same ones I made last week. I stopped
> > > there because it was late and I didn't find GENERIC_ENTRY nor a
> > > TIF_NEED_RESCHED check in arm64 so I paused. Where is this?
> > 
> > Currently arm64 doesn't use GENERIC_ENTRY; people are working on that
> > (see the link above), but it's likely to take a short while. IIUC
> > there's no strict dependency on GENERIC_ENTRY here, unless I'm missing
> > something?
> 
> No, not really, that is perfect.
> 
> > For TIF_NEED_RESCHED, arm64 relies upon the core code to call
> > set_preempt_need_resched() (e.g. via preempt_fold_need_resched()) to
> > fold that into thread_info::preempt::need_resched. That's checked by
> > arm64_preempt_schedule_irq(), which reads thread_info::preempt_count,
> > which is unioned with thread_info::preempt::{count,need_resched} such
> > that the two fields can be checked together.
> 
> All sounds fine. Now, if that bit is set, we need schedule() before
> returning to userland. I didn't it initially but now I did:
> 
> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
> index b260ddc4d3e9a..2e2f13ce076da 100644
> --- a/arch/arm64/kernel/entry-common.c
> +++ b/arch/arm64/kernel/entry-common.c
> @@ -132,7 +132,7 @@ static void do_notify_resume(struct pt_regs *regs, unsigned long thread_flags)
>  	do {
>  		local_irq_enable();
>  
> -		if (thread_flags & _TIF_NEED_RESCHED)
> +		if (thread_flags & _TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY)
>  			schedule();
>  
>  		if (thread_flags & _TIF_UPROBE)
> 
> With that piece we should be fine.

Yep, I had that in my HACK patch:

  https://lore.kernel.org/linux-rt-users/20241217115931.wjw_HO2V@linutronix.de/T/#m12eece66786a3a207e4e952bdf58570ab75c6a89

... so it sounds like we're on the same page. :)

> > > Other than that I would be happy to take it then hoping arm64 does the
> > > same.
> > 
> > If PREEMPT_LAZY is something that people need urgently then I can go
> > turn the hack into a proepr patch and see if we can queue that ahead of
> > the larger rework for GENERIC_ENTRY.
> 
> I would appreciate it. However if there is reason to delay it I could
> hold to it for some time…

I'll try to spin it as a proper patch later this week (and will Cc the
folk here, along with Jinjie, etc); it'll be up to Will and Catalin as
to whether they're happy to pick it up, but given it's small I suspect
that'll be fine.

> > > > Mark tagged it with "HACK", but to me it actually looks just as good as
> > > > the good old (pre-PREEMPT_AUTO) arm64 patch. ;-)
> > > 
> > > The old lazy-preempt had also tweaks in should_resched() and
> > > __preempt_count_dec_and_test(). So it is slightly different.
> > 
> > Hmm... what needed to change there?
> > 
> > Currently we're relying on the union trick to check both
> > thread_info::preempt::{count,need_resched}, where the latter should have
> > TIF_NEED_RESCHED folded in (but not TIF_NEED_RESCHED_LAZY), which IIUC
> > is sufficient?
> 
> The old lazy-preempt dates back to around v3.0-RT+. The logic back then
> was slightly different and had also a counter (similar to the counter
> used by preempt_disable()) so we had to ensure preempt_enable() does not
> schedule if the lazy-counter > 0 and the caller was not a RT task.
> With the improvements over time and the current design a lot of the old
> cruft simply removed. So nothing to worry :)

Phew, thanks for confirming!

Mark.
