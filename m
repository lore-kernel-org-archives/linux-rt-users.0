Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E8035201F
	for <linux-rt-users@vger.kernel.org>; Tue,  1 Sep 2026 08:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788251960; cv=none; b=AgrIxMu7EKw0aQehq7TRhTzELSXUleHIVNIoJq173QzkOOJdAiozLDPl5zU/S6vhWpOzjsL6EYsgwUU1GmEBFiLAKlKJ3656kCcoL3MIC1mFARaJBgiA+57bggDxABB68sPWDgEDKQjOHxnpCEwodGAcv90KGJD7Reql9YKwf+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788251960; c=relaxed/simple;
	bh=2obnZYjvAuaNTKMH1YvlWKxamdVKEeWAlfWUlfEMGBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xl95FGrx3LAK7k/J9Gw44wIlI20XC5d7dBECRESLfJnx5002LT2wadZ+CCEOepWKFgLMJoStuNE869iJOX3gePXuukUiHNlysIWCltTLPc1zDec5pxnOcwxy1qeDCliEkTKXC2njPRcQ77rHwQIiTg2sFn+7kdcZXGW8mEPbEds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FWL1w9I8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gMr5v7co; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FWL1w9I8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gMr5v7co"
Date: Tue, 1 Sep 2026 10:39:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788251956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2obnZYjvAuaNTKMH1YvlWKxamdVKEeWAlfWUlfEMGBc=;
	b=FWL1w9I87DrzGSKH25r+50nXPtqXW7+z4YTjlX+eorfU9LvrOCyMoWaV5GMo2/UARosEIf
	PoQ7MVwDxigMcHSNw6GIwBMetaf7V4eTK90/vP0ZSWAKkf47cgjRB+y7v18CF701zXCcAv
	ghBGd6zWwPA3SIeGYrvsBTKiqT9c3U0uGhPcuirLJN3jXWpHSTSPss5Pficna3/zKQ97xp
	tweeak6YpU/kdJl+PDfpVNjNlRBg2/QXA8r0l/msEwMsfPTk2wNIRBfExQA4NaI8i+UkNk
	i/MB1Usk2KWDOmX1zMR3FsTIcgb/0SYgA0bsJGwEAvwfsczev1qGtw5+GK0Mdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788251956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2obnZYjvAuaNTKMH1YvlWKxamdVKEeWAlfWUlfEMGBc=;
	b=gMr5v7corMhWfKt5nFS+0zgHuL9iQg4d+ve71igTuczATV8BMTAZ3MnL4QQd1mo81GDrH2
	0DVog4juRsI8j8Aw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "D, Suneeth" <suneethd@amd.com>
Cc: linux-rt-users@vger.kernel.org, John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 2/5] cyclictest: Acquire a lock before invoking
 pthread_cond_signal()
Message-ID: <20260901083915.6BnZHwip@linutronix.de>
References: <20260826132153.2476006-1-bigeasy@linutronix.de>
 <20260826132153.2476006-3-bigeasy@linutronix.de>
 <4ce24139-5f7e-4180-a290-bcc15fb4f559@amd.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4ce24139-5f7e-4180-a290-bcc15fb4f559@amd.com>

On 2026-09-01 13:49:33 [+0530], D, Suneeth wrote:
> I shall send the fix as a neatly formatted patch if the proposed fix LGTY.

Yes, please do.

Sebastian
