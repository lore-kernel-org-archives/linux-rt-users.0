Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CA119E82A;
	Fri, 17 Jan 2025 17:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737134903; cv=none; b=FNN3OkC9g8rON2miMimKF0So/egkpag1lD8NLJBIQUqdN1R4PSAxJbEV9pU8XnmoJ6OGvwdDcp1FzyJSF2abO5M4Ii1JVnwsScoe3lGJpXc3U4W9oQcFr++lmKIIsoLiqbPBaqNloKqtsb1X0MThvDnHtS6GnDGp7M7Ak9PKy3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737134903; c=relaxed/simple;
	bh=0fvEqFsKRBQ4dYSWUqfsbufWKTs+0cxi5TI+tznwqxg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pWRFyHF3Dx1T/mM+2swyOqVMnhqMqCQdUxRZrJ0Nl37dcP5sm5PlXOZYOIXaPDEKhL7BI7sxz+TAlfqAsqKbAkiSuAYOtK4WxGqspcDtunUVBti2heZoSbHOdURnaTQdEZGcL+Y/IwXXQ/nsIvC5brzw1yzsxR0HDGFy2axl40E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 660FBC4CEDD;
	Fri, 17 Jan 2025 17:28:22 +0000 (UTC)
Date: Fri, 17 Jan 2025 12:28:29 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: Can we switch the tracepoints from preempt protection to
 rcu_read_lock?
Message-ID: <20250117122829.615753e8@gandalf.local.home>
In-Reply-To: <fd4fc5ad-1a55-4a6c-b98c-4b58dd3c36bf@efficios.com>
References: <20241206120709.736f943e@gandalf.local.home>
	<fd4fc5ad-1a55-4a6c-b98c-4b58dd3c36bf@efficios.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Dec 2024 14:03:38 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> > I'm not asking for you to do this work, but can you remind me what you saw
> > when you created the faultable tracepoints?  
> 
> I saw the future! ;-)

Well, I actually meant what you saw in the tracing code that would have an
issue with removing preempt_disable from tracepoints ;-)

Anyway. Sebastian,

Doing a quick scan, one issue is your code:


static inline unsigned int tracing_gen_ctx_dec(void)
{
	unsigned int trace_ctx;

	trace_ctx = tracing_gen_ctx();
	/*
	 * Subtract one from the preemption counter if preemption is enabled,
	 * see trace_event_buffer_reserve()for details.
	 */
	if (IS_ENABLED(CONFIG_PREEMPTION))
		trace_ctx--;
	return trace_ctx;
}

Looks like that could be removed if we remove preemption from the tracepoints.

-- Steve
