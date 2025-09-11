Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EBB158538
	for <linux-rt-users@vger.kernel.org>; Thu, 11 Sep 2025 22:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757628933; cv=none; b=iSqRrGkRx1hKbkB3CWjt0oRCYuzyZpbnjP7GOijxovH/99ZfyMoT5wEsOBfDU3jCymeQheok4+C1m7UvyFteI0dPtCITP+c4zeHO9+/wzIsrllu15HRCmgeHTZEkNQZKZScAK4BPZ2wBvvkDP/breRHGQILRLGD5yiBj56LLbMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757628933; c=relaxed/simple;
	bh=epJpX7JeW26JnB77+mFVAQ0RAyUkGI1Fd0ehJkVdp+Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Vh2jeoxciaE25xig4GxENUlouVq5Pgm5WMfHr8KQ3jS/3b+WoYHN4fH/CmNv/zhA17LKnohuQaaz35kC4+1Dfg051JOyPzgA6OGUhZ2253HdBavWHF9GJvhlKbGrgikoGpxkVNMab/M9TD+1rMfDpvZvM5aXTBqVPiVoXKgqOxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=fMXOsH9o; arc=none smtp.client-ip=212.27.42.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="fMXOsH9o"
Received: from [IPV6:2a01:e34:ec24:52e0:7f63:f6c4:b3d2:48d6] (unknown [IPv6:2a01:e34:ec24:52e0:7f63:f6c4:b3d2:48d6])
	(Authenticated sender: marc.w.gonzalez@free.fr)
	by smtp2-g21.free.fr (Postfix) with ESMTPSA id 6ED7320039E;
	Fri, 12 Sep 2025 00:15:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1757628929;
	bh=epJpX7JeW26JnB77+mFVAQ0RAyUkGI1Fd0ehJkVdp+Q=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=fMXOsH9oHpqPCsJM910OYumjXZ7P9AHhEI0OFWRBzgK2mRdV/zOymF6EE/rcpEJ+s
	 U5M1Ox2sLF4qyLZyQLc3Bh7xny35caEfiYu/f5o647aiBo1xfPGN/EBydS1O6d5P4T
	 zkP0zXSus8XnpNvZgci04qhxhV10/km8Jdztguhjxm98ZVf0KQmn2pFHCXbV6hxnnZ
	 8qSHjG2cP3j/pI/aiP6p2DF5L6pS9L9uHhJ29rDu7u7II6DFeVR7SZ7/ApDDJpvc62
	 xruBl2KrqQP7R4gdwz1gS7QuRJ3P8wfjhwXq2Ifl+rlUDXS5rpeC3QDtiCCv8ZvzZI
	 hbpehVTLYoQqg==
Message-ID: <913e8f73-d10f-47c9-b608-f8f9cb9eef1c@free.fr>
Date: Fri, 12 Sep 2025 00:15:12 +0200
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
 <60e4eb3c-3dfc-4212-bdcc-229a5b67b975@free.fr>
Content-Language: fr
In-Reply-To: <60e4eb3c-3dfc-4212-bdcc-229a5b67b975@free.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/11/25 23:29, Marc Gonzalez wrote:

> - Not sure what the int_misc.recovery_* events measure???
> They're documented as:
> "This event counts the number of cycles spent waiting for a
> recovery after an event such as a processor nuke, JEClear, assist,
> hle/rtm abort etc."
> and
> "Core cycles the allocator was stalled due to recovery from earlier
> clear event for any thread running on the physical core (e.g.
> misprediction or memory nuke)."
> => In my case, they're probably measuring the same thing.
> Weird that the description sounds a bit different.
> Need to read up on processor nuke, memory nuke, machine clear event,
> JEClear, assist, HLE/RTM...

Daniel, seems you were spot on when mentioning side channel attacks.

https://www.usenix.org/system/files/sec21-ragab.pdf

I need to truly read & understand this paper.

GOOD
D,C,Cb,F,T,N
1311384211 4317505417 4317505021 3292326 5002 262144
        6808311015      inst_retired.any                                                      
        7515242772      uops_executed.core                                                    
          31190466      uops_executed.stall_cycles                                            
          25467763      cycle_activity.cycles_no_execute                                      
         165247175      uops_retired.stall_cycles                                             
           6335672      int_misc.recovery_cycles                                              
            296086      MACHINE_CLEARS.CYCLES                                                 

BAD
D,C,Cb,F,T,N
1460302963 4807793027 4807792639 3292325 5570 262144
        6808333218      inst_retired.any                                                      
        7656792683      uops_executed.core                                                    
         107194058      uops_executed.stall_cycles                                            
         102852971      cycle_activity.cycles_no_execute                                      
         341106967      uops_retired.stall_cycles                                             
          15062277      int_misc.recovery_cycles                                              
           2124362      MACHINE_CLEARS.CYCLES                                                 


Random reference
https://community.intel.com/t5/Analyzers/Regarding-machine-clears/m-p/953984


