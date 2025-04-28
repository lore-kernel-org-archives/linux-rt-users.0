Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28CF13FD86
	for <linux-rt-users@vger.kernel.org>; Mon, 28 Apr 2025 09:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745833417; cv=none; b=R/4DjuRnE67SfKX6ocp46NHNqAU+tjrzpauCFBYo3S4emBXALR/541M5s1ls4JEvpaG3lqaSOEahZC4d/bt13nY5eKRcfqnmdPKkuhy8WNaOraExa6pKo9I31pBSUuFJAnTUJsJWziDuGyUVXoy6OaD0846l5aN/ryAnfpAZZZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745833417; c=relaxed/simple;
	bh=Ws8OuO69eJ5HoRrsf9K263+4gn57np0gxkcYzAi3RC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dd+qELBslYrr1ZDLNinzStUSVCdVqBV/o9UcY3Kf0IHCan+ZeAIoaa8lJdwqJBAhCthrjSWKNbu40jWgVzoSWQpfmAuotv/EVSzOh4Kaq/HWd4XolwlVoY5FMAnin7bbw+OoMg0gjgZa4bodeFAWjOq/aQz/Dc1+IZDJSfJumDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yyCTct7b; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gK72hiHh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yyCTct7b";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gK72hiHh"
Date: Mon, 28 Apr 2025 11:43:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745833414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G6pgXnAEC+1w7gK5wTvOmFh3M3FQlRLaRfNE2Esci+0=;
	b=yyCTct7b9V642JDHUkocqStc7TSRuXuMV66CCJdrYly6ZDdX0QPR1++uAjCaraU12sg3f2
	t96nMUy7DRTI7N3MckSOeGYy50iwKcVv2BNumPEg3v6lYFfxVno4gghvjM9znTZUGwChOp
	OpQm0ty76LeecBzJdA2u4XtJdVbelik1P5mr/8okfZKoUQP7k7hlNbEKQsuWHWFYqHHAvw
	5MoiYi9JWqCW7TilfU5aeUoVsbx+q/aqQbS20UrS/b9xOON5ffEiJbWOeD/Y+6MhB1hVbk
	FZsv46Vz61UiYxG9Bosa6qikyOgLO8WltQ+bbIrDvKKcMU1LFhZg7/I6lR+b7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745833414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G6pgXnAEC+1w7gK5wTvOmFh3M3FQlRLaRfNE2Esci+0=;
	b=gK72hiHhpABrHc0u6TSP6f4DRtIVszmH1EA3qttx7GAgGGn6TQsSkwlJUrXRtAvizo0c4S
	XJVKn+0mkvDSVgAA==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: Sheng Liu <liu.stor@gmail.com>
Cc: linux-rt-users@vger.kernel.org
Subject: Re: How can an RT application know if it is running in nohz_full
 mode?
Message-ID: <aA9NxBprfXuLJ0I1@lx-t490>
References: <CAPJipUVDP2sT3cwj_K-tB1-Zpmc0uGKsg=9=qxbj3SaQmo+T_w@mail.gmail.com>
 <aAy05nSkkqRJ8HXu@lx-t490>
 <CAPJipUX_2gDEMt9VtTdP6GSvYRH9GnTLBRDSe019Yd0szMmXqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPJipUX_2gDEMt9VtTdP6GSvYRH9GnTLBRDSe019Yd0szMmXqA@mail.gmail.com>

Hi Sheng,

On Sat, 26 Apr, Sheng Liu wrote:
>
> On Sat, Apr 26 PM Ahmed S. Darwish wrote:
> >
> > On Fri, 25 Apr, Sheng Liu wrote:
> > >
> > > Would it be feasible to add a variable in procfs, which can be read by
> > > other programs and notify the RT process throught a shared memory flag.
> > >
> >
> > This is overly-engineeded with no extra benefit.  A simple cgroup setup
> > and some basic /sys/fs/cgroup/ file reads should do the job just fine.
> >
...
> > Both "cat"s should print something like:
> >
> >     0::/rtisolated.slice/isolated-shell.service
> >
> > which can be easily done and verified from any C code as well, before
> > starting the RT loop (where multiple initiatory steps need to be done
> > anyway).
>
> According to the kernel documentation (e.g.
> Documentation/timers/NO_HZ.txt), The only runnable SCHED_FIFO task in
> adaptive-tick mode can run continuously until they voluntarily release
> the CPU.
>
> However, in practice, just because a task is running on an isolated CPU
> doesn't mean the CPU is free of interrupts.  Even if only one task is
> running on an isolated CPU, it may still be interrupted by delayed
> work. User programs cannot know if there are future timed events on the
> CPU.
>

IMHO, you're conflating two issues here:

  (a) How can an RT process "know" it's run on the isolated CPUs
  (b) Proper kernel configuration for such isolated CPUs

I was merely answering (a).

That is, how to use CGroups so that your RT application is forced (in a
clean way) to run on the correct CPUs and how can the application
(cleanly) verify that, where such verification can be done in the
preparation code usually required before invoking the RT event loop.

Regarding (b), kernel configuration for the isolated CPUs, it's a whole
different topic.  There's nothing stopping you from further configuring
the isolated CPUs, exclusive to that 'rtisolated' cgroup, through nohz
kernel parameters and other means, in any way you want.

This, I belive, completes your subject line question:

    How can an RT application know if it is running in nohz_full?

Now, regarding:

>
> However, in practice, just because a task is running on an isolated CPU
> doesn't mean the CPU is free of interrupts.  Even if only one task is
> running on an isolated CPU, it may still be interrupted by delayed
> work. User programs cannot know if there are future timed events on the
> CPU.
>

The kernel controls the isolated CPU, not the SCHED_FIFO task.

So, beyond measuring latencies from within the application, the RT
application itself can /not/ "know" anything about the total kernel
behavior on the isolated CPUs.

The system configurator, need to ensure that, and then verify the sanity
of such RT system configuration later with the appropriate tools.  How to
configure the system properly for that is discussed at multiple
conference talks.  A quick "John Ogness real time checklist" search,
along with talks by Rostedt, can give some nice pointers to start with.

Hope this helps a bit.

Good luck!

--
Ahmed S. Darwish
Linutronix GmbH
