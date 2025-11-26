Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43061CD15
	for <linux-rt-users@vger.kernel.org>; Wed, 26 Nov 2025 19:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764184564; cv=none; b=iAgcIcB+mHmjewb7JPh9pKvD/uxOgCNu+nTaSmJTgoH3iUvyvOpZaBsoOJbiZv7CGi5Qm+B/Q23WRFBEE+zH/fVc0vfqvXofIJrLkW2lfEqi1/Tte7t+K99IlVRvEIHCUhgBWMxKCDbCPKcMluA7IHE3IFqP1YudgCynA4n6yeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764184564; c=relaxed/simple;
	bh=QrOeXh9SmhwEFETKb92g/QtilURlsI/x6tDbolUY0nk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=riHGzO4HWMRwW3Jl2GWaxT9+8yPIezojGTgIUT3N5lLeUgjVGP5ZFPKDGXm7IAh/Hb4ntbvGAiQf0xnxRUj7YY7Ep6YoQwVrq3+59xd0el9NZ1wmP/iZBfpcuD+dKwnzNbjlT8Nh2dxg2OwZmfwjvfkhKuUgO5eisSl1aggE8pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jnUr+/Gm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Va/qAzb6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jnUr+/Gm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Va/qAzb6"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764184558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OVkvNMK/WnbNn1ZdFYwiBXHXLen4XnBnkX/iK/nOPBs=;
	b=jnUr+/GmFldcEROeNp99dDuslbViLTV5UfE5v3Cxj6ctsnvacAdcyzlGrFbkrgoTEiC9yn
	LJXoCprGtc5wHbv/4oII4NhUm2IJwxM5DBtEf13F5XK8kymfvR/Odj0y6IWF5dgRb/8j6l
	3JrK4xtVkH75viCvzKdYGCXFCdTlomaS31d8S5xROId1kiZPe/bnY+LBAOY6NW0I7aRuJZ
	rQGlDK6sUQKZlbjaklL8GjbPczNDCb/+yk/k4xSDxwrH6HNRTaam8bxUWFizCvx9jBqHD4
	Wr+P5aMGW+2j20bBoWDF3oF9w7fajR4V+DcQY4y/OQM4GYXX6bo4tQ7K5A0nkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764184558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OVkvNMK/WnbNn1ZdFYwiBXHXLen4XnBnkX/iK/nOPBs=;
	b=Va/qAzb6aVllEyBu7eSzVXi+G/2R/Bz9zKmHNJXnNl4kymBuAKWvI9emgEa/wfksb0fwvb
	ke96o81s/yeTypCg==
To: Florian Bezdeka <florian.bezdeka@siemens.com>, "bigeasy@linutronix.de"
 <bigeasy@linutronix.de>
Cc: "Preclik, Tobias" <tobias.preclik@siemens.com>, Frederic Weisbecker
 <frederic@kernel.org>, "linux-rt-users@vger.kernel.org"
 <linux-rt-users@vger.kernel.org>, "Kiszka, Jan" <jan.kiszka@siemens.com>,
 Waiman Long <longman@redhat.com>, Gabriele Monaco <gmonaco@redhat.com>
Subject: Re: Control of IRQ Affinities from Userspace
In-Reply-To: <DEIPY3BS8AHL.1YJ1980URTLYH@siemens.com>
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
Date: Wed, 26 Nov 2025 20:15:57 +0100
Message-ID: <877bvchafm.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Nov 26 2025 at 16:07, Florian Bezdeka wrote:
> On Wed Nov 26, 2025 at 3:26 PM CET, Thomas Gleixner wrote:
>> The question is whether that affinity hint has a functional requirement
>> to be applied or not. I don't think so because those interrupts can be
>> moved by userspace as it sees fit.
>
> The background seems performance. Those NICs support link speeds up to
> (or even above) 2.5Gbit/s. Seems it's hard to fully utilize the link
> when all queues are routed - IRQ wise - to a single core.
>
> This is now the point where the IRQ chips matters. Some (like APIC for
> x86) have the IRQ balancing implemented in SW, while others don't have
> that. So the driver does that manually by ignoring all the RT settings.

Hardware interrupt balancing never worked right :)

APIC "supports" it in logical/cluster mode, but in fact 99% of the
interrupts ended up on the lowest APIC in the logical/cluster mask. So
we gave up on it because the benefit was close to zero and the
complexity for multi-CPU affinity management with the limited vector
space was just not worth it. In high performance setups the interrupts
were anyway steered to a single CPU by the admin or irqbalanced :)

ARM64 would support that too IIRC, but they decided to avoid the whole
multi-CPU affinity mess as well :)

>> So it's easy enough to make this "set" part conditional and restrict it
>> to some TBD mask (housekeeping, default ...) under some isolation magic.
>>
>
> For now I would be happy if I could modify the stmmac in a way that its
> balancing takes the default affinity into account. I couldn't find any
> available API that allows me to do so from a module.
>
> Are there any strong reasons for not exporting the default affinity from
> the IRQ core? Read-only would be enough.

Default affinity is yet another piece which is disconnected from all the
other isolation mechanics. So we are not exporting it for some quick and
dirty hack. You can do that of course in your own kernel, but please
don't send the result to my inbox :)

> In addition I'm quite sure that the housekeeping infrastructure would
> not help in the area of networking as nobody (except one driver) is
> based on the managed IRQ API.

Managed interrupts are not user steerable and due to their strict
CPU/CPUgroup relationship they are not required to be steerable. NVME &
al have a strict command/response on the same queue scheme, which is
obviously most efficient when you have per CPU queues. The nice thing
about that concept is that the queues are only active (and having
interrupts) when an application on a given CPU issues a R/W operation.

Networking does not have that by default as their strategy of routing
packages to queues is way more complicated and can be affected by
hardware filtering etc.

But why can't housekeeping help in general and why do you want to hack
around the problem in random drivers?

What's wrong with providing a new irq_set_affinity_hint_xxx() variant
which takes a additional queue number as argument and let that do:

    if (isolate) {
        weight = cpumask_weight(housekeeping);
        qnr %= weight;
        cpu = cpumask_nth(qnr, housekeeping);
        mask = cpumask_of(cpu);
    }
    return irq_set_affinity_hint(mask);
    
or something like that. From a quick glance over the drivers this could
maybe be based on a queue number alone as most drivers do:

      mask = cpumask_of(qnr % num_online_cpus());

or something daft like that, which is obviously broken, but who cares.
So that would become:

    if (isolate) {
        weight = cpumask_weight(housekeeping);
        qnr %= weight;
        cpu = cpumask_nth(qnr, housekeeping);
    } else {
        guard(cpus_read_lock)();
        qnr %= num_online_cpus();
        cpu = cpumask_nth(qnr, cpu_online_mask);
    }
    	
    return irq_set_affinity_hint(cpumask_of(cpu));

See?

That lets userspace still override the hint but does at least initial
spreading within the housekeeping mask. Which ever mask that is out of
the zoo of masks you best debate with Frederic. :)

Thanks,

        tglx
