Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FFE49552B
	for <linux-rt-users@vger.kernel.org>; Wed, 23 Sep 2026 12:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790166919; cv=none; b=lLQQGka1gUCodVyOg9Qps8GTvABpicyEmclJtA16pqJFNUqOev9GdVmrkpaSNQFGIj0nZAs1JsO2FyQMKs6/+BDz/LFodtp9CKSTWbJonYH0PWV63WpSBQucmtvWy075zZ4qwg9iWhMRCB3HFFGQzEyJAGU7grNslOaRvHLLDS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790166919; c=relaxed/simple;
	bh=ojqt1xIIogDn5ebEyeFAM7Tw+5usEkOIFahDILSWCWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJH4DtPUCLd39+t9Ten81JbN0kW4g8C4ZngUC/tWG16XF9x5tG6j5Hds+/SdEpIdENdFgJewNYdLSFfrYGr0Z9d7MQxlnzRFmOV7E0ty0GLuQnCu40ut+e4723TfSStGX3npDVQ3aubdh2TUBenWqpfR2GDX3x4LUiPK6kifKfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h4yyb/Sb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MuRIBctN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h4yyb/Sb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MuRIBctN"
Date: Wed, 23 Sep 2026 14:35:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790166914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X7BwxLoKSgDeM8NaU9hPe9UY4bzVSVKpQ8Pfx2JPTho=;
	b=h4yyb/Sb3oZc6TozvgLadEhLdVGkVhla1BFKFmXI2LEWsJijidjdhQB+SwZR3kGRcuoi3o
	+k2OCAUnsOiQ7Sx9K1xhMhLC1rM46E6B0jBVB7SVgpy7ktssm07GwCLBlO0TfiT1JGLpsr
	3ButkU9UWjnt7fC4ATRfaAhN3gKDMmJIjWlhp1R0xPuLoN/zSPCttboBom3rNNVv3s4k64
	JZUV7CE6k5dKR5b2HcqWIY/BPu810aOjV2mAoeny+wXxIjy+Y5F4MswPEZnpnztioeav/D
	BOwyYh/ZuFsHUrcuPwHhR+twXfGPsRYRR6PKslrer87B6RZr5i7Ta1gsFK7yeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790166914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X7BwxLoKSgDeM8NaU9hPe9UY4bzVSVKpQ8Pfx2JPTho=;
	b=MuRIBctNy5mH8hwcFrZvxluCw92qFvcbji7a7xUFyujmIJhDoQ/kUuUovEjqHHU80oGZYQ
	SLHXGvyXlipgqrDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Costa Shulyupin <costa.shul@redhat.com>, John Kacur <jkacur@redhat.com>
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>,
	Lukas Beckmann <lbckmnn@mailbox.org>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH v3] clictest, cyclicdeadline: Exit with failure when
 breaktrace threshold is exceeded
Message-ID: <20260923123513.IJnaN87n@linutronix.de>
References: <20260824101852.2237494-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260824101852.2237494-1-costa.shul@redhat.com>

On 2026-08-24 13:18:52 [+0300], Costa Shulyupin wrote:
> cyclictest and cyclicdeadline always exit 0 even when the latency
> threshold set by --breaktrace is exceeded, requiring test harnesses
> to parse output or json to detect a failed test.
> 
> Set ret to 2 when break_thread_id is set, indicating the breaktrace
> threshold was hit.  The exit code enables shell expressions like
> "cyclictest ... && echo PASS" and seamless integration with testing
> frameworks.  Also pass ret to rt_write_json() in cyclicdeadline so the
> JSON output reflects the failure.
> 
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

John, does this look good to you?

Sebastian
