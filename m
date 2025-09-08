Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9B82940D
	for <linux-rt-users@vger.kernel.org>; Mon,  8 Sep 2025 15:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346241; cv=none; b=sCa2gx9bdabT7Mz3/lsfPtV5zr0Bt3xSmO0IG5BJi1liCST3D9il47FLvr0M2T4BSLhBQ2d8diHSkR81UeqCtamh68Y2wxt6+WIpAyJAUotOnAER5euoNlDLiKw1mVOZf9UsSKBsWu/ckVctQnM78v9cvAzFzvH2rdf6tr+ozvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346241; c=relaxed/simple;
	bh=sOaaZZZoMW1N1aXyVz74BGFxHM0VBtK3B/VG5J1vWvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DpqvT3XXHr4OyNX74mb7X+h504J3+0rHTSFNUg/rLQK/hpYZnU0CNTGMyk8FMA5akpQg3gBaBoBwMMYqnuKJAQPsLLt0TSf65lopU/Ql58aNM3XkuPgCixdIwyCzgfBLk45M7mfzJ2IhE1UzBOnB95/bbk3eTWvf011WsQr1sTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=roWdIm1r; arc=none smtp.client-ip=212.27.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="roWdIm1r"
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 67E274DECA
	for <linux-rt-users@vger.kernel.org>; Mon,  8 Sep 2025 17:43:18 +0200 (CEST)
Received: from [IPV6:2a01:e34:ec24:52e0:b7e3:847c:625c:d84a] (unknown [IPv6:2a01:e34:ec24:52e0:b7e3:847c:625c:d84a])
	(Authenticated sender: marc.w.gonzalez@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id 6DEF0780395;
	Mon,  8 Sep 2025 17:42:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1757346191;
	bh=sOaaZZZoMW1N1aXyVz74BGFxHM0VBtK3B/VG5J1vWvA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=roWdIm1rDqO2ihNzionUZmVXVzb5GgnS7uSeGIBprsDPdMOw0c+oFlYclbZGHx8Lh
	 iMT7tcQrpraR5pqX7AXPlzZ+PvMt4yj4J2mR+vqn7O2JMM6XVeNLs3p3R/P/lULJ3/
	 aWkp5oB5r3m4/1lLiOCHKTesx/jyNHRzugnN/lzpzJ3OVUIEvwQGI4jUZqY0B8rxuL
	 LQu9h+BIPgnjnJCXmxvvX9WQsNEMR+DMnsZyPtHE1cyB4xbJU0/8EyiQJpvqwpqCgb
	 ObimzsZa7y47PFKVKUQd/V9N7xBi8GAUZUuj60pZfBhywwo+rx4QSglHdxG8fLTy4c
	 6kZElhn8JZrcw==
Message-ID: <3fe55967-b4fa-4bc1-ae2b-58b5d1bbf3ea@free.fr>
Date: Mon, 8 Sep 2025 17:42:58 +0200
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Large(ish) variance induced by SCHED_FIFO
To: John Ogness <john.ogness@linutronix.de>,
 Leon Woestenberg <leon@sidebranch.com>, Daniel Wagner <dwagner@suse.de>
Cc: linux-rt-users@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Daniel Wagner <daniel.wagner@suse.com>, Clark Williams
 <williams@redhat.com>, Pavel Machek <pavel@denx.de>,
 Luis Goncalves <lgoncalv@redhat.com>,
 John McCalpin <mccalpin@tacc.utexas.edu>
References: <5f7496eb-bf62-4cc9-bef0-9cae97a93dca@free.fr>
 <ac1ef5df-aa30-4b63-9beb-3e0522dd3cec@flourine.local>
 <afc4c145-4758-4924-b106-e7844624d269@free.fr>
 <841polf13z.fsf@jogness.linutronix.de>
 <42c5fb53-d423-41a5-80d9-557ff2a3e804@free.fr>
 <84ldmsevcm.fsf@jogness.linutronix.de>
 <3f1d4229-a95c-4d99-a98f-249d9e488b32@free.fr>
 <84ldmp8ewv.fsf@jogness.linutronix.de>
Content-Language: fr, en-US
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
In-Reply-To: <84ldmp8ewv.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/09/2025 11:36, John Ogness wrote:

> There are still reasons why CLOCK_MONOTONIC_RAW might be
> interesting. For example, if you want a very stable time source to
> compare intervals, but do not care so much about the real world time
> lengths of those intervals (i.e. where is the greatest latency vs. what
> is the value of the greatest latency). Although even here, I doubt
> CLOCK_MONOTONIC_RAW has a practical advantage over CLOCK_MONOTONIC.

In fact, I'm just trying to compare the run-time of 2 minor
variations of the same program (testing micro-optimizations).

Absolute run-time is not really important, what I really want
to know is: does v2 run faster or slower than v1?

This is the framework I'm using at this point:

#include <stdio.h>
#include <time.h>
extern void my_code(void);

static long loop(int log2)
{
	int n = 1 << log2;
	struct timespec t0, t1;
	clock_gettime(CLOCK_MONOTONIC, &t0);
	for (int i = 0; i < n; ++i) my_code();
	clock_gettime(CLOCK_MONOTONIC, &t1);
	long d = (t1.tv_sec - t0.tv_sec)*1000000000L + (t1.tv_nsec - t0.tv_nsec);
	long t = d >> log2;
	return t;
}

int main(void)
{
	long t, min = loop(4);
	for (int i = 0; i < 20; ++i)
		if ((t = loop(8)) < min) min = t;
	printf("MIN=%ld\n", min);
	return 0;
}

Basically:
- warm up the caches
- run my_code() 256 times && compute average run-time
- repeat 20 times to find MINIMUM average run-time

When my_code() is a trivial computational loop such as:

	mov $(1<<12), %eax
1:	dec %ecx
	dec %ecx
	dec %eax
	jnz 1b
	ret

Then running the benchmark 1000 times returns the same value 1000 times:
MIN=2737


Obviously, the program I'm working on is a bit more complex, but barely:
- no system calls, no library calls
- just simple bit twiddling
- tiny code, tiny data structures, everything fits in L1
$ size a.out
   text	   data	    bss	    dec	    hex	filename
   8549	    632	   1072	  10253	   280d	a.out

When I run the benchmark 1000 times, there are some large outliers:
MIN_MIN=2502
MAX_MIN=2774

NOTE: 95% of the results are below 2536.
But the top 1% (worst 10) are really bad (2646-2774)

How to get repeatable results?

Random 10% outliers break the ability to measure the impact
of micro-optimizations expected to provide 0-3% improvements :(

For reference, the script launching the benchmark does:

echo     -1 > /proc/sys/kernel/sched_rt_runtime_us
for I in 0 1 2 3; do echo userspace > /sys/devices/system/cpu/cpu$I/cpufreq/scaling_governor; done
sleep 0.25
for I in 0 1 2 3; do echo   3000000 > /sys/devices/system/cpu/cpu$I/cpufreq/scaling_setspeed; done
sleep 0.25

for I in $(seq 1 1000); do
chrt -f 99 taskset -c 2 ./a.out < $1
done

for I in 0 1 2 3; do
echo schedutil > /sys/devices/system/cpu/cpu$I/cpufreq/scaling_governor
done
echo 950000 > /proc/sys/kernel/sched_rt_runtime_us


I've run out of ideas to identify other sources of variance.
(I ran everything in single user mode with nothing else running.)
Perhaps with perf I could identify the source of stalls or bubbles?

Hoping someone can point me in the right direction.

Regards


