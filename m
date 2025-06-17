Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57460293C43;
	Tue, 17 Jun 2025 09:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750151332; cv=none; b=Tt+Kcb8dBj9R9k/ltRPcEeC0kAsk7Z5OlsX/3WJo3vCxa9S9CqI8DwnAteA7g1dS+Ef0uiSvSPibi9yQJw9ES05wiBf+pakbUzv2TimSSiRtsu82WNnim9mduXSrPj+ONk1sZbn1e/99dhLhe7XVir5Gy03CPSEExtLbc/P1wBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750151332; c=relaxed/simple;
	bh=+LSwdzi7iFB7WX4cH5+zM8FDjhuEN9oGKbGlFg7oMac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+gkW80Xt++pu8L4Lv39OCd7yi4v8k8Tc6bC8ckS+2HKoAHIRfWMWjQ3mZhwhDNrEclHhAaExB+hVIqm/DvD0ZMRmkRQgY+51mvb3vl1MoAYwTOzuyIADsTdBN0dZ6PLb5EPK0E4nI5kS7LDfu7WsZq/LQXxMyDSw5XaIOVg0+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KUb8QgmT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NPrQeILg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KUb8QgmT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NPrQeILg"
Date: Tue, 17 Jun 2025 11:08:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750151328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=25pCXzxkNTMYHHMTY+X+tnzwjC+bKUvyR61NQn/zjBc=;
	b=KUb8QgmTBfXmGSLRFurMn9NhvTz/C8RtHdjjjCq6cF84pLIiPpPLNZ9S5C0+18WKySLs3Q
	pnSxbWTMCFtvOZSjfl9zs/Pk6CMEklcJMYjgclRqoEEHERQiR4qzPb8yq2/LwdjDX9QPB/
	Li/TSegb9OAzQgqW7bUdgW0LBOcYM1xh4R3827K2tw/oB6+5Oqe0xNRDg0cMzM6usKymlb
	/1JzqLn4eYjzgpq4rYHnvJgv9xFVtpHpvFmwIRZbDlbdtYrjM0OoDStRS9Hg5VZSyTS24+
	qYtlpuC9FDe9l8HqBWcrSM65oHVkkNK0dtIZRqpiilFYpQoBHMvFNGK/cvzOWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750151328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=25pCXzxkNTMYHHMTY+X+tnzwjC+bKUvyR61NQn/zjBc=;
	b=NPrQeILgql6i20io6NJngC6jglNiJ/wcZJMjjkxJ7is3IUNVdQBMHIZQZhKYUFRrR6qWUF
	03LIThUV/6LnUIBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Marc =?utf-8?Q?Str=C3=A4mke?= <marc.straemke@eltropuls.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: Latency spikes on V6.15.1 Preempt RT and maybe related to intel?
 IGB
Message-ID: <20250617090846.cxnYD_fg@linutronix.de>
References: <20250613145434.T2x2ML8_@linutronix.de>
 <E1uQ6I0-000000003aa-37uJ@smtprelay05.ispgateway.de>
 <20250613195838.0-gZ6bqS@linutronix.de>
 <97638b0b-cd96-40e2-9dc2-5e6f767b90a4@eltropuls.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <97638b0b-cd96-40e2-9dc2-5e6f767b90a4@eltropuls.de>

On 2025-06-14 10:52:36 [+0200], Marc Str=C3=A4mke wrote:
> Sebastian,
Hi,

> i tried that in the past (rtla top auto analysis). But i do not really
> understand the result:
>=20
> rtla timerlat hit stop tracing
> ## CPU 1 hit stop tracing, analyzing it ##
> =C2=A0 IRQ handler delay:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00 us (0.00
> %)
> =C2=A0 IRQ latency:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 709.25 us
> =C2=A0 Blocking thread:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ip:3567
> =C2=A0=C2=A0=C2=A0 Blocking thread stack trace
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 -> timerlat_irq
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 -> __hrtimer_run_queues
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 -> hrtimer_interrupt
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 -> __sysvec_apic_timer_interrupt
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 -> sysvec_apic_timer_interrupt
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 -> asm_sysvec_apic_timer_interrupt
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 -> igb_update_mc_addr_list
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 -> igb_set_rx_mode
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 -> __dev_change_flags
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 -> netif_change_flags
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 -> do_setlink.constprop.0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 -> rtnl_newlink
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 -> rtnetlink_rcv_msg
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 -> netlink_rcv_skb
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 -> netlink_unicast
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 -> netlink_sendmsg
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 -> ____sys_sendmsg
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 -> ___sys_sendmsg
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 -> __sys_sendmsg
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 -> do_syscall_64
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 -> entry_SYSCALL_64_after_hwframe
> ------------------------------------------------------------------------
> =C2=A0=C2=A0=C2=A0=C2=A0 IRQ latency:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 709.25 us (100=
%)
>=20
>=20
> I do not really understand where the IRQ/Preemption disabling is happenin=
g.
> What would the next thing be to do? Function (graph?) tracing on all the
> functions visible in the backtrace?

So somewhere between entry_SYSCALL_64_after_hwframe() and timerlat_irq()
something happened that led to the spike. Up to __dev_change_flags() it
is mostly regular and asm_sysvec_apic_timer_interrupt() is already the
interrupt.=20
There is only one calling site for igb_update_mc_addr_list() and
everything before that looks harmless.
igb_update_mc_addr_list() has these loops where it writes to FIFO
register. This is followed by wrfl() which reads the status register.
This read forces the writes to go through the bus. What might happen is
that all the writes are "cached" and scheduled for a better time. That
read will force the writes to actually happen and the CPU will stall
until this done.
My guess would be one the writes cause the stall here.

> I tried to look at the event race output starting with the call to
> igb_set_rx_mode. I have attached the trace with all events and a function
> filter on igb on only the cpu executing ip.=C2=A0 I cannot understand wha=
t is
> happening between timestasmp 700.149995 and the IRQ disable event on
> 700.150795....
>=20
>               ip-4931    [001] b...3   700.149994: igb_set_rx_mode <-__de=
v_change_flags
>               ip-4931    [001] b...3   700.149995: kmalloc: call_site=3Di=
gb_set_rx_mode+0x4f8/0x5a0 ptr=3D00000000b0b4e5c8 bytes_req=3D12 bytes_allo=
c=3D16 gfp_flags=3DGFP_ATOMIC|__GFP_ZERO node=3D-1 accounted=3Dfalse
>               ip-4931    [001] b...3   700.149995: igb_update_mc_addr_lis=
t <-igb_set_rx_mode
>               ip-4931    [001] Dn..3   700.150795: irq_disable: caller=3D=
irqentry_enter+0x2a/0x60 parent=3D0x0

The CPU is somewhere in igb_update_mc_addr_list(). Based on the
timestamps it was there for 800us before the irq_disable() occurred.
This did not happen within igb_update_mc_addr_list() but due to an
interrupt.

> Thanks for your help,
>=20
> Marc

Sebastian
