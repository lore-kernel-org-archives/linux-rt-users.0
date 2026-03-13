Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3CF23182D
	for <linux-rt-users@vger.kernel.org>; Fri, 13 Mar 2026 10:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773397538; cv=none; b=gWcNfAybgGjKNKIjHi7tuzPZgTvjwnpq3Cf6I91oCZKeUCecx5ZfeLDiVhBF3KYmHt1ZsPew5Jf+l36/urMlT4+7HrfSx52s1C/VdZdB7dGD7fDeSYGIAD9x6zvVDPYhCN9I4fjSaSfVFnHnA2tNVE4Z/d7E8KH9w6klorfcEUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773397538; c=relaxed/simple;
	bh=SCmZTRXpHx1H+H6JlgeW0xcbPKEiudkFEbn5R0NFL0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgLjTlI3ffszkAJUKJJHQ9OS2DqTA9zW1ejs/5TyUIehD75sOnzdqu3gBFzfk9noOEdeWUdqDvR3W+PZWCrbZe4dUWInwKBNfDBMdMjimcmBgvMmnvpptAyqE8rg+C3ArKObjska+JtlKk760Ks9iLHUVGhyvO1Sg5cN9GYvYKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=pmgRkd8J; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="pmgRkd8J"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8821C1486145;
	Fri, 13 Mar 2026 11:15:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1773396947; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=yp1E8y15TqYq+2tmBLW3LRxmcMWYV28lAAuZWA5+Z68=;
	b=pmgRkd8JGLXa+XpCbLUYF2qL9yZB3eEnhANdgn3e91NIo4fC1vayLrBasepcYFW5A6615a
	Q7ILoFr+x32Lu90c810zLWoYCw1rPw7U9/SsgNj1tt5AOgTdyBFyLJ/t2DAAoVKGoa6KXv
	ynoBpJiUdKAjfzWwhb/0+lVBOSNkyoCNw07qaVgJeKIbLvJMdTaJ8ddnag843BHv34QWyW
	hQ+d4v7lLRKYMyJGPe/b9gXcb+laAksN0OdCHh358DCkM5uT4aGLINx1r3tRe+FHON2GXh
	Lvoz3cB3ViOTdYPQAOzvR6N0n6Z0sXQecA/kwufObXvznErfei1jSpvfMu8ALQ==
Date: Fri, 13 Mar 2026 11:15:36 +0100
From: Alexander Dahl <ada@thorsis.com>
To: =?utf-8?B?6rmA66+87IiY?= <m.kim@knu.ac.kr>
Cc: linux-rt-users@vger.kernel.org
Subject: Re: EtherCAT on PREEMPT_RT: =?utf-8?Q?send?=
 =?utf-8?Q?-recv_tail_~50-80=CE=BCs=2C?= looking for guidance 
Message-ID: <20260313-icy-nursing-37b1bbeb83a1@thorsis.com>
Mail-Followup-To: =?utf-8?B?6rmA66+87IiY?= <m.kim@knu.ac.kr>,
	linux-rt-users@vger.kernel.org
References: <C35885A5-1CAD-4373-927A-CBEB7DF116EA@knu.ac.kr>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C35885A5-1CAD-4373-927A-CBEB7DF116EA@knu.ac.kr>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Last-TLS-Session-Version: TLSv1.3

Hei hei,

Am Fri, Jan 30, 2026 at 02:33:58PM +0900 schrieb 김민수:
> To: linux-rt-users@vger.kernel.org
> Subject: EtherCAT on PREEMPT_RT: send-recv tail ~50-80μs, looking for guidance
> 
> --
> Hi all,
> 
> I'm working on reducing worst-case EtherCAT send-recv round-trip
> latency on PREEMPT_RT 6.8-rt8, targeting under 50μs. I've done
> ftrace analysis over ~50k cycles and tried two kernel-side fixes,
> but the measured tail (50-80μs) exceeds what my trace can account
> for (~31μs). I'd appreciate help identifying what I'm missing.
> 
> == Environment ==
> 
>   - Kernel: 6.8.0-rt8 (PREEMPT_RT)
>   - CPU: Intel, core 3 isolated
>     - isolcpus=domain,managed,3 nohz_full=3 rcu_nocbs=3
>     - intel_pstate=disable idle=poll intel_idle.max_cstate=0
>   - NIC: RTL8168H (r8169 driver), IRQ pinned to CPU3
>     - Coalescing off: rx-usecs=0, rx-frames=1
>   - EtherCAT master: SOEM (Open EtherCATsociety)
>     - SCHED_FIFO 99, pinned to CPU3, 1ms cycle
>     - AF_PACKET raw socket (ETH_P_ECAT)
>     - Measures send-recv with clock_gettime(CLOCK_MONOTONIC)
> 
> == What I've tried ==
> 
> Using ftrace (function_graph + sched_switch) on CPU3:
> 
> 1) ksoftirqd preemption during NAPI poll
> 
>    During rtl8169_poll() → napi_gro_receive() → sock_def_readable()
>    → wake_up(), SOEM (FIFO 99) preempts ksoftirqd/3 (CFS) mid-poll.
>    SOEM then blocks on rt_spin_lock (socket wq_head->lock, held by
>    wake_up) → D state ~2μs → returns to ksoftirqd → preempts again
>    after recv() completes. Measured overhead: 5.5μs mean, up to 25μs.
> 
>    Fix: chrt -f -p 99 ksoftirqd/3
> 
>    Result: D state eliminated, recv() peak improved ~3μs, but
>    max got worse (77μs → 88μs).
> 
> 2) TX completion IRQ elimination
> 
>    Each cycle generates two polls: TX IRQ triggers poll#1 (rtl_tx
>    cleanup only, ~1.3μs), then RX IRQ triggers poll#2. Gap: 3-13μs.
> 
>    Fix: Masked TxOK from interrupt enable register.
> 
>    Result: recv() distribution narrowed, but send-recv unchanged
>    (TX poll + gap overlaps with wire delay).
> 
>    Combined: No improvement beyond H1 alone.

If you see latencies due to ksoftirqd, I assume you don't use threaded
NAPI?  Did you try?

Quoting from my own notes here:

    NAPI processing mostly happens in eth softirq threads, but not always,
    especially with higher system load it might end up in ksoftirqd, which
    runs with low priority, and which process priority is not recommended to
    be changed (with RT).
    
    Link: https://lwn.net/Articles/833840/
    Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5fdd2f0e5c64
    Link: https://lwn.net/Articles/853289/

What we did:

+           # enable napi threads and set realtime priority
+           echo 1 > /sys/class/net/eth0/threaded
+           sleep 1
+           pgrep napi/eth0 | xargs -n 1 chrt --pid 49

That eliminated latency spikes for us, on completely different
hardware though. ^^

Greets
Alex

