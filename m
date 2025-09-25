Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD202FB975
	for <linux-rt-users@vger.kernel.org>; Thu, 25 Sep 2025 11:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758800327; cv=none; b=OoV3kL3rzBtZB6GcVaIXPq2BhK3dM+Vs3QMBh6mchFhTpgW6HPjvKGcPsTe03CY1+8xcAf8EtfIiTyZ07JvpVMtwhQ87csQqHFX493kKx6bLu2hrlhJWwPRIwvMtZouKJMiUeXQZSncSpjV8QHmE5Mthfv2l5QjvxFsg3IT0jvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758800327; c=relaxed/simple;
	bh=D6ixJiB25y8yKJMjUoqkPWe+Nka6v8o1MNHZvES0f+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zj7PyKq9XJ+GJBF77ipCAR1KF3S/eTWy2ka/yi3+ldcFAQgamauYS3A/US2hpxgx9SCPucmldm99rd4OcUCto6dStRJV5LmM+Mwa6fmwNbtp0W37fiGDVLtiweNvNszNbN7Jj9s9JtB1asjaPrtgvHK59AxqtFz5vzjZ3kGb4s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=SamMIwZQ; arc=none smtp.client-ip=212.27.42.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="SamMIwZQ"
Received: from [IPV6:2a01:e34:ec24:52e0:35c2:6f4a:bea:44e5] (unknown [IPv6:2a01:e34:ec24:52e0:35c2:6f4a:bea:44e5])
	(Authenticated sender: marc.w.gonzalez@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id 30F16B00593;
	Thu, 25 Sep 2025 13:38:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1758800316;
	bh=D6ixJiB25y8yKJMjUoqkPWe+Nka6v8o1MNHZvES0f+M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SamMIwZQkJGukBqsAVjHt8MSuZP/v3a7TvldfQYtrxjDG+0L1a6yEQNZxSTSldTjd
	 tD0E4P087FsS5aPLP5A6mXHbZ3DBmxOj/XiKGzD2U4QyjpiWjco5Y0fHQ7KtHNYqVX
	 3RJBl4nfFRmcnK+qcOaD5KaI7Ka9kzvWuP8XaZGgOA1j6Rb+NDazDVLJM1UX0MUHUS
	 MWPLeuV4KsWPP0TySH64yc179nh+O77zBr55C+lwuJSQpF6LJXPlxUybWKXCQRuxuB
	 dipVQdQ86TlFbdFuZzIY7sQ7OosMwevo3yon9W2w03GUBFd1YEVWP56mp2HfZoMDhd
	 PqeHouFdNU67A==
Message-ID: <01ba2ae3-fd09-4168-ab7f-66f363922e58@free.fr>
Date: Thu, 25 Sep 2025 13:38:17 +0200
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Unexplained variance in run-time of trivial program
To: "Ahmed S. Darwish" <darwi@linutronix.de>
Cc: Daniel Wagner <dwagner@suse.de>, Leon Woestenberg <leon@sidebranch.com>,
 John Ogness <john.ogness@linutronix.de>, linux-rt-users@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <williams@redhat.com>, Pavel Machek <pavel@denx.de>,
 Luis Goncalves <lgoncalv@redhat.com>,
 John McCalpin <mccalpin@tacc.utexas.edu>,
 Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, agner@agner.org
References: <11dfa501-e280-4b50-a593-a4b153019b40@free.fr>
 <ddb85a49-934b-4c11-ac2a-c8a562e76e7e@free.fr>
 <CAMjhiJjMOQN-nWd+KP4JBBNHf20M+J2fXAuTTvowXctJgvGOcQ@mail.gmail.com>
 <41b7c365-62c2-4bfa-acd7-db73dc9f94f0@free.fr>
 <c462578d-4010-4063-9f01-54008ac91f95@flourine.local>
 <60e4eb3c-3dfc-4212-bdcc-229a5b67b975@free.fr>
 <913e8f73-d10f-47c9-b608-f8f9cb9eef1c@free.fr>
 <1b76251b-6f57-4d72-bc48-b8df6ac077b2@flourine.local>
 <10a88382-dc37-4912-86b5-fe6bf98e5491@free.fr>
 <491b2ee8-1c25-486c-acb5-0d68454a5769@free.fr> <aMkWqQyHIzg4kjk_@lx-t490>
Content-Language: en-US
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
In-Reply-To: <aMkWqQyHIzg4kjk_@lx-t490>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/09/2025 09:50, Ahmed S. Darwish wrote:

> On Mon, 15 Sep 2025, Marc Gonzalez wrote:
> 
>> These types of events happen when different cores share memory (true
>> sharing or false sharing). Since my code is purely single-threaded, it
>> must be false sharing.
> 
> I don't know if you're just having "fun" with the CPU or optimizing a
> real-world use-case...

I'm writing a sudoku solver in my free time.
So, having fun on a real-world use-case :)

> With that in mind, maybe the following helps: understand the topology of
> your x86 CPU and turn off the cores that might be causing a "noisy
> neighbor" problem.

Hmmm... I would assume a fairly simple topology.
https://www.techpowerup.com/cpu-specs/core-i5-4590.c1750
https://en.wikipedia.org/wiki/Haswell_(microarchitecture)#Desktop_processors

This CPU does not support SMT, so L1 & L2 are exclusive to each core.
L3 is shared between all cores IIUC.

> If you were able to root it down, and your CPU supports class of service
> resource monitoring and allocation, then check
> Documentation/filesystems/resctrl.rst.

I have not yet found a good way to minimize the noise from
memory ordering memory nukes. (For the time being, I'm running
the benchmark hundreds of times, and take the minimum run time.)

https://docs.kernel.org/filesystems/resctrl.html

$ grep 'l2\|l3\|llc\|mb' /proc/cpuinfo
/* returns nothing */

Looks like Haswell didn't support those nice features :(

Thanks for the suggestion.

I might update to Zen 5 or Zen 6 at some point.

Regards

