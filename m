Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD201328B46
	for <linux-rt-users@vger.kernel.org>; Tue, 25 Nov 2025 16:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764088314; cv=none; b=l0YtwOsWNxZdL3DN0lgtSVQiqwp0uH4xlpnJFn1UiHbqyxZ7f/21IQR5HKRIh8KB6VesFXypU8chfmxWMBD4hF5Y+3NmxEaMQSfskyOVNfrDQ7gyBQTntlUWppk63HaP+bcuqtPZqczLKRJ0PZtOKxrwkhcFWPdukRok+dMIk7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764088314; c=relaxed/simple;
	bh=/yhc0UJH23OKGdi8bp8/iEQMjM0HrcwfLRJ1aA1l/64=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=boxC4hm1jvCWQNbmk4uVs/1K4yOAURygkbYPHjtVE5vsnFijEPL2eYXrMBjifiywpzIzJ6Fz2RkPrGqJ6XL/eMxN598msATrrLAd5KxEFx0tQLkjd1FImjkx1xTD6y7XWAJX0iLG6rI7XnmxMovfxQKuymsZ4zjzMcAxYuHW8ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cB/LTWh1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8yDZfp14; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cB/LTWh1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8yDZfp14"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764088310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fzAwcT18S3aJ9aPvKZ/1j1b62eeYh5u6ECVGFCCx0MA=;
	b=cB/LTWh1Vkd/1fdHC4BAG5vf/xR+RSq2AnjQ8tF0LvDq1G6u1sCGYiqqVtxnv1U7jAKDK8
	lkBNE51+eB6OTD1hkAjAjPnUyMCjcRSH51JIsjfQVaxiIGPPWIo3p6qggS/D5TGCCFZIKb
	4lD1kMusc0MoiLLqktTG2arqCjVbrhiUZ6TL2VyUY4EVp58Ktv55gWapvLUguWZZCVLgg6
	A+KRbqXaauXTje8u4G3Hos1l+LsQDCaxbnWSeJsxSN5pkj754O6tsVErVpVU0gW2uNyGHI
	IWl/oSAWjSwz4TalO6CG+28uzrqnfRKoqm3t65c+9wq4aa6632btYi2MtISZzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764088310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fzAwcT18S3aJ9aPvKZ/1j1b62eeYh5u6ECVGFCCx0MA=;
	b=8yDZfp14l9Wy9dpNRQMB6slqBKqu7iaghJwHoG+oOir/Y+CTcFLXS1WLrO4odi7WquYzby
	Uf5IyF6YLgaDR9Bw==
To: Florian Bezdeka <florian.bezdeka@siemens.com>, "bigeasy@linutronix.de"
 <bigeasy@linutronix.de>
Cc: "Preclik, Tobias" <tobias.preclik@siemens.com>, Frederic Weisbecker
 <frederic@kernel.org>, "linux-rt-users@vger.kernel.org"
 <linux-rt-users@vger.kernel.org>, "Kiszka, Jan" <jan.kiszka@siemens.com>
Subject: Re: Control of IRQ Affinities from Userspace
In-Reply-To: <767a8c7c1c88d930c5e7d7b39e7081c3cb39a08c.camel@siemens.com>
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
Date: Tue, 25 Nov 2025 17:31:47 +0100
Message-ID: <87tsyigjkc.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25 2025 at 15:36, Florian Bezdeka wrote:
> On Tue, 2025-11-25 at 12:50 +0100, bigeasy@linutronix.de wrote:
>> On 2025-11-25 12:32:39 [+0100], Florian Bezdeka wrote:
>> > > It seems that if you exclude certain CPUs from getting interrupt
>> > > handling than it should work fine. Then the driver would only balance
>> > > the interrupts among the CPUs that are left.
>> >=20
>> > Sebastian, what exactly do you mean by "exclude certain CPUs from
>> > getting interrupt handling"? I mean, that is what we do by configuring
>> > the /proc/<irq>/smp_affinity_list interface.
>>=20
>> Step #1
>> - figure out if isolcpus=3D is restricting the affinity of requested
>>   interrupts to housekeeping CPUs only
>
> This question can not be answered with yes/no. It depends. Affinities
> are based on the default_smp_affinity during creation. But as it turned
> out there are drivers that overwrite those affinities after IRQ
> creation.

Which ones?

>> I *think* the driver should request as many interrupts as there are
>> available CPUs in the system to handle them.=C2=A0
>>=20
>
> That does not match how networking (and some storage) drivers are
> designed. Those drivers are usually HW queue centric. A driver is
> setting up a IRQ per queue pair (TX/RX). The number of HW queues is
> defined by the hardware and is decoupled from any CPU count.
>
> To optimize performance, drivers may spread / balance the IRQs / queues
> over available CPUs and while doing so might ignore any previous RT
> configuration. Again: The performance optimization is valid, but how
> could we prevent violating RT settings?

That spreading happens and it depends how it is grouped and how that
matches your isolation requirements. NVME certainly allocates a queue
per CPU if there are enough available and those won't disturb your RT
isolated CPUs as long as nothing issues I/O on those CPUs.

Networking is a different story, but networking does not use managed
interrupts (except for one driver) and you can move them away from your
isolated CPUs after the device is set up.

There have been discussions how to keep interrupts by default off from
isolated CPUs, but I don't know where this stands. Frederic?

>> The number of available
>> CPUs/ CPU mask should be a configure knob by the user.=C2=A0
>>=20
> The user normally configures the number of HW queues that the NIC should
> use. In most cases in combination with some HW packet filters to achieve
> best packet separation. IMHO the user should not have to deal with any
> (additional) CPU mask on that level. RT tuning will / should handle
> that.

How so. The kernel magically knows what the user wants?

>> Using the
>> housekeeping CPUs as a default mask seems reasonable.
>> The question is what should happen if the mask changes at runtime. Maybe
>> a device needs to reconfigure, maybe just move the interrupt away.
>> But this should also affect NOHZ_FULL workloads.
>>=20
>> > To sum up:=C2=A0
>> > - The IRQ balancing issue is not limited to a single driver / subsystem
>> > - The managed IRQ infrastructure seems very "static" so insufficient f=
or
>> >   this problem. In addition we would have to migrate all affected
>> >   drivers to the managed IRQ infrastructure first.
>> >=20
>> > We would love to hear further thoughts / ideas / comments about this
>> > problem. We're highly interested in fixing this issue properly.
>>=20
>> If the "managed IRQ infrastructure" would help here then why not. Maybe
>> Frederic has some insight here.
>
> I currently can't see how this could help.=C2=A0
>
> That looks like dead code to me. I started in irq_do_set_affinity() -
> which checks for managed IRQs - but I could not find any user of
> irq_create_affinity_masks() - that is where the managed flag is set -
> that is actually being used. The road seems dead in
> devm_platform_get_irqs_affinity() which has no in-tree user.

# git grep -nH irq_create_affinity_masks drivers/
drivers/base/platform.c:424:    desc =3D irq_create_affinity_masks(nvec, af=
fd);
drivers/pci/msi/api.c:289:                              irq_create_affinity=
_masks(1, affd);
drivers/pci/msi/msi.c:405:              affd ? irq_create_affinity_masks(nv=
ec, affd) : NULL;
drivers/pci/msi/msi.c:695:              affd ? irq_create_affinity_masks(nv=
ec, affd) : NULL;

These three PCI ones are all going through pci_alloc_irq_vectors_affinity()

# git grep -nH pci_alloc_irq_vectors_affinity drivers/

drivers/net/ethernet/wangxun/libwx/wx_lib.c:1867:       nvecs =3D pci_alloc=
_irq_vectors_affinity(wx->pdev, nvecs,
drivers/nvme/host/pci.c:2659:   return pci_alloc_irq_vectors_affinity(pdev,=
 1, irq_queues, flags,
drivers/scsi/be2iscsi/be_main.c:3585:           if (pci_alloc_irq_vectors_a=
ffinity(phba->pcidev, 2, nvec,
drivers/scsi/csiostor/csio_isr.c:520:   cnt =3D pci_alloc_irq_vectors_affin=
ity(hw->pdev, min, cnt,
drivers/scsi/hisi_sas/hisi_sas_v3_hw.c:2611:    vectors =3D pci_alloc_irq_v=
ectors_affinity(pdev,
drivers/scsi/megaraid/megaraid_sas_base.c:5943: i =3D pci_alloc_irq_vectors=
_affinity(instance->pdev,
drivers/scsi/mpi3mr/mpi3mr_fw.c:862:            retval =3D pci_alloc_irq_ve=
ctors_affinity(mrioc->pdev,
drivers/scsi/mpt3sas/mpt3sas_base.c:3390:       i =3D pci_alloc_irq_vectors=
_affinity(ioc->pdev,
drivers/scsi/pm8001/pm8001_init.c:982:          rc =3D pci_alloc_irq_vector=
s_affinity(
drivers/scsi/qla2xxx/qla_isr.c:4539:            ret =3D pci_alloc_irq_vecto=
rs_affinity(ha->pdev, min_vecs,
drivers/virtio/virtio_pci_common.c:160: err =3D pci_alloc_irq_vectors_affin=
ity(vp_dev->pci_dev, nvectors,

Not a so dead road :)

Thanks,

        tglx


