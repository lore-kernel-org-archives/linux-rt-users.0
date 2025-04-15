Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18900186295;
	Tue, 15 Apr 2025 08:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744704046; cv=none; b=Ydl7BuZdGna7B3Tbisw5CTYrQLWQwKiJaKbyx5LMhirE4otLPwgzT/3JuT0a5MH7zlO7Byoo5ziL5P7j0IlgxRk058EwR2Hwe7kJzgP71PWMrjX3pL6WKjvDbfdQXcB84NuyeKEBKeQmNkg/bDwV6eD7ZEYugaQl3dT1nEFa3Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744704046; c=relaxed/simple;
	bh=oE4njIYIocdyHd2LTSGNVO0Lq1qySI0tjQsnzN3KaTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSJC09Doe92dN1PKO8jOkr8N9OZrpZ1r/4Nr/tar5TMgmv8xHH5+FXpWBiQqVTHhWubbvMRVboD+o+orfeUOYjbcfB9aItl8mzbaez1wK5t74dZ5h7mi/mcjwGheLwhiDxk1Dd/sp2tJIHeeq3JkscWjU+j1i5UgBA3AHoyvygg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IwlI92r2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=awEBpu3y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IwlI92r2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="awEBpu3y"
Date: Tue, 15 Apr 2025 10:00:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744704043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XLvp6s6831DFXRugd3VKZChU2DM6rbcklQXOdpSFDYg=;
	b=IwlI92r2KtoX7V5cjgXLPv9YQYO1PxV3fd8OhqIzmzjGKc4HJRSBxNJQVhYi411+z5/LXS
	lFzFHlRzgPe0jYxC1YjmJ243RIMybojUmg0JNCthLU85TAhffT6aYfru0DM/GdrLmgvowg
	HgA6ZtG0S6tiLIggjs0l7XNszZEV0LPkKGfyOk3UgeMAdydDKqhSBau1z6Z/gtsh/2FPTw
	UkxOPJ0mGq6oj1KIN28Ts/qOYAzppFKUiGLp2uCx14IFfZULYio8CJVoCedFlFH9rEX8Qb
	exVblJxRfLG64BGKEIwqPWoHIu2Uq1BaDujs2uxL6mzlRLymkMC31hfaEStdng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744704043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XLvp6s6831DFXRugd3VKZChU2DM6rbcklQXOdpSFDYg=;
	b=awEBpu3yfgAzcx1jD4ft1WHrh15hCUTRSVd9hnv59a0CqReDsx1/JtPJ9jE5OH3WlKTDtL
	VW1kjqIsErf0k4Bw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Aaron Lu <ziqianlu@bytedance.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Andreas Ziegler <ziegler.andreas@siemens.com>,
	Felix Moessbauer <felix.moessbauer@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: Re: [RT BUG] Stall caused by eventpoll, rwlocks and CFS bandwidth
 controller
Message-ID: <20250415080041.kePLxkOG@linutronix.de>
References: <xhsmhttqvnall.mognet@vschneid.remote.csb>
 <3f7b7ce1-6dd4-4a4e-9789-4c0cbde057bd@siemens.com>
 <c92290e0-f5db-49bd-ac51-d429133a224b@amd.com>
 <20250409121314.GA632990@bytedance>
 <3d13e35a-51bb-4057-8923-ebb280793351@siemens.com>
 <f2e2c74c-b15d-4185-a6ea-4a19eee02417@amd.com>
 <20250414150513.klU46xkw@linutronix.de>
 <438a5250-30c0-4820-9084-cdef50f67865@siemens.com>
 <20250415062320.bMvqQsQ4@linutronix.de>
 <f5520221-b5ec-4204-966c-881b3428d4c0@siemens.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f5520221-b5ec-4204-966c-881b3428d4c0@siemens.com>

On 2025-04-15 08:54:01 [+0200], Jan Kiszka wrote:
> On 15.04.25 08:23, Sebastian Andrzej Siewior wrote:
> > On 2025-04-15 07:35:50 [+0200], Jan Kiszka wrote:
> >>> On RT the read_lock() in the timer block, the write blocks, too. So
> >>> every blocker on the lock is scheduled out until the reader is gone. On
> >>> top of that, the reader gets RCU boosted with FIFO-1 by default to get
> >>> out.
> >>
> >> There is no boosting of the active readers on RT as there is no
> >> information recorded about who is currently holding a read lock. This is
> >> the whole point why rwlocks are hairy with RT, I thought.
> > 
> > Kind of, yes. PREEMPT_RT has by default RCU boosting enabled with
> > SCHED_FIFO 1. If you acquire a readlock you start a RCU section. If you
> > get stuck in a RCU section for too long then this boosting will take
> > effect by making the task, within the RCU section, the owner of the
> > boost-lock and the boosting task will try to acquire it. This is used to
> > get SCHED_OTHER tasks out of the RCU section.
> > But if a SCHED_FIFO task is on the CPU then this boosting will have to
> > no effect because the scheduler will not switch to a task with lower
> > priority.
> 
> Does that boosting happen to need ktimersd or ksoftirqd (which both are
> stalling in our case)? I'm still looking for the reason why it does not
> help in the observed stall scenarios.

Your problem is that you likely have many reader which need to get out
first. That spinlock replacement will help. I'm not sure about the CFS
patch referenced in the thread here.

That boosting requires a RCU reader that starts the mechanism (on rcu
unlock). But I don't think that it will help. You would also need to
raise the priority above to the writer level (manually) and that will
likely break other things. It is meant to unstuck SCHED_OTHER tasks and
not boost stuck reader as a side effect. Also I am not sure how that
works with multiple tasks.

> Jan

Sebastian
