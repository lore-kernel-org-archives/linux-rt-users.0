Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7C82D027E
	for <linux-rt-users@vger.kernel.org>; Fri, 28 Nov 2025 07:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764315234; cv=none; b=tU7u0rxUi0/FK26zFZygcoXL1A3pGpVZyAd8MQsTTNOKuGVEoaR77uAY7qMV2H4D8mEX+2hJG5sMM+LYUBW/lrCy5a6b/PQYcB/b+t1jhipO+Yv0yY0TNnGUM7TZNXHoTzCP1BpTALUVmHicHdTcbjKJVMdDP2pdpirDXQELvOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764315234; c=relaxed/simple;
	bh=Mq27K90ClaCPrW25cpoQRQw0cfgb3FJMcja2ls3eTy0=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=RTqEtVsv89M5l4OkbMcK7XSLEi+CZ8cb95eLrcarEXUf3HwJ3mIwzYuhHI8ZTArYNNYDn7f7NcBCpKVXW0hRcEdp/uFqTr2oFw/TtltCCm/jjbmgUP2QjXH9s+LcSJqqkQexDqWtV0TpM4J/N1TU25g+YLUOO6Rkkb8zijITdiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=RBavYMpq; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="RBavYMpq"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202511280733401d07bffcbd00020776
        for <linux-rt-users@vger.kernel.org>;
        Fri, 28 Nov 2025 08:33:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=wJs0ZYwy2K6ErrLAzyN7Dh/sop0q0HRWe+XMToTZsCU=;
 b=RBavYMpqVVFAfM3qPdFheYfh4uTdA3IjqrJ4y4+/YC6yloVNWdliI9i/jtJhI7tjrRrAtc
 jVvIBnzwePFUSWs2CP6YsCHrE+MqMgbpYJWjFZ5my4L+SChPYujoJbYadeJkSF1c+kXqqrKA
 7YhrdYn8Zhemjl7PeIpuyGz4KUvoNAaaCZJ5MZaXQtQsn3ir21R8B6L9EHHh1iRz2Y5ZdFxw
 y0VjVZgMOWPdJkpuU4y5caOrHdJqVaUOcHbMBshNZaUQBDIsJB3BoM2aYtXnJvjYMfP6TBd1
 IsdLtFUCTUNmF7MKbxcXD5/pdQifw2Hv6Qpjxmpq9krHt3FElC6T8iDw==;
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 28 Nov 2025 08:33:40 +0100
Message-Id: <DEK5JQZ9V9O3.1J10X6Z0U8JFX@siemens.com>
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: "Thomas Gleixner" <tglx@linutronix.de>, "Florian Bezdeka"
 <florian.bezdeka@siemens.com>, "bigeasy@linutronix.de"
 <bigeasy@linutronix.de>
Cc: "Preclik, Tobias" <tobias.preclik@siemens.com>, "Frederic Weisbecker"
 <frederic@kernel.org>, "linux-rt-users@vger.kernel.org"
 <linux-rt-users@vger.kernel.org>, "Kiszka, Jan" <jan.kiszka@siemens.com>,
 "Waiman Long" <longman@redhat.com>, "Gabriele Monaco" <gmonaco@redhat.com>
Subject: Re: Control of IRQ Affinities from Userspace
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
 <87v7ivfitr.ffs@tglx>
In-Reply-To: <87v7ivfitr.ffs@tglx>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Thu Nov 27, 2025 at 7:09 PM CET, Thomas Gleixner wrote:
> On Thu, Nov 27 2025 at 15:52, Florian Bezdeka wrote:
>> On Wed Nov 26, 2025 at 8:15 PM CET, Thomas Gleixner wrote:
>
> I just went and looked at that stmac driver once more. The way how it
> sets up those affinity hints is actually stupid and leads exactly to the
> effects you describe.
>
> The hints should be set exactly once, when MSI is enabled and the
> interrupts are allocated and not after request_irq().
>
> So the first request_irq() will use that hinted affinity.  In case that
> user space changed the affinity, the setting is preserved accross a
> free_irq()/request_irq() sequence unless all CPUs in the affinity mask
> have gone offline.
>
> That preservation was explicitly added on request of networking people,
> but then someone got it wrong and that request_irq()/set_hint() sequence
> started a Copy&Pasta spreading disease. Oh well...
>
> So yes, you have to fix that driver and do the affinity hint business
> right after pci_alloc_irq_vectors() and clear it when the driver shuts
> down. Looking at intel_eth_pci_remove(), that's another trainwreck as it
> does not do any PCI related cleanup despite claiming so....
>
> But the more I look at that whole hint usage, the more I'm convinced
> that it is in most cases actively wrong. It only makes really sense when
> there is an actual 1:1 relationship of queues to CPUs like in the NVME
> case.
>
> I'm pretty sure by now that this is in most cases used to ensure that
> the interrupts are spread out properly. But that spreading is only done
> to ensure that not all interrupts end up on CPU0 or whatever the
> architecture specific interrupt management decides to do. x86 used to
> prefer CPU0, but nowadays it tries to spread it accross CPUs within the
> provided affinity mask. Not perfect but better than before :)
>
> So the right thing here is to expand the functionality of
> irq_calc_affinity_vectors() and group_cpus_evenly() to:
>
>      1) Take isolation masks into account (opt-in and/or system wide
>         knob)
>
>      2) Do the spreading over the interrupt sets without setting
>         the managed bit in the mask descriptor.
>
> Then use pci_alloc_irq_vectors_affinity(), which does the spreading and
> assigns the resulting affinities during interrupt descriptor allocation.
>
> With that the whole hint business can be removed because it has zero
> value after the initial setup.
>
> But that's a discussion to be had on LKML/netdev and not on the RT devel
> list.

Thanks Thomas, this is now going into the expected direction. Let me
look at that proposal in more detail. Once I have tested that and it
works we will migrate the discussion to LKML/netdev.

>> Choosing the right mask is key. The right mask depends on the usage of
>> the device. Some devices (or maybe even just some queues) should be
>> limited to !RT CPUs, while others should explicitly run within a
>> isolated cpuset.
>
> You can't know that upfront. That's a policy decision and user space has
> to make it.
>
> What the kernel can do is to take isolation into account when doing the
> initial setup. Though that needs a lot of thoughts and presumably a
> opt-in knob:
>
>    Depending on your isolation constraints there might only be a single
>    housekeeping CPU, which means depending on the number of devices and
>    their queue/interrupt requirements that single CPU might run into
>    vector exhaustion pretty fast.

This is definitely something that we should keep an eye on.

>
>> When I'm getting this right, the work from Frederic will bring in the
>> "isolated flag" for cpusets. That seems great preparation work. In
>> addition we would need something like a mapping between devices (or
>> queues maybe indirectly via IRQs) and cgroup/cpusets.
>>
>> Have there been thoughts around a cpuset.interrupts API - or something
>> similar - already?
>
> There was some mumbling about propagating isolation into the interrupt
> world, but as far as I can tell there is no plan or idea how that should
> look like. But that's again a discussion to be held on LKML.

We have the /proc/irq/default_smp_affinity which is already available
but decoupled from the cgroup/cpuset isolation feature of Frederic - as
it seems. Let me check how those settings could be merged at the end.

Thanks a lot Thomas!

Best regards,
Florian
