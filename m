Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858B23019AB
	for <linux-rt-users@vger.kernel.org>; Tue,  9 Sep 2025 18:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757442815; cv=none; b=h0bY0S5fGSsgB0FBkrF0f5di+/5yUdwdd4STNIZf1Oo+zYpxYgm1zBw31a2gc8phIu5PQVLZvqp1RQKcOCTXa/tn2HE8OtUWbM1x5R453JichB14ppsl2deNq3/23D2UTLPaacO9qFdkqf09VvGoIfeXY4we9cdhuZBtPpaOLq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757442815; c=relaxed/simple;
	bh=S9EAQkzQ0v1UEjyl1EpqjJGU+emHcu2OodU/xCOzLaA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KNiRqUZiKEM88ddNqNC04Mj+g58ScSDxyWBaoUnFlZe7uroUMCz6BI6FHoxc4CXogP3myln06TQy+sOSDW3WlHJ2mkeRrPpb2Dwhzvg38PZDrAH5vKrISf6tjXeu9It4PVra9W9vlVZkOy7LY5zd7DWVtdc1v0GJGBcQb8+Fnlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=IFcadTfX; arc=none smtp.client-ip=212.27.42.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="IFcadTfX"
Received: from [IPV6:2a01:e34:ec24:52e0:4e45:8447:d6c0:1a95] (unknown [IPv6:2a01:e34:ec24:52e0:4e45:8447:d6c0:1a95])
	(Authenticated sender: marc.w.gonzalez@free.fr)
	by smtp2-g21.free.fr (Postfix) with ESMTPSA id A7A802003CC;
	Tue,  9 Sep 2025 20:33:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1757442806;
	bh=S9EAQkzQ0v1UEjyl1EpqjJGU+emHcu2OodU/xCOzLaA=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=IFcadTfX6O3MLEkJGAeRNhIjrLJyczEesL21/A19/VOYBL8O3OjprCBR+V71t6od7
	 8kIwOQL+rnfggKBC5XogxO7E/gdqEai71OboqOIkwmakx9GYnxteIQQqkKrO2tc+M5
	 Zmqkwxqo+kAU0dnZ3VqhdhjmxliknYMXY031u9/xeoGUs4BTqZn+n89x590Fawdkpo
	 5C8oUDldHMhb4+Mnmjl/ylJdjIbu/QCLU9aMLxBLLbhsTkAzGghppcb1SthVQpHZKk
	 q+W3Rqr+nRrgOTgeAlMZyb05YwU3IczfuHyywhcrmNd6TIlTkUE7Lsu4y3/tiG7JW7
	 SBMD66/sWVSJQ==
Message-ID: <ddb85a49-934b-4c11-ac2a-c8a562e76e7e@free.fr>
Date: Tue, 9 Sep 2025 20:33:09 +0200
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Unexplained variance in run-time of trivial program
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
To: John Ogness <john.ogness@linutronix.de>, linux-rt-users@vger.kernel.org
Cc: Daniel Wagner <dwagner@suse.de>, Leon Woestenberg <leon@sidebranch.com>,
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
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
Content-Language: fr
In-Reply-To: <11dfa501-e280-4b50-a593-a4b153019b40@free.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/25 16:08, Marc Gonzalez wrote:

> My hunch is frequency dropped to ~2.7 GHz for the duration of the benchmark.
> 
> Maybe I should lower the frequency to 2 GHz.
> But again, why would my code force throttling and not the toy code?
> One possible reason is my code reaches 3.5 IPC, while the toy code
> remains at 1.5 IPC (with micro-op fusion).
> 
> It's a stretch, but easy to test.
> 
> I will measure CPU cycles, to see if the increased run-time
> corresponds with a change in CPU cycles.

# dmesg | grep -i tsc
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 3292.563 MHz processor
[    0.038014] TSC deadline timer available
[    0.093396] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x2f75db292c8, max_idle_ns: 440795321216 ns
[    0.178415] clocksource: Switched to clocksource tsc-early
[    1.272272] tsc: Refined TSC clocksource calibration: 3292.377 MHz
[    1.272280] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2f752b31fa5, max_idle_ns: 440795265170 ns
[    1.272305] clocksource: Switched to clocksource tsc

$ lscpu | grep -o '[a-z_]*tsc[a-z_]*'
tsc
rdtscp
constant_tsc
nonstop_tsc
tsc_deadline_timer
tsc_adjust

static void loop(int log2)
{
	int n = 1 << log2;
	struct timespec t0, t1;
	clock_gettime(CLK, &t0);
	long c0 = __rdtsc();
	for (int i = 0; i < n; ++i) my_code();
	long c1 = __rdtsc();
	clock_gettime(CLK, &t1);
	long d = (t1.tv_sec - t0.tv_sec)*1000000000L + (t1.tv_nsec - t0.tv_nsec);
	long t = d >> log2;
	long c = c1-c0;
	long f = c*1000000/d;
	printf("D=%ld C=%ld F=%ld T=%ld N=%d\n", d, c, f, t, n);
}

(Looks like RDTSCP might have been preferable over RDTSC)

I lowered the frequency of all cores to 1.5 GHz

MIN RUNTIME: D=327944847 C=1079700683 F=3292323 T=5004 N=65536
MAX RUNTIME: D=369923901 C=1217909284 F=3292323 T=5644 N=65536

Looks like the TSC ticks at 3.3 GHz (core nominal freq) even
if I manually lower the core frequency. I need to figure out
how 'perf stat' does it. Probably reads a different MSR.

Changing /sys/devices/system/clocksource/clocksource0/current_clocksource
to hpet doesn't really change anything.

TODO: find cycle count MSR.

