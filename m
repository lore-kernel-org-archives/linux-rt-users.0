Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053DD45FFC7;
	Mon, 21 Sep 2026 10:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789985366; cv=none; b=asK+1zKDARm+mNu1KGtU1WjdXWRS554rlEsLyeP6f9RK6YwBw+kQd3EKRuLfgY83bhMDWQATTBth7b/EvXqV43YpHcLzCsRaKkZVKynnJV+c+t1j6n9hRMCLoZ/DYis72r4C2vbqkoHaC+NRNiCgobeu5wIixV9wfSBFRQAT6rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789985366; c=relaxed/simple;
	bh=T22FBrbsaH6GteKfpGdtFbbPTKZ5yViZTOOx4UuGTYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9uqehs+MhIMCAsjf7GhLsg1rfJT2VDJzWEZASH3bsifLiOpdc3m8NE5LWw2njm6y+7EZlc1L1CHk4u9zYLHe5OoX2zOnfdzmztjo2uXlI+BtmTdAoNuDyvQ4UfMmqA4cOYoVNi2iX9ejsjdB7iRmTV/qYXA78tbdr3moNh1ka0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PESHxKPX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mngMcqPb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PESHxKPX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mngMcqPb"
Date: Mon, 21 Sep 2026 12:09:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1789985363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T22FBrbsaH6GteKfpGdtFbbPTKZ5yViZTOOx4UuGTYk=;
	b=PESHxKPXEgoMz86CMABc8+DQC3oXH9ZkYFBeo6Hw8KXwrUBmDDsXBZ15RIZlXF4hjX4Y0J
	cf4Kb3T435fFjHH1A7NRCA4ikAQt8NLIjrQT3enWMm2F6cRz9R0K7KdeX9exsjL66CzpSP
	qTafdsMuUN9UpWi5vCdFaHmT3vYxt9zVsdtPu1kAUg6n0zjtoFjP6ezTHpJW6yxwtKgYX8
	6e4maqPgb2xRfZJegexkFuVs3b5OV81E389/7jb0X/JZ/g8ap1ozt5ZzETVXn9wbgQl5Tl
	Urf8CZ73q0xsJ7hQYdSEfZp4LijzbbJvc0HXqnXEiVtbed0FxCYtic6ErzslRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1789985363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T22FBrbsaH6GteKfpGdtFbbPTKZ5yViZTOOx4UuGTYk=;
	b=mngMcqPbtzwC0W0Jxp25iKOD2FrXUiMyM5v0IojDzKlTEAno3KWdbUZbYABiwRQZS1Pkws
	cXu4fODrThi3tUDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Quchaosheng <quchaosheng000406@163.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.kernel@gmail.com>, Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] sched/proxy: allow SCHED_PROXY_EXEC with PREEMPT_RT
Message-ID: <20260921100921.PsZhWgmh@linutronix.de>
References: <20260921081525.2982361-1-quchaosheng000406@163.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260921081525.2982361-1-quchaosheng000406@163.com>

On 2026-09-21 16:15:25 [+0800], Quchaosheng wrote:
> Note that this makes the combination build and boot; it does not make
> proxy execution actually do anything useful on PREEMPT_RT. An rt_mutex
> already provides priority inheritance, so there is no blocked_on chain to
> follow and proxy execution stays inactive. Replacing rt_mutexes in the RT
> mutex implementation is tracked as future work in the proxy execution
> series.

Why exactly is this a good thing to do?

> Signed-off-by: Quchaosheng <quchaosheng000406@163.com>

Sebastian
