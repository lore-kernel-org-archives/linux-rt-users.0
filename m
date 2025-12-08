Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729D42EC57C
	for <linux-rt-users@vger.kernel.org>; Mon,  8 Dec 2025 15:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765209496; cv=none; b=VzhLR6bjL3GdeP5D81YQ3LN5O6SBVdwtCR8zr/0APeq1KURxSKrI2Zl0gBOSTvgDmQQnrOI7Drz3yhQeJX4eVXdIxk9OSpwyjJSexNo5hqk9iTVCiAwbA4LiysxCHbyNw6g74Cppuk9CKkHprCBK6qrYN2SlU+qB+JnpI4S++Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765209496; c=relaxed/simple;
	bh=JGggKbleudk8lA+aNo1n/Ix7aeL+ih6dJN61Aky6LOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFQIG4duyHpcjz4hroO5X0iZnQGtguqXLPQB91HU9YupnR8o8yGWnDiRiQ5mEVUlTA6OhWpLasjbxCgZkywNUCiCOATHgel7ZNcg4mGGoPLZ39Wvy40FdNELCKwGl45rxEk/aNDclS9gGNCzkrnwPVttyOfDbFvbWQHEjz4lDkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WEse7F2R; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=89+upyCI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WEse7F2R";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="89+upyCI"
Date: Mon, 8 Dec 2025 16:58:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765209492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wWpRDQ+aJBoo+jjV3aArFLZnIZH47Ly+oWJzHnx6VvQ=;
	b=WEse7F2RWv3dVLtQfUAXFhWV7nWfrXi1t1nCKMw3Bdbc0T8FfjI2yMuudlaIi9MtfSLdgS
	uOcOs6qikKzy/cuQ2drVPhh9yIOw6x83runoTqr9lgVJZrGYeK3E8CbJl63Nijz9FiJYh6
	OlGS572vQ2o+p/1ihL7wpHmXCo3SSaKWICe8Z5EJQhfJjS9k+qixRbkenS+az38jAr72N0
	tQJTL7/cQE6GJSRz04NKyFGRI7ZJ/il67MHC///Rl7EXblg5vxKAGfev3Yfe8BTStfCKMC
	+F7GqotNWY+GtwoAQQV7plko/Zk0SfwWBDcw28pjc2ClHfwQNbtypDR6kYPRAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765209492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wWpRDQ+aJBoo+jjV3aArFLZnIZH47Ly+oWJzHnx6VvQ=;
	b=89+upyCIhYXdVmjIuKhRYRIU7U4Rxfsm/R6xRE+/fRse3rP9PXfnysBw2IQ/U8Ov7YQ8oo
	LDzHiYrOc3iqawAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Michael Schanne <michael.schanne@gmail.com>
Cc: linux-rt-users@vger.kernel.org
Subject: Re: Random lockups with i915 driver enabled
Message-ID: <20251208155811.Gb4m8Z9J@linutronix.de>
References: <CAC_kJhQ53MGieN29Kmx96bk-8hhnLb_7bp7cb_kFQ+Hf-_Gtgg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAC_kJhQ53MGieN29Kmx96bk-8hhnLb_7bp7cb_kFQ+Hf-_Gtgg@mail.gmail.com>

On 2025-12-03 16:23:01 [-0500], Michael Schanne wrote:
> Hi,
Hi,

> Can anyone suggest any debug techniques to nail down root cause when
> the next lockup occurs?  Or are there any potential i915 fixes I could
> try out?

An 8250-UART would be probably help.
Does lockdep (CONFIG_PROVE_LOCKING) and/ or CONFIG_DEBUG_ATOMIC_SLEEP
complain?
Can you setup pstore and use it for locking?
Does your BIOS reset your memory on reset? If not, and you can force a
reset in the lockup case, you could try to stuff some information into
the tracing buffer. See 
	https://docs.kernel.org/trace/debugging.html#persistent-buffers-across-boots


Can you try to use the XE driver instead of i915?

> Hardware: Intel i5-6500TE quad core CPU (Skylake), 16 GB RAM
> 
> Thanks,
> Mike

Sebastian
