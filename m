Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8EE23814D
	for <linux-rt-users@vger.kernel.org>; Mon, 15 Sep 2025 16:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757953882; cv=none; b=M8WqWRpgqchPG7xZeeRVstXJXBtpLB4rhqGeIY0wuBO6DuNz2ncB3yyXCKW2yhUsOpoKxjAwUTQaq3h19WYJBC/3kaDQzCzzhCCXnqkQ7tRoeCBrQv4fMhx50bWLIkw52VRXSczKGt22dVBeFdozyhotrm7vaQoSwz6pg+spHfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757953882; c=relaxed/simple;
	bh=deTQ3UBKmyhJEniz9Mxuk4D+nLJt6A9lz7jbHOnep2E=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DJ6HGtUbvubdDeYwAsQ1NARhabI64OtC1jej+qEPRKHT4FLOggm50eq/H3wgvjWclAAomrbHg2cEINBrBGaeFGenVhtvwm0U0YAhsTPoiblbylIlDYtmfhNI7wkcSRHlPg+LdH152razIWVW0XKhQ4Wpe+3aRda/kw9Jv7VzI+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=vR9Vgklp; arc=none smtp.client-ip=212.27.42.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="vR9Vgklp"
Received: from [IPV6:2a01:e34:ec24:52e0:e26c:c183:b317:90b6] (unknown [IPv6:2a01:e34:ec24:52e0:e26c:c183:b317:90b6])
	(Authenticated sender: marc.w.gonzalez@free.fr)
	by smtp4-g21.free.fr (Postfix) with ESMTPSA id 122B519F576;
	Mon, 15 Sep 2025 18:30:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1757953872;
	bh=deTQ3UBKmyhJEniz9Mxuk4D+nLJt6A9lz7jbHOnep2E=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=vR9VgklpOKjWXDq+3a6ad3sax1ugCk+WtvIYZdFgYW4GbHef5pkdYcABUtljGaXRT
	 AekxPoF7Dd54mxRU+W46ilr3ZHGhAJKcY4+DazEPMvgQIzxhDeHYRWmjHUzJZX+HGg
	 k0XQoCF0q4/GTB8hNOUSpaSpQjKLpK6jp3laayySM5kB/cJoqkZKd++c7iRoiHBZ2C
	 qIwPyht8twUc4J487Ml13oJq6D+11avvc0hTgp/ZIop/bJbAvv1WqcWB+3N5QWELko
	 7tJdSWQLnNjXPIciVRo+hS9/fI/Ers3Ii8RJTPW+3pRaWnYvzoUL7gt8zm5BG2F/Gi
	 BEu8GFrWW4c6w==
Message-ID: <491b2ee8-1c25-486c-acb5-0d68454a5769@free.fr>
Date: Mon, 15 Sep 2025 18:30:55 +0200
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Unexplained variance in run-time of trivial program
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
To: Daniel Wagner <dwagner@suse.de>
Cc: Leon Woestenberg <leon@sidebranch.com>,
 John Ogness <john.ogness@linutronix.de>, linux-rt-users@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <williams@redhat.com>, Pavel Machek <pavel@denx.de>,
 Luis Goncalves <lgoncalv@redhat.com>,
 John McCalpin <mccalpin@tacc.utexas.edu>,
 Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, agner@agner.org
References: <3220a6ab-19e5-4705-865a-1e1c37b67ccf@free.fr>
 <0d87e3c3-8de1-4d98-802e-a292f63f1bf1@free.fr>
 <84ms73kdn2.fsf@jogness.linutronix.de>
 <11dfa501-e280-4b50-a593-a4b153019b40@free.fr>
 <ddb85a49-934b-4c11-ac2a-c8a562e76e7e@free.fr>
 <CAMjhiJjMOQN-nWd+KP4JBBNHf20M+J2fXAuTTvowXctJgvGOcQ@mail.gmail.com>
 <41b7c365-62c2-4bfa-acd7-db73dc9f94f0@free.fr>
 <c462578d-4010-4063-9f01-54008ac91f95@flourine.local>
 <60e4eb3c-3dfc-4212-bdcc-229a5b67b975@free.fr>
 <913e8f73-d10f-47c9-b608-f8f9cb9eef1c@free.fr>
 <1b76251b-6f57-4d72-bc48-b8df6ac077b2@flourine.local>
 <10a88382-dc37-4912-86b5-fe6bf98e5491@free.fr>
Content-Language: en-US
In-Reply-To: <10a88382-dc37-4912-86b5-fe6bf98e5491@free.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/13/25 12:09, Marc Gonzalez wrote:

> GOOD RUN
> D,C,Cb,F,T,N
> 1310881180 4315846773 4315846665 3292324 5000 262144
>         6808319919      inst_retired.any                                                      
>         7513464787      uops_executed.core                                                    
>           30496248      uops_executed.stall_cycles                                            
>          164691876      uops_retired.stall_cycles                                             
>            6292081      int_misc.recovery_cycles                                              
>             292758      machine_clears.count                                                  
>             292049      machine_clears.memory_ordering                                        
> 
> BAD RUN
> D,C,Cb,F,T,N
> 1417213267 4665926496 4665926108 3292324 5406 262144
>         6808316250      inst_retired.any                                                      
>         7614270474      uops_executed.core                                                    
>           85148157      uops_executed.stall_cycles                                            
>          285284384      uops_retired.stall_cycles                                             
>           13520285      int_misc.recovery_cycles                                              
>            1536963      machine_clears.count                                                  
>            1536308      machine_clears.memory_ordering                                        
> 
> Notes:
> 
> - A "good" run gets 300k machine clears.
> - A  "bad" run gets 1.5M machine clears.
> - All machine clears are memory ordering machine clears.
> No self-modifying code, no floating point code.
> Probably a few MCs from page faults.
> (TODO: measure only MCs from my code, not setup code)
> 
> If I understand correctly, a memory ordering machine clear
> only happens when different cores access the same memory?
> I'm running single-threaded code on an otherwise idle system.
> I'm thinking that Haswell might lump Memory Ordering AND
> Memory Disambiguation MCs?
> 
> Is that a reasonable assumption?
> 
> Not sure what's non-deterministic about the loads in my code.
> Might be some kind of "catastrophic" chain of events where
> one mispredict generates a cascade of subsequent mispredicts.
> 
> I will keep digging :)

I now have a better understanding of the issue :)

To recap, I'm benchmarking a fairly trivial piece of code.
But I observe a large variance in the run-time of said code
(from N to 1.15N nanoseconds).

What's more, the variance REMAINS when I run the code
far longer (by looping the same execution).

Therefore
- Either the perturbation is periodic, and adds noise
whatever the duration of the benchmark,
- OR the perturbation only manifests in SOME RUNS.

However, some runs complete without any perturbation,
even very long ones.

Runs where perturbations are observed have a much higher
incidence of MEMORY ORDERING MEMORY NUKES. These types
of events happen when different cores share memory
(true sharing or false sharing). Since my code is purely
single-threaded, it must be false sharing. At this point,
I'm guessing that the address randomization creates
ONLY FOR SOME RUNS a condition where my program lives
in similar virtual addresses than another program active
on a different core, which causes MEMORY NUKES.

I can work around the issue by:
INSTEAD OF running 1M instances of my code in 1 program,
I RUN 1000 programs running 1000 instances of my code.
And taking the minimum run-time of the 1000.
(There is a bit more overhead in forking so many programs,
but I really need reproducible results.)

Now I observe less than 0.2% variance.

I will also try disabling address randomization,
to test my hypothesis.

Has anyone ever dealt with this issue?

Regards
