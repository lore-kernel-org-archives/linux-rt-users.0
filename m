Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1843321BC
	for <linux-rt-users@vger.kernel.org>; Wed, 26 Nov 2025 15:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764170646; cv=none; b=UhlBBB0ZONJ+YvxynN1x3ZolfQjBLSbnAm9Q5UcFht4HTmQlrvJTCxSyx88Apze5qMwL2j0fFC3cg/Q3fmTkflFPdT3AvGaS75V5j+eOa1VMqtXqytMg3qI+s2evVKDF87Fu9ZVE4tIvMZfFqIwbSiXregKta6COVBwOU8j0/v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764170646; c=relaxed/simple;
	bh=/zvawkSnA5WGE2eELAcVJThCpE/Si73u/FaiI5gFrJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XzNIrc5hEeZ3WXz+UQtdNm/yX4BMUUcdC7lKtEZ4ojUXBl6V9ehbsreDmq5W7BB8YeG1yH3fvyr059gU908fiQUN69ZWnMdJm+vqshYeYz7KzJwNDcP1yITQ2Lm9rULHcXPyMabkoje9jsThqSQWFsS5HSWrGqoGF1JuXc6FU7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QaXotmQN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QaXotmQN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC5AC19422;
	Wed, 26 Nov 2025 15:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764170646;
	bh=/zvawkSnA5WGE2eELAcVJThCpE/Si73u/FaiI5gFrJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QaXotmQNHlpbgEQw/9upFsJRDo8nmH+ExilGzCMWX04xycbiUpqJ7kd0d1nOKroZh
	 k7Pc/kirGAOednSKFqDVACiB4T/ozuE+J6F5b5kWjWbPz4vCPNloaOtzUm/VOTlPqM
	 FRqA0bvLuSHJVjZhXMPR9RvjCf8mqv0ZHRj8e8qHB33Rr6162czU9nqjMgJMPtrEX4
	 pNfBDgFnAnx5Cj6eT1nUbavmGMvEJVOw9hibMCZSAlZDlWu/FsdCJzVnwV+nzQXYUX
	 2avVqCkAOdwSoGWKldmhfsiIaw4hgqUaixCs+IDXmv3qy2zn9UVP9rbOu3odg7ArjJ
	 adb6bAuBn5X2g==
Date: Wed, 26 Nov 2025 16:24:03 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
	"Preclik, Tobias" <tobias.preclik@siemens.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"Kiszka, Jan" <jan.kiszka@siemens.com>
Subject: Re: Control of IRQ Affinities from Userspace
Message-ID: <aScbkxRMUbMxlwTG@localhost.localdomain>
References: <a0cad8314124ca98d7c6763e3e08d7192598cf92.camel@siemens.com>
 <20251103155322.Aw9MSNYv@linutronix.de>
 <3cbc0cf5301350d87c03b7ceb646a3d7c549167b.camel@siemens.com>
 <6523960abaff2054ed25bf57b2a12e381f305a3e.camel@siemens.com>
 <20251111143456.YML0ggA7@linutronix.de>
 <cce633df665f167291d975c0c13dab990e267384.camel@siemens.com>
 <20251124095919.V73BtuvW@linutronix.de>
 <387396748522d2279c3188e5c2b4345bc2211556.camel@siemens.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <387396748522d2279c3188e5c2b4345bc2211556.camel@siemens.com>

Le Tue, Nov 25, 2025 at 12:32:39PM +0100, Florian Bezdeka a écrit :
> On Mon, 2025-11-24 at 10:59 +0100, bigeasy@linutronix.de wrote:
> > On 2025-11-21 13:25:09 [+0000], Preclik, Tobias wrote:
> > > > I would be careful with the deprecated term here. The functionality
> > > > is
> > > > not deprecated just the interface is. The CPU affinity has been
> > > > migrated
> > > > a cgroup based interface. If the matching irq affinity is missing
> > > > then
> > > > it should be added rather than avoiding the whole "affinity is
> > > > managed"
> > > > interface since this looks as it has been meant for your use case.
> > > > 
> > > 
> > > As you point out isolcpus interface is deprecated and it seems there
> > > exists no way to translate the managed_irq flag of the isolcpus
> > > interface into the cgroups based interface. My understanding is that
> > 
> > I did not point out anything. I just suggested to test whether this
> > option is working for you and if it does, check if there is matching
> > configuration knob in the cpusets/cgroups interface. As per 
> >    https://www.suse.com/c/cpu-isolation-practical-example-part-5/
> > 
> > in "3.2) Isolcpus" Frederic says that the options should be used if the
> > kernel/ application "haven't been built with cpusets/cgroups support".
> > So it seems that this bit is either missing in the other interface or
> > hard to find.
> 
> In case that was still unclear: We're using the dynamic system
> configuration features provided by cpusets/cgrups. No isolcpus= on the
> kernel cmdline anymore. With that all applications are build around
> cgroups. There is some userspace tooling around that takes care of
> proper system configuration / RT isolation.
> 
> > 
> > …
> > > > > The conclusion got lost:
> > > > > 
> > > > > Other drivers like for example igb respect the interrupt affinities
> > > > > (both default and per-irq affinities). This leads me to believe
> > > > that
> > > > > the irq rebalancing in the drivers should only affect the effective
> > > > > interrupt affinities. This admittedly is more involved than it
> > > > appears
> > > > > at first because the interface interrupts would have to be balanced
> > > > > subject to multiple (potentially totally different) cpusets.
> > > > 
> > > > Exactly. Maybe it would work to align the driver with what igb does.
> > > 
> > > Currently, stmmac sets IRQ affinity and hints for all IRQ
> > > configurations. But on x86 systems with IOAPIC MSI-X vectors should be
> > > automatically balanced. If we remove the driver-based irq balancing
> > > then other architectures would not necessarily balance the interrupts
> > > anymore and would be impacted in terms of performance. Maybe driver-
> > > based irq balancing could be deactivated whenever the underlying system
> > > is capable of balancing them? That would of course only reduced the
> > > number of affected systems.
> > > 
> > > In general I lack information when drivers should (or are allowed to)
> > > balance interrupts on driver level and whether smp_affinity is allowed
> > > to be ignored and overwritten in that case. All documentation I have
> > > found so far remains rather unspecific.
> > 
> > It seems that if you exclude certain CPUs from getting interrupt
> > handling than it should work fine. Then the driver would only balance
> > the interrupts among the CPUs that are left.
> 
> Sebastian, what exactly do you mean by "exclude certain CPUs from
> getting interrupt handling"? I mean, that is what we do by configuring
> the /proc/<irq>/smp_affinity_list interface.
> 
> The point here is, that drivers (like the stmmac, storage, ...) simply
> ignore everything that was configured by userspace. As soon as one of
> the dynamic events (link up/down, bpf loading) occurs they destroy the
> current RT aware system configuration.
> 
> I was not successful in finding an API that would allow the driver(s) to
> do better. The default affinity (/proc/irq/default_smp_affinity) - as an
> example - is not visible from outside the IRQ core.
> 
> The managed IRQ infrastructure that you mentioned seems coupled with the
> interfaces behind CONFIG_CPU_ISOLATION which seems to be "static", so
> configured at boot time. Is that understanding correct? That would not
> be flexible enough as we don't know the system configuration at boot
> time.
> 
> As we now have Frederic with us: Frederic, are there any plans to extend
> the housekeeping API to deal with cpuset creation? Not sure if that
> would be possible as it's hard to say if the newly created cpuset is
> targeting isolation or housekeeping...

I'm not sure what you mean by that. But HK_TYPE_DOMAIN will soon include
both isolcpus and cpuset isolated partitions. And the next step is to be
able to create nohz_full/isolated cpuset partitions.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs
