Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE032236E8
	for <linux-rt-users@vger.kernel.org>; Thu, 11 Sep 2025 21:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757626218; cv=none; b=FGSrQFQYLeyyqznYLu5TOSdeNISS1i1XgqnvoBH/wDzw2IA/Rf+XUxIXoOuuYz2wf7Tx6+ddHi42Wlx0j9J3koJMFKo+LK3/xw3+nIJ3g5cSh1c0izLr722/tly4aTG+m3JnumH9YO3bQsgqIFFfgDx4keH0tY+VE0aTcnhCU3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757626218; c=relaxed/simple;
	bh=N/rtMP0HUMk7WzxaGeEH9kv5H4zEU3Yy7ABPSE5N0YY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t/KqeoMaupVQa/EDmvGQhavuMRRHSxdJS85//BzzKxrv9lyKnZ47DyUJJXUUqWG2v7vn56i6lAzcsPG2XM4PYLHro2WwD1+wNZ1yvUYXhFXqt7K7WzsHl+xtDEBQsr7x2FewZEE4jFtr4qqrEkRTzQj4W/t+j8C0w54u+bm7ZG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=ckDZh5fb; arc=none smtp.client-ip=212.27.42.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="ckDZh5fb"
Received: from [IPV6:2a01:e34:ec24:52e0:7f63:f6c4:b3d2:48d6] (unknown [IPv6:2a01:e34:ec24:52e0:7f63:f6c4:b3d2:48d6])
	(Authenticated sender: marc.w.gonzalez@free.fr)
	by smtp2-g21.free.fr (Postfix) with ESMTPSA id A79362003D0;
	Thu, 11 Sep 2025 23:29:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1757626207;
	bh=N/rtMP0HUMk7WzxaGeEH9kv5H4zEU3Yy7ABPSE5N0YY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ckDZh5fb2hua8ametU0XPBxNFKRwAGujpNNhVSlZPIwdwpmHdk8a9n77oX65St/xE
	 9mUA87+HI9E9BwiA//kG0zp4WDK9Y2qsZvG3fQlpQYwXp6HGkLXRFY+eF6MORNdbcR
	 9oIH50lYiIxeHUWSAl1K5TCCqClJDv3ZzHEecD8/BrdtMdRUvlTPBbnOS/ABGdFjFJ
	 fX84RKpQ+uRwkJp7ONvWQ0JB37hd0HSuxQeUNXHd2NXrtbG9DFyg5H2/MQjrU9DdPl
	 9jJibwCtwdOXV5y+gSSwxKLl/XV59NqOpXQjVJWI1TYctzS0F6/grEKyXHiJYPuJFC
	 UzgKKdpm1QVTQ==
Message-ID: <60e4eb3c-3dfc-4212-bdcc-229a5b67b975@free.fr>
Date: Thu, 11 Sep 2025 23:29:48 +0200
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Unexplained variance in run-time of trivial program
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
References: <84ldmp8ewv.fsf@jogness.linutronix.de>
 <3fe55967-b4fa-4bc1-ae2b-58b5d1bbf3ea@free.fr>
 <d5f3d4c1-714b-46d4-99e6-c71ebf64e76b@flourine.local>
 <3220a6ab-19e5-4705-865a-1e1c37b67ccf@free.fr>
 <0d87e3c3-8de1-4d98-802e-a292f63f1bf1@free.fr>
 <84ms73kdn2.fsf@jogness.linutronix.de>
 <11dfa501-e280-4b50-a593-a4b153019b40@free.fr>
 <ddb85a49-934b-4c11-ac2a-c8a562e76e7e@free.fr>
 <CAMjhiJjMOQN-nWd+KP4JBBNHf20M+J2fXAuTTvowXctJgvGOcQ@mail.gmail.com>
 <41b7c365-62c2-4bfa-acd7-db73dc9f94f0@free.fr>
 <c462578d-4010-4063-9f01-54008ac91f95@flourine.local>
Content-Language: en-US
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
In-Reply-To: <c462578d-4010-4063-9f01-54008ac91f95@flourine.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/10/25 09:59, Daniel Wagner wrote:

> On Tue, Sep 09, 2025 at 10:30:49PM +0200, Marc Gonzalez wrote:
>
>> On 9/9/25 21:34, Leon Woestenberg wrote:
>>
>>> Basically, you are reverse-tuning a multicore CPU system,
>>> that is heavily optimized for time-sharing and overall
>>> system throughput, back to act like bare-metal single-application.
>>> You can get close, but you will never reach the determinism
>>> of say, an Cortex-R(ealtime) Core.
>>
>> This ignores the fact that I've been testing 2 programs:
>>
>> - P1, toy code that just calls dec 3 times in a tight loop
>> - P2, a few memory accesses, everything fits in L1
>>
>> I then loop P1 & P2 2^16 times to compute their average run-time.
>>
>> Over thousands of runs, RUNTIME_P1 is ALWAYS the same (within 30 ppm)
>>
>> Over thousands of runs, RUNTIME_P2 varies by up to 12 PERCENT (!!) = 122k ppm
> 
> Modern CPUs are highly complex systems with their micro architecture.
> The result is non-deterministic runtime behavior. I can't tell what you
> are measuring is the ballpark of non-deterministic runtime variance. If
> you don't want to read through the CPU manufactures documentation, you
> could check if the Spectre and related side channels attack papers give
> some clues on timings behavior?

I am well aware of the complexity of modern micro-architectures ;)

I actually reported a bug in the original K7 micro-architecture
25 years ago.

And Agner Fog's microarchitecture.pdf is always on my bedside table.
https://www.agner.org/optimize/microarchitecture.pdf

In an attempt to figure out the origin of the chaos, I broke out perf.
I would say I found many more questions than answers...

Running 3.3 GHz Haswell at 1.5 GHz
https://perfmon-events.intel.com/index.html?pltfrm=haswell_server.html
https://oprofile.sourceforge.io/docs/intel-haswell-events.php


GOOD RUN

D,C,Cb,F,T,N
1311453543 4317733068 4317732972 3292326 5002 262144

        7512849605      uops_executed.core                                                    
          31445738      uops_executed.stall_cycles                                            
         164966498      uops_retired.stall_cycles                                             
         574110144      topdown-fetch-bubbles                                                 
          25679080      cycle_activity.cycles_no_execute                                      
        6808318537      inst_retired.any                                                      
           6268865      int_misc.recovery_cycles                                              
           6268818      int_misc.recovery_cycles_any                                          

       1,313036051 seconds time elapsed


BAD RUN

D,C,Cb,F,T,N
1436503721 4729437143 4729436743 3292325 5479 262144

        7647384031      uops_executed.core                                                    
         113200734      uops_executed.stall_cycles                                            
         343460280      uops_retired.stall_cycles                                             
         787367726      topdown-fetch-bubbles                                                 
         106926806      cycle_activity.cycles_no_execute                                      
        6808330091      inst_retired.any                                                      
          17369470      int_misc.recovery_cycles                                              
          17369430      int_misc.recovery_cycles_any                                          

       1,438057158 seconds time elapsed


Remarks (in no particular order)

- Run-time increased by 9.5% (125 ms / 1.311 s)

- inst_retired.any remains (nearly) constant
BUT uops_executed.core increased by 1.8%
=> Where are those extra uops coming from???
Speculatively executed uops discarded on some flush event?

- 343460280-164966498 = 178.5M more stall cycles at retire stage
at 1.5 GHz = 119 ms
This alone could explain the degraded performance

- 113200734-31445738 = 81.7M more stall cycles at execute stage
some are probably dupes with retire stalls

- Not sure what the int_misc.recovery_* events measure???
They're documented as:
"This event counts the number of cycles spent waiting for a
recovery after an event such as a processor nuke, JEClear, assist,
hle/rtm abort etc."
and
"Core cycles the allocator was stalled due to recovery from earlier
clear event for any thread running on the physical core (e.g.
misprediction or memory nuke)."
=> In my case, they're probably measuring the same thing.
Weird that the description sounds a bit different.
Need to read up on processor nuke, memory nuke, machine clear event,
JEClear, assist, HLE/RTM...
I'll throw in MACHINE_CLEARS.CYCLES in the next run.
"Cycles there was a Nuke. Account for both thread-specific and All Thread Nukes."


I would love for someone to chime in & cast some light
on my utter confusion :)

Regards
