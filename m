Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37610206274;
	Fri,  6 Dec 2024 17:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733504825; cv=none; b=p7toaLeM7fkjFSDIj1xBEsGvWmy7N5+LbVzBjEBF3jMVkpy4vNapJL1BEtt1vx3Ms11rE4SoBMmU1emw5U65a1LYUmMbZENf2nQH8q4EBvQ8Z4CW7qyUhTG+RyJk374FaVbPtN0qMwPZ1qCsHo44Puozixy0tcKH+sEad6naKFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733504825; c=relaxed/simple;
	bh=Q586skKfDQhTq6OREz8sDPN/D5Ew+q2HHWTKe3sXCaE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=LOB4GKJ2BDB5pdBLamkz+m7+Vgx4bFrx2H3IWyqX0wg86QBhL0JQ4SXQL1HvxSBqUBcDUqLDprwKSmRmLYdCekX4j8UZtWf9W5WpjvYKVsMdxSnHc25EL8cVFjGSLr93r7mH2eanzEMrAX+KdPxNlonZMs/PCLYpntaCGNNk92g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E7E0C4CED1;
	Fri,  6 Dec 2024 17:07:04 +0000 (UTC)
Date: Fri, 6 Dec 2024 12:07:09 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Can we switch the tracepoints from preempt protection to
 rcu_read_lock?
Message-ID: <20241206120709.736f943e@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Mathieu,

Sebastian brought up a point at our RT Stable meeting. BPF hooks into
tracepoints and can cause long latency on RT setups.

IIRC, tracepoints themselves do not need to have preemption disabled. It's
just that some of the users of tracepoints expect preemption to be disabled.

If we fix the users of tracepoints not to expect preemption to be disabled,
then we could just switch the preempt_disable code (guard(preempt)) to
rcu_read_lock()s for the tracepoint callbacks, right?

There's a one or two places in ftrace that expect it, but I don't know
enough about perf. I don't think BPF needs preemption disabled, but just
migration disabled. I know you had some patches to work around this.

We need to get BPF working without preemption disabled for RT, I'm not sure
how much you know about what needs to be fixed.

I'm not asking for you to do this work, but can you remind me what you saw
when you created the faultable tracepoints?

Thanks,

-- Steve
