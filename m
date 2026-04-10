Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433F037DE9B
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Apr 2026 17:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775841417; cv=none; b=mwEaM/JD9PbZpXMV8VWnEd0NGtlE8IuYnMMRuVOHTA5hJuWwHyUNWea7egwupm9fl+87GklNGyCsBqmEwBne8SOhmG3Axhr2CpmOBL78a3dswISNv+3Pdyk2X6kYxZ1jN5wj2A4Qb5ooSuz4HbJKGiKJGHxJOBL/G6REdlJ2/PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775841417; c=relaxed/simple;
	bh=wJiI4S0mZwFqV8qBG5ZW++/ImEuBIIBe75RO8ukVdbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VoeHJuqS/Pht6w+LJ+KLi8nQaALVwo+gyJHz87Unl9qRC9Q+p2Yu8vZ27Y3+cXo4NhEvigogj+/AV5yCrcZrxiSWyVPGS8qg2yPDzUz1YYMzZhkJbGXkTXaNWMdqmaMSp1pqbmz0qduj3OmQD0kP6D7VOnZHvzxPKRYjiEo0/vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=rQUcwJ8p; arc=none smtp.client-ip=212.27.42.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="rQUcwJ8p"
Received: from [IPV6:2a01:e34:ec24:52e0:f488:e842:4484:d629] (unknown [IPv6:2a01:e34:ec24:52e0:f488:e842:4484:d629])
	(Authenticated sender: marc.w.gonzalez@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id 5C1EF780333;
	Fri, 10 Apr 2026 19:16:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1775841406;
	bh=wJiI4S0mZwFqV8qBG5ZW++/ImEuBIIBe75RO8ukVdbU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rQUcwJ8pA0eQblQWPWM8VLrCNWzgZP9t+rPvwHE6kb5galBTvlAbQ/dGIVGjFWs6J
	 rJVJ9jwqObJax81Hwi/jNTYY/1ei0YCU8REBhskBeOu+T8HfW1lq5kgS6ItQZtqBVm
	 viMXPIHvMUzjQu28jvv/yweaYStY2LSsX6zORfL13zVkGvRY/m9k8/b0If7Tgcs25/
	 s7Y2yUKdu9KQ9D84vh4eifrY430P7Dv0QVkoji9qN15Oh+Ugdye02ofls6n3cuLZDM
	 iiZpoqN8d9hOe5Rb5c2r4XFiCIhHb7JPyot/TyH7YWyvrPu7RRNnUweyXlPtQc15eZ
	 7BbF71+9STLQg==
Message-ID: <1137e806-eddc-409d-8694-4465e2123764@free.fr>
Date: Fri, 10 Apr 2026 19:16:25 +0200
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Unexplained variance in run-time of simple program (part 2)
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
Content-Language: en-US
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
In-Reply-To: <7FA25B6F-71A1-4B2B-9488-46D91445DAF3@mccalpin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 08/04/2026 11:29, John D. McCalpin wrote:

> I am still not clear on exactly what you mean by “executing the benchmark 2^16 times”.
> Are you forking a new process 2^16 times, or is a single process executing a block of code 2^16 times.
> The difference is critical for determining where to look for sources of performance variability.
Based on your very insightful feedback (thanks again!) I currently use this wrapper:

#include <stdlib.h>
#include <stdio.h>

typedef unsigned int u32;

// Ignore id: process will be pinned to core 3
// Ignore hi: t1-t0 < 2^32 cycles (1.3 seconds)
static inline u32 rdtscp(void)
{
	u32 hi, lo, id;
	asm volatile("rdtscp" : "=d"(hi), "=a"(lo), "=c"(id));
	return lo;
}

extern void init(void);
extern void spin(void); // THE CODE UNDER BENCHMARK

static u32 v[4];

int main(int argc, char **argv)
{
	if (argc != 3) return 1;

	const u32 N = strtoul(argv[1], NULL, 10);
	const u32 S = strtoul(argv[2], NULL, 10);

	void *buf = aligned_alloc(4096, N * sizeof v);

	for (u32 n = 0; n < N; ++n)
	{
		for (u32 i = 0; i < 4; ++i)
		{
			u32 t0 = rdtscp();
			for (u32 s = 0; s < S; ++s) spin();
			u32 t1 = rdtscp();
			v[i] = t1 - t0;
		}
		__builtin_ia32_movntdq(buf + n * sizeof v, __builtin_ia32_movntdqa((void *)v));
	}

	for (int i = 0; i < N * 4; ++i) printf("%u\n", ((u32 *)buf)[i]);

	return 0;
}

N times: time the code 4 times, and transfer the 4 results to memory using a non-temporal store.
Once measuring is done, print all the results.
Would it be more efficient to write a full cache line with movntdq? (64 bytes vs 16 bytes)


The baseline code (to check for correct results) is:

spin:
	xor eax, eax
	mov ecx, 1000
loop:
	times 60 inc eax ; 120 bytes
	dec ecx
	jnz loop ; 8-bit offset
	ret


I ran the following experiments:
./run.sh ./baseline 200000 1
./run.sh ./baseline 200000 2
./run.sh ./baseline 200000 4


The results in histogram (in 50-cycle steps) :

histo.1
99000: 199999
99100: 1

histo.2
197950: 85290
198000: 114706
198050: 1
198200: 2
198250: 1

$ cat histo.4
395900: 110104
395950: 89891
396000: 1
396150: 2
396200: 1
396450: 1

1st col: cycles @ 3.3 GHz
2nd col: number of times result fell in that interval

I think this is looking pretty good!
I just need to test on my actual code that uses L1$.

Regards

