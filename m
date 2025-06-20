Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0137220C02D
	for <linux-rt-users@vger.kernel.org>; Fri, 20 Jun 2025 08:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750407416; cv=none; b=SA6JcvEkTb0GPHxkcNUNco8BGH8KxB0gGM3caCygPC5iLT6MI+iIS4/LsfgUX4NvI1xyqR69q/ewK+ICgK+RI6y06fbneQi6dM+SZFr4SZ+FvLLE7CacGm39NRdNB+gqo12ltlgnCkj/x4iJklwry7CfVIv6s4DXDGcobxaIQS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750407416; c=relaxed/simple;
	bh=d8Mgbq+tlXgiOCvUUJ1CQ/wErcy/a1QcdjM8cScxgsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOwjYC1oMohkJ2YOjSUVBy3v8gKPaiJNQJagPpJ5pg6WYYAMh/eXQDqe59Xdo9e0/rzU0wDC7QpS8sT7EQzXaBYHhMpdjflwHza9qGVFoEbWb4zJScq/4KTNaIr452wYQuTNcOWHS2+dZga3FHp0AWRBQ8dTGxTIPCn5b3zrFxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KWrW7OVM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CY4sn07G; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KWrW7OVM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CY4sn07G"
Date: Fri, 20 Jun 2025 10:16:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750407413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MmmBlduHwPkdN/f1kH6ThEp5OdF66BfvSJIyhyA+ixM=;
	b=KWrW7OVMxzpjCPLJkoMm6/hBtWWY5ux8pkQkdP5DR8PMfbSJqMezAbffMY++R/NIAVe64Y
	NRUMzMITxm5eMhmxhFYyI7t6v+1OI2g4L5x+9r3DfPLr4nm0XQtADePx3w1liAOr9nNP7n
	Gd0KlxvxGWbM8LRne/kOfrBpcmWCjsWZG3HYWFi00SQVo7R4Qcl99B9t39l1mGGWAqN6Hw
	qwk/sw7gfUneT0uA9MZDGe+GBnuAdxPd05oxd82bFDDYOz9/CWMhPV/ApSSvJP8FNP8Fvx
	gayPLI3WNP2g8If49cZGcQTr4mSlQAPVqGuNdUW0J1NTGkZ3FFe0VWr0vIyi0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750407413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MmmBlduHwPkdN/f1kH6ThEp5OdF66BfvSJIyhyA+ixM=;
	b=CY4sn07GhZiAkp4AyV+4QduDZWTJKJmkvkFoP+Gpfrr0wyyHJzf2Z6S3nNAlnNwI/gUc2q
	Fn1tViZ0VOm7PcDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Michael Schanne <michael.schanne@gmail.com>
Cc: linux-rt-users@vger.kernel.org
Subject: Re: liveloock using PREEMPT_RT with i915 driver
Message-ID: <20250620081652.gUUPOkOh@linutronix.de>
References: <CAC_kJhQcdP5=0fcWAuXaJ=3Hxx1TwX5WR-UgS=EHuQeqckhZmg@mail.gmail.com>
 <20250617100521.6EW6IWXh@linutronix.de>
 <CAC_kJhQZpZoUjavRsSVHuXL5k3-3u6+wdL9=h8Pbv3qWvzeOiw@mail.gmail.com>
 <20250618121656.wjpoNGAT@linutronix.de>
 <CAC_kJhTQ635vwtj6c7UpvM3BwNb+baMASbeo8t2zT5m5UfEYHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAC_kJhTQ635vwtj6c7UpvM3BwNb+baMASbeo8t2zT5m5UfEYHw@mail.gmail.com>

On 2025-06-19 07:19:23 [-0400], Michael Schanne wrote:
> > So you are not using clock_nanosleep() but something like a POSIX timer?
> 
> No, I was using timerfd_create() and then calling read() in a loop in
> my timer thread.  Is it recommended to use clock_nanosleep() instead?

clock_nanosleep() based delays allow a "direct" wakeup. So yes.

Because of how it is implemented, timerfd based wakeup need to be
performed by a thread which is ktimersd. If you busy-poll the timer from
your application then ktimersd needs to have a higher priority than your
application so that it can preempt it.
ktimersd is also responsible the wakeups of non-RT applications. So if
multiple SCHED_OTHER applications ask for a wakeup then this wake up
will preempt your realtime task.

> -Mike

Sebastian
