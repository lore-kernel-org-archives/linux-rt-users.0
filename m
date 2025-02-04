Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DD419C54A;
	Tue,  4 Feb 2025 08:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738657104; cv=none; b=PLWYsktzN0B8wsXe8UXXtnFyDVpNLTrBnAjKsOtP3iho3QYoFemojs+mP6gqsjTI7LCa443QyvumeCsToT0fUQtcaEaeeG8hZ4XuRqbNmOW1YcpHhTRzslSpwU2ePgp4j0fO0UTepmih9oqtSvl5K2BDEoeLPce1Lx/C/S/h2v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738657104; c=relaxed/simple;
	bh=SUTbVLnTBbnSmMQFrFVhK44XBdRTNZ3OqnPfYXbS8xU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxJURNP4Dwxhw4dnme47bJkfB0TiXia4Ft3UHxtwRqBIS7YywPEN6lPWQeDgDJATTRBgK52TbGMceuMML6BXN/IjFNyif57VhTtyxDyilNmx6KCtjB0EWX5/0DQ84FS9IjlQbIBajabkXL8oX17yqOLHsneEosDWdBMNiduAvOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tbjYr4/4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NmZRulOG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tbjYr4/4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NmZRulOG"
Date: Tue, 4 Feb 2025 09:18:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738657095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E/o4cd1+sS1V8YVI6C37SoZJBCljbNtuj8oie5yQkUQ=;
	b=tbjYr4/4eQo//S+bpmmMk45KwHZAXZON1bPv+Ppb0wA7UF+nr0LWMW5+N4n2x3t23/08sh
	bRUJz1GlYvjfEEJmWcJzdbiWtZlxtagDkFUc7JJWsbGWeHkV7QcFp20ZKpzF2UbM6xT55o
	30ydTlrkp2a3ygYemNTw1tNCk3uNE66PFhKnCIESMqDkfNnTrKtYETnGjsFa41sCb1x2wm
	d6P5jSlC4hHa0JuFfoQC0mJJqh66nmYO/WUJRDJhpLT4lm8jvlDdq+0WyQIyGW2F5jEPNW
	X96ft+kOaj48xreegCAd7LX4Ch85wUp6lUDqpJVmvACc3iSW0EZu8kQnr206Ig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738657095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E/o4cd1+sS1V8YVI6C37SoZJBCljbNtuj8oie5yQkUQ=;
	b=NmZRulOGoc4wQzv0gG2ye7TpghyQedqNYfTOsZQhuydD+5x32vLPMGVq5QMSOLBhhtCFWS
	KFqtexfiILjfuxDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	cip-dev@lists.cip-project.org, tglx@linutronix.de,
	rostedt@goodmis.org, linux-rt-users@vger.kernel.org, pavel@denx.de
Subject: Re: [PATCH 4.4 4.9 v1 2/2] mm: slub: allocate_slab() enables IRQ
 right after scheduler starts
Message-ID: <20250204081813.7qsvLFsU@linutronix.de>
References: <1738629964-11977-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
 <1738629964-11977-3-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1738629964-11977-3-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>

On 2025-02-04 09:46:04 [+0900], Kazuhiro Hayashi wrote:
> On PREEMPT_RT kernels < v4.14-rt, after __slab_alloc() disables
> IRQ with local_irq_save(), allocate_slab() is responsible for
> re-enabling IRQ only under the specific conditions:
> 
> (1) gfpflags_allow_blocking(flags) OR
> (2) system_state == SYSTEM_RUNNING
>
> The problem happens when (1) is false AND system_state == SYSTEM_BOOTING,
> caused by the following scenario:
> 
> 1. Some kernel codes invokes the allocator without __GFP_DIRECT_RECLAIM
>    bit (i.e. blocking not allowed) while SYSTEM_BOOTING
> 2. allocate_slab() calls the following functions with IRQ disabled
> 3. buffered_rmqueue() invokes local_[spin_]lock_irqsave(pa_lock) which
>    might call schedule() and enable IRQ, if it failed to get pa_lock
> 4. The migrate_disable counter, which is not intended to be updated with
>    IRQs disabled, is accidentally updated after schedule() then
>    migrate_enable() raises WARN_ON_ONCE(p->migrate_disable <= 0)
> 5. The unpin_current_cpu() WARNING is raised eventually because the
>    refcount counter is linked to the migrate_disable counter

I think the problem is that system_state _is_ SYSTEM_BOOTING but
scheduling and/or an additional CPU is already enabled. This is why the
lock is contended. Otherwise you wouldn't get that far. 

> The behavior 2-5 above has been obsereved[1] using ftrace.
> The condition (2) above intends to make the memory allocator fully
> preemptible on PREEMPT_RT kernels[2], so the lock function in the
> step 3 above should work if SYSTEM_RUNNING but not if SYSTEM_BOOTING.
> 
> [How this is resolved in newer RT kernels]
> 
> A patch series in the mainline (v4.13) introduces SYSTEM_SCHEDULING[3].
> On top of this, v4.14-rt (6cec8467) changes the condition (2) above:
> 
> -	if (system_state == SYSTEM_RUNNING)
> +	if (system_state > SYSTEM_BOOTING)
> 
> This avoids the problem by enabling IRQ after SYSTEM_SCHEULDING.

Yes. Once scheduling is enabled any sleeping lock might be contended so
interrupts must be enabled. This is not done done unconditionally
because early boot code expects to run with disabled interrupts.
This "system_state == SYSTEM_RUNNING" looked like a sane state in
between. However, once the scheduler is up and running, interrupts in
the system are enabled and so the slub allocator needs to always enable
interrupts.

> Thus, the conditions that allocate_slab() enables IRQ are like:
> 
> (2)system_state   v4.9-rt or before  v4.14-rt or later
> SYSTEM_BOOTING        (1)==true          (1)==true
>                           :                  :
>                           :                  v
> SYSTEM_SCHEDULING         : < Problem      Always
>                           v < occurs here    |
> SYSTEM_RUNNING          Always               |
>                           |                  |
>                           v                  v
> 
> [How this patch works]
> 
> An simple option would be to backport the series[3], which is possible
> and has been verified[4]. However, that series pulls functional
> changes like SYSTEM_SCHEDULING and adjustments for it,
> early might_sleep() and smp_processor_id() supports, etc.
> Therefore, this patch uses an extra (but not mainline) flag
> "system_scheduling" provided by the prior patch instead of
> introducing SYSTEM_SCHEDULING, then uses the same condition as
> newer RT kernels in allocate_slab().

The proposal looks okay. However the verified upstream version not only
addresses your issue but also makes smp_processor_id() and might_sleep()
work in the early phase. I would prefer the upstream solution for those
two reasons.

Sebastian
