Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72EF34F494
	for <linux-rt-users@vger.kernel.org>; Tue,  9 Sep 2025 14:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757426939; cv=none; b=pmPkMoGzNbIsSIA86bGnZgKLhfHFnkSCpbP1AJV00W6PXwWiYlO6Pao9YLXS7EAJ5IGbUk9OR5YqgvtZ4JfwiNUUiXILIEPcCQPhM+93nh4I5ciEJ1B22xzHwYXzCW/Y0qLI9YcM13w5dlSDXdEzajk3oa+Caakc4RmukXlW+lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757426939; c=relaxed/simple;
	bh=UukR2vFySM80Du0ZTo5obm7gGbFRvXSFzVz1899S23o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ltkgNI9c6qWpkIFLKCv33G6mQhhdBR9gzRY2Qh9GCnIte4PACfc5Y1tPDsFTd0flxvF5VsBB3dkOdnFjvjknzuHOx1PCOyrPzcoYKg/X0fgkm4Do2g0BpastHpgDkEkqggL9lyfA+c4OXIi9qOuA5lE7jhDuH3LP2vmrUdwvdHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=FjfskFSS; arc=none smtp.client-ip=212.27.42.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="FjfskFSS"
Received: from [IPV6:2a01:e34:ec24:52e0:4e45:8447:d6c0:1a95] (unknown [IPv6:2a01:e34:ec24:52e0:4e45:8447:d6c0:1a95])
	(Authenticated sender: marc.w.gonzalez@free.fr)
	by smtp2-g21.free.fr (Postfix) with ESMTPSA id 6881B2003C8;
	Tue,  9 Sep 2025 16:08:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1757426933;
	bh=UukR2vFySM80Du0ZTo5obm7gGbFRvXSFzVz1899S23o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FjfskFSSnUxs3mNF03VwFCLlhegz+87/5fvQbnxEQINd+0MeJhpL3Csa+j95SHNBZ
	 sTTxZmv8go73atpfELpAj/c2mouevkxyE4bKPGLnH5H+txViCCFt/on2QExIZNKzjj
	 DYN2KLUNy1aLSNV1CQmNhU9qVdFBxOcCdHLwzJQ09gvtP24vO+f6GjR/2rV70Iie5Y
	 kV9ronDciJwHkJNJ5BRi52GhzBmyueCSLpkzEz/NDQCl7x23IvoFyFjl35E/rTpqDC
	 Hmr4rQk3zJ7cY7yMZLXsk7uGEPZclwkzy6C967FfBjJCBLQU07LBL3kKYPp+l4+SF5
	 dxhAEH+K7OTNQ==
Message-ID: <11dfa501-e280-4b50-a593-a4b153019b40@free.fr>
Date: Tue, 9 Sep 2025 16:08:38 +0200
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Unexplained variance in run-time of trivial program
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
Content-Language: en-US
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
In-Reply-To: <84ms73kdn2.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/09/2025 14:34, John Ogness wrote:

> On 2025-09-09, Marc Gonzalez wrote:
> 
>> I captured a full trace of this occurrence with
>> echo *:* > $TRACING/set_event
>> cat $TRACING/per_cpu/cpu$CPU/trace > trace.$CPU
> 
> ...
> 
>> But there is absolutely NOTHING traced between 4606.628019 & 4606.811832.
> 
> I recommend using the function tracer:
> 
> # echo function > $TRACING/current_tracer
> 
> It should not affect your timings for pure-userspace code. This should
> catch any unintentional kernel activity.

OK. This time, I used:
echo function > $TRACING/current_tracer
cat $TRACING/trace > trace.all
(which produced a 12.65 MB file)

I dumped a problematic run where T=2722 instead of T=2500
i.e. total run-time = 178.389 ms instead of 163.84 ms

Looking for a.out-23683 until the log goes quiet...

  a.out-23683   [003] d.... 14939.982368: user_enter: 
  a.out-23683   [003] d.... 14939.982368: vtime_user_enter <-__ct_user_enter
  a.out-23683   [003] d.... 14939.982368: get_vtime_delta <-vtime_user_enter
  NO OCCURRENCE of a.out or [003] between these 2 points
  a.out-23683   [003] d.... 14940.160764: vtime_user_exit <-__ct_user_exit
  a.out-23683   [003] d.... 14940.160765: get_vtime_delta <-vtime_user_exit
  a.out-23683   [003] d.... 14940.160765: account_user_time <-vtime_user_exit

14940.160764 - 14939.982368 = 178.396 ms
(which corresponds to the total run-time)
Are the vtime_user_enter/exit tied to clock_gettime?
(Probably not, since they're not balanced)

It's starting to look like the problem is on the CPU itself,
not the kernel interrupting the CPU.

Might be time to break out perf?

My hunch is frequency dropped to ~2.7 GHz for the duration of the benchmark.

Maybe I should lower the frequency to 2 GHz.
But again, why would my code force throttling and not the toy code?
One possible reason is my code reaches 3.5 IPC, while the toy code
remains at 1.5 IPC (with micro-op fusion).

It's a stretch, but easy to test.

I will measure CPU cycles, to see if the increased run-time
corresponds with a change in CPU cycles.

Regards

