Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30991EEA31
	for <linux-rt-users@vger.kernel.org>; Thu, 26 Mar 2026 19:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774552176; cv=none; b=QMIoTf+u6y/+iTc+rLkvb4EvrpFLkcyV/zC7ROqyNJavNfHQldjCmiwMmbmZ81/NUWKkfFmFgZ6enQ9xjSd5aGF2eRnYwGKnyNQ3i2pofO0/+MbLRNVDcrPHSOb8KGN8fwAxBFC5WFyvd25cmmyXNnlaESGjvTbYUcPx1GQqo90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774552176; c=relaxed/simple;
	bh=qy3z3C4KIG5R6LgvhA8qmv8YR9til2j6nSywxZExOS0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=lETRZrg5trrfDS4pAl06bEBQsTJ2OUwF2qNC2WJ7djpMWmg36miFQ3Hd4EBD8cI4OOYpDvTnE+aGhJ3PtrDPtHp2psL1LP25TtiI8UXYTlbWKGZFGZNd/neUoGFZtWLN98/ceObA79c0NymBbLLgRb+k05di2oVdmWl4Ihah8mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=fS0NiHzU; arc=none smtp.client-ip=212.27.42.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="fS0NiHzU"
Received: from [IPV6:2a01:e34:ec24:52e0:bc12:2c8:82b0:e1] (unknown [IPv6:2a01:e34:ec24:52e0:bc12:2c8:82b0:e1])
	(Authenticated sender: marc.w.gonzalez@free.fr)
	by smtp3-g21.free.fr (Postfix) with ESMTPSA id ADEE913F8C6;
	Thu, 26 Mar 2026 20:09:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1774552171;
	bh=qy3z3C4KIG5R6LgvhA8qmv8YR9til2j6nSywxZExOS0=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=fS0NiHzUvJgBeAyiDr3mnS+cM4kXlDTOONfg51AcdFpMwW3yTwJTKzReiTY9e3dJf
	 C5j5zhwabHdxCJ5CICsSifKVnWykIkBMLvhAlko4OW2NfTrJ7zOra2LvP3OipKNr9Z
	 pxEQIdzn3A8gZCSjNQ6A5hHa4hyVI+qG2julKv5kTcs1Dd7+rkx0DKwgEli+NoU07R
	 JnIxCJFSD1xJO6y7F1I3rI0dAQ0tZQF8YgGOhjp8xtfbVEEmH8HUV55TunDilyCkru
	 X6P9sEzIFKj8ZViR3WqlkQgcohYPFiHppZYKXM8exny0gO8o35+uto/EUxzOKtLsvn
	 RBL7M+oBuIESg==
Message-ID: <5397d0cd-9266-44ae-97f2-75164d89bf48@free.fr>
Date: Thu, 26 Mar 2026 20:09:12 +0100
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
 "Ahmed S. Darwish" <darwi@linutronix.de>, agner@agner.org,
 Dirk Beyer <dirk.beyer@lmu.de>, Philipp Wendler <philipp.wendler@lmu.de>
References: <199905cb-04b3-4d3e-aeb3-da2b2d6428eb@free.fr>
Content-Language: fr
In-Reply-To: <199905cb-04b3-4d3e-aeb3-da2b2d6428eb@free.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

[ Add Daniel Wagner + use different address for John McCalpin ]

On 26/03/2026 16:24, Marc Gonzalez wrote:

> Hello (again) everyone,
> 
> Past discussion:
> Large(ish) variance induced by SCHED_FIFO / Unexplained variance in run-time of trivial program
> https://lore.kernel.org/linux-rt-users/0d87e3c3-8de1-4d98-802e-a292f63f1bf1@free.fr/
> 
> SYNOPSIS:
> I have a simple(*) program.
> I want to know how long the program runs.
> 
> (*) By simple, I mean:
> - no system calls, no library calls, just simple bit twiddling
> - tiny code, small(ish) dataset
> (the main function uses ~900 bytes of stack & recurses 40-60 times)
> 
> GOAL: Run the program 25,000 times. Get the SAME(ish) cycle count 25,000 times.
> 
> Running kernel v6.8 on Haswell i5-4590 3.3 GHz
> 
> I have removed "all" sources of noise / jitter / variance in the system:
> 
> A) kernel boots with:
> threadirqs irqaffinity=0-2 nohz=on nohz_full=3 isolcpus=3 rcu_nocbs=3 nosmt mitigations=off single
> i.e.
> - Expose ISRs as regular processes
> - No ISRs on CPU3
> - No timer interrupt on CPU3
> - No RCU callbacks on CPU3
> - 1 thread per core
> - No side-channel mitigations
> - Single user mode, no GUI, only 1 terminal
> 
> B) before program runs:
> echo -1 > /proc/sys/kernel/sched_rt_runtime_us
> for I in 0 1 2 3; do echo userspace > /sys/devices/system/cpu/cpu$I/cpufreq/scaling_governor; done
> for I in 0 1 2 3; do echo   2000000 > /sys/devices/system/cpu/cpu$I/cpufreq/scaling_setspeed; done
> sleep 0.5
> i.e
> - Let SCHED_FIFO program monopolize a CPU
> - Pin CPU frequency to 2 GHz to avoid thermal throttling & disable turbo-boost
> - Give these settings time to settle
> 
> C) start the benchmark:
> for I in $(seq 1 25000); do chrt -f 99 taskset -c 3 ./bench; done
> i.e.
> - Run as SCHED_FIFO 99 = nothing can interrupt the benchmark
> - Run the program on isolated CPU 3 where nothing else is running
> $ ps -eo psr,cls,pri,cmd --sort psr,pri
>   3  FF 139 [migration/3]
>   3  FF  90 [idle_inject/3]
>   3  TS  19 [cpuhp/3]
>   3  TS  19 [ksoftirqd/3]
>   3  TS  19 [kworker/3:0-events]
>   3  TS  19 [kworker/3:1]
> 
> D) prepare to run the timed code:
> 	u64 v[1+4];
> 	int main_fd = open_event(PERF_TYPE_HARDWARE, PERF_COUNT_HW_CPU_CYCLES, -1);
> 	open_event(PERF_TYPE_HARDWARE, PERF_COUNT_HW_INSTRUCTIONS, main_fd);
> 	open_event(PERF_TYPE_RAW, UOPS_EXECUTED, main_fd);
> 	open_event(PERF_TYPE_RAW, EXEC_STALLS, main_fd);
> 
> 	void *ctx = init_ctx();
> 	solve_grid(ctx); // warm up all types of caches
> 
> 	ioctl(main_fd, PERF_EVENT_IOC_RESET, PERF_IOC_FLAG_GROUP);
> 	solve_grid(ctx);
> 	if (read(main_fd, v, sizeof v) < sizeof v) return 2;
> 
> 	printf("%lu %lu %lu %lu\n", v[1], v[2], v[3], v[4]);
> 
> - PERF_EVENT_IOC_RESET resets all counters to 0, so we're only measuring the actual program, not any setup/teardown system code.
> 
> The results are unexpected, disappointing, frustrating...
> 
> 
>   AA     BB     CC    DD
> $ head -5 sorted.RES.5
> 108018 186124 256147 23195
> 108412 186124 257228 23275
> 108637 186124 258963 23245
> 109103 186124 258598 23507
> 109167 186124 259715 23425
> 
> $ tail -5 sorted.RES.5
> 123824 186124 266546 30949
> 124755 186122 266494 31749
> 124773 186124 264435 30966
> 126273 186122 267967 32376
> 130967 186124 284301 33597
> 
> AA = PERF_COUNT_HW_CPU_CYCLES
> BB = PERF_COUNT_HW_INSTRUCTIONS
> CC = UOPS_EXECUTED
> DD = EXEC_STALLS
> 
> It seems the program runs in ~108k cycles, but unexplained perturbations can delay
> the program by up to 23k cycles = 21% (108k + 23k = 131k in the worst observed case)
> 
> BEST CASE vs WORST CASE
> 108018 186124 256147 23195
> 130967 186124 284301 33597
> 
> Run-time: +21%
> I_count: identical
> uop_count: +11%
> exec_stalls: +45%
> 
> I don't see these wild deviations when I test toy programs that don't touch memory
> or only touch 1 word on the stack. So this seems to be memory-related?
> But everything fits in L1...
> Could there be some activity on other CPUs that force cache-coherence shenanigans?
> I'm stumped :(
> 
> Would appreciate any insight.
> Will re-read the previous thread for anything I might have missed.
> 
> Regards

