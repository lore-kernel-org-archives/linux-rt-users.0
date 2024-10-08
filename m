Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9221DFE00;
	Tue,  8 Oct 2024 15:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728403182; cv=none; b=a6VIEnUu67QjMj/iob/iHzJUZyFGUqVmq3Gpmcu9kt42T4mILfC08M9MeK7mfGa5EE0iK8dEyXVsmxo9iwYbve2Gr1Nv2sGwu5IqJQoOv0u+PcnH7urxQZhwZOp7XingRMa9bD4rtL/q03IEek7HDuRdmUym93KxbFJ0/ckh7Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728403182; c=relaxed/simple;
	bh=dSIwuYhnmxNKFqrxfUY7yxSnMVVqhRf8Z4WOU75Xuz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UhEr1cDGI6FlR4EsEvsKIZiNqJZFqsbaJljoN9yfAhgQqBrZ6e6V01wElLrITOkRIU5CwQ91EzONfL0gg3mTtYM2d6B97Tw5uVAgL+w985Ux/eazOkHo7t8WfUXxNAKfobbrLz5B/tVa8MVfXPF91bdl0yU04sWlVB6yv1rawrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=jbKL+uWD; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="jbKL+uWD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BksZbOewQMA8NpDRXf1fW7zXP4s6rrlvXiCuKc9WvfA=; b=jbKL+uWDIjOCie5P4hfOCTgZiO
	SlT2GO0qigTJ/I6DzdwznQaTZNBpUhvuoHr4TZ8YpUNv84DzRbU1q1RAb2x+rEs+svdFkwuqFyyeC
	jRira2qZjAGdAYV+4fbtlSNPKoM0dU6EEgizr1WcRenGV5n+zHHRKHZ1sKvIbDmOHeR5A0X8hoFvU
	nIXrV4gBQJI6qbnEYoCH1tfOVnjfeXiVA7l7iw6ZJWO+quBGZ2M5dlKBpctaGLBrYLtPX2UPKjNST
	a4sMHHCMgkg5GFmF+v5uRFrJMriXQ0uzq0dA+YZrSvxHlAtX792mPNreZPak8mHL64HHdSK7+1kOw
	5+L0mWdw==;
Received: from [187.57.199.212] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1syCcT-006cjs-Vz; Tue, 08 Oct 2024 17:59:30 +0200
Message-ID: <46c259c2-5503-4a63-94ae-96660e5ce0eb@igalia.com>
Date: Tue, 8 Oct 2024 12:59:24 -0300
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Futex hash_bucket lock can break isolation and cause priority
 inversion on RT
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-rt-users <linux-rt-users@vger.kernel.org>,
 Valentin Schneider <vschneid@redhat.com>, Waiman Long <longman@redhat.com>
References: <ZwVOMgBMxrw7BU9A@jlelli-thinkpadt14gen4.remote.csb>
 <98b3dcb0-8b64-45a5-9531-16aeb010c052@igalia.com>
 <20241008155129.z7ZZVzW3@linutronix.de>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20241008155129.z7ZZVzW3@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 08/10/2024 12:51, Sebastian Andrzej Siewior escreveu:
> On 2024-10-08 12:38:11 [-0300], André Almeida wrote:
>> Em 08/10/2024 12:22, Juri Lelli escreveu:
>>
>> [...]
>>
>>> Now, of course by making the latency sensitive application tasks use a
>>> higher priority than anything on housekeeping CPUs we could avoid the
>>> issue, but the fact that an implicit in-kernel link between otherwise
>>> unrelated tasks might cause priority inversion is probably not ideal?
>>> Thus this email.
>>>
>>> Does this report make any sense? If it does, has this issue ever been
>>> reported and possibly discussed? I guess it’s kind of a corner case, but
>>> I wonder if anybody has suggestions already on how to possibly try to
>>> tackle it from a kernel perspective.
>>>
>>
>> That's right, unrelated apps can share the same futex bucket, causing those
>> side effects. The bucket is determined by futex_hash() and then tasks get
>> the hash bucket lock at futex_q_lock(), and none of those functions have
>> awareness of priorities.
> 
> almost. Since Juri mentioned PREEMPT_RT the hb locks are aware of
> priorities. So in his case there was a PI boost, the task with the
> higher priority can grab the hb lock before others may however since the
> owner is blocked by the NIC thread, it can't make progress.
> Lifting the priority over the NIC-thread would bring the owner on the
> CPU in order to drop the hb lock.
> 

Oh that's right, thanks for pointing it out!

>> There's this work from Thomas that aims to solve corner cases like this, by
>> giving apps the option to instead of using the global hash table, to have
>> their own allocated wait queue:
>> https://lore.kernel.org/lkml/20160402095108.894519835@linutronix.de/
>>
>> "Collisions on that hash can lead to performance degradation
>> and on real-time enabled kernels to unbound priority inversions."
> 
> This is correct. The problem is also that the hb lock is hashed on
> several things so if you restart/ reboot you may no longer share the hb
> lock with the "bad" application.
> 
> Now that I think about it, of all things we never tried a per-process
> (shared by threads) hb-lock which could also be hashed. This would avoid
> blocking on other applications, your would have to blame your own threads.
> 

So if every process has it owns hb-lock, every process has their own 
bucket? It would act just like a linked list then?

>>> Thanks!
>>> Juri
> 
> Sebastian
