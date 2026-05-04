Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1AF3D410E
	for <linux-rt-users@vger.kernel.org>; Mon,  4 May 2026 23:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777937073; cv=none; b=ac2FB7e2IK0KKJT64RSYaz4DpXOhvUdpf8hRMKcre/BdXvB9snLoVZCeiQ3RPi1fF8C8POovnTRzd9DS6nzIgqV1VjYXsgRuk4aNJZn9iUkN2hU0THcWGFmYFFENE+968uFvbKAbLs0FqLrGdaxR9CPZ62wy2L9rItnxz3WrHjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777937073; c=relaxed/simple;
	bh=Odqk194lYUuc3gGN2c/Sw3ZUL/Al3AYb8k+3tgEZdtM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DdBItuqfPAi8ySbe7zSwNbBNLyLTUmqCfTa1U90z8nL77z8CGw3ulA/CDiA7zHyxyvWLRSnzGaUgP9PO1WTeFj9unjWkob5lzmNzbQLUPGBNfY7qgjwTv8eZyer6xe0obIeBgg//0SJd3VX0MtGsKok+kVUXiAly+dlP55HwIT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=aPcKasXL; arc=none smtp.client-ip=212.27.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="aPcKasXL"
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 0F37F4C3FA
	for <linux-rt-users@vger.kernel.org>; Tue,  5 May 2026 01:17:43 +0200 (CEST)
Received: from [IPV6:2a01:e34:ec24:52e0:284:73fc:f242:ca64] (unknown [IPv6:2a01:e34:ec24:52e0:284:73fc:f242:ca64])
	(Authenticated sender: marc.w.gonzalez@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id 75CE7B0053D;
	Tue,  5 May 2026 01:17:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1777936655;
	bh=Odqk194lYUuc3gGN2c/Sw3ZUL/Al3AYb8k+3tgEZdtM=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=aPcKasXLSz7Murab+9Yu5XJap3FWoAMtM9659fkdde2AFcHvO4Mw0DK9Jnbi6jAAl
	 GttaFC8VODeGaaSc7wQLYC7rU+X1lOZbnTjml33QkGS+qjD+hRfvOGuiCwsUGiNraj
	 PCqTZfi0uvdMkw1zSmGO7LAFSV62teV8NrILjunJRJwrzPWtY8MN3yOyGf7B9XJNpm
	 LE4fyQjmyGfqZs3VkD9SNpwD3VrtmwdhVGY4SttxTQBgv7tCd1GilyL+wzwNNUU3Ke
	 0HnSrV6HYNk9kDjxt1AshWGDIrVuBfTNK4jEJ6XTZdOK/kofAGeCOwNHVvIrgMiCZ6
	 Xg2ChDy0W/v6Q==
Message-ID: <79f4cf81-9fc4-4c22-945c-1eaa68137305@free.fr>
Date: Tue, 5 May 2026 01:17:15 +0200
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Unexplained variance in run-time of simple program (part 2)
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
To: "John D. McCalpin" <john@mccalpin.com>
Cc: linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>,
 Leon Woestenberg <leon@sidebranch.com>,
 John Ogness <john.ogness@linutronix.de>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <williams@redhat.com>, Pavel Machek <pavel@denx.de>,
 Luis Goncalves <lgoncalv@redhat.com>,
 Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 "Ahmed S. Darwish" <darwi@linutronix.de>, Agner Fog <agner@agner.org>,
 Dirk Beyer <dirk.beyer@lmu.de>, Philipp Wendler <philipp.wendler@lmu.de>,
 Matt Godbolt <matt@godbolt.org>
References: <199905cb-04b3-4d3e-aeb3-da2b2d6428eb@free.fr>
 <5397d0cd-9266-44ae-97f2-75164d89bf48@free.fr>
 <b1630867-0e0c-47fd-8de2-ffca2f517da3@free.fr>
 <17537284-FA52-40E5-A70F-1120FCEB8BC6@mccalpin.com>
 <b73d91c0-2fc8-45fc-959e-5fc2b484e0fe@free.fr>
 <7FA25B6F-71A1-4B2B-9488-46D91445DAF3@mccalpin.com>
 <1137e806-eddc-409d-8694-4465e2123764@free.fr>
Content-Language: en-US
In-Reply-To: <1137e806-eddc-409d-8694-4465e2123764@free.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello John,

On 10/04/2026 19:16, Marc Gonzalez wrote: [snip]

I have come to the conclusion that it seems IMPOSSIBLE to get reproducible run-times,
even for simple programs, on "modern" systems (in quotes because Haswell, so 2013).

SETUP:
- System is idle, booted in single-user mode, with CPU3 isolated for benchmarks.
- CPU frequency is pinned at 2.8 GHz (nominal 3.3 GHz) to avoid thermal throttling & turbo boost.
- Benchmark is run as SCHED_FIFO 99, pinned to CPU3.
Linux version 6.8.0-110-generic
nohz_full=3 rcu_nocbs=3 isolcpus=nohz,domain,managed_irq,3 irqaffinity=0-2 nosmt mitigations=off nosoftlockup tsc=reliable log_buf_len=16M single


If I benchmark an absolutely trivial program (no memory access, 1 predictable loop)
then the run-time is extremely reproducible:

spin:
	xor eax, eax
	mov ecx, 1000
loop:
	times 60 inc eax ; 120 bytes
	dec ecx
	jnz loop ; 8-bit offset
	ret

This code is expected to run in 60,000 cycles
So the TSC pulsing at 3.3 GHz would count 70715 cycles + a few cycles for rdtscp & call overhead.

After measuring 12M calls to spin(), the run-time distribution is:

70725: 31
70730: 6235014
70735: 5142415
70740: 622531
70750: 1
70905: 3
70910: 4
103965: 1

(Not sure what's up with that 103965 outlier)

So the run-time is within 70730-70745 with 0,999996 certainty (11999960/12M)
A 15-cycle spread is 212 ppm. All is well & as expected for the trivial case.


Everything breaks down when I measure my actual (simple) program.
By simple, I mean:
- no system calls, no library calls, no I/O, just bit twiddling
- tiny code, small(ish) dataset

Here, I ran the code 15 MILLION TIMES, and took the MINIMUM run-time measured.
And I repeated this 20 times, expecting the various MINIMUMS to be quite similar:

66413
65707
66214
66277
67345
66640
66029
66693
67551
66771
66376
66536
66871
66177
65674
65435
66136
66223
66145
66305

The minimums of 15 MILLION runs fell somewhere between 65435 and 67551 :(
That's a spread of (67551-65435) / ((65435+67551) / 2) = 3.18% = 31823 ppm
150 times larger than for the trivial case.

Do I need to run the code 50M times? 100M times? to get consistent run-times? :(

Running out of ideas.

Maybe the memory traffic is generating a lot of "volatility" / non-determinism?
(But I don't think I'm even using all of L1$)
Maybe I need to disable the memory pre-fetchers?

I'm stumped...

Regards

