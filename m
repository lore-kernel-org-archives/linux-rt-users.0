Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CB91C68F
	for <linux-rt-users@vger.kernel.org>; Tue,  9 Sep 2025 20:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757449870; cv=none; b=TidU17QQST2P5Bie3YuEi5SIIWigvLVXdFu/+ZawiGN+0wuSi1TLxBxqkT1TQ4r4hzaWJ/ecTfrD2W/mtP4PeUHsbynthhq2d0GCsBfQpDTDiCFmXXP+PlASJ5Sf1yNIfC9FtclFTdUiSGFnxQiyaJ+i/RwokFrYPZaPPxItYXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757449870; c=relaxed/simple;
	bh=MD1fOlM/vu5DkR1RKNAHkON3FC10aD8CwVsi82B/67s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NYLhSJSTqSDtD+vmnZSPh8eT8xGaxA7kP2nkaDRBbbyniU2T69Wejk4ELh9vT/OlcBet72dxbmsRn8KmsdTqHF+fewZDZTup17wBgZ7eJCY+JE+5wdItjhuNQl2MW7XTRNrZp6kGoqPnCGRiG7Rb93zeNProkxK/t9XG9ZMopOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=c81iXbHv; arc=none smtp.client-ip=212.27.42.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="c81iXbHv"
Received: from [IPV6:2a01:e34:ec24:52e0:4e45:8447:d6c0:1a95] (unknown [IPv6:2a01:e34:ec24:52e0:4e45:8447:d6c0:1a95])
	(Authenticated sender: marc.w.gonzalez@free.fr)
	by smtp2-g21.free.fr (Postfix) with ESMTPSA id 0BC442003C1;
	Tue,  9 Sep 2025 22:30:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1757449865;
	bh=MD1fOlM/vu5DkR1RKNAHkON3FC10aD8CwVsi82B/67s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=c81iXbHvPfShjqdwIq5rMNEuYXuyMTK1TRYJg+gesB5rBs3lv3nEfGLlYLspF6IRw
	 Ht4dwBwtWtRGm8xFZxGZyWTQADh/oMuSwlymMT8Qa4b1f6q0FOM74X6rocD/FQkq5K
	 VcmUuPXsP5x5qHlYz3hGLH89nMV1p49v2a3F8XBWBzT/q64JRAy/7IIcBWUvlmTuFJ
	 wMXdIqzW1hwN7zQc0IQeCC50t6mxeAp3OLT/N0BN9AEy8OH39f8pcTRlM4JHzswZyW
	 OadAn1oezmhqTIj+/+FhJmXAv+WcGV6gWdIkq4MEFxdVDmtuY72s8esvOZoGqzANYK
	 tGVP9a+ImwItQ==
Message-ID: <41b7c365-62c2-4bfa-acd7-db73dc9f94f0@free.fr>
Date: Tue, 9 Sep 2025 22:30:49 +0200
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Unexplained variance in run-time of trivial program
To: Leon Woestenberg <leon@sidebranch.com>
Cc: John Ogness <john.ogness@linutronix.de>, linux-rt-users@vger.kernel.org,
 Daniel Wagner <dwagner@suse.de>, Steven Rostedt <rostedt@goodmis.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <williams@redhat.com>, Pavel Machek <pavel@denx.de>,
 Luis Goncalves <lgoncalv@redhat.com>,
 John McCalpin <mccalpin@tacc.utexas.edu>,
 Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>
References: <5f7496eb-bf62-4cc9-bef0-9cae97a93dca@free.fr>
 <ac1ef5df-aa30-4b63-9beb-3e0522dd3cec@flourine.local>
 <afc4c145-4758-4924-b106-e7844624d269@free.fr>
 <841polf13z.fsf@jogness.linutronix.de>
 <42c5fb53-d423-41a5-80d9-557ff2a3e804@free.fr>
 <84ldmsevcm.fsf@jogness.linutronix.de>
 <3f1d4229-a95c-4d99-a98f-249d9e488b32@free.fr>
 <84ldmp8ewv.fsf@jogness.linutronix.de>
 <3fe55967-b4fa-4bc1-ae2b-58b5d1bbf3ea@free.fr>
 <d5f3d4c1-714b-46d4-99e6-c71ebf64e76b@flourine.local>
 <3220a6ab-19e5-4705-865a-1e1c37b67ccf@free.fr>
 <0d87e3c3-8de1-4d98-802e-a292f63f1bf1@free.fr>
 <84ms73kdn2.fsf@jogness.linutronix.de>
 <11dfa501-e280-4b50-a593-a4b153019b40@free.fr>
 <ddb85a49-934b-4c11-ac2a-c8a562e76e7e@free.fr>
 <CAMjhiJjMOQN-nWd+KP4JBBNHf20M+J2fXAuTTvowXctJgvGOcQ@mail.gmail.com>
Content-Language: en-US
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
In-Reply-To: <CAMjhiJjMOQN-nWd+KP4JBBNHf20M+J2fXAuTTvowXctJgvGOcQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/25 21:34, Leon Woestenberg wrote:

> Basically, you are reverse-tuning a multicore CPU system,
> that is heavily optimized for time-sharing and overall
> system throughput, back to act like bare-metal single-application.
> You can get close, but you will never reach the determinism
> of say, an Cortex-R(ealtime) Core.

This ignores the fact that I've been testing 2 programs:

- P1, toy code that just calls dec 3 times in a tight loop
- P2, a few memory accesses, everything fits in L1

I then loop P1 & P2 2^16 times to compute their average run-time.

Over thousands of runs, RUNTIME_P1 is ALWAYS the same (within 30 ppm)

Over thousands of runs, RUNTIME_P2 varies by up to 12 PERCENT (!!) = 122k ppm

Since P1 runs fine without ANY jitter, the problem cannot be
something inherent to the system itself, such as
- SMM
- IRQs firing randomly
- drifting, jittery, jumping time source

The problem appears to be something inherent to P2.
(Either the whole core is slowed down perhaps by thermal throttling,
or something is causing huge pipeline stalls.)

Regards

