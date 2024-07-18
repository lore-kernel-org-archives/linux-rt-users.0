Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA6381ADA
	for <linux-rt-users@vger.kernel.org>; Thu, 18 Jul 2024 19:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721330691; cv=none; b=B2QRlgDeTwsWhNh8DL0Q48BNBT/0ct+fBeHCY3BnQ4oPihBWySIPS8n3qTnFWytWAq89Lt/XVIIwPiDryIcWt3JSoVnPpHwGR/fDUm+iaNfPqiJwW8+j5jO+7zuu0TWwGUtrIBTvrw4lGv0N44NEPUX1as+pad9v0VEp/inLRHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721330691; c=relaxed/simple;
	bh=00mp7z5nxsPjLKa37ZxZlfledgtKHG0MSNfZlCFKI4k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F1Xzsd4HHjrSwwZeeZScVlcFv7RVE47m+joQ3ezLBV4QW6QY5AFxUSv6xaOCYGmsxVw7Y+Ik7RoxwwV8/ghT5LzVNQmcSPz9V0inFBvt5B4+31ZYQieCESPWz2CMKUJHsYQry0YtSedRVBpl4xJfQYC8BKziQZZSuZGYQ9W7Ong=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC76C116B1;
	Thu, 18 Jul 2024 19:24:48 +0000 (UTC)
Date: Thu, 18 Jul 2024 15:24:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrew Halaney <ahalaney@redhat.com>
Cc: pmladek@suse.com, john.ogness@linutronix.de, senozhatsky@chromium.org,
 debarbos@redhat.com, williams@redhat.com, jlelli@redhat.com,
 linux-rt-users@vger.kernel.org
Subject: Re: [BUG] printk/nbcon can use RCU illegally prior to CPU online
Message-ID: <20240718152447.42244f98@rorschach.local.home>
In-Reply-To: <436jncgrfxwcizjw5gxw3yar5ybo62zdctout6sti6gamwtnlw@gqrmo5ine6d2>
References: <5x4nejpojrtny37k7l6loewqwuaituq77zc3tkkojvawcuvmml@thwg65fdb3vn>
	<20240718115704.0cd768bc@rorschach.local.home>
	<436jncgrfxwcizjw5gxw3yar5ybo62zdctout6sti6gamwtnlw@gqrmo5ine6d2>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Jul 2024 13:13:02 -0500
Andrew Halaney <ahalaney@redhat.com> wrote:


> I'll be honest, I only considered this from a printk() point of view so
> far and pretty much ignored the original splat (as someone else is
> looking at that). Here's the original splat from a centos kernel, I have
> yet to look into it other than "we took an exception prior to RCU coming
> online for this CPU" and me naively thinking that printk() should work
> everywhere. I'll post the splat here for now before considering it more,
> but it sounds like my expectation is wrong and that if something goes
> awry and needs to printk prior to the CPU coming online, then this RCU
> warning is sort of expected?:

Note, printk() is most definitely not safe in all contexts. It can
cause issues if done in NMI, or even called while holding an scheduler
rq lock. And now we are trying to make sure all tracing/printk is done
while RCU is watching.

> 
>     [ 13.643007] smp: Bringing up secondary CPUs ...
>     [ 13.644422] smpboot: x86: Booting SMP configuration:
>     [ 13.644431] .... node #0, CPUs: #1 #2 #3 #4 #5 #6 #7 #8 #9 #10 #11 #12 #13 #14 #15 #16 #17 #18 #19 #20 #21 #22 #23 #24 #25 #26 #27 #28 #29 #30 #31 #32 #33 #34
>     [ 13.680691] Callback from call_rcu_tasks_rude() invoked.
>     [ 13.684308] #35 #36 #37 #38 #39 #40 #41 #42 #43 #44 #45 #46 #47 #48 #49 #50 #51 #52 #53 #54 #55
>     [ 13.720218] .... node #1, CPUs: #56 #57 #58 #59 #60 #61 #62 #63 #64 #65 #66 #67 #68 #69 #70 #71 #72 #73 #74 #75 #76 #77 #78 #79 #80 #81 #82 #83 #84 #85 #86 #87 #88 #89 #90 #91 #92 #93 #94 #95 #96 #97 #98 #99
>     [ 13.783247] Callback from call_rcu_tasks() invoked.
>     [ 13.785941] #100 #101 #102 #103 #104 #105 #106 #107 #108 #109 #110 #111
>     [ 5.061942] x2apic lock mismatch between BSP and AP.

>     [ 5.061942] =============================
>     [ 5.061942] WARNING: suspicious RCU usage
>     [ 5.061942] 5.14.0-467.el9.x86_64+debug #1 Not tainted
>     [ 5.061942] -----------------------------
>     [ 5.061942] kernel/printk/nbcon.c:1118 suspicious rcu_dereference_check() usage!

You said this was a centos kernel. Well that explains why the above
says 5.14 and has a reference to kernel/printk/nbcon.c, which doesn't
exist in 5.14.

Looks like a bad backport.

-- Steve


>     [ 5.061942]
>     other info that might help us debug this:
> 
>     [ 5.061942]
>     RCU used illegally from offline CPU!
>     rcu_scheduler_active = 1, debug_locks = 1
>     [ 5.061942] 2 locks held by swapper/1/0:
>     [ 5.061942] #0: ffffffff8b721a10 (console_srcu)
>     {....}-{0:0}, at: console_srcu_read_lock+0x44/0x60
>     [ 5.061942] #1: ffffffff8b735080 (rcu_read_lock){....}
