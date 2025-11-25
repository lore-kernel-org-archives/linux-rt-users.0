Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9E332692D
	for <linux-rt-users@vger.kernel.org>; Tue, 25 Nov 2025 14:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764082019; cv=none; b=nIDtvfAB9tExFSPAycU/MD8kTAsN6y4yK79J9z3Nf1cwFh8DkhwoBNT9aP4qct63v7ESe89T6BKiI0FZUhkkw11jERUx2g9tJIQItA7zAPtF1M77mOnolsrzKKqckM4Vm1wbajTk86cboUFC8ZatZLoNGSFbpDTCgcvLx7vl5XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764082019; c=relaxed/simple;
	bh=jh+VidHnR5zYpZI2fGxi5jr0zDoC75rktYFZXT/ffEo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rv9ZH1o+ReDnbcwyDuTJyYZlov6SK8mVsMJZ5jawXSrjnVw8qu6nFRSTsAIbPUAPenp8//AuysCPcD2Jicemc26R9y/18SuDh2T4h0xiKO1IYfmDSND4ULT+B2hPNL2wYZBb1KAQ4H2qVrGMC2yLcQ4o7Xtljlduec8N4sR++jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=l3R6XFKl; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="l3R6XFKl"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20251125143642670b19d304000207a3
        for <linux-rt-users@vger.kernel.org>;
        Tue, 25 Nov 2025 15:36:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=3jEgtgENHRJqTdQ+W8am0y8hGf0xFdF8nxpFwoa15Jw=;
 b=l3R6XFKl+34w4X8B4la6jFWmLUVodFmxUZF5RPQBcPO4xYQXoDfwmGXP008aOGSYqv/zEQ
 plNugYSBsKL6Fizom/HB9ToHHfoWlWljkatQx8VqBClcVNiqwtaR/2WJXO+rJzoSfP9s2Mxh
 ypUILOBzNdvIwHKJGo/gGQjpj2AG/Oat5EV1hYL2CGIznHHk2w49akmH51mtqFJgNADte5U9
 3X7FszBLdl3/NUKhY06r7gABE3zv0y1khVppeRknv4CVpqqKuxwpd7J5Wqbe+pqOpjadFahh
 3PzJD5SZcFSeszFylqAoSA2D6TQOqIaiHS0JV+SW8e3hd+TWI5tyb5vw==;
Message-ID: <767a8c7c1c88d930c5e7d7b39e7081c3cb39a08c.camel@siemens.com>
Subject: Re: Control of IRQ Affinities from Userspace
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: "bigeasy@linutronix.de" <bigeasy@linutronix.de>
Cc: "Preclik, Tobias" <tobias.preclik@siemens.com>, Frederic Weisbecker
	 <frederic@kernel.org>, "linux-rt-users@vger.kernel.org"
	 <linux-rt-users@vger.kernel.org>, "Kiszka, Jan" <jan.kiszka@siemens.com>
Date: Tue, 25 Nov 2025 15:36:41 +0100
In-Reply-To: <20251125115008.-R5m5dX9@linutronix.de>
References: <a0cad8314124ca98d7c6763e3e08d7192598cf92.camel@siemens.com>
	 <20251103155322.Aw9MSNYv@linutronix.de>
	 <3cbc0cf5301350d87c03b7ceb646a3d7c549167b.camel@siemens.com>
	 <6523960abaff2054ed25bf57b2a12e381f305a3e.camel@siemens.com>
	 <20251111143456.YML0ggA7@linutronix.de>
	 <cce633df665f167291d975c0c13dab990e267384.camel@siemens.com>
	 <20251124095919.V73BtuvW@linutronix.de>
	 <387396748522d2279c3188e5c2b4345bc2211556.camel@siemens.com>
	 <20251125115008.-R5m5dX9@linutronix.de>
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

On Tue, 2025-11-25 at 12:50 +0100, bigeasy@linutronix.de wrote:
> On 2025-11-25 12:32:39 [+0100], Florian Bezdeka wrote:
> > > It seems that if you exclude certain CPUs from getting interrupt
> > > handling than it should work fine. Then the driver would only balance
> > > the interrupts among the CPUs that are left.
> >=20
> > Sebastian, what exactly do you mean by "exclude certain CPUs from
> > getting interrupt handling"? I mean, that is what we do by configuring
> > the /proc/<irq>/smp_affinity_list interface.
>=20
> Step #1
> - figure out if isolcpus=3D is restricting the affinity of requested
>   interrupts to housekeeping CPUs only

This question can not be answered with yes/no. It depends. Affinities
are based on the default_smp_affinity during creation. But as it turned
out there are drivers that overwrite those affinities after IRQ
creation.

>=20
> Step #2
> - Yes
>    =3D> look for the matching knob in cgroup interface
>       Knob found?
>       - Yes
>         =3D> Use knob.
>       - No.
>         =3D> Add knob.
> - No
>   This should be added as it breaks the expectation of an isolated
>   system.

Assuming that No is the answer as there are a couple of drivers leading
to this situation. The question is now: How do we prevent this violation
of the isolated system configuration?

>=20
> I *think* the driver should request as many interrupts as there are
> available CPUs in the system to handle them.=C2=A0
>=20

That does not match how networking (and some storage) drivers are
designed. Those drivers are usually HW queue centric. A driver is
setting up a IRQ per queue pair (TX/RX). The number of HW queues is
defined by the hardware and is decoupled from any CPU count.

To optimize performance, drivers may spread / balance the IRQs / queues
over available CPUs and while doing so might ignore any previous RT
configuration. Again: The performance optimization is valid, but how
could we prevent violating RT settings?

> The number of available
> CPUs/ CPU mask should be a configure knob by the user.=C2=A0
>=20

The user normally configures the number of HW queues that the NIC should
use. In most cases in combination with some HW packet filters to achieve
best packet separation. IMHO the user should not have to deal with any
(additional) CPU mask on that level. RT tuning will / should handle
that.

> Using the
> housekeeping CPUs as a default mask seems reasonable.
> The question is what should happen if the mask changes at runtime. Maybe
> a device needs to reconfigure, maybe just move the interrupt away.
> But this should also affect NOHZ_FULL workloads.
>=20
> > To sum up:=C2=A0
> > - The IRQ balancing issue is not limited to a single driver / subsystem
> > - The managed IRQ infrastructure seems very "static" so insufficient fo=
r
> >   this problem. In addition we would have to migrate all affected
> >   drivers to the managed IRQ infrastructure first.
> >=20
> > We would love to hear further thoughts / ideas / comments about this
> > problem. We're highly interested in fixing this issue properly.
>=20
> If the "managed IRQ infrastructure" would help here then why not. Maybe
> Frederic has some insight here.

I currently can't see how this could help.=C2=A0

That looks like dead code to me. I started in irq_do_set_affinity() -
which checks for managed IRQs - but I could not find any user of
irq_create_affinity_masks() - that is where the managed flag is set -
that is actually being used. The road seems dead in
devm_platform_get_irqs_affinity() which has no in-tree user.

>=20
> > Thanks for all the comments so far!
> >=20
> > Florian
>=20
> Sebastian
