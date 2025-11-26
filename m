Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD52F2F99AD
	for <linux-rt-users@vger.kernel.org>; Wed, 26 Nov 2025 14:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764167202; cv=none; b=Vgc7IQXcUjGkGdIDYdNGRHX3GHxUX0V5v4ZDKLCdbZWdlRZCcRIcClE0ey3JE238dlUcrPZ6azS0IaaQYEchnCkpqR2++EO6NcXr8jUzB2YDdg4URoXdqivoay5Vps7fs4nFH6TvDuKqD/KQ6dXnVOECkJNdB0620FSt7IIKJ1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764167202; c=relaxed/simple;
	bh=VMSLyNTUQSvxZEU7uEYSLJn5sQAcgK54q2hupGEFDcI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gy0+L9LY4F036DsrA1N2+osQJtJIRDWGoiqy5qOoPiI3kqaZTz8m5RqDbd+GAUzO9rhrFN58yOpQZotgoxrMthwNc3WDrWcplGYBJCGrQhauFRnMqGEeJ/pVcEorFCT/6S782gziYIj76CnuPIDuI/D35lGRSjQM1IkTlpwKGqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Gyq0i9vA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m2TCAc8o; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gyq0i9vA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m2TCAc8o"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764167198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UBtpltTsd1qRuMeDU8d1IurNPvVIkbqeGQ7oVdDPLOg=;
	b=Gyq0i9vAtappihUsrvL/HtBFkrAJMU9gt76n/8XuPHMF8/rbIEsuWXy/utXtzaggIyIjT7
	qgKn3u2SkFkZtKj+mHzxOc4h89yLkqEnjEIT4NWU3W51+5dScwgAolCYFCYs11OnKf3X7m
	0YS8Vwb86lxU3Yy7TqcxHUlLwpUF+3zsUaaPjDNSLjSqYp64o1nBn8fbA+QSYmmg4Vpyb2
	La1/HBzu9qNPWAr4qHVbtRG2GnJpXguh5aip33hZ8IMuhZjejqTmXUqwaZXqCXez18oqDL
	gZnTfuCyau/yPmpyj1f8CK2S9IWLVCaIMbfAzy4LsXZB8VdEb+6bk6PAE2t59A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764167198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UBtpltTsd1qRuMeDU8d1IurNPvVIkbqeGQ7oVdDPLOg=;
	b=m2TCAc8oUkB8xmCzBeoehRGFBvOPMkHRy/bvFrXhTq2QXFtrPkv7fL9ukkz04giM4+5o9N
	WGUgzJ2iUsEcwCDw==
To: Florian Bezdeka <florian.bezdeka@siemens.com>, "bigeasy@linutronix.de"
 <bigeasy@linutronix.de>
Cc: "Preclik, Tobias" <tobias.preclik@siemens.com>, Frederic Weisbecker
 <frederic@kernel.org>, "linux-rt-users@vger.kernel.org"
 <linux-rt-users@vger.kernel.org>, "Kiszka, Jan" <jan.kiszka@siemens.com>,
 Waiman Long <longman@redhat.com>, Gabriele Monaco <gmonaco@redhat.com>
Subject: Re: Control of IRQ Affinities from Userspace
In-Reply-To: <4de393b9304c99386d847ed0694ec12075a99c0a.camel@siemens.com>
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
Date: Wed, 26 Nov 2025 15:26:36 +0100
Message-ID: <87fra0hntv.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Nov 26 2025 at 10:20, Florian Bezdeka wrote:
> On Tue, 2025-11-25 at 17:31 +0100, Thomas Gleixner wrote:
>> > This question can not be answered with yes/no. It depends. Affinities
>> > are based on the default_smp_affinity during creation. But as it turned
>> > out there are drivers that overwrite those affinities after IRQ
>> > creation.
>> 
>> Which ones?
>
> The problem at hand is the stmmac
> (drivers/net/ethernet/stmicro/stmmac/stmmac_main), which is pulled in by
> a couple of others like the dwmac_intel in our case.
>
> Searching for the problematic irq_set_affinity_hint() call in
> drivers/net/ethernet reveals more "affected" drivers but each of them
> requires some double checking. In some cases the supplied cpumask or the
> "time of the call" might be OKish.

The question is whether that affinity hint has a functional requirement
to be applied or not. I don't think so because those interrupts can be
moved by userspace as it sees fit.

So it's easy enough to make this "set" part conditional and restrict it
to some TBD mask (housekeeping, default ...) under some isolation magic.

>> > The user normally configures the number of HW queues that the NIC should
>> > use. In most cases in combination with some HW packet filters to achieve
>> > best packet separation. IMHO the user should not have to deal with any
>> > (additional) CPU mask on that level. RT tuning will / should handle
>> > that.
>> 
>> How so. The kernel magically knows what the user wants?
>
> We can already identify the IRQs that belong to a certain hardware queue
> (NAPI threads) and move it when necessary. I just wanted to express that
> there might not be a need for an additional API / cpumask.

Ok.

>> Not a so dead road :)
>
> Grml... I definitely fat-fingered the query. Anyway, this housekeeping
> API still seems very boot-time oriented to me. Can't see yet where this
> housekeeping cpumasks are filled up by the cgroup/cpuset infrastructure.
>
> cgroups/cpusets don't care about "isolation" in that sense yet. It's
> just about cpumasks for compute. Am I missing something?

There is work in progress on various related ends:

  https://lore.kernel.org/all/20251105210348.35256-1-frederic@kernel.org
  https://lore.kernel.org/all/20251120145653.296659-1-gmonaco@redhat.com
  https://lore.kernel.org/all/20251105043848.382703-1-longman@redhat.com
  https://lore.kernel.org/all/20251121143500.42111-3-frederic@kernel.org

There is certainly more going on it that area, but those were the bits
and pieces I could remember from the top of my head. Waiman and Gabriele
should be able to fill in some blanks, but that discussion should move
to LKML then.

Thanks,

        tglx

