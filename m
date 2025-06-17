Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C71F1C7017;
	Tue, 17 Jun 2025 09:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750151786; cv=none; b=nEDUQsaqlXo6HctcJSGoVCmHI7/+pXbP4zDJBGK4ExkM53kdWkjPdkLKIPklfXBKUTxGWIF4Jz+RZK6deYuKl/6RE746pCJEKjBwkdlcNXqtWkE0EM3eBP2oL33jM+WrL50xPP+5Vx4uCgsoCj6lB+savPR0MD3DGfxCBSoHDDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750151786; c=relaxed/simple;
	bh=STvRZQJwA3XC3xAYQftHzEDHDwhWS8nqBCyKnSZhUU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OD537WFpj5uRoVxmCUenK9lt8YjMH1qlgg7N7NTAd+vZo1FrcmEF9LtoG1PJV+oejh8g73lZwZt/XP8m4xd4OemPYj6WCAzB6LZyLHuIMOylDkivqi1EVBCRsqE9W+TH4qcijrY9GSii6KMatDXm/Mej6aHPD6FXOsP3z1Gavz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zhAM8GQa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dSKfFSbi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zhAM8GQa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dSKfFSbi"
Date: Tue, 17 Jun 2025 11:16:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750151782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=STvRZQJwA3XC3xAYQftHzEDHDwhWS8nqBCyKnSZhUU0=;
	b=zhAM8GQaUoLIpGBk3b+2DPKXr2791hRG8YCg8OEPjweRs59bLCzwshS4t+JTP2N5TdOI7e
	mCt2zWg8oqy98UqIsdfpCpai9WfO75/U05aB51HNs2Lx+WFvNFOBM1h8zhwyW/g9Po3JoG
	Z1S4TLd4R2FGkXdlX7Es+vZdoESffmigA8aeGPtJ2QBE//BlIssfIJfQsjvNpEx/K86rKG
	ektzx6WbreYMrzpogO4CCKMvBusaotqTDEWWgRO6+HqHDYwVYBG0kQl+X5GWtvox5FFTul
	vWT+2w0icjQg58bXoywchIMGDOCDGrmDPUftaprsMNWoSxod+6ivzytnhL9itA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750151782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=STvRZQJwA3XC3xAYQftHzEDHDwhWS8nqBCyKnSZhUU0=;
	b=dSKfFSbixbdO7OJftIyib+LrBAvib6zwUIzCgSAeP/FZFJ2Bw/kOiHx9kyKWQKoi4RXzac
	h/JlijUxSfMSnADA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Marc =?utf-8?Q?Str=C3=A4mke?= <marc.straemke@eltropuls.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: Latency spikes on V6.15.1 Preempt RT and maybe related to intel?
 IGB
Message-ID: <20250617091621.IZh5OyYh@linutronix.de>
References: <20250613145434.T2x2ML8_@linutronix.de>
 <E1uQ6I0-000000003aa-37uJ@smtprelay05.ispgateway.de>
 <20250613195838.0-gZ6bqS@linutronix.de>
 <97638b0b-cd96-40e2-9dc2-5e6f767b90a4@eltropuls.de>
 <d72bc0b1-7898-4513-9b50-60b56112c8e1@eltropuls.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <d72bc0b1-7898-4513-9b50-60b56112c8e1@eltropuls.de>

On 2025-06-16 17:10:33 [+0200], Marc Str=C3=A4mke wrote:
> Hi Sebastian,
Hi Marc,

> I am still trying to figure that puzzle out: Please see the following
> function trace snippet:
>=20
> ip-690530=C2=A0 [000] ..... 178636.460435: rtnl_is_locked <-__dev_change_=
flags
> ip-690530=C2=A0 [000] ..... 178636.460435: __local_bh_disable_ip <-__dev_=
change_flags
> ip-690530=C2=A0 [000] ..... 178636.460435: migrate_disable <-__local_bh_d=
isable_ip
> ip-690530=C2=A0 [000] ...1. 178636.460435: preempt_disable: caller=3D__lo=
cal_bh_disable_ip+0x76/0xe0 parent=3D__local_bh_disable_ip+0x76/0xe0
> ip-690530=C2=A0 [000] ...11 178636.460435: preempt_enable: caller=3D__loc=
al_bh_disable_ip+0x76/0xe0 parent=3D__local_bh_disable_ip+0x76/0xe0
> ip-690530=C2=A0 [000] ....1 178636.460435: rt_spin_lock <-__local_bh_disa=
ble_ip
> ip-690530=C2=A0 [000] ....1 178636.460436: __rcu_read_lock <-rt_spin_lock
> ip-690530=C2=A0 [000] ....1 178636.460436: migrate_disable <-__local_bh_d=
isable_ip
> ip-690530=C2=A0 [000] ....2 178636.460436: __rcu_read_lock <-__local_bh_d=
isable_ip
> ip-690530=C2=A0 [000] b...2 178636.460436: rt_spin_lock <-__dev_change_fl=
ags
> ip-690530=C2=A0 [000] b...2 178636.460436: __rcu_read_lock <-rt_spin_lock
> ip-690530=C2=A0 [000] b...2 178636.460436: migrate_disable <-__dev_change=
_flags
> ip-690530=C2=A0 [000] b...3 178636.460436: __dev_set_rx_mode <-__dev_chan=
ge_flags
> ip-690530=C2=A0 [000] b...3 178636.460437: igb_set_rx_mode <-__dev_change=
_flags
>=20
> It is my understanding that __local_bh_disable_ip called from
> netif_addr_lock_bh seems to be the origin of my latency.

How so?

> What i do not understand is, even if the bottom halves are disabled.
> Shouldn't I see the interrupt arriving in the trace?
Yes.

> If i understood it correctly, your talk "Unblocking the softirq lock for
> PREEMPT_RT" during the plumbers conference 2023 is exactly about that cas=
e,
> right?
No.

> Probably fixing this issue is out of my abilities for now ;-) The wast
> variety of locking concepts inside the kernel is quite intimidating for a
> newcomer in kernel land...

If you would have only the scheduler events enabled and you would see
that "ip-690530" is doing something, then an interrupt fires, that
interrupts wakes a thread, CPU switches to that thread and that thread
does sched_pi_setprio() and switches back to "ip-690530" until it is
done _then_ it would be what I said on plumbers in 2023.

Your trace snippet above is short latency wise. It covers just 2us.
=46rom that it all looks good. If you go further down in your trace,
there has to be a spike between igb_update_mc_addr_list() and
asm_sysvec_apic_timer_interrupt().

> Regards,
>=20
>=20
> Marc

Sebastian
