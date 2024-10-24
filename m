Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8947722B641;
	Thu, 24 Oct 2024 22:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729809371; cv=none; b=Vc2LDQu8GOZJYOvUQ85bn62anAInk3lP75o7mQZS2mGwmBzGF0GFaBAT4BLjvYyyG+h5es/N+paUHfgRWUPE3IxEto0dMptusk7s7iXErhkxWZ0wF2D8jhuG7vk65zmt4CmyX47XsOwkkDUY3KZ7J8/Wm6utmkHD6CQl2whwDQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729809371; c=relaxed/simple;
	bh=Jt3C4XZY2DVVaIZcdgmgJd0t1yH/sMjZCOkOQwfdMPA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KsNk/arWpld0+jlTwn+iy4frkZU6M1wlbmmfUn9Haw+/VyO+ubpDBx6MSYdZxT7yrwUhu9D4uBNeGRRLuynIU+3cZLucuc+LW78tXLv7x8doMz3KBRCS/K67H7h9DRJRPbLzeHUK36lQW3LcOknL3dEm8+kqN/rcncHSZyBgZ9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Gl3afXNs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i+ZXxaTj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gl3afXNs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i+ZXxaTj"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729809366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6uY+deMHLemNWoqOREDbILH5FUu7u7Jdqe0ZFvihKiY=;
	b=Gl3afXNs41JvatGjhgudRTWQqXDivrWSp/eDxg83xL0hO78HStf+AEwcgj0jeTCBEpGsgf
	DrMJHw4i9+TTtvD2bah+bMrkABU5oCCZJGmVfQP8lPoSUetWxeNq7ELCmLIckXnQlPVajN
	pZ0Y7vhEhQZenz2vol9Ec9EFHL98yNC/QaHuhvSd0pcQcvxT82wPSkhWclL5HW11rdS+83
	w6lMuz2ihWmoWy8yCol0nlBzZRGNoqf99I2eQa7FGFHe450MFPnXjRojMjIfY2ZZAKBLji
	kL7zf8YsTg7Vok7rWPfUhldpQBzLF1gwrLn5xQyV1JecGNNtTllKF/w8+nOVYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729809366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6uY+deMHLemNWoqOREDbILH5FUu7u7Jdqe0ZFvihKiY=;
	b=i+ZXxaTjoF4Cp+tP7TDr15cXOwLtZmmAJpHt/kl2F2YwOSrbsC4iVQCOdMCRPYfI/qYi8W
	j0njZ+n0wHz0KlDw==
To: Juri Lelli <juri.lelli@redhat.com>, =?utf-8?Q?Andr=C3=A9?= Almeida
 <andrealmeid@igalia.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Darren Hart
 <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, LKML
 <linux-kernel@vger.kernel.org>, linux-rt-users
 <linux-rt-users@vger.kernel.org>, Valentin Schneider
 <vschneid@redhat.com>, Waiman Long <longman@redhat.com>
Subject: Re: Futex hash_bucket lock can break isolation and cause priority
 inversion on RT
In-Reply-To: <ZwZAicOokVUn2h8h@jlelli-thinkpadt14gen4.remote.csb>
References: <ZwVOMgBMxrw7BU9A@jlelli-thinkpadt14gen4.remote.csb>
 <98b3dcb0-8b64-45a5-9531-16aeb010c052@igalia.com>
 <20241008155129.z7ZZVzW3@linutronix.de>
 <46c259c2-5503-4a63-94ae-96660e5ce0eb@igalia.com>
 <ZwZAicOokVUn2h8h@jlelli-thinkpadt14gen4.remote.csb>
Date: Fri, 25 Oct 2024 00:36:06 +0200
Message-ID: <875xph5dt5.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 09 2024 at 09:36, Juri Lelli wrote:
> On 08/10/24 12:59, Andr=C3=A9 Almeida wrote:
>> > > There's this work from Thomas that aims to solve corner cases like t=
his, by
>> > > giving apps the option to instead of using the global hash table, to=
 have
>> > > their own allocated wait queue:
>> > > https://lore.kernel.org/lkml/20160402095108.894519835@linutronix.de/
>> > >=20
>> > > "Collisions on that hash can lead to performance degradation
>> > > and on real-time enabled kernels to unbound priority inversions."
>> >=20
>> > This is correct. The problem is also that the hb lock is hashed on
>> > several things so if you restart/ reboot you may no longer share the hb
>> > lock with the "bad" application.
>> >=20
>> > Now that I think about it, of all things we never tried a per-process
>> > (shared by threads) hb-lock which could also be hashed. This would avo=
id
>> > blocking on other applications, your would have to blame your own thre=
ads.
>
> Would this be somewhat similar to what Linus (and Ingo IIUC) were
> inclined to suggesting from the thread above (edited)?
>
> ---
> So automatically using a local hashtable according to some heuristic is
> definitely the way to go. And yes, the heuristic may be well be - at
> least to start - "this is a preempt-RT system" (for people who clearly
> care about having predictable latencies) or "this is actually a
> multi-node NUMA system, and I have heaps of memory"
> ---
>
> So, make it per-process local by default on PREEMPT_RT and NUMA?

I somehow did not have cycles to follow up on that proposal back then
and consequently forgot about it :(

To make this sane, per process has to be restricted to process private
futexes. That's a reasonable restriction IMO and completely avoids the
global state dance which we implemented back then.

I just digged up my old notes. Let me dump some thoughts.

1) The reason for the attachment syscall was to avoid latency on first
   usage, which can be far into the application lifetime because the
   kernel only learns about the futex when there is contention.

   For most scenarios this should be a non-issue because allocating a
   small hash table is usually not a problem, especially if you use a
   dedicated kmem_cache for it. Under memory pressure, that's a
   different issue, but a RT system should not get there in the first
   place.

   But for RT systems this might matter. Though we can be clever about
   it and allow preallocation of the per process hash table via a TBD
   sys_futex_init_private_hash() syscall or a prctl().

2) We aimed for zero collision back then by making this a indexed based
   mechanism. Though there was an open question how to limit the maximum
   table size and from my notes there was some insane number of entries
   required by some heavily threaded enterprise Java muck which used a
   gazillion of futexes...

   We need some sane default/maximum sizing of the per-process hash
   table which can be adjusted by the sysadmin.

   Whether the proper mechanism is a syscall audit, which includes
   prctl(), or a UID/GID based rlimit does not matter much. That's a
   question for system admins/configurators to answer.

Hope that helps.

Thanks,

        tglx
