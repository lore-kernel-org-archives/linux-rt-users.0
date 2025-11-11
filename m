Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4D82C2357
	for <linux-rt-users@vger.kernel.org>; Tue, 11 Nov 2025 14:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762871703; cv=none; b=lqEjq8QAZgOWrqK3CbfrqD2bAwr0i1zvV1jAqbn+4NGgNDg7YsKacdDOIf+mjkM/Nyd4UwaYL/MLzaIGRjuISFdF/aFaF1ZRwkacTcE6BMg8zmLsGa8F+Fng8AoHFVbnGmO3z0cGVFDAb4ysRR8QQYlCSncf2I7Fj+dx4NDbLYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762871703; c=relaxed/simple;
	bh=L/WGK32KNRJoV/15/0oIViMc/YHmtMIpKmmrvIN0XSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EYcm8pRAR2HeDn3qwTaFYl+JZiGAD/S63fBNV5MfBz6yWvuArxNFO+9hP6HOXH+JvSIfq6tinarLWLw4GgsQJyWqkYmGcOJqtbZhjDcIXyWWtKaO1UPnZByOXsZiddNVYcTmKKbePmTTtp+CEeKW3oxlJbcH4LYjumN5W47eL98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Vfr4mmU/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Js3ETRSB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vfr4mmU/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Js3ETRSB"
Date: Tue, 11 Nov 2025 15:34:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762871699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L/WGK32KNRJoV/15/0oIViMc/YHmtMIpKmmrvIN0XSc=;
	b=Vfr4mmU/0HqJyChEywwXCduDfoNbJ5pmcPAn/cDoD22ishwn5tEghIY62Mx9PJOKid3/5i
	8TjyhOwwKm0YISNcSLu2/etBL6vz+SXmia9AygwP3wxB5CtnC8ayc8xnQnQn6ll6fMtd0k
	BYhm8oO6ORvSbJC8RR269D0CrwK/L9m3YLJkAyMPxQhDa6yL8LQMDSAy4ea6steAv48xd/
	80dcol7V2gVoHnf7LQ1Y0nJxPAHJTOsIzebIAxMOpiNe7u9HuigZ8tru1xNByl3biG2ygx
	2MXkKe8OBDpnl1i/rT9D+xb+G3rz2XGKOTOpG55liJnMDGxReLjuzH1brewvwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762871699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L/WGK32KNRJoV/15/0oIViMc/YHmtMIpKmmrvIN0XSc=;
	b=Js3ETRSBJnxNwlRqQcuBdlbtRuKdgTTnZYpIKtnx4XpUnPC4VBImcPk2rGjuySZ/hE8eba
	laEZZh1+veM0gEDA==
From: "bigeasy@linutronix.de" <bigeasy@linutronix.de>
To: "Preclik, Tobias" <tobias.preclik@siemens.com>
Cc: "Bezdeka, Florian" <florian.bezdeka@siemens.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"Kiszka, Jan" <jan.kiszka@siemens.com>
Subject: Re: Control of IRQ Affinities from Userspace
Message-ID: <20251111143456.YML0ggA7@linutronix.de>
References: <a0cad8314124ca98d7c6763e3e08d7192598cf92.camel@siemens.com>
 <20251103155322.Aw9MSNYv@linutronix.de>
 <3cbc0cf5301350d87c03b7ceb646a3d7c549167b.camel@siemens.com>
 <6523960abaff2054ed25bf57b2a12e381f305a3e.camel@siemens.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <6523960abaff2054ed25bf57b2a12e381f305a3e.camel@siemens.com>

On 2025-11-05 13:11:29 [+0000], Preclik, Tobias wrote:
> > > so if the IRQ is managed and you have IRQ isolation enabled then it
> > > should exclude the non-isolated CPUs. Would that work?
>=20
> For that code path to be taken we would have to specify isolcpus and
> managed_irq on the kernel command-line. However, we already migrated
> away from the deprecated isolcpus parameter. Additionally, we need to
> dynamically change the interrupt affinities while in operation. For
> that matter we have to rely on setting the interrupt affinities in
> procfs.

I would be careful with the deprecated term here. The functionality is
not deprecated just the interface is. The CPU affinity has been migrated
a cgroup based interface. If the matching irq affinity is missing then
it should be added rather than avoiding the whole "affinity is managed"
interface since this looks as it has been meant for your use case.

=E2=80=A6

> Thanks for sharing the details Florian. The discovery of newly
> registered/requested IRQs in userland is indeed an additional problem.
> Still I would say that we can work around it by polling procfs and
> setting the default interrupt affinity appropriately (given that it is
> not ignored by the drivers of course). RT applications might have to
> accept an initial delay until the interrupts on their I/O path are
> detected and properly tuned.

This depends how you sell it. The initial setup of the application/
system might take a small hit until everything is ready and setup for
your workload. I don't know how changing the XDP program fits into this.
Usually I would expect that you setup it once and use it. However if
switching the XDP program makes sense within your real time workload
then maybe the affinity should not be randomly assigned.

> > I tried to modify stmmac and let it evaluate the default affinity
> > while
> > doing the IRQ balancing dance. That turned out to be working at the
> > end,
> > but each line violated several coding/style/abstraction rules. There
> > is
> > no API at driver level to read the current default affinity - or I
> > missed it. I could sent that hack out as RFC if requested. Just let
> > me
> > know.
>=20
> When drivers at least respect the default affinity when rebalancing
> interrupts we can avoid interfering with RT applications. However, we
> must also ensure that specific interrupts which are in use by RT
> applications on their I/O path must remain on the application core.
> Meaning the IRQ rebalancing should also respect the interrupt
> affinities set from userspace via /proc/irq/${IRQ_NO}/smp_affinity.

If free_irq() removes all information about the IRQ then it might also
lose the configured smp_affinity.=20

> Here are steps to explore the behavior and reproduce the issue.
=E2=80=A6
> online cpus ignoring the default interrupt affinity as well as ignoring
> and overwriting the explicitly set interrupt affinities from userspace.

I just compared with igb and here the affinity mask survives. So it is
just this driver that is doing things different. The igb also removes
all interrupts on down. The affinity remains after changing the number
of queues (which changes the number of used interrupts).=20

> Tobias

Sebastian
