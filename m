Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3A62D9ED1
	for <linux-rt-users@vger.kernel.org>; Thu, 27 Nov 2025 18:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764266997; cv=none; b=qFx8ihTdMt6qWKRcbc9UbfsFADEG0mUxRjE4GJTqyAtgiBm7qtTibRDo75bvdDzls6nJ2124sjvw2rCVcElXCE238t7GYu0NsvGVjcAgR4fBfeWxho2KLL+6Ee56CPecUmqVdHHFfJ7aosmab4cgMjTkqSSahSfHcSu0QODwpLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764266997; c=relaxed/simple;
	bh=PbI6aye62sKYGAiIu6TawYapkqp+7H8OrQ8UdgJ4cVo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gg/oLG/zgRmaBAzX31qjAKUN6/NS6+NkU6wJ+ueacyKn9kVkE8YiZAX3Vah8bQc9nYjHdo14N78WAByNz9fXB48DD6dgYPXDhMtDw1ZyP3B9dKaNZv9YK35ZZSb9sUkTWLzJTHwMQsWRTnCRt1TgrN3w48025xE7A63UDt/0bW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N+CYM5h8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1DMrIGbG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N+CYM5h8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1DMrIGbG"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764266993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eznIwL5JK+VCohiPlLXCtT6sCNnt+j3wUDifjDZAcR0=;
	b=N+CYM5h8353Y476Q86p02YvniaeAYJllbyZ9o/EmxfDf8JQMYENtPfqahXVNaWbXOJWE3T
	+cHkEURnG/rQh5vZJWpKMh6353IPUE0V/HJlN4iCD0Tb1tmKCsv3WjBE6dHyBW4zj0qlvS
	gOrDf2nlE41i6VWuUbQr7+gEH+2y+QCPKdFv1FA5kHnmXYAZrWX2ViBgvyu3Zoo+gY2ZwJ
	4NkBJrbiQEf1d52J1Ni7VnA55WpeCKSm3WSe7EAlW8yG+7AqlbHbfyqvDPAiJ00vpbLbPq
	cekWSy60vUMOutayU49QPmL56VBY1kp4PsA6SAae9JsUrPkCh/uAWQ1RP/DcWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764266993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eznIwL5JK+VCohiPlLXCtT6sCNnt+j3wUDifjDZAcR0=;
	b=1DMrIGbGtkzqoYEdPELZ+Iwe+zamB3ZuoS4U1YXcuWdTuzdINiXKgmc7nqpH4AoVDMg9NK
	zMsKyATyKVtBtHDw==
To: Florian Bezdeka <florian.bezdeka@siemens.com>, "bigeasy@linutronix.de"
 <bigeasy@linutronix.de>
Cc: "Preclik, Tobias" <tobias.preclik@siemens.com>, Frederic Weisbecker
 <frederic@kernel.org>, "linux-rt-users@vger.kernel.org"
 <linux-rt-users@vger.kernel.org>, "Kiszka, Jan" <jan.kiszka@siemens.com>,
 Waiman Long <longman@redhat.com>, Gabriele Monaco <gmonaco@redhat.com>
Subject: Re: Control of IRQ Affinities from Userspace
In-Reply-To: <DEJK91DAS7P0.1UN9SHE15VZRK@siemens.com>
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
 <877bvchafm.ffs@tglx> <DEJK91DAS7P0.1UN9SHE15VZRK@siemens.com>
Date: Thu, 27 Nov 2025 19:09:52 +0100
Message-ID: <87v7ivfitr.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Nov 27 2025 at 15:52, Florian Bezdeka wrote:
> On Wed Nov 26, 2025 at 8:15 PM CET, Thomas Gleixner wrote:
>> So that would become:
>>
>>     if (isolate) {
>>         weight = cpumask_weight(housekeeping);
>>         qnr %= weight;
>>         cpu = cpumask_nth(qnr, housekeeping);
>>     } else {
>>         guard(cpus_read_lock)();
>>         qnr %= num_online_cpus();
>>         cpu = cpumask_nth(qnr, cpu_online_mask);
>>     }
>>     	
>>     return irq_set_affinity_hint(cpumask_of(cpu));
>>
>> See?
>
> That is close to a RFC that I was already preparing, until I realized
> that it would only solve one part of the problem.
>
> Part one: Get rid of unwanted IRQ traffic on my isolated cores. That
> part would be covered as the balancing would be limited to !RT cores.
> Fine.
>
> Part two: In case the device is actually being used by an RT application
> and allowed to run on isolated cores (userspace has properly configured
> that upfront) we would get the opposite after loading a BPF: IRQs are
> now configured wrong.

I just went and looked at that stmac driver once more. The way how it
sets up those affinity hints is actually stupid and leads exactly to the
effects you describe.

The hints should be set exactly once, when MSI is enabled and the
interrupts are allocated and not after request_irq().

So the first request_irq() will use that hinted affinity.  In case that
user space changed the affinity, the setting is preserved accross a
free_irq()/request_irq() sequence unless all CPUs in the affinity mask
have gone offline.

That preservation was explicitly added on request of networking people,
but then someone got it wrong and that request_irq()/set_hint() sequence
started a Copy&Pasta spreading disease. Oh well...

So yes, you have to fix that driver and do the affinity hint business
right after pci_alloc_irq_vectors() and clear it when the driver shuts
down. Looking at intel_eth_pci_remove(), that's another trainwreck as it
does not do any PCI related cleanup despite claiming so....

But the more I look at that whole hint usage, the more I'm convinced
that it is in most cases actively wrong. It only makes really sense when
there is an actual 1:1 relationship of queues to CPUs like in the NVME
case.

I'm pretty sure by now that this is in most cases used to ensure that
the interrupts are spread out properly. But that spreading is only done
to ensure that not all interrupts end up on CPU0 or whatever the
architecture specific interrupt management decides to do. x86 used to
prefer CPU0, but nowadays it tries to spread it accross CPUs within the
provided affinity mask. Not perfect but better than before :)

So the right thing here is to expand the functionality of
irq_calc_affinity_vectors() and group_cpus_evenly() to:

     1) Take isolation masks into account (opt-in and/or system wide
        knob)

     2) Do the spreading over the interrupt sets without setting
        the managed bit in the mask descriptor.

Then use pci_alloc_irq_vectors_affinity(), which does the spreading and
assigns the resulting affinities during interrupt descriptor allocation.

With that the whole hint business can be removed because it has zero
value after the initial setup.

But that's a discussion to be had on LKML/netdev and not on the RT devel
list.

>> That lets userspace still override the hint but does at least initial
>> spreading within the housekeeping mask. Which ever mask that is out of
>> the zoo of masks you best debate with Frederic. :)
>>
> Choosing the right mask is key. The right mask depends on the usage of
> the device. Some devices (or maybe even just some queues) should be
> limited to !RT CPUs, while others should explicitly run within a
> isolated cpuset.

You can't know that upfront. That's a policy decision and user space has
to make it.

What the kernel can do is to take isolation into account when doing the
initial setup. Though that needs a lot of thoughts and presumably a
opt-in knob:

   Depending on your isolation constraints there might only be a single
   housekeeping CPU, which means depending on the number of devices and
   their queue/interrupt requirements that single CPU might run into
   vector exhaustion pretty fast.

> When I'm getting this right, the work from Frederic will bring in the
> "isolated flag" for cpusets. That seems great preparation work. In
> addition we would need something like a mapping between devices (or
> queues maybe indirectly via IRQs) and cgroup/cpusets.
>
> Have there been thoughts around a cpuset.interrupts API - or something
> similar - already?

There was some mumbling about propagating isolation into the interrupt
world, but as far as I can tell there is no plan or idea how that should
look like. But that's again a discussion to be held on LKML.

Thanks,

        tglx
