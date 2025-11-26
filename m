Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E273358B8
	for <linux-rt-users@vger.kernel.org>; Wed, 26 Nov 2025 15:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764171087; cv=none; b=Xn9UZXVVKXRJiRVTBe6p0237WGTmXEpZXJ0uVArZiX6/0kCjRkz0Gs+5M9lFNzC9dlEBm9ARFeslrSnvTa+6VFH8QofP9Uym0eI0no853OF42K2OKNNTom94QPCuUGrUY7JAbDuypc0NroX/BNPRPDSTolmADgHDjeW7Ud9behk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764171087; c=relaxed/simple;
	bh=HuDVpyWD7lbUL5WtsPKyaYpScPFjxQ5lm1/Dhs7jXyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=StfSeWyAXi7uazkLt8w59pIa+Bi4ic1GJeaTX5rgdphjTXcUzT8I9nLL+QqmW7XnhlaIYoN78mNpBCxBrXRtYsZ147PrGQDsGOEVQMU6IhhfstGH/iI1JpBR6LfpkmPTYbCJPAZmM9UCH580IyMV7UoCbeApCCWzE/t9mVwHQOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Un6JXwTG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Un6JXwTG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F02C4CEF7;
	Wed, 26 Nov 2025 15:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764171086;
	bh=HuDVpyWD7lbUL5WtsPKyaYpScPFjxQ5lm1/Dhs7jXyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Un6JXwTGfwltGUM/g5gLqH/exqhYP+Z3PxDTVnuHppfFOdFlYFo6qgttIegiz/IGX
	 GbgmsDjdA7hO3g7YhwWm+M7h+ZMcahkg085y7ZTDkpy4+Ehc5z9p6oQDsJvzvdHFMI
	 DzmE9ybTjcYHpm7s45cO36zLeS7MmAxH4X6ZWhx5Izo3MZpXJmWqwUgNPoki02GmNx
	 gC2/WkYAHxEBeNfU/5hUYYPaswMRUr9Gn4TmorBmCbFnTG1UhTXnrUqxPfGjURXcMf
	 lYmh98b3A9quKlMZnj+RmFTi8heFqjI6Eof0oKf2HoZe3bF2740kUAsGWsUJfbXs8j
	 BPtnGZne5T2Rg==
Date: Wed, 26 Nov 2025 16:31:23 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "bigeasy@linutronix.de" <bigeasy@linutronix.de>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,
	"Preclik, Tobias" <tobias.preclik@siemens.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"Kiszka, Jan" <jan.kiszka@siemens.com>
Subject: Re: Control of IRQ Affinities from Userspace
Message-ID: <aScdS6HNQHZ6OvDO@localhost.localdomain>
References: <a0cad8314124ca98d7c6763e3e08d7192598cf92.camel@siemens.com>
 <20251103155322.Aw9MSNYv@linutronix.de>
 <3cbc0cf5301350d87c03b7ceb646a3d7c549167b.camel@siemens.com>
 <6523960abaff2054ed25bf57b2a12e381f305a3e.camel@siemens.com>
 <20251111143456.YML0ggA7@linutronix.de>
 <cce633df665f167291d975c0c13dab990e267384.camel@siemens.com>
 <20251124095919.V73BtuvW@linutronix.de>
 <387396748522d2279c3188e5c2b4345bc2211556.camel@siemens.com>
 <20251125115008.-R5m5dX9@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251125115008.-R5m5dX9@linutronix.de>

Le Tue, Nov 25, 2025 at 12:50:08PM +0100, bigeasy@linutronix.de a écrit :
> On 2025-11-25 12:32:39 [+0100], Florian Bezdeka wrote:
> > > It seems that if you exclude certain CPUs from getting interrupt
> > > handling than it should work fine. Then the driver would only balance
> > > the interrupts among the CPUs that are left.
> > 
> > Sebastian, what exactly do you mean by "exclude certain CPUs from
> > getting interrupt handling"? I mean, that is what we do by configuring
> > the /proc/<irq>/smp_affinity_list interface.
> 
> Step #1
> - figure out if isolcpus= is restricting the affinity of requested
>   interrupts to housekeeping CPUs only
> 
> Step #2
> - Yes
>    => look for the matching knob in cgroup interface
>       Knob found?
>       - Yes
>         => Use knob.
>       - No.
>         => Add knob.
> - No
>   This should be added as it breaks the expectation of an isolated
>   system.
> 
> I *think* the driver should request as many interrupts as there are
> available CPUs in the system to handle them. The number of available
> CPUs/ CPU mask should be a configure knob by the user. Using the
> housekeeping CPUs as a default mask seems reasonable.
> The question is what should happen if the mask changes at runtime. Maybe
> a device needs to reconfigure, maybe just move the interrupt away.
> But this should also affect NOHZ_FULL workloads.

Right now, you still need to change by hand the affinity of an IRQ through
/proc to match a new isolated cpuset partition. But ideally this should be
automatically handled by cpuset. If someone wants to tackle that, it would
be greatly appreciated.

As for those IRQs whose affinity can only be controlled by isolcpus=managed_irq
this is more complicated but probably not unfeasible.

> 
> > To sum up: 
> > - The IRQ balancing issue is not limited to a single driver / subsystem
> > - The managed IRQ infrastructure seems very "static" so insufficient for
> >   this problem. In addition we would have to migrate all affected
> >   drivers to the managed IRQ infrastructure first.
> > 
> > We would love to hear further thoughts / ideas / comments about this
> > problem. We're highly interested in fixing this issue properly.
> 
> If the "managed IRQ infrastructure" would help here then why not. Maybe
> Frederic has some insight here.

Not really but being able to change managed_irq affinities at runtime would
certainly be welcome. I fear my first visit to the genirq subsystem is only
one month old though and I miss the cycles to dive further there right now.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs
