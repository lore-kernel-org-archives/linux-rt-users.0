Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731A6316196
	for <linux-rt-users@vger.kernel.org>; Mon,  3 Nov 2025 17:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762189977; cv=none; b=TDnEJXsJ8325N9SnBw0mSjfKdhZjia8+bdTS1rLtmDQ7gObO+Ms+eKmxAvpauAaCHEOFkMRRbOFsEz187AV+8+ssKMI3TDcc+aIpx8n0v7mpl481PN5WwXHxd1JkfkxvCMJB1a9c2t5C/WPcAZV/3CT00afkIN/nvZ8NR9HioeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762189977; c=relaxed/simple;
	bh=0ai2gFCAY9b48dKzaLmLzB+n+vuUszA8dDynDxgl8AY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KFxfTF2OLnANqjXPU/qPAsNRwTJ5/3ku67ltedhkGofzL1Z2gk18xgW1BJZkrAx2QVx5AJ5QAp9Bv5wet+lAVc2eUHmA/0oO40cbwanQSay/tNzJp2iuQk0s5ZWLg15cxgOZH0vckyF4uCWz4wF0g2XCixnUKZqYrG4uvfyUiZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=SCIVwDVB; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="SCIVwDVB"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202511031712495efaa0fbab000207c6
        for <linux-rt-users@vger.kernel.org>;
        Mon, 03 Nov 2025 18:12:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=0ai2gFCAY9b48dKzaLmLzB+n+vuUszA8dDynDxgl8AY=;
 b=SCIVwDVB+17iSf2ZQ2y1MhjSfsJ5SNd0vi8kwEeh1cq1obJTSzsOJzJohDF9Qxt4ACd7B2
 cYzXblhiu8Vc15TEy9IV/jHzrb2Pd8oaO5i7Pz1LHi0xw9j5MMD4qdKMDMm9mlETRQH46ep0
 sTmLeQqanG0RVSDU+GVVxt9hT4uD9MrB/+FimTlU5GNAbPCGhuuTYARNUL/vCtSk/h5vW0cM
 B6VA64pLWVktLOt9rF0A9H01CHpcdLxacP65hNtA19EHSv9g7MgZydfluacZOgTbs7n9ieXN
 D4ayavaieHtXafHBQx9OIpzoKVeMAKlI6lz34OICELHDxNT/oMwoxWyg==;
Message-ID: <3cbc0cf5301350d87c03b7ceb646a3d7c549167b.camel@siemens.com>
Subject: Re: Control of IRQ Affinities from Userspace
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "Preclik, Tobias"
	 <tobias.preclik@siemens.com>
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>, Jan
 Kiszka <jan.kiszka@siemens.com>
Date: Mon, 03 Nov 2025 18:12:48 +0100
In-Reply-To: <20251103155322.Aw9MSNYv@linutronix.de>
References: <a0cad8314124ca98d7c6763e3e08d7192598cf92.camel@siemens.com>
	 <20251103155322.Aw9MSNYv@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Mon, 2025-11-03 at 16:53 +0100, Sebastian Andrzej Siewior wrote:
> On 2025-10-30 14:20:01 [+0000], Preclik, Tobias wrote:
> > Dear Linux RT Experts,
> >=20
> > the Linux kernel exposes two userspace interfaces to control IRQ
> > affinities in the procfs [1]. First, /proc/irq/default_smp_affinity
> > specifies the default affinity mask which gets applied as initial
> > affinity mask for newly registering IRQs. Second,
> > /proc/irq/${IRQ_NO}/smp_affinity which can be used to specify an
> > affinity mask for a given IRQ.
> >=20
> > For tuning the I/O path of RT applications we use the second interface
> > to relocate IRQs to cores dedicated to run RT applications. However, we
> > have observed that certain situations, such as interface bring-up or
> > loading BPF/XDP programs, can cause the IRQ affinity mask to be lost.
> > Specifically, some network drivers, particularly those based on stmmac,
> > ignore the IRQ affinity mask set from userspace and overwrite it with
> > decisions from IRQ rebalancing [2]. This driver behavior prevents
> > consistent control of IRQ affinities from userspace, impacting the
> > tuning of the I/O path for RT applications.
> >=20
> > I would greatly appreciate any comments or guidance on this issue.
>=20
> The usage of irq_set_affinity_hint() is not uncommon within the
> networking drivers. It is probably a pity if the request happens on each
> ifdown/ up but in this case it happens each time you add/ remove a XDP
> program.
>=20
> But the interrupt should be managed by the kernel. Looking at
> irq_do_set_affinity() there is:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (irqd_affinity_is_m=
anaged(data) &&
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 housekeeping_enabled(HK_TYPE_MANAGED_IRQ)) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct cpumask *hk_mask;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 hk_mask =3D housekeeping_cpumask(HK_TYPE_MANAGE=
D_IRQ);
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpumask_and(tmp_mask, mask, hk_mask);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!cpumask_intersects(tmp_mask, cpu_online_ma=
sk))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 prog_mask =3D mask;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 prog_mask =3D tmp_mask;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>=20
> so if the IRQ is managed and you have IRQ isolation enabled then it
> should exclude the non-isolated CPUs. Would that work?

I'm trying to jump in and adding some thoughts and results we got while
analyzing this issue:

What stmmac (and some more drivers) are trying to achieve here is some
kind of handcrafted IRQ balancing, like the good old irqbalanced did in
the past from usermode. Turns out that the situation about IRQ balancing
is a bit inconsistent. Some IRQ chips (like the APIC on x86 do that
"automatically" on driver level, many others don't. So drivers end up
fiddling with affinities.

We can nicely tune IRQs and affected affinities that that have been
requested during system boot. Tools like tuned can configure them using
the APIs Tobias described. IRQs that are requested / setup after boot,
during runtime, are kind of "problematic" for us, as there is no API
that informs about new IRQ. We would have to rescan /proc. But even if
there would be such an API: That would be too late. The IRQ might have
fired already.

Once an affinity has been set (e.g. by tuned) this affinity is being
restored when the IRQ comes back after a link up/down or bpf load. But:
It might have happened that the situation on the system has changed.
Even the default affinity could be different now. In case of the stmmac
- and probably way more drivers - the default affinity is not taken into
account anymore. The previous affinity is being restored
unconditionally.

I tried to modify stmmac and let it evaluate the default affinity while
doing the IRQ balancing dance. That turned out to be working at the end,
but each line violated several coding/style/abstraction rules. There is
no API at driver level to read the current default affinity - or I
missed it. I could sent that hack out as RFC if requested. Just let me
know.

Thinking more about this problem - and trying to abstract that in a
generalized way - triggered some ideas about "IRQ namespaces", similar
to what we have for CPUs/Memory/... in the cgroup world. Devices, or
classes of devices could be moved into namespaces, instead of
configuring them one by one. Thoughts welcome. The main challenge here
is that we do not think about rt vs. non-rt. It's more about multiple RT
applications running in parallel, well isolated from each other and the
non-rt world.

Florian

>=20
> > Best regards,
> > Tobias Preclik
>=20
> Sebastian
