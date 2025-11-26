Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43A622172C
	for <linux-rt-users@vger.kernel.org>; Wed, 26 Nov 2025 09:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764148868; cv=none; b=ogG9PbqOPk+B+lKI9mnY5tAuIN6spUH6r6frgtdRLcoYba2uJga2b4e1yPyg2ApnYxOOSD/kOh9NRDj745w0zXhexVmj7Y18xMgDaLv1aeAcUyOiz8rfblMteE/VfmDJ/JLT3SD/CZWtfuaDLIBViOeDl1ho5yNwMqrGeS63HZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764148868; c=relaxed/simple;
	bh=M50Ve+Hu1ctNRF3tHeHZMPw40ceQWELRfckcf2e8wwg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pKVWjIN7XTBLnuhjJG5HLzgQHEyZg7al+VSQkfL2PlRR+GLxNu5Wn/B9rq1hG3/pyFB/1DnGRwtEFwra+lE+uWfohd+TOj/TR5dQovlpKzlRjFzcfErFnz6o9OzBcHAjwKHcUMlw5Sft6aVGmLRKMxU2urPE0ZNNw31ZgQK6p6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=ZKJL5k3J; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="ZKJL5k3J"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2025112609205359243ff4a5000207fe
        for <linux-rt-users@vger.kernel.org>;
        Wed, 26 Nov 2025 10:20:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=lgaz5IURQ3n1bafsCvxnVBHYF7bKTztqNIwAOwUPY00=;
 b=ZKJL5k3J7viiSbNFUpUFYyPlPVamhRsxPqZPFdXVkbjN0QFDdFdCFuS5adyQMaP3XxzKUn
 lZeWU7gfRL4gHGa6Th634cunLmC0sXpXdk0hEi3SlvmdpD3vFq7VY4gKyQZBKxhQZy/Tunrs
 XD/3zXA7IAkOyLDDZcLzgSUjmb4NKB+p4YGc7zWb/U6kO9UeIe245bmaSU6M5Of4jZuQWD2y
 pNQYaMhrs4tqVSMpxZmkWWEW5FtwvOXGlbiD9Ho8yyXR/cRImFnNT8grWKk4dZB+Roo3/+NA
 Hk2XnoN/Z+/J2OOYX2e7ULiipssVjwwDgOiIhd05aocG22RWhpXlAGOg==;
Message-ID: <4de393b9304c99386d847ed0694ec12075a99c0a.camel@siemens.com>
Subject: Re: Control of IRQ Affinities from Userspace
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Thomas Gleixner <tglx@linutronix.de>, "bigeasy@linutronix.de"
	 <bigeasy@linutronix.de>
Cc: "Preclik, Tobias" <tobias.preclik@siemens.com>, Frederic Weisbecker
	 <frederic@kernel.org>, "linux-rt-users@vger.kernel.org"
	 <linux-rt-users@vger.kernel.org>, "Kiszka, Jan" <jan.kiszka@siemens.com>
Date: Wed, 26 Nov 2025 10:20:53 +0100
In-Reply-To: <87tsyigjkc.ffs@tglx>
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

On Tue, 2025-11-25 at 17:31 +0100, Thomas Gleixner wrote:
> On Tue, Nov 25 2025 at 15:36, Florian Bezdeka wrote:
> > On Tue, 2025-11-25 at 12:50 +0100, bigeasy@linutronix.de wrote:
> > > On 2025-11-25 12:32:39 [+0100], Florian Bezdeka wrote:
> > > > > It seems that if you exclude certain CPUs from getting interrupt
> > > > > handling than it should work fine. Then the driver would only bal=
ance
> > > > > the interrupts among the CPUs that are left.
> > > >=20
> > > > Sebastian, what exactly do you mean by "exclude certain CPUs from
> > > > getting interrupt handling"? I mean, that is what we do by configur=
ing
> > > > the /proc/<irq>/smp_affinity_list interface.
> > >=20
> > > Step #1
> > > - figure out if isolcpus=3D is restricting the affinity of requested
> > >   interrupts to housekeeping CPUs only
> >=20
> > This question can not be answered with yes/no. It depends. Affinities
> > are based on the default_smp_affinity during creation. But as it turned
> > out there are drivers that overwrite those affinities after IRQ
> > creation.
>=20
> Which ones?

The problem at hand is the stmmac
(drivers/net/ethernet/stmicro/stmmac/stmmac_main), which is pulled in by
a couple of others like the dwmac_intel in our case.

Searching for the problematic irq_set_affinity_hint() call in
drivers/net/ethernet reveals more "affected" drivers but each of them
requires some double checking. In some cases the supplied cpumask or the
"time of the call" might be OKish.

>=20
> > > I *think* the driver should request as many interrupts as there are
> > > available CPUs in the system to handle them.=C2=A0
> > >=20
> >=20
> > That does not match how networking (and some storage) drivers are
> > designed. Those drivers are usually HW queue centric. A driver is
> > setting up a IRQ per queue pair (TX/RX). The number of HW queues is
> > defined by the hardware and is decoupled from any CPU count.
> >=20
> > To optimize performance, drivers may spread / balance the IRQs / queues
> > over available CPUs and while doing so might ignore any previous RT
> > configuration. Again: The performance optimization is valid, but how
> > could we prevent violating RT settings?
>=20
> That spreading happens and it depends how it is grouped and how that
> matches your isolation requirements. NVME certainly allocates a queue
> per CPU if there are enough available and those won't disturb your RT
> isolated CPUs as long as nothing issues I/O on those CPUs.
>=20
> Networking is a different story, but networking does not use managed
> interrupts (except for one driver) and you can move them away from your
> isolated CPUs after the device is set up.

That's one key point here. The pattern implemented in network drivers
seems to be, that drivers register/free IRQs on interface up/down events
and for loading bpf programs (necessary for AF_XDP).

Such events can happen at any time - even after the initial "move
everything away from my isolated CPUs" has completed - and you end up
with a broken RT system configuration.

Even (RT) applications might trigger such an event. Example would be
loading such an AF_XDP bpf program. Applications can "destroy" isolated
environment this way.

>=20
> There have been discussions how to keep interrupts by default off from
> isolated CPUs, but I don't know where this stands. Frederic?

Would love to hear more here.

>=20
> > > The number of available
> > > CPUs/ CPU mask should be a configure knob by the user.=C2=A0
> > >=20
> > The user normally configures the number of HW queues that the NIC shoul=
d
> > use. In most cases in combination with some HW packet filters to achiev=
e
> > best packet separation. IMHO the user should not have to deal with any
> > (additional) CPU mask on that level. RT tuning will / should handle
> > that.
>=20
> How so. The kernel magically knows what the user wants?

We can already identify the IRQs that belong to a certain hardware queue
(NAPI threads) and move it when necessary. I just wanted to express that
there might not be a need for an additional API / cpumask.

>=20
> > > Using the
> > > housekeeping CPUs as a default mask seems reasonable.
> > > The question is what should happen if the mask changes at runtime. Ma=
ybe
> > > a device needs to reconfigure, maybe just move the interrupt away.
> > > But this should also affect NOHZ_FULL workloads.
> > >=20
> > > > To sum up:=C2=A0
> > > > - The IRQ balancing issue is not limited to a single driver / subsy=
stem
> > > > - The managed IRQ infrastructure seems very "static" so insufficien=
t for
> > > >   this problem. In addition we would have to migrate all affected
> > > >   drivers to the managed IRQ infrastructure first.
> > > >=20
> > > > We would love to hear further thoughts / ideas / comments about thi=
s
> > > > problem. We're highly interested in fixing this issue properly.
> > >=20
> > > If the "managed IRQ infrastructure" would help here then why not. May=
be
> > > Frederic has some insight here.
> >=20
> > I currently can't see how this could help.=C2=A0
> >=20
> > That looks like dead code to me. I started in irq_do_set_affinity() -
> > which checks for managed IRQs - but I could not find any user of
> > irq_create_affinity_masks() - that is where the managed flag is set -
> > that is actually being used. The road seems dead in
> > devm_platform_get_irqs_affinity() which has no in-tree user.
>=20
> # git grep -nH irq_create_affinity_masks drivers/
> drivers/base/platform.c:424:    desc =3D irq_create_affinity_masks(nvec, =
affd);
> drivers/pci/msi/api.c:289:                              irq_create_affini=
ty_masks(1, affd);
> drivers/pci/msi/msi.c:405:              affd ? irq_create_affinity_masks(=
nvec, affd) : NULL;
> drivers/pci/msi/msi.c:695:              affd ? irq_create_affinity_masks(=
nvec, affd) : NULL;
>=20
> These three PCI ones are all going through pci_alloc_irq_vectors_affinity=
()
>=20
> # git grep -nH pci_alloc_irq_vectors_affinity drivers/
>=20
> drivers/net/ethernet/wangxun/libwx/wx_lib.c:1867:       nvecs =3D pci_all=
oc_irq_vectors_affinity(wx->pdev, nvecs,
> drivers/nvme/host/pci.c:2659:   return pci_alloc_irq_vectors_affinity(pde=
v, 1, irq_queues, flags,
> drivers/scsi/be2iscsi/be_main.c:3585:           if (pci_alloc_irq_vectors=
_affinity(phba->pcidev, 2, nvec,
> drivers/scsi/csiostor/csio_isr.c:520:   cnt =3D pci_alloc_irq_vectors_aff=
inity(hw->pdev, min, cnt,
> drivers/scsi/hisi_sas/hisi_sas_v3_hw.c:2611:    vectors =3D pci_alloc_irq=
_vectors_affinity(pdev,
> drivers/scsi/megaraid/megaraid_sas_base.c:5943: i =3D pci_alloc_irq_vecto=
rs_affinity(instance->pdev,
> drivers/scsi/mpi3mr/mpi3mr_fw.c:862:            retval =3D pci_alloc_irq_=
vectors_affinity(mrioc->pdev,
> drivers/scsi/mpt3sas/mpt3sas_base.c:3390:       i =3D pci_alloc_irq_vecto=
rs_affinity(ioc->pdev,
> drivers/scsi/pm8001/pm8001_init.c:982:          rc =3D pci_alloc_irq_vect=
ors_affinity(
> drivers/scsi/qla2xxx/qla_isr.c:4539:            ret =3D pci_alloc_irq_vec=
tors_affinity(ha->pdev, min_vecs,
> drivers/virtio/virtio_pci_common.c:160: err =3D pci_alloc_irq_vectors_aff=
inity(vp_dev->pci_dev, nvectors,
>=20
> Not a so dead road :)

Grml... I definitely fat-fingered the query. Anyway, this housekeeping
API still seems very boot-time oriented to me. Can't see yet where this
housekeeping cpumasks are filled up by the cgroup/cpuset infrastructure.

cgroups/cpusets don't care about "isolation" in that sense yet. It's
just about cpumasks for compute. Am I missing something?


Florian
