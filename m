Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C9B269811
	for <linux-rt-users@vger.kernel.org>; Tue, 25 Nov 2025 11:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764070375; cv=none; b=FSnsR8kgeLT6zs0txSoaG4ZUdbZeAz5rS0eNEbnPntvTPH1AF5qQVYjJJBw1cgk+Zslw7iDTEyJ831u/vmhZuAt0tcBWcYd4xE0b216CIjGVPLl1+hc66Ka9YXMMOVydaDxkQDB/5vuzgmpnsl7MUTUfpDH96tLky5/ET+DwPkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764070375; c=relaxed/simple;
	bh=Rt+EMFr5I5CD+jGcfOaDX0Sp7S9jSlKyHdSDCL640SE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QlsfLfwm1KoG4ntnVeW2CyzTp2wqQF4gj1JbpoIMMpWyQEBziO3JrKu00p3xHSAFcSM9pj59f62enDKL/z8iQkFcUryVUbC3vP6fazSa9hVnb5F5U0rK8kv/wKXCa2fC7/CPdAUEJFlx22h+Vvn2ziF1tarcT72uJq1bSEZeCZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=ooVbwKNn; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="ooVbwKNn"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20251125113240a2cd531c4200020745
        for <linux-rt-users@vger.kernel.org>;
        Tue, 25 Nov 2025 12:32:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=lhh3jD7OYasAcuiQDk2OZZQH8uinDL639rK3VgaNn1Y=;
 b=ooVbwKNnKcNBWNSaOi8iOrhIw+NnUR8fgjQvanJuWQwDYzy6x5gSNlThDOgKLG0roebNzg
 CwnDl+yyUi6at9NA4Pdq3jKWMeHVUL+0NsaByVN9ihtY2xGxosx443M7EN+O1eYiP/YuSESx
 3MBGoViDvQAd1M0FrDLWQAzZxH2SUU6/mDaxNCmgPD/G9abOWJOAEmVSP+ujTZHtsc7CHjpj
 J+JavMX+nA8RntvJSwTymiC6MQA653QMlciWYUI40zE+4swwRC6mleLOPUVHLXNdc9l28+TS
 rKQBBQcdQwNksKrX8eFiKB8PMFX9AqNyEhWFkJxTBj0lBVRy3lafXWsw==;
Message-ID: <387396748522d2279c3188e5c2b4345bc2211556.camel@siemens.com>
Subject: Re: Control of IRQ Affinities from Userspace
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: "bigeasy@linutronix.de" <bigeasy@linutronix.de>, "Preclik, Tobias"
	 <tobias.preclik@siemens.com>, Frederic Weisbecker <frederic@kernel.org>
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>, 
 "Kiszka, Jan" <jan.kiszka@siemens.com>
Date: Tue, 25 Nov 2025 12:32:39 +0100
In-Reply-To: <20251124095919.V73BtuvW@linutronix.de>
References: <a0cad8314124ca98d7c6763e3e08d7192598cf92.camel@siemens.com>
	 <20251103155322.Aw9MSNYv@linutronix.de>
	 <3cbc0cf5301350d87c03b7ceb646a3d7c549167b.camel@siemens.com>
	 <6523960abaff2054ed25bf57b2a12e381f305a3e.camel@siemens.com>
	 <20251111143456.YML0ggA7@linutronix.de>
	 <cce633df665f167291d975c0c13dab990e267384.camel@siemens.com>
	 <20251124095919.V73BtuvW@linutronix.de>
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

On Mon, 2025-11-24 at 10:59 +0100, bigeasy@linutronix.de wrote:
> On 2025-11-21 13:25:09 [+0000], Preclik, Tobias wrote:
> > > I would be careful with the deprecated term here. The functionality
> > > is
> > > not deprecated just the interface is. The CPU affinity has been
> > > migrated
> > > a cgroup based interface. If the matching irq affinity is missing
> > > then
> > > it should be added rather than avoiding the whole "affinity is
> > > managed"
> > > interface since this looks as it has been meant for your use case.
> > >=20
> >=20
> > As you point out isolcpus interface is deprecated and it seems there
> > exists no way to translate the managed_irq flag of the isolcpus
> > interface into the cgroups based interface. My understanding is that
>=20
> I did not point out anything. I just suggested to test whether this
> option is working for you and if it does, check if there is matching
> configuration knob in the cpusets/cgroups interface. As per=20
>    https://www.suse.com/c/cpu-isolation-practical-example-part-5/
>=20
> in "3.2) Isolcpus" Frederic says that the options should be used if the
> kernel/ application "haven't been built with cpusets/cgroups support".
> So it seems that this bit is either missing in the other interface or
> hard to find.

In case that was still unclear: We're using the dynamic system
configuration features provided by cpusets/cgrups. No isolcpus=3D on the
kernel cmdline anymore. With that all applications are build around
cgroups. There is some userspace tooling around that takes care of
proper system configuration / RT isolation.

>=20
> =E2=80=A6
> > > > The conclusion got lost:
> > > >=20
> > > > Other drivers like for example igb respect the interrupt affinities
> > > > (both default and per-irq affinities). This leads me to believe
> > > that
> > > > the irq rebalancing in the drivers should only affect the effective
> > > > interrupt affinities. This admittedly is more involved than it
> > > appears
> > > > at first because the interface interrupts would have to be balanced
> > > > subject to multiple (potentially totally different) cpusets.
> > >=20
> > > Exactly. Maybe it would work to align the driver with what igb does.
> >=20
> > Currently, stmmac sets IRQ affinity and hints for all IRQ
> > configurations. But on x86 systems with IOAPIC MSI-X vectors should be
> > automatically balanced. If we remove the driver-based irq balancing
> > then other architectures would not necessarily balance the interrupts
> > anymore and would be impacted in terms of performance. Maybe driver-
> > based irq balancing could be deactivated whenever the underlying system
> > is capable of balancing them? That would of course only reduced the
> > number of affected systems.
> >=20
> > In general I lack information when drivers should (or are allowed to)
> > balance interrupts on driver level and whether smp_affinity is allowed
> > to be ignored and overwritten in that case. All documentation I have
> > found so far remains rather unspecific.
>=20
> It seems that if you exclude certain CPUs from getting interrupt
> handling than it should work fine. Then the driver would only balance
> the interrupts among the CPUs that are left.

Sebastian, what exactly do you mean by "exclude certain CPUs from
getting interrupt handling"? I mean, that is what we do by configuring
the /proc/<irq>/smp_affinity_list interface.

The point here is, that drivers (like the stmmac, storage, ...) simply
ignore everything that was configured by userspace. As soon as one of
the dynamic events (link up/down, bpf loading) occurs they destroy the
current RT aware system configuration.

I was not successful in finding an API that would allow the driver(s) to
do better. The default affinity (/proc/irq/default_smp_affinity) - as an
example - is not visible from outside the IRQ core.

The managed IRQ infrastructure that you mentioned seems coupled with the
interfaces behind CONFIG_CPU_ISOLATION which seems to be "static", so
configured at boot time. Is that understanding correct? That would not
be flexible enough as we don't know the system configuration at boot
time.

As we now have Frederic with us: Frederic, are there any plans to extend
the housekeeping API to deal with cpuset creation? Not sure if that
would be possible as it's hard to say if the newly created cpuset is
targeting isolation or housekeeping...

The question from Tobias in other words: What are drivers allowed to do?
Are they free in choosing/configuring a (performance optimized) IRQ
handling? If so, how can we prevent them from touching RT isolated CPUs?

Do we consider issues like "driver ignoring the default IRQ affinity" as
driver bugs? Is there some consensus in the community? Background here
is the argumentation why we would have to touch / fix those drivers.

To sum up:=C2=A0
- The IRQ balancing issue is not limited to a single driver / subsystem
- The managed IRQ infrastructure seems very "static" so insufficient for
  this problem. In addition we would have to migrate all affected
  drivers to the managed IRQ infrastructure first.

We would love to hear further thoughts / ideas / comments about this
problem. We're highly interested in fixing this issue properly.

Thanks for all the comments so far!

Florian

