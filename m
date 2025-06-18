Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA112E7F3E
	for <linux-rt-users@vger.kernel.org>; Wed, 18 Jun 2025 12:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750249021; cv=none; b=iVJVs8lbCQ4e8GY/0KID/emyZytl9WnWEk4bhiqoHvSY3aS0XqfRgkjZzzOr3TPjiuVKXvp0Bgq4ke/cC6VSa6RXt7rvIXAVYFvyvLD1bzvz5V6YpLtC4uL8C7WhrduTDHbtSUU8STi2vnX9LAuksp/azbvviWoEFZq6Q5u6V/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750249021; c=relaxed/simple;
	bh=kGC0w/6tV/tDy/0oALQEShvagTAp/XKynKxm+Zop5+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TLYPifGmKA+eg2inceWYNL5XdJLpmM/lOSHbu/oObZ+WrM2NdEpT5NmheyF2v6yPOQlLnNuJGM4yUWcBdQDdsmEYfztXuCYGxcPNqkA1H9yLmHa86EkuTnvbnvlu1PtJ685QU0qon5RNDZVCH8D1R/8y9RcJd1voaXji3oMEUmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OVQt5QiU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PRLJEjVD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OVQt5QiU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PRLJEjVD"
Date: Wed, 18 Jun 2025 14:16:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750249017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xhyS6eggtaWMRlnrzK7536rsMUrFCuXB3VSI2pPV78A=;
	b=OVQt5QiUp42AJcoYX8nF5p6vncL3vaewSrvx3mMlTNOtQKwGRnAiSpb3lDNHJDldzjm3lN
	S30vbBwwPdXp3GlI+eHJYUyOFBSpy0gwivKFPg95sso9ya4tYv2snZcTwuvjWlLof3uO5M
	SRErJyLNGZFMzyK6kgDhFMk8a3QyiblaSktE1odRC5LlZM429i4g7jLVUMA83WH75qrjKu
	jxV1kGahKYINwINXcy17y6nxqh6XN1xRqB8A7DNzFPt2TiYDJtxxNi9hGhFxmC+hdSWxN6
	AnI5bEfpc43g3gJKawxY58lNUnSG2ANNvYQyaYPUYN5dxNx8Va11q/19wrXulg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750249017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xhyS6eggtaWMRlnrzK7536rsMUrFCuXB3VSI2pPV78A=;
	b=PRLJEjVDhueUE3NiyeDdGEBNKlAlyNQ7+aOhEpZsZJZAv6dJLxZb1EOBzMi9A+w+K0akPP
	1SPEUv6I7xzkZWCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Michael Schanne <michael.schanne@gmail.com>
Cc: linux-rt-users@vger.kernel.org
Subject: Re: liveloock using PREEMPT_RT with i915 driver
Message-ID: <20250618121656.wjpoNGAT@linutronix.de>
References: <CAC_kJhQcdP5=0fcWAuXaJ=3Hxx1TwX5WR-UgS=EHuQeqckhZmg@mail.gmail.com>
 <20250617100521.6EW6IWXh@linutronix.de>
 <CAC_kJhQZpZoUjavRsSVHuXL5k3-3u6+wdL9=h8Pbv3qWvzeOiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAC_kJhQZpZoUjavRsSVHuXL5k3-3u6+wdL9=h8Pbv3qWvzeOiw@mail.gmail.com>

On 2025-06-18 07:34:25 [-0400], Michael Schanne wrote:
> I found my issue, I am using several SCHED_FIFO threads, one was spinning
> waiting on a timer to update, another thread which was supposed to update
> the timer count is higher priority, but with the RT patch applied there is
> also a ktimers thread set to RT priority 1, so it was never getting a
> chance to run and my timer would never fire.  I adjusted the ktimers thread
> to a higher priority and things started working again.  This thread does
> not exist in the vanilla kernel even with CONFIG_PREEMPT_RT enabled, so
> that is why I wasn't seeing it there.  The i915 driver was a red herring.

Okay not the i915.
The ktimers thread wakes only SCHED_OTHER tasks. The SCHED_FIFO/RR
threads should be woken up directly (without the need of the ktimers
thread).
So you are not using clock_nanosleep() but something like a POSIX timer?

> Thanks,
> Mike

Sebastian
