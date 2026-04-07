Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AB8192D97
	for <linux-rt-users@vger.kernel.org>; Tue,  7 Apr 2026 00:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775522344; cv=none; b=g0qGYRE6egBlCXtdWwkPPZyavNxT9dhbUKrlWLU15l2Ypef/rrtSnTdIh2Bko2TlrUvQ7eeRX1I8udB3V9kmUdFT5/oyWpjvY6J8DhOLRJrX6t/Wa3U4llZ0HpFdiCMtpE6sM/CmvXle+LS0dfoUI5RUJx7tO7CjhSK60CApCXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775522344; c=relaxed/simple;
	bh=TGNYREmV98/iMVIBPHCvd8AAO4aXzGiZAAhjEoFmO2A=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=bCxyoDrnW2zXnCUkyI9qGDfoQyOI6gt9g0/5nn0YvtLc9ccfwE9KgNZkA6HHo/C0Vgfb/STtv1QJnanOZAL4SAGWgHWRISCUtGasap/ArJi+L3YQPXNql9ppXzPKYgcY4YZPdrmgI+9MuOplsXke/EpQeokjIGMSuVFyoGtHG/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=m6+oMHA+; arc=none smtp.client-ip=212.27.42.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="m6+oMHA+"
Received: from [IPV6:2a01:e34:ec24:52e0:336e:3708:3288:8262] (unknown [IPv6:2a01:e34:ec24:52e0:336e:3708:3288:8262])
	(Authenticated sender: marc.w.gonzalez@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id 917D578032A;
	Tue,  7 Apr 2026 02:38:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1775522335;
	bh=TGNYREmV98/iMVIBPHCvd8AAO4aXzGiZAAhjEoFmO2A=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=m6+oMHA+TuzHPpTfU1MYgXFX73U53R0g4v8ruiNg4sZjsqtc795bM6EHaIeNqYh8e
	 G6iB9AaGTpyOJ7F1AYJ6VMCeYuAR/C+7ZXRJQzMborA0e3oY5t/naRANL7VmpGFRJ3
	 2CrgY9sfyCwLZ+33vg4TmohgvmBglXMQ/IxEwFl1rNRlhbciN7l8uKWxxBxU5egfPE
	 1Nm8vPofUrs9CS8UzYr7jP2l/6sNslGJDRGpcmj3G2BCY0UTta1sF0zQhRVv1UHmO/
	 lS+DrgQPJsMOMay9CkuD4LDUKXGshDvidtpW+i79qFTp792kaYyBxn4k9zJKLS3pbK
	 hZktACCXLetwQ==
Message-ID: <b1630867-0e0c-47fd-8de2-ffca2f517da3@free.fr>
Date: Tue, 7 Apr 2026 02:38:34 +0200
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Unexplained variance in run-time of simple program (part 2)
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
To: linux-rt-users@vger.kernel.org
Cc: Daniel Wagner <dwagner@suse.de>, Leon Woestenberg <leon@sidebranch.com>,
 John Ogness <john.ogness@linutronix.de>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <williams@redhat.com>, Pavel Machek <pavel@denx.de>,
 Luis Goncalves <lgoncalv@redhat.com>, John McCalpin <john@mccalpin.com>,
 Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 "Ahmed S. Darwish" <darwi@linutronix.de>, Agner Fog <agner@agner.org>,
 Dirk Beyer <dirk.beyer@lmu.de>, Philipp Wendler <philipp.wendler@lmu.de>,
 Matt Godbolt <matt@godbolt.org>
References: <199905cb-04b3-4d3e-aeb3-da2b2d6428eb@free.fr>
 <5397d0cd-9266-44ae-97f2-75164d89bf48@free.fr>
Content-Language: en-US
In-Reply-To: <5397d0cd-9266-44ae-97f2-75164d89bf48@free.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/03/2026 16:24, Marc Gonzalez wrote:

> Past discussion:
> Large(ish) variance induced by SCHED_FIFO / Unexplained variance in run-time of trivial program
> https://lore.kernel.org/linux-rt-users/0d87e3c3-8de1-4d98-802e-a292f63f1bf1@free.fr/
>
> SYNOPSIS:
> I have a simple(*) program.
> I just want to know how long the program takes to run.

I probably need to start from the absolutely MOST simple program possible, then work from there.

spin:
	mov ecx, 1
	shl ecx, 10
	xor eax, eax
loop:
	times 60 inc eax
	dec ecx
	jnz loop
	ret

I.e. just a long dependency chain of 61440 increment instructions.

Experimental setup:

- Boot kernel 6.8 with nohz_full=3 rcu_nocbs=3 isolcpus=nohz,domain,managed_irq,3 irqaffinity=0-2 nosmt mitigations=off nosoftlockup tsc=reliable log_buf_len=16M single
- Prepare system with:
echo -1 > /proc/sys/kernel/sched_rt_runtime_us
for I in 0 1 2 3; do echo userspace > /sys/devices/system/cpu/cpu$I/cpufreq/scaling_governor; done
for I in 0 1 2 3; do echo   2000000 > /sys/devices/system/cpu/cpu$I/cpufreq/scaling_setspeed; done
- Call spin() 10M times, recording the following events every time:
HW_CPU_CYCLES, HW_INSTRUCTIONS, UOPS_EXECUTED, EXEC_STALLS

Cycle-count distribution:

63500: 470202
63625: 8747244
63750: 770281
63875: 12143
64000: 105
64125: 16
64250: 3
64375: 2
64500: 1
64875: 1
68375: 1
91250: 1

This looks good, as far as I can tell.

 4.70% within [63500, 63625[
87.47% within [63625, 63750[
 7.70% within [63750, 63875[
 0.12% within [63875, 64000[

Covers 99.99% of samples.

Therefore, I think I would get very stable results by simply:
- running 100 iterations of the code
- discarding the worst 10 (20? 50?) outliers (what about the best outliers?)
- taking the arithmetic mean (or the median?)

I note that the benchmark overhead itself seems to be ~3000 cycles
(ioctl to reset the event counters + read to copy the event counters to user space)
3000 cycles is a whopping 5% of what I'm trying to measure.
It might make sense to call spin() a few times (2? 4? 10?) to lower the overhead's impact...

As always, happy to read anyone's input / insight into the process :)

Regards

