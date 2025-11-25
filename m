Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAB2315D33
	for <linux-rt-users@vger.kernel.org>; Tue, 25 Nov 2025 11:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764071416; cv=none; b=fqwGwqzNmgixRdpGf1kUzhytLUZMUrWqk3mlk5iwKkIBx/cIstW0j3FXrWL8laXC3CYJZZcqsOeGjLI1bm1uK4dqmU2Y+q8McsKarC5dM+72Ocir9uH5Cz4c++dxFnxePn0b+9yPVcz8QCFgZWusD88xypaBib50FMDqB5Y1TfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764071416; c=relaxed/simple;
	bh=RdgaI9xnQgTkOLjm4s4aEPNh5q7spfN35W2Oaen9+UM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FRPw/XgaozQHub3U0VN7MIhFm7ZMdqzfOq0fRyPBDjGpDD7kmzz1OP+F2MnXcijqmAEcCOI2MsFCGeUvEuL5xAFoG5s4LuC2hLh5BRfpTUf56wDA7jXtG+FC6ebJRbcMg2m5dw4cBzgOtFDOSwOgsWcWzCwkJ5nJMi3mgs6N9sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ntuiy2le; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5R42N7df; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ntuiy2le";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5R42N7df"
Date: Tue, 25 Nov 2025 12:50:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764071409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DY7r9Cxa0yxiTtUEJHH+QVIBWnKQ+OLhnrHPaI1ZZmQ=;
	b=ntuiy2leAdUk5gy9/wa6Hw4BlemeM9nl3lTO705xp4FKTqQAvI7WsyyapUM7gCC+/oMgMC
	qG3xzTyw2YyYaTS46rigJBq6J77TjT4xEAjngwpP9wHqa7uJUKix9d5mqm8WEBYoHIkYdu
	ZUty2T/W5XzSL719R6Uoi0uMM+L/5ipyLxk2kwCnQTwrP1cva3kP/xfUIYktmUIGUPPIqi
	eqnC6ac83cfT6G+B+Ebm7o1J/oZ7fLpuO5yc7k3h7NPhO6B1upXR+8m8Ynl1CRwCQGXSPX
	0YmKcWQhuJd5/raRbwuA89ndh7BmQt7Dbel3eUTt2DPHleQ7A9CYmtH/GljX2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764071409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DY7r9Cxa0yxiTtUEJHH+QVIBWnKQ+OLhnrHPaI1ZZmQ=;
	b=5R42N7dfi6l1dsCZ/OABuutwh8dUf349/xdi4S2MhNyRpHI6aCyI1/ULfLMxC/xiDc8RhI
	RznJhYw+5tTWKzDQ==
From: "bigeasy@linutronix.de" <bigeasy@linutronix.de>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: "Preclik, Tobias" <tobias.preclik@siemens.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"Kiszka, Jan" <jan.kiszka@siemens.com>
Subject: Re: Control of IRQ Affinities from Userspace
Message-ID: <20251125115008.-R5m5dX9@linutronix.de>
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
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <387396748522d2279c3188e5c2b4345bc2211556.camel@siemens.com>

On 2025-11-25 12:32:39 [+0100], Florian Bezdeka wrote:
> > It seems that if you exclude certain CPUs from getting interrupt
> > handling than it should work fine. Then the driver would only balance
> > the interrupts among the CPUs that are left.
>=20
> Sebastian, what exactly do you mean by "exclude certain CPUs from
> getting interrupt handling"? I mean, that is what we do by configuring
> the /proc/<irq>/smp_affinity_list interface.

Step #1
- figure out if isolcpus=3D is restricting the affinity of requested
  interrupts to housekeeping CPUs only

Step #2
- Yes
   =3D> look for the matching knob in cgroup interface
      Knob found?
      - Yes
        =3D> Use knob.
      - No.
        =3D> Add knob.
- No
  This should be added as it breaks the expectation of an isolated
  system.

I *think* the driver should request as many interrupts as there are
available CPUs in the system to handle them. The number of available
CPUs/ CPU mask should be a configure knob by the user. Using the
housekeeping CPUs as a default mask seems reasonable.
The question is what should happen if the mask changes at runtime. Maybe
a device needs to reconfigure, maybe just move the interrupt away.
But this should also affect NOHZ_FULL workloads.

> To sum up:=C2=A0
> - The IRQ balancing issue is not limited to a single driver / subsystem
> - The managed IRQ infrastructure seems very "static" so insufficient for
>   this problem. In addition we would have to migrate all affected
>   drivers to the managed IRQ infrastructure first.
>=20
> We would love to hear further thoughts / ideas / comments about this
> problem. We're highly interested in fixing this issue properly.

If the "managed IRQ infrastructure" would help here then why not. Maybe
Frederic has some insight here.

> Thanks for all the comments so far!
>=20
> Florian

Sebastian
