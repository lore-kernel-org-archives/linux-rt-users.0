Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A7484A3E
	for <linux-rt-users@vger.kernel.org>; Sat, 13 Sep 2025 10:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757758190; cv=none; b=ALIpY3yinkwPSUxb2Kll4jXykWJYK4jLioTNaEQt2yeHeo4TBkXzyDAejJXs2UJxV4TRr/ZYoACk0O8M49vHb1hSexHO5a8rMce1yb0+Lvx2dZB3G9uzyS+ntJmo/RjGNWrOo0QgV1LfiIyEif/egqHu//L+BRtN6T79sBNnqVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757758190; c=relaxed/simple;
	bh=XnKXm5UChNjXJVmKVWxSG/pdSt1W6jA/2yClPYn3V3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b2pfhWSeOnENCa4snG0uz3lcYWy62murP/Kc5eWzgGtptQ/hDGP/EOrzTLFXmTJV+El6Zr5zjGBUN7HbITjc5E7yLw9gUxRH/eWFZeqs4PXBMU3v5B4o9IuK+oW3bu3OrJR2tRppkvl5+VW66fV5sr0vd5ADr7bIBvs7omxFfv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=LsR6FPk9; arc=none smtp.client-ip=212.27.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="LsR6FPk9"
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 88398428536
	for <linux-rt-users@vger.kernel.org>; Sat, 13 Sep 2025 12:09:38 +0200 (CEST)
Received: from [IPV6:2a01:e34:ec24:52e0:ae9f:4aea:7b83:696] (unknown [IPv6:2a01:e34:ec24:52e0:ae9f:4aea:7b83:696])
	(Authenticated sender: marc.w.gonzalez@free.fr)
	by smtp3-g21.free.fr (Postfix) with ESMTPSA id EAE8613F8AD;
	Sat, 13 Sep 2025 12:09:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1757758171;
	bh=XnKXm5UChNjXJVmKVWxSG/pdSt1W6jA/2yClPYn3V3M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LsR6FPk9+KhKdvIEEotXR9XOyC6NrEAnAZsyqPG1pswaWeAtkBOd4LcBrIxaJK5/K
	 q3IapbwIktEOlNUsV+2CDAnyBgs3I80h7Y2RgLS4L/POkuiEpGUTlUrxa2bC16S+Vk
	 U5bTRjgQ5lyYD/fiS2ff31xcxwvJbdVhc1n/YDn0nPmenspfs8X0IaiL0Brp80R5a1
	 SkWrR8boo0wCxwsiDjbqlXTuO5ZJOIeKGaZROdIf9xHFQZD/zoIZ8sWFttfSXVQa37
	 yAEwhaZflwA6+PlhPOsP7p0HqIZJcAgV2+b5m/z6UE/82rbLAjleHbN0gjGPmWzx6D
	 DPjn3HwQQx2sA==
Message-ID: <10a88382-dc37-4912-86b5-fe6bf98e5491@free.fr>
Date: Sat, 13 Sep 2025 12:09:13 +0200
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
Content-Language: en-US
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
In-Reply-To: <1b76251b-6f57-4d72-bc48-b8df6ac077b2@flourine.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/25 09:44, Daniel Wagner wrote:

> On Fri, Sep 12, 2025 at 12:15:12AM +0200, Marc Gonzalez wrote:
>
>> - Not sure what the int_misc.recovery_* events measure???
>> They're documented as:
>> "This event counts the number of cycles spent waiting for a
>> recovery after an event such as a processor nuke, JEClear, assist,
>> hle/rtm abort etc."
>> and
>> "Core cycles the allocator was stalled due to recovery from earlier
>> clear event for any thread running on the physical core (e.g.
>> misprediction or memory nuke)."
>> => In my case, they're probably measuring the same thing.
>> Weird that the description sounds a bit different.
>> Need to read up on processor nuke, memory nuke, machine clear event,
>> JEClear, assist, HLE/RTM...
>>
>> Daniel, seems you were spot on when mentioning side channel attacks.
> 
> I'm sorry if I sounded patronizing, that was not my intent. After we
> ruled out the OS noise the only thing left was that the runtime variance
> is from the CPU itself.

I appreciate all the insights you've shared this far! :)
(As well as that from other participants!)

>> https://www.usenix.org/system/files/sec21-ragab.pdf
>>
>> I need to truly read & understand this paper.
> 
> Skimmed over it, it could explain what you are observing. The question
> obviously is which part of the 'bad' code is confusing the CPU :)

GOOD RUN
D,C,Cb,F,T,N
1310881180 4315846773 4315846665 3292324 5000 262144
        6808319919      inst_retired.any                                                      
        7513464787      uops_executed.core                                                    
          30496248      uops_executed.stall_cycles                                            
         164691876      uops_retired.stall_cycles                                             
           6292081      int_misc.recovery_cycles                                              
            292758      machine_clears.count                                                  
            292049      machine_clears.memory_ordering                                        

BAD RUN
D,C,Cb,F,T,N
1417213267 4665926496 4665926108 3292324 5406 262144
        6808316250      inst_retired.any                                                      
        7614270474      uops_executed.core                                                    
          85148157      uops_executed.stall_cycles                                            
         285284384      uops_retired.stall_cycles                                             
          13520285      int_misc.recovery_cycles                                              
           1536963      machine_clears.count                                                  
           1536308      machine_clears.memory_ordering                                        

Notes:

- A "good" run gets 300k machine clears.
- A  "bad" run gets 1.5M machine clears.
- All machine clears are memory ordering machine clears.
No self-modifying code, no floating point code.
Probably a few MCs from page faults.
(TODO: measure only MCs from my code, not setup code)

If I understand correctly, a memory ordering machine clear
only happens when different cores access the same memory?
I'm running single-threaded code on an otherwise idle system.
I'm thinking that Haswell might lump Memory Ordering AND
Memory Disambiguation MCs?

Is that a reasonable assumption?

Not sure what's non-deterministic about the loads in my code.
Might be some kind of "catastrophic" chain of events where
one mispredict generates a cascade of subsequent mispredicts.

I will keep digging :)

Regards

