Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48CC4078DA;
	Fri,  2 Oct 2026 06:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790922858; cv=none; b=T8oIosBfQ3e1Yhsa6dQY/bLjA+Qh1VGIpF8PJnaFp1gz2bB3ybxwiFzOw3cpWpJrVIOXBQc1Tw9YgXop1hHLe/GY5dTlw97tzDuzoSfs8pLHkNWdJIDDI3uHly5PTG82FbIyQojjLB6Nr9WKNw/6j0Ln9YgNKzjEG51mT87Q77o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790922858; c=relaxed/simple;
	bh=7UL10Eop3LfZ3K3zEdx7tP6vRDneIf4EHM222sv8oro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EoBS9/26dM1pKB4oQhplH+oYyKUoX41e9HwK1Efs0q+44ItLsNG4KMH/ChgVs5j+n5A9l1bcEjrs1xlsMtPiq5nkIZpEZDJSqfxveauFQhiHyeu90EFp3f+OHQAi3+pxsA73rLaiDxDIPJn0P5I3hgJFdtGTVcmtSd+gR1QCifw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ct4X7ayi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TQjnkHcs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ct4X7ayi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TQjnkHcs"
Date: Fri, 2 Oct 2026 08:34:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790922849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e6mAAEYjoRuHHTwbuDb1OVAom9j7pGpLsqxuj8rcemI=;
	b=ct4X7ayiOC1BZjaUHcGUPueGc22Z8pTMSU5aOZLk+s+0Rhxe89oNT6nBNdn6Bv6f+1Iejd
	6IjANZi43sYO0gcX4gQfzhNYhgsA52IlcP8/HUO7ZRb4f+HDg6v7Zh6ifBIZUP85+E4H5C
	E868Je9G1T3JEl2NC6stdi9DwuNU+6bkUzM55yYrxkoPkv3lN6x8aLAb+xZK9lFqj4yjb2
	j3WNvm57tV6PI3LzKGu3T4VkRta4MOgWOvZzxdM3WTayBNu6XpIoAQXXvGX80CnVHKBc6E
	mLpvdq4WEyvQigJMjrcfG3iF6mMPGoIyNGKlUVZAtZ1JNryRDSQNSwoeUKRaAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790922849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e6mAAEYjoRuHHTwbuDb1OVAom9j7pGpLsqxuj8rcemI=;
	b=TQjnkHcsj/Gsw9wKWB+CFEXUuazhSU+ErW4s5cMDN6Gu3IqskJIeTclDuFm7red2M7l1kz
	clPXJBIZiBDjLFCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-rt-devel@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Maarten Lankhorst <dev@lankhorst.se>
Subject: Re: [ANNOUNCE] v7.3-rc4-rt1
Message-ID: <20261002063407.7BkSj6Yk@linutronix.de>
References: <20260922144152.x2J3_tNz@linutronix.de>
 <37b02446-1e54-4ea1-9532-11056053de6c@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <37b02446-1e54-4ea1-9532-11056053de6c@linux.ibm.com>

On 2026-10-02 10:14:51 [+0530], Shrikanth Hegde wrote:
> It is nice to see a little progress has been made atleast.
> But it was mostly my mistake that I couldn't get time to work on it.
> 
> Let me see if we can atleast get these ppc patches upstream.
> Most seems sensible to me.
> 
> But then would come heavy lifting on function and performance verification.
> That's a different beast altogether.

Right. I remember the 32bit ports (e300, e500) were okay and from 64bit
I remember just e6500. I know John has a G4 and he didn't complain :)
So sadly it is almost just Book-E that I had.
The recent testing I did was on qemu (and there I hit the one bug I
reported) so it is just works or !works.

Sebastian
