Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0641FC7C5
	for <linux-rt-users@vger.kernel.org>; Wed, 26 Nov 2025 15:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764171941; cv=none; b=abkx3ACy7655oMk3ANR4VnbiKhHwEnER0Izpvz3irZ8oTjNad/Bm+8J+xNgejXeUQIf4YTSGFZSWjMG1XFSDln10TTvlv9qsWJFltcHOR7fnyIUGaacKQvjDNcddpmWO80vUKyHTC1PX4f9UUfLDXAg8oo3PFLW9wV/3t5YbXPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764171941; c=relaxed/simple;
	bh=Z3uxgPMorVr2itfskY4BHKdGRubFYxJSM/RKKGm3x8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yg20XL3QL4RPNpu2xt9NfRIospKfZNzRQ4RoTW5vue5wBjfpbs0sZABonGis5iEh68QwnHdbb783WnMvrGaK/pLHJfQZwqlK45h6pOMGtDC9x5hApfh+a9/F+XrANYBGcX22qAl2hWLpZleHkqIuB6b+PZN8QUrZPlBLs1EtUJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cA05fXre; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cA05fXre"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6099C4CEF7;
	Wed, 26 Nov 2025 15:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764171941;
	bh=Z3uxgPMorVr2itfskY4BHKdGRubFYxJSM/RKKGm3x8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cA05fXreaFzmJELo7tkDCQHN1CoYGzMyyz+MJ+VeHlZzfGU+DF4wncbgU00Zgky/i
	 HaI7xpLngQuiSCJRogkem61fRP5Th23VpgGy4TDGkQAiKVotCXA/MW+0qOcn3t1+oD
	 4PcE6J94XZasH9C5DZDwnGWa583wZlbAQz46IYdPen08TyUhV1eeybopF1j8uoY4+/
	 O3pX4lyLopqIZP3hFvthp6EyK9mopEC5n7FQsd6w8RnMIXJ+PyW8KDDeG/L/Mmgu0V
	 XGWmSxUsOIa+LQAuyY5yBus81NNMdhDbTYPSDaOJ6+e7HzXozKHGoCAKS3LmwvEEpr
	 1N3kFTm2lVvdw==
Date: Wed, 26 Nov 2025 16:45:38 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	"bigeasy@linutronix.de" <bigeasy@linutronix.de>,
	"Preclik, Tobias" <tobias.preclik@siemens.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"Kiszka, Jan" <jan.kiszka@siemens.com>
Subject: Re: Control of IRQ Affinities from Userspace
Message-ID: <aScgovATTqcdPmYB@localhost.localdomain>
References: <3cbc0cf5301350d87c03b7ceb646a3d7c549167b.camel@siemens.com>
 <6523960abaff2054ed25bf57b2a12e381f305a3e.camel@siemens.com>
 <20251111143456.YML0ggA7@linutronix.de>
 <cce633df665f167291d975c0c13dab990e267384.camel@siemens.com>
 <20251124095919.V73BtuvW@linutronix.de>
 <387396748522d2279c3188e5c2b4345bc2211556.camel@siemens.com>
 <20251125115008.-R5m5dX9@linutronix.de>
 <767a8c7c1c88d930c5e7d7b39e7081c3cb39a08c.camel@siemens.com>
 <87tsyigjkc.ffs@tglx>
 <4de393b9304c99386d847ed0694ec12075a99c0a.camel@siemens.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4de393b9304c99386d847ed0694ec12075a99c0a.camel@siemens.com>

Le Wed, Nov 26, 2025 at 10:20:53AM +0100, Florian Bezdeka a écrit :
> > drivers/net/ethernet/wangxun/libwx/wx_lib.c:1867:       nvecs = pci_alloc_irq_vectors_affinity(wx->pdev, nvecs,
> > drivers/nvme/host/pci.c:2659:   return pci_alloc_irq_vectors_affinity(pdev, 1, irq_queues, flags,
> > drivers/scsi/be2iscsi/be_main.c:3585:           if (pci_alloc_irq_vectors_affinity(phba->pcidev, 2, nvec,
> > drivers/scsi/csiostor/csio_isr.c:520:   cnt = pci_alloc_irq_vectors_affinity(hw->pdev, min, cnt,
> > drivers/scsi/hisi_sas/hisi_sas_v3_hw.c:2611:    vectors = pci_alloc_irq_vectors_affinity(pdev,
> > drivers/scsi/megaraid/megaraid_sas_base.c:5943: i = pci_alloc_irq_vectors_affinity(instance->pdev,
> > drivers/scsi/mpi3mr/mpi3mr_fw.c:862:            retval = pci_alloc_irq_vectors_affinity(mrioc->pdev,
> > drivers/scsi/mpt3sas/mpt3sas_base.c:3390:       i = pci_alloc_irq_vectors_affinity(ioc->pdev,
> > drivers/scsi/pm8001/pm8001_init.c:982:          rc = pci_alloc_irq_vectors_affinity(
> > drivers/scsi/qla2xxx/qla_isr.c:4539:            ret = pci_alloc_irq_vectors_affinity(ha->pdev, min_vecs,
> > drivers/virtio/virtio_pci_common.c:160: err = pci_alloc_irq_vectors_affinity(vp_dev->pci_dev, nvectors,
> > 
> > Not a so dead road :)
> 
> Grml... I definitely fat-fingered the query. Anyway, this housekeeping
> API still seems very boot-time oriented to me. Can't see yet where this
> housekeeping cpumasks are filled up by the cgroup/cpuset infrastructure.

It's on the way:
https://lore.kernel.org/all/20251105210348.35256-1-frederic@kernel.org/

If all goes well, not for the upcoming merge window but the next one.

> cgroups/cpusets don't care about "isolation" in that sense yet. It's
> just about cpumasks for compute. Am I missing something?

It's a bit more than just scheduler domain isolation. It also handles
kthreads and workqueues. It's also going to handle unbound timers (on the way
to the upcoming merge window).

Thanks.

> 
> 
> Florian

-- 
Frederic Weisbecker
SUSE Labs
