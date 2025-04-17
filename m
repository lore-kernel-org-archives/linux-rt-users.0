Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C0C219A76
	for <linux-rt-users@vger.kernel.org>; Thu, 17 Apr 2025 07:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744875669; cv=none; b=P3PHUI34A181NojLMCuWKziCC4KjBmGDn/yuEX6NhMkw/zUqeylmWuRkAKOPaK5H5TTDmObWLlr2jPdtGo7syrvjs6xExIztJQEEcraWR7qon/NtoqJEncRNO1O6t7hfcf5sN9nk2G+rbVt8Yq1J3IK7StIsGBOC8fo6GT1pAV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744875669; c=relaxed/simple;
	bh=h/onBgarZjooA/+rgcntDf5m/QqKU9szvu1ijizQin0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/Ql651HFpXLAeJUnXcbg4LNMxhkLAJJFYEfj7lIautCsig9oSxnmmjLYs3HkXgDtNzLlZWL+4L11NsYZimUc5Xpmvap5T8RxzWyXtZ3KOYxorv3ruCKsFVAS2E5wLaMFVE3cZhVKeSjMjcZU/m5koGiu9T1EKIelKcN+wfKpww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bUlz1i/K; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hiDIkHAi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bUlz1i/K";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hiDIkHAi"
Date: Thu, 17 Apr 2025 09:40:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744875661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w91usc76ApbfsFfJ/vhKufOGKKUR/1HuPyoh/L9bisQ=;
	b=bUlz1i/KfSJlTYrRhpxlwLVco333esOQSfwuVA87PNtq6q9lDT2h9K+p50iSAcKoRElS7v
	Uw3fE5HRJVOvAI6Q3AxJSPO4ymW8OZiNgLOhnQmvYuRqRU9swOVu60SF/HOx3dl9BSjqCh
	jJAHKZul9SPvPAFBNm4EuPWz+vLdzjPI0lkqkcuicJL7YyhdW20TUGqQJvfFJVZRmWmWPg
	sKO4IJmcuR4hAH7dlbrvaVs8y/oC8Q+fftdMlbsGL1UIxAwEPLwkg8L0ugN0WTRVbRivC0
	UuIhAXXbMF7q9YcbXxJu6j4iElaY78hMzlqr7cO0axdu/4jPkDTIgCQMWpZLRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744875661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w91usc76ApbfsFfJ/vhKufOGKKUR/1HuPyoh/L9bisQ=;
	b=hiDIkHAi8bbIke47tgcj/nYSZAY/Nqq4Lmk800DcDxDIhkU1GfXSmOzRvSf/IODdWMhByv
	2EzuPnK9AQWgo3Dg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Gautam Thaker <ghthaker@gmail.com>
Cc: linux-rt-users@vger.kernel.org
Subject: Re: seeking best steps to go from Armbian 6.12.19 PREEMPT to
 PREEMPT_RT
Message-ID: <20250417074059.1B0DxVpU@linutronix.de>
References: <CA+1+E3VC4LX5X8ANf5d1Wm7QjSJZUG=mei8E5cvBUyqcd5j3yA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+1+E3VC4LX5X8ANf5d1Wm7QjSJZUG=mei8E5cvBUyqcd5j3yA@mail.gmail.com>

On 2025-03-21 12:03:10 [-0400], Gautam Thaker wrote:
> I am currently running Armbian on rk3318 TV box. Runs great.
> 
> rk3318-box> uname -a
> Linux rk3318-box 6.12.19-current-rockchip64 #2 SMP PREEMPT Thu Mar 13
> 12:02:20 UTC 2025 aarch64 GNU/Linux
> 
> My question: what is the quickest path to get FULL PREEMPT-RT kernel
> running on my box?

The easiest way should be simply enabling PREEMPT_RT on that kernel.

> I believe I have found the Armbian sources.
> (https://docs.armbian.com/Developer-Guide_Build-Preparation/)
> 
> Are there instructions to build a kernel w/ all the same parameters as
> a currently running kernel with only change to set FULL PREEMPT-RT ? I
> would like to make least changes to configuration so that I may
> continue to boot on my hardware.

It is enough to just enable PREEMPT_RT. I would recommend to enable 
at least CONFIG_PROVE_LOCKING and CONFIG_DEBUG_ATOMIC_SLEEP in the
beginning that there is nothing wrong in the kernel that nobody saw
before. Once nothing pops up in the kernel log, then it could be turned
off.

> I used to make many RT kernels in the past, but not in the last 10
> years. I can't find current instructions. It was my understanding that
> with 6.12+ linux kernel one needs NO RT patches, but still have  to
> config FULL PREEMPT-RT and build a new kernel.

That is correct.

> Or can I change some grub option and simply reboot my current kernel?

No, that does not work.

> Gautam
> 

Sebastian
