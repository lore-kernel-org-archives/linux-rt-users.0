Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5303B182;
	Tue,  8 Oct 2024 15:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728401921; cv=none; b=aQ36sMjquooneCEI9njISKWLI/p1kZdCXehz2vbpng5tFj0jLM1K4EOfQkVDk1iLVnH1CzVcg5uaTo9r16Em21qZUp5IBjdaOEAUI956nxILrnGYLFQeDy6S99XgCGGR4iaUBQ1WDceY8k0EvATglT0cJcobGTmv2byjwbf56Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728401921; c=relaxed/simple;
	bh=ew+FvYhB1pQsrVrOj3VrBZQAlHeeT2Pv9cdaQDrUttg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IYD7cTR9LlhhgvswIqMpQ1Bp8vRHbiAs4SfzW4namPbL1ftzT7GtkjgWYOUJ5zGN43VuQKh0juuZz1B66hvnytQ0hpbC4A9iowEFGhKN+Bk61pEUqyrUy3KGBJ2eCSQ78t5oxi3ymkO0jM8+FtGLbyZfRkwmTvApaqh8/MYIVEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=CjOpBkJY; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="CjOpBkJY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=I/GFSjJJFrKR3oSm94SMXt+tNic7ilJr4T2XGb1Aym0=; b=CjOpBkJYYVRp9z6kqMfue19vrT
	im45IYBtv4Vhc6tIY/EmX6QjHnAGQcZ/rH0Wh/7V9pLS9p/D8qvDq5E9Ei6SGZe+2WFGyRLw/xLwy
	GhZ3xkS+NuWJuwP8w+9JAMPtkKbPEYkRVdsU38Kw68eZc3dTqvtv9TnvZZgqEAvrcx5MUKVBATDxc
	PqRQJ/E/k6CxNUR9+ReLtU90w1CrJ6uZAcdlvGp8rbnweRPk5pUMazFU6ElG6f6JwWCvoQ0okaP96
	pe5zl/LIxqkhNlnI+/Jwem7XIpJVoIz166Ve0ubrGQ1jTN5Vax2tCPynYb//831dPjLXDLA2AEE07
	8udEEZXA==;
Received: from [187.57.199.212] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1syCHy-006cM6-M8; Tue, 08 Oct 2024 17:38:18 +0200
Message-ID: <98b3dcb0-8b64-45a5-9531-16aeb010c052@igalia.com>
Date: Tue, 8 Oct 2024 12:38:11 -0300
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Futex hash_bucket lock can break isolation and cause priority
 inversion on RT
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-rt-users <linux-rt-users@vger.kernel.org>,
 Valentin Schneider <vschneid@redhat.com>, Waiman Long <longman@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <ZwVOMgBMxrw7BU9A@jlelli-thinkpadt14gen4.remote.csb>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <ZwVOMgBMxrw7BU9A@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Juri,

Em 08/10/2024 12:22, Juri Lelli escreveu:

[...]

> Now, of course by making the latency sensitive application tasks use a
> higher priority than anything on housekeeping CPUs we could avoid the
> issue, but the fact that an implicit in-kernel link between otherwise
> unrelated tasks might cause priority inversion is probably not ideal?
> Thus this email.
> 
> Does this report make any sense? If it does, has this issue ever been
> reported and possibly discussed? I guess it’s kind of a corner case, but
> I wonder if anybody has suggestions already on how to possibly try to
> tackle it from a kernel perspective.
> 

That's right, unrelated apps can share the same futex bucket, causing 
those side effects. The bucket is determined by futex_hash() and then 
tasks get the hash bucket lock at futex_q_lock(), and none of those 
functions have awareness of priorities.

There's this work from Thomas that aims to solve corner cases like this, 
by giving apps the option to instead of using the global hash table, to 
have their own allocated wait queue: 
https://lore.kernel.org/lkml/20160402095108.894519835@linutronix.de/

"Collisions on that hash can lead to performance degradation
and on real-time enabled kernels to unbound priority inversions."


> Thanks!
> Juri
> 
