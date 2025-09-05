Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9231A2727E3
	for <linux-rt-users@vger.kernel.org>; Fri,  5 Sep 2025 21:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757106423; cv=none; b=fuqgIXIgC279oLsq/cOYmnfSL+GTAlr4OBp0MOXoUnNjLmxOzVfro0TvLBvjnMe94HTMhR3JmAvMxNj7ZZbpfJIDOFaGxGzdN4nwkuKAAs9Bueq0HnKDc1ZjUBhEf8JG2EX8BkP5jv0X64bRDF1cUswfKSe6UdC2d2rv1E0o/Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757106423; c=relaxed/simple;
	bh=hLeyUs4HbLVHjbR9tAefLlQsgf+nDULZO9crKFvMhoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gROWuBd1DOpJRWJnjqj+P4IPOxjAgT5Dx5q96yPhsQPc+9RGp6lhI0j4OT82I3iDwTBsYHjuqdcJrsQ+EoNTj53fwPWKMDnkT1EwwdvhHID8xkXzFla06ACJuCZ74VwCKH0jy8DiDoiFoIUJi64qWCMrbO4KOIaS0beWmvzqcNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=LVk+uaiI; arc=none smtp.client-ip=212.27.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="LVk+uaiI"
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 146B54C1CB
	for <linux-rt-users@vger.kernel.org>; Fri,  5 Sep 2025 23:06:03 +0200 (CEST)
Received: from [IPV6:2a01:e34:ec24:52e0:186c:6bb4:fc0e:4183] (unknown [IPv6:2a01:e34:ec24:52e0:186c:6bb4:fc0e:4183])
	(Authenticated sender: marc.w.gonzalez@free.fr)
	by smtp2-g21.free.fr (Postfix) with ESMTPSA id 7BA9E2003B4;
	Fri,  5 Sep 2025 23:05:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1757106355;
	bh=hLeyUs4HbLVHjbR9tAefLlQsgf+nDULZO9crKFvMhoA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LVk+uaiICKEYH4bQZqNx6PhaY10Wi6mLSE2u1u2e97DY+AvrXnuTgXmFrT8NsdZYT
	 j6Zv3gZp5ZJgi4zia9BsldYoDafrjpZgyzqbb0EyRYXiVQfgebU4HSvjo8KKwvSLoz
	 UmGrMunZVVAZIudGp6Tin4ouIU76cQtoAMjo3nhO1LGMgwbuZdvMpeAOtohYZEtXgP
	 2V/Pvsr9jigJowb3QbmIydygjqoE8j73lgNf5oW+GKH+3eqiukErlWZN8x/CP/Ylk1
	 mufwgelK4cy6XF89/KJk1ugXDtKHJ1Cs+CqBSVea+5zxyXpCu7lsBfpeTsxF7YuoHh
	 8+RdHVTTE9QYQ==
Message-ID: <f6fcc6da-07ff-4014-b883-aa1d99a3e794@free.fr>
Date: Fri, 5 Sep 2025 23:05:43 +0200
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Large(ish) variance induced by SCHED_FIFO
To: Leon Woestenberg <leon@sidebranch.com>
Cc: linux-rt-users@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Daniel Wagner <daniel.wagner@suse.com>, Clark Williams
 <williams@redhat.com>, Pavel Machek <pavel@denx.de>,
 Luis Goncalves <lgoncalv@redhat.com>,
 John McCalpin <mccalpin@tacc.utexas.edu>
References: <5f7496eb-bf62-4cc9-bef0-9cae97a93dca@free.fr>
 <CAMjhiJiVDmnx+pgpvtAy=KarHexjsYs+T9tSkpGvppjqFdtmiw@mail.gmail.com>
Content-Language: en-US
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
In-Reply-To: <CAMjhiJiVDmnx+pgpvtAy=KarHexjsYs+T9tSkpGvppjqFdtmiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello Leon :)

On 05/09/2025 18:18, Leon Woestenberg wrote:

> On Fri, 5 Sep 2025 at 01:45, Marc Gonzalez wrote:
> 
>> I am trying to get reproducible / deterministic / low variance results
>> using a vendor kernel (6.8.0-79-generic #79-Ubuntu SMP PREEMPT_DYNAMIC).
> 
> Is that your end goal or is your question maybe an XY question?
> If so please describe X.

I need a rudimentary (but accurate) benchmark framework,
to measure the impact of micro-optimizations on codes.
These optimizations are expected to make programs 0-3% faster,
so the framework should have the lowest variance possible,
otherwise I can't discern the result from the noise.

> Or just include the measurement inside the program using CLOCK_MONOTONIC.

David suggested that as well, but it was not the source of the problem.

John pointed out the culprit:
/proc/sys/kernel/sched_rt_runtime_us

https://www.kernel.org/doc/html/latest/scheduler/sched-rt-group.html

Regards


