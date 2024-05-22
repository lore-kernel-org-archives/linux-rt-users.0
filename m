Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7F81DA24;
	Wed, 22 May 2024 14:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716387954; cv=none; b=mkpIlnEf/CjA6F+wn6dBGztVhF2IKLJnhPiVGxQgKbUFoSg/zSaBKG07Dcnr0U6G0oy/vJGhGfYWrpc877oIgt+TMzqhHs8G2dj0QlhBrXdtG0egLet2bzTB5FlvtLNfAN4yE3xZHJNUEObp67sJ80uXed+RCUThXvmuLFOTSDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716387954; c=relaxed/simple;
	bh=jW8l9hHiJfGGnwrZq/+yvYmUIsnVBUNJ+WL3xazSb8I=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=VBMjMQUwudo8OTn5YyKo0cUbHrtmYUuJg2Y6Qu9zsO1FUtC0MmEMjs4NVXFYwd3OUMHNjllOaFH6p1kD3VH46HwLHUIK+jQ0wX2lDANnIobwC9HatYmsDLovGjCzPgI1psUsezC+ireB6hR7rQp9qCpy/gVYQ/yixkpOrOCxbKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxo+GXxi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxo+GXxi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F58C2BBFC;
	Wed, 22 May 2024 14:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716387953;
	bh=jW8l9hHiJfGGnwrZq/+yvYmUIsnVBUNJ+WL3xazSb8I=;
	h=Date:From:Subject:To:Cc:From;
	b=rxo+GXxi/7Z50pJoStIUwH8drHeIwAA6jg1C6JdGxq0F+s/DfCJft90TLLJcZBITU
	 HYFWKkcLFEVY4H0SfusNEjKhniDXytJgZUhUNANOHauaKdly1Edats9hVtszNtTO/s
	 akdAMK5jniXWXvo8M/eH0bcFN6fnlRCNk/+W+WVsMTiogSWy47YUtOQe7AfX//5JOJ
	 hm9tN3VYDUGfTxfMz0oOn2sKEwT18FDZi+EKu8ksyV1XxtCIRvJ5XHyMje42sDfgFH
	 lIXA2IWA9aiXS7PwP/dkve8jUEGZGqfgJlsbR4a/lZgNMy62zt7LGr6tWwoy4FV0S4
	 /Rg8loZWDi4kw==
Message-ID: <d637037f-7485-45da-a3b2-f2ac17e2eb12@kernel.org>
Date: Wed, 22 May 2024 16:25:35 +0200
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, pt-BR, it-IT
From: Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: [CPF] Real-time Micro-conference at LPC
To: LKML <linux-kernel@vger.kernel.org>,
 linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Juri Lelli <juri.lelli@redhat.com>,
 anna-maria@linutronix.de, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The real-time community around Linux has been responsible for
important changes in the kernel over the last few decades.
Preemptive mode, high-resolution timers, threaded IRQs,
sleeping locks, tracing, deadline scheduling and formal
tracing analysis are integral parts of the kernel rooted
in real-time efforts, mainly from the PREEMPT_RT patch set.
The real-time and low-latency properties of Linux has
enabled a series of modern use cases, like low-latency
network communication with NFV and the use of Linux in
safety-critical systems.

This MC is the space for the community to discuss the advances of
Linux in real-time and low latency features. For example
(but not limited to):

 - Bits left for the PREEMPT_RT merge
 - Advances in the fully preemptive mode
 - CPU isolation (mainly about how to make it dynamic)
 - Tools for PREEMPT_RT and low latency analysis
 - Tools for detecting non-optimal usages of the PREEMPT_RT
 - Improvement on locks non-protected for priority inversion
 - General improvements for locking
 - General improvements for scheduling
 - Other RT operating systems that run in parallel
   with Linux and the integration with Linux (e.g., Xenomai).
 - Real-time virtualization

Examples of topics that the community discussed over the
last years that made progress in the RT MC:

 - timerlat/osnoise tracers and RTLA
 - DL server for starvation avoidance
 - Proxy execution (still under discussion)
 - Tracing improvements - for example, to trace IPIs

It is important to notice that it is not _only_ about PREEMPT_RT,
but anything related to real-time and low latency. For instance,
CPU isolation, real-time scheduling, timers, other OSs that
run in parallel... and so on.

Join us to discuss the future of real-time and low-latency Linux.

This email has a list of people in Bcc, based on a list of
commit authors in sched/locking/power/time. It is far from being
complete. So, please forward this message to the people on
your team working on scheduling-related topics.

-- Daniel on behalf the organization: Sebastian Andrzej Siewior, Frederic
Weisbecker, Steven Rostedt, Juri Lelli and myself.

