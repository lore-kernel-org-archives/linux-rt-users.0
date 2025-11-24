Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A6D2F690E
	for <linux-rt-users@vger.kernel.org>; Mon, 24 Nov 2025 09:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763978363; cv=none; b=LGY3LU4jFxcAjTePlJRseKm5zvxS4pbdEqdW3nMUqxa1ZZ+vjBjHekshBAcGxzLBpYuZeeoIuWuwerf6OOkSWDFpH9qSkUd3wnEArqNQ8fl/PJyFMVU5bSbAVm77onwvEFKJtwAzyH73235gmnEGpC9RY7KAK9AS0z+VgVonRVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763978363; c=relaxed/simple;
	bh=5T4dPNZ40LmxMDCHmGzQqPS5WA1aPWE5okCkK3jWQX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lquf0632VQ2n9xOizO3RM3soMdxVxoqtHlq8GNWVN6BsOlS8XKSvXRp4hO8za1/VK2La8DEK9ZEeC+AFcHlcMbFb0XgbV1TtH1rIy6XQjy0I0V+0tRf5XOZK7aA0m9SiVoMzpUOyTQGgpFPzlV07PS3PZqePW1Jyv8sl1DSTefg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pTkcKtJA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TBajPxZ/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pTkcKtJA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TBajPxZ/"
Date: Mon, 24 Nov 2025 10:59:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763978360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qw+8ZlN9OgPPUXXmIxzF2YXDnlFhnlq6Vc2cVjDYqSI=;
	b=pTkcKtJAUxxaQlqSx18/wEmf8oeQsursBxOFnevjW8aADOWjAd3SVXhIujGJAwx7qMJGS6
	9L/la/LfWyOJZr+hfeiXDNDsm4cBiyRrOVaFxt14xA8qLq/js4jHa11glol8BGWeWMgYAn
	73BBorLGtR65H6l/ld3ZHEA1LOzCZItk/vH75QlyfgnDAoz05cV1KmOA39wt8wW0aZvdtQ
	eJl2LLl0rmiB8mnTJ5E8/JJOUlZuVofK53arLEsu/J3eBenTLcxpj1aWJk1frF3J/7O2b4
	xMt4rUb/uFA4LQys9I8ShUwUT5ap5Keh7wjoBo78HjYgwhzQNhLgE2Ovw9Zl/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763978360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qw+8ZlN9OgPPUXXmIxzF2YXDnlFhnlq6Vc2cVjDYqSI=;
	b=TBajPxZ/0N1pSCtnq4FuU6x1nZWzwteuZVYVhDp0IvW5YBmEPizrkek8qR9iWAiYO76jKC
	2UlF6CEGeGs2KeDA==
From: "bigeasy@linutronix.de" <bigeasy@linutronix.de>
To: "Preclik, Tobias" <tobias.preclik@siemens.com>
Cc: "Bezdeka, Florian" <florian.bezdeka@siemens.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"Kiszka, Jan" <jan.kiszka@siemens.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: Control of IRQ Affinities from Userspace
Message-ID: <20251124095919.V73BtuvW@linutronix.de>
References: <a0cad8314124ca98d7c6763e3e08d7192598cf92.camel@siemens.com>
 <20251103155322.Aw9MSNYv@linutronix.de>
 <3cbc0cf5301350d87c03b7ceb646a3d7c549167b.camel@siemens.com>
 <6523960abaff2054ed25bf57b2a12e381f305a3e.camel@siemens.com>
 <20251111143456.YML0ggA7@linutronix.de>
 <cce633df665f167291d975c0c13dab990e267384.camel@siemens.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <cce633df665f167291d975c0c13dab990e267384.camel@siemens.com>

On 2025-11-21 13:25:09 [+0000], Preclik, Tobias wrote:
> > I would be careful with the deprecated term here. The functionality
> > is
> > not deprecated just the interface is. The CPU affinity has been
> > migrated
> > a cgroup based interface. If the matching irq affinity is missing
> > then
> > it should be added rather than avoiding the whole "affinity is
> > managed"
> > interface since this looks as it has been meant for your use case.
> >=20
>=20
> As you point out isolcpus interface is deprecated and it seems there
> exists no way to translate the managed_irq flag of the isolcpus
> interface into the cgroups based interface. My understanding is that

I did not point out anything. I just suggested to test whether this
option is working for you and if it does, check if there is matching
configuration knob in the cpusets/cgroups interface. As per=20
   https://www.suse.com/c/cpu-isolation-practical-example-part-5/

in "3.2) Isolcpus" Frederic says that the options should be used if the
kernel/ application "haven't been built with cpusets/cgroups support".
So it seems that this bit is either missing in the other interface or
hard to find.

=E2=80=A6
> > > The conclusion got lost:
> > >
> > > Other drivers like for example igb respect the interrupt affinities
> > > (both default and per-irq affinities). This leads me to believe
> > that
> > > the irq rebalancing in the drivers should only affect the effective
> > > interrupt affinities. This admittedly is more involved than it
> > appears
> > > at first because the interface interrupts would have to be balanced
> > > subject to multiple (potentially totally different) cpusets.
> >=20
> > Exactly. Maybe it would work to align the driver with what igb does.
>=20
> Currently, stmmac sets IRQ affinity and hints for all IRQ
> configurations. But on x86 systems with IOAPIC MSI-X vectors should be
> automatically balanced. If we remove the driver-based irq balancing
> then other architectures would not necessarily balance the interrupts
> anymore and would be impacted in terms of performance. Maybe driver-
> based irq balancing could be deactivated whenever the underlying system
> is capable of balancing them? That would of course only reduced the
> number of affected systems.
>=20
> In general I lack information when drivers should (or are allowed to)
> balance interrupts on driver level and whether smp_affinity is allowed
> to be ignored and overwritten in that case. All documentation I have
> found so far remains rather unspecific.

It seems that if you exclude certain CPUs from getting interrupt
handling than it should work fine. Then the driver would only balance
the interrupts among the CPUs that are left.

> Tobias

Sebastian
