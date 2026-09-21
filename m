Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8BE48EC69;
	Mon, 21 Sep 2026 12:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789995467; cv=none; b=pBWyVWeU4b1SNVLveeLDPpMb02xzMpPPpNF84QWmljUQ6eAzvTW0CgowuxOyMDAYTpaKVhbnpsvcid4wXsyfKweBiZuST4ialV7sIPIIS1MOaoeiEOy9yECcNxtKNd5gOy9SsXDHYzHx4gDAkWr6FinE15bz24BdIE+yR1isgQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789995467; c=relaxed/simple;
	bh=XYTz/bDPy5AHdbPxHZeZXwjBR/dn5+7P39D2RiVuLCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLI0C+303wTcIab2dsQdxpcewa90YE7nmvY0kvFLEWcC8XSxTdNY/2peFTemEfl1g4RU/90N7wmVHu2qX+5eDeRrOi7XsbB32L3OlChFmgSj6X0+lMgAos1NvbuxlNkW7Q15MzJ8JoBZYEUBl5cfl+q83D5FUFmU2NSMkHIv01A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iSLQ+a/0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b6QDQCYS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iSLQ+a/0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b6QDQCYS"
Date: Mon, 21 Sep 2026 14:57:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1789995462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+AJpnD11/J/hkZ8Y91nI/UwOF80ppZScsajgHoSnUk8=;
	b=iSLQ+a/0vNHSUlFe7NBhiSRN8xRU3xjIIq44BDEjhCAbVYSyM2nP3lqRwZ5nY93K8tIKuS
	PYn6n1os6iXs+j6yhVA9rHmUljX+I5DAkCf0nhCFztOhjqCqzT6zj3NoQ35d/7GQkJbGg7
	6Ns7wG6KBjAYSO5gKYxf2Exdg1uyNaYhi+G5pl2zCmg+92ebXltc2cDgMn8GDYNYH8Lm/1
	2/9AWs0JbPCQML71aFfotH0fazGun4Gq3+4aRoOuINGVZrwrsN4Nei4rtVmDDl8QGLpF4T
	BXs6lYP+H+plE0qWDAc0ejuTea2hrJbUtg8ya6DF7EAlzB6nKQ+Yhb6nlRjTXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1789995462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+AJpnD11/J/hkZ8Y91nI/UwOF80ppZScsajgHoSnUk8=;
	b=b6QDQCYSvLu83vFCbBLNglQBwD1zRQ/8iVGWsPCHPhEVCIZFkNOHpLRw6nXQky3qmqFCi6
	iU7906F8jHFdlSDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Quchaosheng <quchaosheng000406@163.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun@kernel.org>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] sched/proxy: allow SCHED_PROXY_EXEC with PREEMPT_RT
Message-ID: <20260921125740.vKjQ0Qtr@linutronix.de>
References: <20260921081525.2982361-1-quchaosheng000406@163.com>
 <20260921100921.PsZhWgmh@linutronix.de>
 <178998790498.3308959.13462163523351109568@163.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <178998790498.3308959.13462163523351109568@163.com>

On 2026-09-21 18:51:44 [+0800], Quchaosheng wrote:
> On 2026-09-21 12:09:21 [+0200], Sebastian Andrzej Siewior wrote:
> > Why exactly is this a good thing to do?
> 
> What the patch does is make a combination that the Kconfig itself already
> documents as broken ("Avoid some build failures w/ PREEMPT_RT until it can
> be fixed") compile again, and drop the RT stub in include/linux/sched.h
> whose parameter type did not match any caller. That is the whole of it.

Is there a build failure as of today or not?
The whole proxy exec thingy depends on !PREEMPT_RT, so there should be
no build failures.

> If that is not worth carrying, I would rather withdraw the patch than
> argue for it. Enabling a config that silently does nothing is a fair
> objection, and teaching the RT mutex to maintain blocked_on is the real
> work here.

I still fail to understand why we want it. It does nothing. The option
itself is document and once enabled CONFIG_SCHED_PROXY_EXEC does
something an !PREEMPT_RT and leads to a different behaviour if disabled.
But with your patch and PREEMPT_RT enabled there would be nothing that
CONFIG_SCHED_PROXY_EXEC does, would there be?

Sebastian
