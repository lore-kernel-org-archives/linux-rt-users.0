Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040302563
	for <linux-rt-users@vger.kernel.org>; Sun, 12 Jan 2025 21:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736717444; cv=none; b=bqdNNmI4pI5ORMMdhb3ARhsm/+wOal32C/KD+cp5PmNjByYade80Y5v0CRvnJpDSo/cA04l84ruwP3WGzrtGNpLdJBQJB0ReLm4691Knrfkgd4eKmW2ImJhMJEHJnpNn42z2gamX/GfoU3VSk0wJbhZ/48+qFdFsnFwEOXHL6lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736717444; c=relaxed/simple;
	bh=Tc6dYTZlljha8botPVoZJJoSVHWUhMiv0YTGil5QbFo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QtpjCSgK1ze5N54quWl1swSoFOrkOksCvMpA9dvl/4HWzoHTW00nzxbjVrVs3euB8TQfr7LDO9rVNqZGMHmy9N7Y5+CSNyzjcNvMXUuUu8Bcxm/CEobOt1Ki2CO0ZMX/Ygmaqq05U3joPGyJZBZCtKpn30o9QBbJCi2LOXCQTmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DgRBC6cf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1c/iECli; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DgRBC6cf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1c/iECli"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736717433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hYZXIraGVM56yq6UUjbP+/9qIpnJBcw4qMMYsKAvWRg=;
	b=DgRBC6cfen/Gv8VVUAsrE9VjWRf4C/2i0mcZdbdfaaozmjzv+4S0hHf9PDqf8bhzz4GQj3
	Bhm1Os/B68HiRtxjk/RTUqlcjjSgLUC/FjPt/+vXySLqPXiIFrV0jecqrhyR3v0xMSsOP+
	1Z3QjeH5lwvJbC0n4mECft2hXheiz1Lgq2d3xI44tLA1rCFaM3peLuJf8d1jsRZJ97foN1
	NF5rxPJAVs5XtdZEvU5RYglMNx2hFGdzxExz/Q3M7I8b6Nj7FBvmFB0H3M6CT8WDAhR3MP
	xDZVMjW8aEohlP+0RfNuV2GHZjtjG2IBZgI4luLFBpln/+7L6IS5DJiMfCFA/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736717433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hYZXIraGVM56yq6UUjbP+/9qIpnJBcw4qMMYsKAvWRg=;
	b=1c/iECliCy+yTW2ji1HIKQLQJgW3iqm+WRrAXTH6QdeVt1ODJCFT8fxoJtdJS47SPJH2RI
	XOVRy/+8aQLa4yBQ==
To: Florian Paul Schmidt <mista.tapas@gmx.net>, Leon Woestenberg
 <leon@sidebranch.com>
Cc: linux-rt-users@vger.kernel.org
Subject: Re: Raspberry Pi 5 and PREEMPT_RT (6.13.0-rc3)
In-Reply-To: <ecb3c326-9d5e-4a39-b9eb-5cc318596eb0@gmx.net>
References: <d445e582-4e49-4135-9d94-f52d72ec5df6@gmx.net>
 <84bjx6h2kd.fsf@jogness.linutronix.de>
 <cb569b76-e0ac-4063-9956-ab6307594d86@gmx.net>
 <CAMjhiJjpnP4Nr5YmgntPd43gndBXnh_DOjW_davDVG2fu0F4sQ@mail.gmail.com>
 <ecb3c326-9d5e-4a39-b9eb-5cc318596eb0@gmx.net>
Date: Sun, 12 Jan 2025 22:36:33 +0106
Message-ID: <84frlnsosm.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-01-12, Florian Paul Schmidt <mista.tapas@gmx.net> wrote:
> OK, I got around to playing with isolcpus. As a first attempt I added
>
> isolcpus=1,2,3
>
> to my kernel commandline and tried
>
> stress -m 1 --vm-stride 16 --vm-bytes 512000000 --vm-keep -c 1
>
> and it ran on core 0 maxxing it out.

...

> Here's the really surprising thing though. If I run
>
> sudo cyclictest  -m -p 95 -a 0,1,2,3 -t 4
>
> then I get these enormous latencies on cores 1,2 and 3 but not on
> core 0:
>
> # /dev/cpu_dma_latency set to 0us
> policy: fifo: loadavg: 2.50 2.83 2.88 3/223 139478
>
> T: 0 (139313) P:95 I:1000 C:   5881 Min:      2 Act:    3 Avg:    3 Max:      10
> T: 1 (139314) P:95 I:1500 C:   3920 Min:      1 Act:    1 Avg:    7 Max:     419
> T: 2 (139315) P:95 I:2000 C:   2940 Min:      1 Act:    1 Avg:    7 Max:     480
> T: 3 (139316) P:95 I:2500 C:   2352 Min:      1 Act:    1 Avg:    9 Max:     433

Notice the average is considerably higher on the "idle" CPUs. Perhaps
you have cpufreq scaling enabled?

Are you running these tests using the OSADL kernel?

I assume you see the same effect when running stress(1) pinned to CPU1?
... just to be sure the boot CPU is not somehow special. (No need to
boot with isolcpus since the machine is otherwise idle anyway.)

taskset 0x2 stress -m 1 --vm-stride 16 --vm-bytes 512000000 --vm-keep -c 1

sudo cyclictest -m -p 95 -a 1,2,3 -t 3

John Ogness
