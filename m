Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5485B189B84
	for <linux-rt-users@vger.kernel.org>; Thu, 24 Oct 2024 21:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729804822; cv=none; b=lnSIuAoon2ecF47QyVyurBLA4MWN/TE9QSB+fyi9wzsKjp663ic6AKql45oF+kf5QTmBz+y3zFGt7Aw52EzvXf+b31VR/yptCkwh2mCBHjzSTcrea127ywoUa1CdsDo/uZNFe2yo81bLVHPzpaYWu/2VbehNYqxBBj+d/wYhaQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729804822; c=relaxed/simple;
	bh=7fNePnfzYzUNZHWNnUFAOhOh6KLmvM8rt8ARlF8xHMc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kZqRsdHTWLXBK5ZQ+jRApp93JW0Tqaa7nhqcT6k3zvGtgqa96yTHy7vUCM9Dp0clw2ZdaeH1NNHn56uw7TQm6/jIb9ggoZlercNyrigxX/6nxxQWrHpy8EuLfmOYP9xLLOO3D4l3McIHLyS5rHoVHRosNTC2gx8vz3tSyHtDTJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rd94eb8w; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fNPz1mIP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rd94eb8w";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fNPz1mIP"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729804817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H71cb/V3irw3GpcNSt+uZBQMYHA5/UmnZdUUHy9eGzc=;
	b=rd94eb8wLpuE7yNqEAoDdSS8jUdjMJ36aI96rHaZ5DZAAe+t6Z+sFqOWlfL1TaYFDwL67w
	MQp649N5ZW0VIp5ZDtTgBS9HL0EKOfG/N6hnoKNwYVJRr+z4fHtZ9TBTZ6uACONajWJCzP
	uXi5DUiopSgIofQ1BEGCMxDETyUwdTNnI3rHQZ5a5UQ+cA7+iqDfGEX1B2O7/SeA9A5KDQ
	9Iu9qL/VzbiFTcgrEGIk/fEl1Lw6P1HO9U+MOfgRVnErJUyK/RtAb0pYo5Q44ME332I5QC
	Iow8YEWYKy3rpVtXay4zpRJVQ4MW97J6OlJDmVQMWhIU2YvGOJscMEXxtyQYwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729804817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H71cb/V3irw3GpcNSt+uZBQMYHA5/UmnZdUUHy9eGzc=;
	b=fNPz1mIPIKo+kQTx6rJ8aGYb6M4eqGnP0tQ8noWAXHucaO0+1kp0ov8LD0WZnvkCilrZLG
	3CxSiKjEv0mNgaAQ==
To: "John B. Wyatt IV" <jwyatt@redhat.com>, Clark Williams
 <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>, linux-rt-users@vger.kernel.org,
 kernel-rts-sst <kernel-rts-sst@redhat.com>, "John B. Wyatt IV"
 <sageofredondo@gmail.com>
Subject: Re: [PATCH] pi_stress: Add memory barrier to resolve crash
In-Reply-To: <20241024162620.349934-1-jwyatt@redhat.com>
References: <20241024162620.349934-1-jwyatt@redhat.com>
Date: Thu, 24 Oct 2024 23:26:17 +0206
Message-ID: <84h691xkoe.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi John,

On 2024-10-24, "John B. Wyatt IV" <jwyatt@redhat.com> wrote:
> +		/**
> +		 * The pthread_barrier_wait should guarantee that only one
> +		 * thread at a time interacts with the variables below that
> +		 * if block.

The pthread_barrier_wait() does exactly the opposite. It guarantees that
multiple threads continue at the same time. Taking a look at some users
of @finish_barrier, we see this means that low_priority() will read
p->total while high_priority() is performing the non-atomic operation
p->total++.

> +		 *
> +		 * GCC -O2 rearranges the two increments above the wait
> +		 * function calls causing a race issue if you run this
> +		 * near full cores with one core (2 threads) free for
> +		 * housekeeping. This causes a crash at around 2 hour of
> +		 * running. You can prove this by commenting out the barrier
> +		 * and compiling with `-O0`. The crash does not show with
> +		 * -O0.

Turning off optimization is not a proof. Show us the assembly code.

> +		 *
> +		 * Add a memory barrier to force GCC to increment the variables
> +		 * below the pthread calls. This funcion depends on C11.
> +		 **/

What you are talking about are compiler barriers, which are for forcing
the compiler to obey instruction ordering. Memory barriers are for
guarenteed memory ordering for CPUs at _runtime_.

> +		atomic_thread_fence(memory_order_seq_cst);

A single memory barrier makes no sense. Memory barriers must be paired
because you are ordering memory access between multiple CPUs.

> +
>  		/* update the group stats */
>  		p->total++;

If you want multiple tasks to be able to modify and read these
variables, then either use atomic operations or use locking. That is
what such mechanisms are for.

John Ogness
