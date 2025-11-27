Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C2A26FD9B
	for <linux-rt-users@vger.kernel.org>; Thu, 27 Nov 2025 15:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764257562; cv=none; b=OLLaKylmJQdPahTZsdjqPYw4XBPahXysnEv4t+wEnFLAOK/Y39Y8Wn6FsSyAcMSwVtin+nOm/yMqP2UT4qh4uef+8ek01Tx5Tf+P1TtrD/W9ClbyTpXdvbzDxtqHWPuwhKtqLpxbVUNpPj7xty2UQQO2a33P0/j38SebaYGiM8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764257562; c=relaxed/simple;
	bh=bLY1bS+ibiGN79A2MNPkacbSMu5qgsyFu64QbcnhsMg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=cz5xY3XSfzEVAhvB9l1GxuJrxpKRIDpHkMoemxTt9ZQryK8d7yUiCSfpTDsIk61lfm/ds7nBPlSxbuUexFCcs5NLWztMP6pNbGdme3SHANj+/tJRWBGRJ8oR0NYEXA1wLpsvw3l/KmiG+Wh3sES/FRQrnwm3s+7PuKuXae72pNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=JHeDhRQb; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="JHeDhRQb"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202511271452182cd008db9c00020714
        for <linux-rt-users@vger.kernel.org>;
        Thu, 27 Nov 2025 15:52:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=KD2pGtA50jmztopcINZ4gFabdDNlScdr0hy40e5Alwo=;
 b=JHeDhRQbKRcyvOfsn+q/bD3LxxZCmRkxSVJBmwQ3Fh+9TUiC6PmfVqFiKe/FdXUeeNLu4z
 +A4ZWRUyVD6u9CVmxHKalnD5VHRh8Ej/VCluXd/zpIjhhy2ekQ33TfdfBUz6ws2I8sClhLD8
 ftu+nZJ1wsK1UCENgVb51ITgSI/7eqA0DbKsKf9Ok700TH6H1/3rU48wGgdr7kyujIIQMqMT
 xJMTwgavQK4Maq8rjdM3FRImWjLZGL8imlHcxC9vGfvYwXAek5LXRoYn+4x2VTTM2w7XwKGc
 P8FoO6isjwQ4sUSpSsyxKA36aYK4Tgr9i35qnNyvEYJ9hO59gxarXWWQ==;
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Nov 2025 15:52:17 +0100
Message-Id: <DEJK91DAS7P0.1UN9SHE15VZRK@siemens.com>
Cc: "Preclik, Tobias" <tobias.preclik@siemens.com>, "Frederic Weisbecker"
 <frederic@kernel.org>, "linux-rt-users@vger.kernel.org"
 <linux-rt-users@vger.kernel.org>, "Kiszka, Jan" <jan.kiszka@siemens.com>,
 "Waiman Long" <longman@redhat.com>, "Gabriele Monaco" <gmonaco@redhat.com>
Subject: Re: Control of IRQ Affinities from Userspace
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: "Thomas Gleixner" <tglx@linutronix.de>, "bigeasy@linutronix.de"
 <bigeasy@linutronix.de>
References: <a0cad8314124ca98d7c6763e3e08d7192598cf92.camel@siemens.com>
 <20251103155322.Aw9MSNYv@linutronix.de>
 <3cbc0cf5301350d87c03b7ceb646a3d7c549167b.camel@siemens.com>
 <6523960abaff2054ed25bf57b2a12e381f305a3e.camel@siemens.com>
 <20251111143456.YML0ggA7@linutronix.de>
 <cce633df665f167291d975c0c13dab990e267384.camel@siemens.com>
 <20251124095919.V73BtuvW@linutronix.de>
 <387396748522d2279c3188e5c2b4345bc2211556.camel@siemens.com>
 <20251125115008.-R5m5dX9@linutronix.de>
 <767a8c7c1c88d930c5e7d7b39e7081c3cb39a08c.camel@siemens.com>
 <87tsyigjkc.ffs@tglx>
 <4de393b9304c99386d847ed0694ec12075a99c0a.camel@siemens.com>
 <87fra0hntv.ffs@tglx> <DEIPY3BS8AHL.1YJ1980URTLYH@siemens.com>
 <877bvchafm.ffs@tglx>
In-Reply-To: <877bvchafm.ffs@tglx>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Wed Nov 26, 2025 at 8:15 PM CET, Thomas Gleixner wrote:
>>
>> Are there any strong reasons for not exporting the default affinity from
>> the IRQ core? Read-only would be enough.
>
> Default affinity is yet another piece which is disconnected from all the
> other isolation mechanics. So we are not exporting it for some quick and
> dirty hack. You can do that of course in your own kernel, but please
> don't send the result to my inbox :)

Well, that's the reason for this discussion here: Upstream first.

>
>> In addition I'm quite sure that the housekeeping infrastructure would
>> not help in the area of networking as nobody (except one driver) is
>> based on the managed IRQ API.
>
> Managed interrupts are not user steerable and due to their strict
> CPU/CPUgroup relationship they are not required to be steerable. NVME &
> al have a strict command/response on the same queue scheme, which is
> obviously most efficient when you have per CPU queues. The nice thing
> about that concept is that the queues are only active (and having
> interrupts) when an application on a given CPU issues a R/W operation.
>
> Networking does not have that by default as their strategy of routing
> packages to queues is way more complicated and can be affected by
> hardware filtering etc.
>
> But why can't housekeeping help in general and why do you want to hack
> around the problem in random drivers?

No, that's not what I want. I'm highly interested in solving this
problem properly. Just trying to collect all the information at the
moment. I'm quite sure there is still something around that I did not
take into account yet.

>
> What's wrong with providing a new irq_set_affinity_hint_xxx() variant
> which takes a additional queue number as argument and let that do:
>
>     if (isolate) {
>         weight =3D cpumask_weight(housekeeping);
>         qnr %=3D weight;
>         cpu =3D cpumask_nth(qnr, housekeeping);
>         mask =3D cpumask_of(cpu);
>     }
>     return irq_set_affinity_hint(mask);
>    =20
> or something like that. From a quick glance over the drivers this could
> maybe be based on a queue number alone as most drivers do:
>
>       mask =3D cpumask_of(qnr % num_online_cpus());
>
> or something daft like that, which is obviously broken, but who cares.
> So that would become:
>
>     if (isolate) {
>         weight =3D cpumask_weight(housekeeping);
>         qnr %=3D weight;
>         cpu =3D cpumask_nth(qnr, housekeeping);
>     } else {
>         guard(cpus_read_lock)();
>         qnr %=3D num_online_cpus();
>         cpu =3D cpumask_nth(qnr, cpu_online_mask);
>     }
>     =09
>     return irq_set_affinity_hint(cpumask_of(cpu));
>
> See?

That is close to a RFC that I was already preparing, until I realized
that it would only solve one part of the problem.

Part one: Get rid of unwanted IRQ traffic on my isolated cores. That
part would be covered as the balancing would be limited to !RT cores.
Fine.

Part two: In case the device is actually being used by an RT application
and allowed to run on isolated cores (userspace has properly configured
that upfront) we would get the opposite after loading a BPF: IRQs are
now configured wrong.

>
> That lets userspace still override the hint but does at least initial
> spreading within the housekeeping mask. Which ever mask that is out of
> the zoo of masks you best debate with Frederic. :)
>

Choosing the right mask is key. The right mask depends on the usage of
the device. Some devices (or maybe even just some queues) should be
limited to !RT CPUs, while others should explicitly run within a
isolated cpuset.

When I'm getting this right, the work from Frederic will bring in the
"isolated flag" for cpusets. That seems great preparation work. In
addition we would need something like a mapping between devices (or
queues maybe indirectly via IRQs) and cgroup/cpusets.

Have there been thoughts around a cpuset.interrupts API - or something
similar - already?

Best regards,
Florian
