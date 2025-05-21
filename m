Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5029D23875D
	for <linux-rt-users@vger.kernel.org>; Wed, 21 May 2025 08:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747816835; cv=none; b=pKqWHmmNTe5Ot0DkY3gkBFr5RLXAru7QRyyTMVlpPPYlSMmEylZgYr675qY0uSSso5dToeyTkWKg0SkDqauO+PqItO/RsEATizFzi/W2U6WfTZob5UelVEoHuUnHlwQq52ICClt3X3lGSCSKIYBKb7VdceGpf42vYSZorGCYQlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747816835; c=relaxed/simple;
	bh=l7JPDlciFZTc3wmjUD7Jo5vMjuNes61PDIg4rNk7pP0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OBpkibV1DHPDZ0TVDd+zWnI8iQ94yJlBsE1f05ymq8PGQrFB+VeZFoDdtaa0SVjBl9s4BM3BOk3v+PYPp/4EF3DSaC2mThU5Lw5pkZdipXch2f3O6u6rjiIF1nJn/zs2pMse6C8sE+nAkg4f4eGIjgcrMsnUBT2dPmUt1twQw74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BBno6TVQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6cpsmsOX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BBno6TVQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6cpsmsOX"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747816832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nZIg26aSKsORTY7cye4DHs4CsbgJw3guIXZBcjRTzSg=;
	b=BBno6TVQbZh27PJsBCzMAjUZuoJo7qKLJUbj+ZHSwk2KLZnW6BG4J18trS2SBvHjwsvlit
	DXQtTE0y/H8DJxorH0fFM80iB/bbZPdvPs5Yimlwfc+aAoJWRs/PST8n9jsCGcF+RWnHs1
	KmBr36+chN/Pma/Hc3QsHoVlBDzEFAm0Tb842zBsLonBVcQNfPSwq6tDCPEJFsFIjKHMfk
	ZhtGrrx5uqKN3kKu5hridFUzcd7/uGa6L0wsBGBGSTdqmEOe3fW6MEKr+oGI2KGDe5nPML
	XYVDwl+pitolkGtYzJ1aIm6hXUNKULlyfv+anNozFLE2eJdyPu3bxTqVXVH3Ig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747816832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nZIg26aSKsORTY7cye4DHs4CsbgJw3guIXZBcjRTzSg=;
	b=6cpsmsOXNxndp6Wgh4a1DyOq+GN8AhTham2Job5ydf8ahOtV1A59fICdji3uX73+orHWK7
	KtaPz3ZGINXAB5Dg==
To: Leonardo Bras Soares Passos <leobras@redhat.com>
Cc: Clark Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>,
 rt-users <linux-rt-users@vger.kernel.org>, Sana Sharma
 <sansshar@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [RFC PATCH] cyclictest: Add skip_sec option
In-Reply-To: <CAJ6HWG7d-1SqOh=H62Ycrx_owziO_CzEvPKMNgsqeWC5b139Bg@mail.gmail.com>
References: <20250520035641.533706-1-leobras@redhat.com>
 <84msb7g2sr.fsf@jogness.linutronix.de>
 <CAJ6HWG7d-1SqOh=H62Ycrx_owziO_CzEvPKMNgsqeWC5b139Bg@mail.gmail.com>
Date: Wed, 21 May 2025 10:46:32 +0206
Message-ID: <84v7pu9x1b.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Leo,

On 2025-05-20, Leonardo Bras Soares Passos <leobras@redhat.com> wrote:
> On Tue, May 20, 2025 at 4:35=E2=80=AFAM John Ogness <john.ogness@linutron=
ix.de> wrote:
>>
>> On 2025-05-20, Leonardo Bras <leobras@redhat.com> wrote:
>> > When running cyclictest with break trace (-b) option, wait for skip_sec
>> > seconds before issuing the break.
>> >
>> > Cyclictest may present high latency on the initial cycles, which can be
>> > caused by initial resource allocations, and may not represent the
>> > expected latency for the running workload.
>>
>> If cyclictest is programmed correctly, this will not happen. Can you
>> provide a technical explanation for high latencies on initial cycles?
>
> We are currently investigating the source of this latency, but I heard
> from other team members it's also happening on Intel Secure VMs as
> well.
>
> Scenario:
> Host: ARM64, kernel-rt, 120 out of 128 cpu isolated, hugepages for guest
> KVM Guest: kernel-rt, 120 vcpus pinned on above isolated cpus, 116
> vcpus isolated on guest
>
> Cyclictest runs with trace-cmd attaching to a guest agent:
>
> trace-cmd record --poll -m 1000 -e csd -e sched/sched_switch -e timer
> -e irq_handler_entry -e irq_handler_exit -e tick_stop -e
> ipi_send_cpumask -e ipi_send_cpu -A 3 -e csd -e sched/sched_switch -e
> timer -e irq_handler_entry -e irq_handler_exit -e tick_stop -e
> ipi_send_cpumask -e ipi_send_cpu bash -c "ssh $my_guest 'cyclictest -m
> -q -p95 --policy=3Dfifo -D 2h -i 200 -h60 -t 116 -a 4-119 -b 50
> --mainaffinity 0,1,2,3 --tracemark'"
>
> What we see is a peak of >50us in the first couple cycles, and then a
> max peak of 15 in our tests.

I wonder if this related to cache misses and/or memory bandwidth. If you
keep this patch but you increase the interval, do you see >50us during
your tests? For example:

    -i 10000

If so, your "max peak" of 15us is only valid when cache hot.

IMHO whatever situation is happening for the "first couple cycles" could
happen later. In that case, the patch is just sweeping some of the bad
numbers under the rug. It is really important to understand exactly what
the problem is before changing cyclictest to ignore such problems.

John
