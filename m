Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABEA21171C;
	Tue, 15 Apr 2025 06:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744698206; cv=none; b=E1jK+j22KUfxso3TJv2TAhLrYHUNqgENQbZSX7aDUKV5czqX8WY/AUjHRzop5ZvFYv+J6+HmxvG4aTR4NuIHOg58UDjQGPtgAiVqwNykbMq4N9458fg2IMXc1JJGVYXbEgn/FAjAlDZeKlg08f/58S73CLCCF0k8/u0uS6Eq2K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744698206; c=relaxed/simple;
	bh=c7TaSe2LYpB4ZDOSpGdN1Qj/+Gj3ShV4vNKW7jjtFQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgD0o5g8ZUMaSu94KxRVFylq9xIgNtzHZHc3nqtBHH3/gBUkgPmN0rPWsx4Ycf7wnGlfcRZ50VEvxFoB0bAHR0zFxQM5LfaB6BRWbK9y9+jRuCF7Z77zsuOiFvv1I/9/hMokj886hJQmIaDsumY8HGJhiNZrvyBCprpObvkdW2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RSgvb0VN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3U3DybJF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RSgvb0VN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3U3DybJF"
Date: Tue, 15 Apr 2025 08:23:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744698202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uKG4WTJy0TDLjBIU7XHiGKXcjUAjTuLwBXl8UqxVMWY=;
	b=RSgvb0VNy18x+lLX69KHvLlHZ6JjmulAwQXxChoU1tZvG+yXGyucJVKtMOi+1bfiYQIX2b
	0m8F5y5Pkc6dEzMpQTS9ITsKUhc+7f0g+xOg9Khmm1Q/A2Fjw6iC4aJ/GmFeTSEpfyYw8j
	dt3oguYojAhZt7j8TUPyhAQkQsCooN1S5LqSiEkSLKEDwkGpYa7mpvBZytcAOSSxbi853M
	4BHnpeoUYg3CtQSRJdbvj//dPgM9Q1RjzFns4aCQx/4G5ZcW6HWvm+MBichQ05fUy2RQQf
	n8MQE+x6OfF9pLjWt7Ekf0OcHkIQkS4ycHJC+0pmnjMqEvtLYMZIUvpwIYgxpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744698202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uKG4WTJy0TDLjBIU7XHiGKXcjUAjTuLwBXl8UqxVMWY=;
	b=3U3DybJFcMBeNJmKsj44yW6aAP0ytnABpExbl03ORaBForOgEXFBdX7BEElVlgqZ/3wFbl
	BiB6N1smfm8kynDw==
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
Message-ID: <20250415062320.bMvqQsQ4@linutronix.de>
References: <xhsmhttqvnall.mognet@vschneid.remote.csb>
 <3f7b7ce1-6dd4-4a4e-9789-4c0cbde057bd@siemens.com>
 <c92290e0-f5db-49bd-ac51-d429133a224b@amd.com>
 <20250409121314.GA632990@bytedance>
 <3d13e35a-51bb-4057-8923-ebb280793351@siemens.com>
 <f2e2c74c-b15d-4185-a6ea-4a19eee02417@amd.com>
 <20250414150513.klU46xkw@linutronix.de>
 <438a5250-30c0-4820-9084-cdef50f67865@siemens.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <438a5250-30c0-4820-9084-cdef50f67865@siemens.com>

On 2025-04-15 07:35:50 [+0200], Jan Kiszka wrote:
> > On RT the read_lock() in the timer block, the write blocks, too. So
> > every blocker on the lock is scheduled out until the reader is gone. On
> > top of that, the reader gets RCU boosted with FIFO-1 by default to get
> > out.
> 
> There is no boosting of the active readers on RT as there is no
> information recorded about who is currently holding a read lock. This is
> the whole point why rwlocks are hairy with RT, I thought.

Kind of, yes. PREEMPT_RT has by default RCU boosting enabled with
SCHED_FIFO 1. If you acquire a readlock you start a RCU section. If you
get stuck in a RCU section for too long then this boosting will take
effect by making the task, within the RCU section, the owner of the
boost-lock and the boosting task will try to acquire it. This is used to
get SCHED_OTHER tasks out of the RCU section.
But if a SCHED_FIFO task is on the CPU then this boosting will have to
no effect because the scheduler will not switch to a task with lower
priority.

> Jan

Sebastian
