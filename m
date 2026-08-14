Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D864398EB
	for <linux-rt-users@vger.kernel.org>; Fri, 14 Aug 2026 09:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786698486; cv=none; b=aELE9kvXqRIHZdZnaGbV6o6k9wP14coRSEIQMIFyaM5Q4tGNOefrOtYu9CGLC9mUTyh8AnCQrLmWbhM3gee1ExsCIkohQt1fbWERS5hz8yoYh+92n6uUuAeWb+Bqr+6j08SERYEbA3G0fX1q1Y/FHvK8fBGwWLGZaIVsqOS4y+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786698486; c=relaxed/simple;
	bh=sW1l6JGNXHhuat07FZ4cs1fyuVVPwoHgze0CG5604Eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X17yQcqk+blc5WdAZccP7yKkLt2/K0cg7mKki7SVvqS5JXQEkE7gYvO15JCUzBr2iq3Ug2em64O4uaZYTBsFsdmQgTv9NsCkOcXzoujvMfxzkT3psFu+XGSMT9zjZ7im9VlwSvhw+BRwYjDeS7VXiNxaswuFDz7ZM0ZInLry0BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Tb3v1958; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dugWVkE8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Tb3v1958";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dugWVkE8"
Date: Fri, 14 Aug 2026 11:08:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1786698482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x6i50PAcxL42VjukSH0m6juTeYnUKf2/ioi4A88ixys=;
	b=Tb3v19585Lvmamd5e1kP2S6+ZauWzDDM7tmmX46AguRwRn9QrfHJqqwdKV9ecTHvwHO7LF
	zHTmQkSAmxesQHpp5LScQfnaIuP39JPw+mpMMAuPdyEs+CDcE8tODzCVRq6EIjTLM2/QzW
	LDFpj4JYWtBTi4ff/Ok9iUVZxO78Ju6QhBhEgowAz7IAezHYavUt5jTxZQOyeO+kYEPzBl
	NfARNNCthLK1kZV8TgTeWflsBoIsMjHxkruNPSSMdV3KFALCj9XPZSwXdbOZFqPwzF2Ki8
	bi8S6+RQhxT1SWvGU1e7ZfRkrKfHTO7lYfJW/oDCpvhf9vtE+brZWaBWgkjwrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1786698482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x6i50PAcxL42VjukSH0m6juTeYnUKf2/ioi4A88ixys=;
	b=dugWVkE8Dkkht1N/ucJVNpVOYccLf6OB93wP1WKK5dVVMHJz1ZT8qXoSKN2AUCpHlNQd7t
	CLbjkVAFa65e44Bg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: John Kacur <jkacur@redhat.com>,
	"Ahmed S. Darwish" <darwi@linutronix.de>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>,
	Lukas Beckmann <lbckmnn@mailbox.org>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH v2] cyclictest, cyclicdeadline: Exit with failure when
 breaktrace threshold is exceeded
Message-ID: <20260814090801.lZ8dlRaB@linutronix.de>
References: <20260806120732.1371118-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260806120732.1371118-1-costa.shul@redhat.com>

On 2026-08-06 15:07:31 [+0300], Costa Shulyupin wrote:
> cyclictest and cyclicdeadline always exit 0 even when the latency
> threshold set by --breaktrace is exceeded, requiring test harnesses
> to parse output or json to detect a failed test.
> 
> Set ret to EXIT_FAILURE when break_thread_id is set, indicating the

This is misleading because 1 is also returned if you use the wrong
options, are now allowed to use the higher priority. You can't set it to
failure and claim in the docs that the threshold has been reach. This
might have happen, there might be another reason.

Why not pick a dedicated exit code value for this scenario and document
it as such and use it for this purpose only.

> breaktrace threshold was hit.  The exit code enables shell expressions
> like "cyclictest ... && echo PASS" and seamless integration with testing
> frameworks.  Also pass ret to rt_write_json() in cyclicdeadline so the
> JSON output reflects the failure.
> 
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

Sebastian
