Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CD4342507
	for <linux-rt-users@vger.kernel.org>; Fri, 27 Mar 2026 16:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774627814; cv=none; b=hAVb+zkQ4VusJqDxG85jeYC/b6dhZMuzoK9NTPINqYSEsBAkR/P9G1OBju74vjm3DXM8k3WEzuG7VUhZPal6b5VqCuy1H6bA63Wj4r5J6SCg1b9lXbva+nQl6zNcGnfZ6ZNn2Ao/mewCuYQ3kFwgTeKjIXcgRkddPfOJIdGzius=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774627814; c=relaxed/simple;
	bh=YkcuI4UmhZbzee969mw/lAJNinkwNHJ3BxOd98qcAbo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G0h6lqK/KuWAuszzeMm6PR8mE72FoeuHCtZToKYVzJWgG8Aep3p21LrJuUhVSnG2e7d1SEpSBNn8FH2LksYOmAcW1wFXNnCsg6MCuj/XR6svzMDfJ4IwnjsSvvuJKszhKhySt6MPOHCUqDc2MMpHMDf2/VU3SaYjC7R3lXHgNsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DKM1JWHb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NKPr/JUP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DKM1JWHb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NKPr/JUP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774627812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YCK3ssWRiv4I0Dc/RzkMjz9crFU2zJlsWVTQmPeHPq8=;
	b=DKM1JWHbA/RtRFClyPTDeqqfomXnaPExog/Q0elmdVRQtxyC2LTlNVWEpV3OpKqg5ROGpJ
	M9+3HZ7yXcOIEvmYwtqq+7jmnZopBQPYNiDDogAY4d+BGmYKNWeM2pt2SGv9xy868oeDO9
	/S8bha2tHfVqkdjNM6P2QOvpN5QQxCo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-UQnIs3FONt6FoD-4j-0jZQ-1; Fri, 27 Mar 2026 12:10:10 -0400
X-MC-Unique: UQnIs3FONt6FoD-4j-0jZQ-1
X-Mimecast-MFC-AGG-ID: UQnIs3FONt6FoD-4j-0jZQ_1774627809
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48531e6012bso25849915e9.1
        for <linux-rt-users@vger.kernel.org>; Fri, 27 Mar 2026 09:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774627809; x=1775232609; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=YCK3ssWRiv4I0Dc/RzkMjz9crFU2zJlsWVTQmPeHPq8=;
        b=NKPr/JUPddSjd+q85TMIGOxiXZHPhdZLKkvtwDvW0TcijYvoiolxnkQmRc2DxOw/ks
         2SBOVQQ8ye+FWIAKqNkVcP7+03NfH2/qlN+Ra92ANW7p6OxMAo/qdh+cWQ7OQIOqePaV
         /JoMeIctWiPLfiLyEArEOxJhCHobs33Pz+S8snKvDGy3bt3nMRrjrY4Re0L2DIr7Zrx1
         8vjxkkPp8vlJm06bhyEeKK5Ihv3U7/nq8/gPFD7t+D/nyx7nHwUqgQmmZY7008gP9sVt
         2uuhKvQ+R1CV56l1Jcl/aMrcPbH1ioqjlgNrdYW8CqWRdDt7YOQHf02ae3T1XleUp1tx
         y/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774627809; x=1775232609;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YCK3ssWRiv4I0Dc/RzkMjz9crFU2zJlsWVTQmPeHPq8=;
        b=PFprDWwwqdE1e30b3aApaMIT0Be6esjBfuxBXI9Y2RHex7bOlmdRIkjK6cmr8ZS7H0
         GDCMO6V9Wymor8JnWbXc+U4qhGhY5aReMnpQGe3du2lBjRrX+UUMxoJKQfJk4YNCHhg+
         A7R7GF3nNPX+3nA8u+0r1LHGd8M9sfTbPLxc4Q4IqXUHMG+Aj50m9z2APyjyVZkOvKMN
         M7KYO4HorPwm9045PywXeW1qkb9qX5JUFdEGn/i5d2oopw4yjIp0wS7uRnxYWKkwEHF0
         hfjRGokp9Ml3ExglDYar550YQXtnB3obkofLP979Gfupg1zD0/gF5YPbN6XXhWFzUxDO
         pipw==
X-Forwarded-Encrypted: i=1; AJvYcCW93WOGXNvVEhbjIWATnp8WTg2la2s2j9domPks8zd99141GNEwfAbtHoDV3+ICyZPw7amk3on4qQVRIWN64w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwW+Siffyqq/oPKOR6MYBzrZgqxCitr+nvtR7o/YdYWd3fyIQc4
	ljIzggRJhibKkBZNZGhqQNca3dV8OnXzYnV/+RcAxBZ98NJtQ4UxLNsE7dHhk9iLTXkW5xELi0E
	SlyUSdOMjjX9RXUCZRjAJhQx4pIoBr8aZMJSv6ai7KAAHGf911yh9U8e4TFWPUOYlrnV4
X-Gm-Gg: ATEYQzzODdD6HeZMPHkD2D/j+XwGqFotaV0QppaNfHbCGLN8ZueIIyCVzviF2HvuBC3
	AXgMy3Y1YPeNbMDZp7w440t5kb5vl+1sGg+4tDvtBSFSHCOs9LtBfHi2FoUG0CRZR37DPKXKeg5
	FB7kLm5e7it6YAAJilgwzSXIkY/KGme/iemOwN5KxJlaj6H+THT66yvlteVc6tWlFLB77WQACe+
	tU5xnqzEX8zNQj/7KmchSvIJygzxJ8CQ/iiGs2b3YLjTr7QfmHVxamObnbVz54mQ5Krk1zYTvoo
	40UCxIeZV3Evn8fj1OlIlzkNoXpkVFsvMQG7uPUsQOZQm9dNNV9+4zQSzznt4OAG/7poyw3OCCc
	hGqOy487lDjMUvlL3J3RNpY0Y9fGLF1q1jMqIENsWNPtngEcDRorBh+4J7pnZVw8y+UIcjaDy2s
	deictCjOU=
X-Received: by 2002:a05:600c:1393:b0:485:3c8f:e4d9 with SMTP id 5b1f17b1804b1-487280a09a2mr51509105e9.26.1774627809199;
        Fri, 27 Mar 2026 09:10:09 -0700 (PDT)
X-Received: by 2002:a05:600c:1393:b0:485:3c8f:e4d9 with SMTP id 5b1f17b1804b1-487280a09a2mr51508295e9.26.1774627808677;
        Fri, 27 Mar 2026 09:10:08 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c789ecsm101715745e9.4.2026.03.27.09.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 09:10:08 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Ionut Nechita <ionut.nechita@windriver.com>, fweisbec@gmail.com,
 tglx@linutronix.de
Cc: anna-maria@linutronix.de, linux-rt-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, frederic@kernel.org,
 chris.friesen@windriver.com, viorel-catalin.rapiteanu@windriver.com,
 ionut_n2001@yahoo.com
Subject: Re: NO_HZ_FULL vs NO_HZ_IDLE: ~300ns cyclictest latency regression
 from context tracking overhead
In-Reply-To: <20260326165725.451127-1-ionut.nechita@windriver.com>
References: <20260326165725.451127-1-ionut.nechita@windriver.com>
Date: Fri, 27 Mar 2026 17:10:07 +0100
Message-ID: <xhsmhpl4pfe3k.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 26/03/26 18:57, Ionut Nechita wrote:
> Hi,
>
> I'm seeing a consistent ~300ns average latency increase in cyclictest when
> switching from CONFIG_NO_HZ_IDLE=y to CONFIG_NO_HZ_FULL=y on a PREEMPT_RT
> kernel. I'd like to understand whether this is expected behavior or if there's
> room for improvement in the context tracking overhead on x86.
>
> Hardware:
>   - Intel Xeon Gold 6338N @ 2.20GHz (Ice Lake SP)
>   - 32 cores / 64 threads, single socket
>   - L3 cache: 48 MiB
>
> Kernel: 6.12.78-rt (PREEMPT_RT)
>
> Boot parameters (identical for both tests except nohz_full/isolcpus):
>   nohz_full=1-16,33-48 isolcpus=nohz,domain,managed_irq,1-16,33-48
>   rcu_nocbs=1-31,33-63 kthread_cpus=0,32 irqaffinity=17-31,49-63
>   intel_pstate=none nopti nospectre_v2 nospectre_v1 psi=0
>
> Cyclictest command:
>   cyclictest --priority 95 --nsecs --histofall 40000 --smi \
>     --duration 7200 --affinity 1-15,33-47 --threads 30 --mainaffinity 0
>
> Config difference:
>   NO_HZ_IDLE build:
>     CONFIG_NO_HZ_IDLE=y
>     # CONFIG_NO_HZ_FULL is not set
>     # CONFIG_TICK_CPU_ACCOUNTING is not set
>
>   NO_HZ_FULL build:
>     CONFIG_NO_HZ_FULL=y
>     CONFIG_VIRT_CPU_ACCOUNTING=y
>     CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
>
> Results summary (30 threads, 2-hour run, values in nanoseconds):
>
>                     NO_HZ_IDLE          NO_HZ_FULL
>   Min (range):      1697 - 1783         2026 - 2182
>   Avg (range):      1876 - 2000         2131 - 2333
>   Max (range):      2017 - 14491        6832 - 11539
>   SMI:              0                   0
>
> The average latency shifts from ~1930ns to ~2270ns, a consistent ~300-350ns
> increase across all 30 threads. The minimum latency floor also rises by
> roughly 400ns.
>
> My understanding is that CONFIG_NO_HZ_FULL forces
> CONFIG_VIRT_CPU_ACCOUNTING_GEN=y on x86, which adds context tracking overhead
> on every kernel entry/exit. Since cyclictest does a clock_nanosleep() syscall
> every 1ms, this overhead is hit on every cycle.
>
> Questions:
>   1. Is ~300ns of additional overhead from context tracking considered
>      acceptable/expected on Ice Lake with PREEMPT_RT?
>   2. Has there been any work on reducing the context tracking cost on x86,
>      or making VIRT_CPU_ACCOUNTING optional with NO_HZ_FULL?
>   3. For RT workloads that do periodic syscalls (not pure userspace polling),
>      is the recommendation to simply stay on NO_HZ_IDLE?
>

I can't answer for 2., but for 1. & 3.: NO_HZ_FULL is about squeezing as
much as you can out of a CPU running a pure userspace application. Any
kernel entry is an anomaly / interference, IOW "you lose". If you know your
workload is going to periodically enter the kernel, put in on a CPU that
isn't nohz_full (but maybe isolated).

> I can provide full histogram data or run additional tests if helpful.
>
> Thanks,
> Ionut

