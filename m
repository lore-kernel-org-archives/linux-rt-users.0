Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56241C3F36;
	Mon, 10 Feb 2025 10:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739182705; cv=none; b=iuVkC3Yt8V7Kh1hqEYOuTUjRh1Q7DzqGZC0IJc8HNWo5k65lQFjkuRmg2/PbNZIVYREhtwdW4mDFWRBQ3UIyghwKwMos4Ki0R3+Qj/hdlOOOsInxKSoezADmApZxErZGTHKERHd29wgxvGZ95ZqRp8o/6cd3/OPh9NlTxg2L/Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739182705; c=relaxed/simple;
	bh=eSvTyMDnhmkmFcppWwSm3V3i6quSbs6CTcyP13KbZDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czofnmAwNng5Z/clVsz1PlRajBAVYGJ3i6l4LL8BOLk6gV7h4MXBnmZrHg+w0lkHL6FBXc8rqocwCe/fE7efFpmObAH5qsEb+PyNds0vBQuURakRk8BCwt0Pssd7YeBjxz6f6MuLspDOwsOZbhYEMjG1IlmomZeM/4N4PDRi7Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JOlncvx5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lAJmG8ai; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JOlncvx5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lAJmG8ai"
Date: Mon, 10 Feb 2025 11:18:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739182702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oONuz56ffauYF3gP0eUnBA886a0FrJODrLFYvs7U1Ig=;
	b=JOlncvx5rr2rWhQOyUyuJaQDJ3Kc87n9AxLdVgpg85mVVsRSuvpS18oo2i+EzhXDtx5o9l
	X9BYY2sQ9Fn7pvLm4PrdapzT1iyTSzYibu4OxPE3oGPPRmiMfMJYe0Q8GRnW1jXojazg9Y
	o51FlNl88dS/auoi7sRkIvkAICWEjzkNOeXAxdhuxeSAPIdhHu9CH/E/CP8jBDMXQw8uZm
	e9tEDl5/eD5/mZgKz7ABSo2TjmNBIFm0hdzblu+XWo1gOxP4h1eOVmCWG4xPbH0cv/C78Y
	4fuSsnusUk5Ofa6ftD/lOwAhnDM6AUt8ffPPvkb501Phtd2PpOYr2mYSFJQbZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739182702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oONuz56ffauYF3gP0eUnBA886a0FrJODrLFYvs7U1Ig=;
	b=lAJmG8airbZW1/09009CVPUxyO1FpKLB8cXVjv4WV5CTiHr39O4f1zqwK4K3VqODHtQhY9
	N69kUIM+hYWvZ2CA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: kazuhiro3.hayashi@toshiba.co.jp
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	cip-dev@lists.cip-project.org, tglx@linutronix.de,
	rostedt@goodmis.org, linux-rt-users@vger.kernel.org, pavel@denx.de
Subject: Re: RE: [PATCH 4.4 4.9 v1 2/2] mm: slub: allocate_slab() enables IRQ
 right after scheduler starts
Message-ID: <20250210101820.lXceJi98@linutronix.de>
References: <1738629964-11977-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
 <1738629964-11977-3-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
 <20250204081813.7qsvLFsU@linutronix.de>
 <TYCPR01MB11385E033624D2D9D93992A95E1F22@TYCPR01MB11385.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <TYCPR01MB11385E033624D2D9D93992A95E1F22@TYCPR01MB11385.jpnprd01.prod.outlook.com>

On 2025-02-10 07:20:35 [+0000], kazuhiro3.hayashi@toshiba.co.jp wrote:
> Hello,
Hi,

> The question here is whether to insert SYSTEM_SCHEDULING is acceptable
> or not in LTS phase. This addition would change behavior of future fixes
> or out-of-tree codes that check system_state, so adjustments similar to
> the mainline series[2] (2/17 ~ 15/17) are needed for them.
> Can I ask if it's recommended to introduce SYSTEM_SCHEDULING even in LTS?
> It's v4.4-rt specific topic but I think similar discussion is regularly
> happening in newer -rt branches and LTS branches where PREEMPT_RT is merged.

In general I try to have the same code if it is easily possible. A few
examples where this was not the case:
- The printk code, as work is in progress, was never fully backported.
  The changes between kernel versions were small and there was little to
  none user visible changes. However changes under the hood were usually
  big so in general it was not worth the effort.

- scheduling wise, we went from PREEMPT_LAZY to PREEMPT_AUTO to
  LAZY_PREEMPT. Fixes within one implementation went all the way down
  but the implementation as a whole was never backported. PREEMPT_AUTO
  could be considered as half way done but nobody complained about
  something in particular. It was "recently" discussed whether or not to
  backport LAZY_PREEMPT to replace PREEMPT_AUTO in some of the lower
  kernels but the changes required to backport it would be huge because
  the scheduler in particular changed. So this is hard to justify.

What questions can you ask?
- Do you backport code that relies on `system_states' or did so in the
  past?
- Is more likely to backport code from before v4.13 or after? Either way
  you need to look at this.

> Best regards,
> Kazu

Sebastian
