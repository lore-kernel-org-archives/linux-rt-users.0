Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0151438C425
	for <linux-rt-users@vger.kernel.org>; Thu, 12 Mar 2026 16:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773332130; cv=none; b=ikwBiOFU8CBVOpOQVpAO7lZhhd+94AH9/Kcaq9tFwnEmoPIVqOPNi9wSpD0jAXSEB1ARzi6qpVx3mpvVyoTazzz4XVa5WFp1w6hkvPoRu3S4gvrDKZFoKgRpiWS4+81H8ziXgw1SJSwacZ9LPL0W6UdsBGYLuTOXrU9eILEzwX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773332130; c=relaxed/simple;
	bh=brqbloNnvELO2+kkUUmMasD/7bVjZZlbkTEDaW3EzgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EnrLOp/bVxCx+rpuK58mnkjbNdhY0y58RrDfxC5TphTSGHYvw0jIG0MP9NwnBjXggkt6dsx0DDxUWpN4zrD3UM3OKUsMvUZsirSnG1OdwzrZ51XythjO3ywL3F3PE4raw/NPZdhFeC8afOl3I+/lXKiNXR8yDYkyZkqvR1pfDnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ew5EJWM3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L017fPgb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ew5EJWM3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L017fPgb"
Date: Thu, 12 Mar 2026 17:15:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773332127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i3x9iWzTChAgUHgBXV5/CGAT9OzxaiVbyJOPWvwJfpU=;
	b=Ew5EJWM3MGYTcbZBttJtOMVct8RXxNOrNU84Zw4RfN8lbz7TQXC+f4SI4+wF/SmEQtU7/x
	9Uv00rAY3JEvku24MCqTPg/ytBaMK3G8oMpw7PlKFGx3h+0OMMGBYolmBdQ/w/0/wVG22X
	mUTO0bey6WPlVsfBKDygW3DyKTAq/2bXIh5lUdHuIwyWPJIw7opPrbXZ8MSCQFr2jy+tTW
	0DpXulbAy8ZmsJkaXqCHu2/dOaDwwCjJLAXW8XlVWca2wvuAjM/qkSIFfOVYwG1ClfU2Mj
	ohl3DlkTX87GUV0tC0VnQd94gMmocVo+0H9m7p+q7qO2E1YeUPMSJ3fDRHNR3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773332127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i3x9iWzTChAgUHgBXV5/CGAT9OzxaiVbyJOPWvwJfpU=;
	b=L017fPgbZEBE0sdwi9+G3Q2MFsAmNb8YWdCn1s27Qov9fM+s6Qojy5CjloZFpGPjEoPA+8
	IR3oqoUqi+gPkZDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: =?utf-8?B?6rmA66+87IiY?= <m.kim@knu.ac.kr>
Cc: linux-rt-users@vger.kernel.org
Subject: Re: EtherCAT on PREEMPT_RT: =?utf-8?Q?send?=
 =?utf-8?Q?-recv_tail_~50-80=CE=BCs=2C?= looking for guidance
Message-ID: <20260312161526.p6Kz2Fs1@linutronix.de>
References: <C35885A5-1CAD-4373-927A-CBEB7DF116EA@knu.ac.kr>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <C35885A5-1CAD-4373-927A-CBEB7DF116EA@knu.ac.kr>

On 2026-01-30 14:33:58 [+0900], =EA=B9=80=EB=AF=BC=EC=88=98 wrote:
> To: linux-rt-users@vger.kernel.org
> Subject: EtherCAT on PREEMPT_RT: send-recv tail ~50-80=CE=BCs, looking fo=
r guidance
>=20
> --
> Hi all,
>=20
> I'm working on reducing worst-case EtherCAT send-recv round-trip
> latency on PREEMPT_RT 6.8-rt8, targeting under 50=CE=BCs. I've done
> ftrace analysis over ~50k cycles and tried two kernel-side fixes,
> but the measured tail (50-80=CE=BCs) exceeds what my trace can account
> for (~31=CE=BCs). I'd appreciate help identifying what I'm missing.
>=20
> =3D=3D Environment =3D=3D
>=20
>   - Kernel: 6.8.0-rt8 (PREEMPT_RT)
>   - CPU: Intel, core 3 isolated
>     - isolcpus=3Ddomain,managed,3 nohz_full=3D3 rcu_nocbs=3D3
>     - intel_pstate=3Ddisable idle=3Dpoll intel_idle.max_cstate=3D0
>   - NIC: RTL8168H (r8169 driver), IRQ pinned to CPU3
>     - Coalescing off: rx-usecs=3D0, rx-frames=3D1
>   - EtherCAT master: SOEM (Open EtherCATsociety)
>     - SCHED_FIFO 99, pinned to CPU3, 1ms cycle
>     - AF_PACKET raw socket (ETH_P_ECAT)
>     - Measures send-recv with clock_gettime(CLOCK_MONOTONIC)
>=20
> =3D=3D What I've tried =3D=3D
>=20
> Using ftrace (function_graph + sched_switch) on CPU3:
>=20
> 1) ksoftirqd preemption during NAPI poll
>=20
>    During rtl8169_poll() =E2=86=92 napi_gro_receive() =E2=86=92 sock_def_=
readable()
>    =E2=86=92 wake_up(), SOEM (FIFO 99) preempts ksoftirqd/3 (CFS) mid-pol=
l.
>    SOEM then blocks on rt_spin_lock (socket wq_head->lock, held by
>    wake_up) =E2=86=92 D state ~2=CE=BCs =E2=86=92 returns to ksoftirqd =
=E2=86=92 preempts again
>    after recv() completes. Measured overhead: 5.5=CE=BCs mean, up to 25=
=CE=BCs.
>=20
>    Fix: chrt -f -p 99 ksoftirqd/3
>=20
>    Result: D state eliminated, recv() peak improved ~3=CE=BCs, but
>    max got worse (77=CE=BCs =E2=86=92 88=CE=BCs).

Why ksoftirqd active to begin with? If your CPU is isolated you
shouldn't have anything waking ksoftirqd. Everything network related
should happen within the threaded irq.

> 2) TX completion IRQ elimination
>=20
>    Each cycle generates two polls: TX IRQ triggers poll#1 (rtl_tx
>    cleanup only, ~1.3=CE=BCs), then RX IRQ triggers poll#2. Gap: 3-13=CE=
=BCs.
>=20
>    Fix: Masked TxOK from interrupt enable register.
>=20
>    Result: recv() distribution narrowed, but send-recv unchanged
>    (TX poll + gap overlaps with wire delay).
>=20
>    Combined: No improvement beyond H1 alone.

I don't follow. You need TX interrupt to clean up the skb you just sent.
If you don't, there will be a watchdog complaining.
The RX interrupt signals that you have a new packet waiting.

> =3D=3D The discrepancy I can't explain =3D=3D
>=20
> send-recv breakdown with H1 applied (from sched_switch trace):
>=20
>   Component         Mean    Tail (P99/Max)
>   -------------------------------------------
>   send() syscall    ~2=CE=BCs    stable
>   Wire RTT          ~7=CE=BCs    stable
>   RX IRQ handling   ~2=CE=BCs    ~3=CE=BCs
>   Sched delay       ~1=CE=BCs    ~10=CE=BCs
>   Poll start delay  ~1=CE=BCs    ~13=CE=BCs
>   RX poll (napi)    ~5=CE=BCs    ~6=CE=BCs
>   recv() return     ~1=CE=BCs    stable
>   -------------------------------------------
>   Trace total       ~19=CE=BCs   ~31=CE=BCs
>=20
> But SOEM measures send-recv tails of 50-80=CE=BCs using
> clock_gettime(CLOCK_MONOTONIC) around the send()+recv() pair.
>=20
> That's a gap of roughly 19-49=CE=BCs that my trace doesn't cover.
>=20
> My tracing (function_graph on rtl8169_poll + sched_switch events)
> covers the kernel NAPI path, but I suspect there are latency
> sources outside this window =E2=80=94 in the send() path, the
> syscall entry/exit, the userspace-to-kernel transitions, or
> somewhere else I haven't instrumented.

If everything (network driver (interrupt thread)) and your user
application (doing send + receive) runs on CPU2 then with enabled
function trace (as you do) looking at CPU2 is enough.
Receiving a packet will start with an interrupt, following by waking the
threaded interrupt. Within this interrupt you will read the packet from
the nic, stuff it into the socket and wake the user application. This
will do recv() + send() and sometime after send() returns there should
be another interrupt for the TX clean up. At this point, your packet is
gone.

This covers the whole path.

> =3D=3D Question =3D=3D
>=20
> What could account for the ~20-50=CE=BCs gap between what ftrace
> shows in the NAPI/sched path (~31=CE=BCs worst case) and what the
> application measures end-to-end (50-80=CE=BCs)?

There should be no gap. There is /sys/kernel/tracing/trace_marker. You
can write there and this will pop up in your trace. So you could map
your application to events in the kernel/ trace. You need be careful
with the clock as the kernel uses sched_clock while you use
CLOCK_MONOTONIC (but the tracing clock can be changed).=20

> Are there known latency sources in the PREEMPT_RT network path
> =E2=80=94 such as softirq-to-userspace return, AF_PACKET socket
> processing, syscall exit, or something else =E2=80=94 that
> function_graph + sched_switch tracing would not capture?

You add the packet to the socket queue and wake the socket. There will
be wakeup event and so. In general function_graph covers every function
so there are no holes.

> I've tried the specific fixes described above. Happy to collect
> additional traces with different tracepoints if someone can
> suggest what to instrument next.
>=20
> Thanks,
>=20
> =E2=80=94
> Minsu Kim
> Undergraduate Student
> School of Mechanical Engineering & Computer Science
> Kyungpook National University (KNU), Daegu, South Korea

Sebastian
