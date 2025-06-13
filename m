Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4785115573F;
	Fri, 13 Jun 2025 14:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749826480; cv=none; b=r6ymeWqUIqGA8Rjj7otO7KbKDNQWfpyJBv51tnwx2huYpZTeGtpsUniXTagwJmbub2g/vsrjg+eJbGxLil49p9aZU3va8DSR9sMVsW6+IENNY915xFj1T678JNSbC5A6K7sHgoXobu4yQt8BdFVV8uH67qLnthC1ytp09pdbAVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749826480; c=relaxed/simple;
	bh=HINBjh/f4wDEC+TsMpSPMskJo5DvoYsxBTVJ6SzjUBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vliy6HxzSpw2TbUjBkPvxi0yrF8lTvg/IRs5KeGCJ2t5vm8QNcajh+BwyfZBMX8S9G3iLyixDOyIzeFKPGFWiwRzwJprhjd9iVFUVuo1GO6E/nal8HyjaFvHaNl9n5zYTMN5J/oJHgQ5In/Y2u0CrNz+w7G/VOd4eK5CT+uvQo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oyU8Moeb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0GYAM/3a; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oyU8Moeb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0GYAM/3a"
Date: Fri, 13 Jun 2025 16:54:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749826476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UCgNyye0M5YlG5NmnZwHEEWDQzhX8B00XQ+oHNnuIUU=;
	b=oyU8MoebGpq/R3iMgUVafJtAEsb9P557A0iORlS/dJI72zIN4TrWAwdJAtSYoHaAQk8N+v
	w28d+Y0mtgPLK90FPMoBJPRI89hHbvhh920vLgySRYVuOiio/MqXa+oz3Z6Tdkw6HZpx8C
	ld7SUpGSAt399vTh29eZ55UOIQIvyjf9Ez+k4MJij/91ZS+wguTbxnxLlLXvPnDxUuOUEe
	3Q+metjbiye9B8etwJ437a94eNzqmiLRgA+ZaGb964HKpTuDPm4E8fdgJ/GOdrNDAXIHy6
	r4ZpW6jtnbu699BETygIlClbiguxI24D6WEU3rJbLTFTC1tq6eg5ZyYTLfFvkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749826476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UCgNyye0M5YlG5NmnZwHEEWDQzhX8B00XQ+oHNnuIUU=;
	b=0GYAM/3awel+LSlkSj40gYMyxveX/JYMnZkFztKf1o3erEzycoPwxY8mp6afTVmrSTcEj6
	9dTYQB80soPTcEBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Marc =?utf-8?Q?Str=C3=A4mke?= <marc.straemke@eltropuls.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: Latency spikes on V6.15.1 Preempt RT and maybe related to intel
 IGB
Message-ID: <20250613145434.T2x2ML8_@linutronix.de>
References: <cb0d6ffc-acb3-4974-8f93-c86a6479109b@eltropuls.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <cb0d6ffc-acb3-4974-8f93-c86a6479109b@eltropuls.de>

On 2025-06-10 13:23:13 [+0200], Marc Str=C3=A4mke wrote:
> Hello Everyone, I am reposting to LKML as I am not sure the rt-users
Hi,

> mailinglist is read by many people, (I hope that is okay)
>=20
> On an AMD Ryzen Embedded machine I am experiencing strange Latency spikes=
 in
> cyclictest and need some hints how to debug that further.
>=20
> The system typically has max latencys of=C2=A0 88 us and averages of 4-8 =
which is
> more then sufficient for my application, but I saw some spikes of many
> hundred us in testing.
>=20
> I can provoke latenciess of more then 500-1000 us by invoking "ip l set
> enp1s0 promisc off" on the first network interfaces. The network interface
> is an "Intel Corporation I210 Gigabit Network Connection" using the IGB
> driver.
>=20
> I tried more or less all tracers but am not knowledgeable enough to make
> sense of the output. IRQSoff and wakeup_rt trace output attached.

I'm not sure what your two traces captured. The irqsoff_trace captured
208us and this looks like a regular top of the run_ktimerd() invocation.
There is not much going on.

wakeup_rt_trace shows the wakeup of cyclictest. It records 411us. Most
of it is scheduler itself with some 100us from
flush_smp_call_function_queue().
=20
> Can anyone point me in the right direction? I am not sure how to interpret
> the function tracers and function_graph tracers output in a meaningful wa=
y.
> As mainly a user of of the kernel I am a bit overwhelmed by the interacti=
on
> of the scheduler, RCU and so on..


Could you please try one of the following:
- enable sched tracing events and tell cyclictest to break & stop
  tracing? The options for cyclitest would be -b --tracemark.
  The idea to see the scheduler events before the delay happens. So your
  latency spike is 500us then you can try -b 490 or so.

- use rtla. This might be easier and give you the backtrace of what you
  are looking for
  	https://bristot.me/linux-scheduling-latency-debug-and-analysis/

> I have attached my config for reference.

There is nothing wrong with it. You might want to disable NO_HZ (and use
PERIODIC) and use HZ=3D250 (or less)=20

> Kind Regards
>=20
> Marc
>=20

Sebastian
