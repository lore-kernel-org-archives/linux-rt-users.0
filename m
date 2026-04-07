Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A8D2ED141
	for <linux-rt-users@vger.kernel.org>; Tue,  7 Apr 2026 08:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775551567; cv=none; b=nUN8qbZF3+19nZmuc9D+YkLK6tvLoQ7AwSEsHA6EowgOmk+jflSUT51dc5TKbR9Tk7Uq7dOgt0xYjdQUVr3zEFh6hUSNrVocxffKQLMRT9kWX1CCYXZjm3XLvQkC54aKRQaXtQ2jICrbRq734AED5NDJEbC7yBn9mjudRL3bQik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775551567; c=relaxed/simple;
	bh=DM9pvRz27l8Alpjhds+t2xn54epmAm87RVbens6GBg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SD4NncU/TMtZF2DJcTMkrVtbpnjbMyaukMVjsJxvC1EPTSQAxbLKPyRlGwAbQRNfUYZ7iBTs/V+e2yllynUKwr8RpwV1lwe+cW69Fl5dFH+9P6k33BXn4N0VQSq6r1wGOfkZScjLF1Mi4+Ztz+iIa6NaRPFh2eJzjEmpGOAg0Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=srPU194/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=orKaJh9R; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="srPU194/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="orKaJh9R"
Date: Tue, 7 Apr 2026 10:45:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1775551563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gQFXYbB09/jTduCx9l7pnzZELWhTBdgB2isWhvQ5Iww=;
	b=srPU194/LpZ6OnROtgjBJpFSMipeb3Se3uadLRMddT4ZU2RX+HoiCJA7OhtgbcCJeroXvJ
	WszIf8GlJpykYMEMtGMypcTrjIGqtBCpUmCd/H910CkdKj0wG+SZ5Xk1+TYLWFrgqY1Vf4
	26ja85erUrVTQ5p7/IqBTr5Fbt9CEBF0ssO4Ln5Alfn4fAWFJd4YXZsGPB1I6S1yh4UnTi
	nYSW9xeGBTilHYI2+Ctu7voliLgcZRhDdxI/jA/g5ngreNUz8K4EJGRP7MmvdCpZnkBN/+
	Mj0hNjNN7/jY2eYTmPYSoCFe/88zUkRpYl7t0cxxqgLPAGCi38jXm+RY0RmPBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1775551563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gQFXYbB09/jTduCx9l7pnzZELWhTBdgB2isWhvQ5Iww=;
	b=orKaJh9RF7mFa3FydVAisCplBB9Jsks7Q0zTvNGYmUeWCgwtBCqsRg5MU8UMfdElUSVUOb
	DalRN0LvKjegcSCw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Clark Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>, 
	linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 1/6] cyclictest: Centralize clock option parsing
Message-ID: <20260407104207-fec29583-fca9-4ae6-ab2b-20976fd28591@linutronix.de>
References: <20260407-auxclocks-v1-0-1ef80d14eb0a@linutronix.de>
 <20260407-auxclocks-v1-1-1ef80d14eb0a@linutronix.de>
 <578d66745469e6263ba3fd6c7a0ec4d92d4f39d9.camel@siemens.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <578d66745469e6263ba3fd6c7a0ec4d92d4f39d9.camel@siemens.com>

On Tue, Apr 07, 2026 at 10:27:39AM +0200, Florian Bezdeka wrote:
> On Tue, 2026-04-07 at 08:48 +0200, Thomas Weiﬂschuh (Schneider Electric)
> wrote:
> > Currently the lookup of the clockid from the commandline options is done
> > in multiple places. This makes the addition of symbolic clock names and
> > new clocks cumbersome.
> > 
> > Move all of the clock option parsing into a new helper function.
> > 
> > As a side-effect fix an off-by-one error in the validation of the
> > clock command line argument.
> > 
> > The new variable can not be named 'clock' as that would conflict with
> > the libc function of the same name.
> > 
> > Signed-off-by: Thomas Weiﬂschuh (Schneider Electric) <thomas.weissschuh@linutronix.de>
> > ---
> >  src/cyclictest/cyclictest.c | 35 ++++++++++++++++++-----------------
> >  1 file changed, 18 insertions(+), 17 deletions(-)
> > 
> > diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> > index 960c90560668..592cf9d9387d 100644
> > --- a/src/cyclictest/cyclictest.c
> > +++ b/src/cyclictest/cyclictest.c
> > @@ -1022,7 +1022,7 @@ static int priority;
> >  static int policy = SCHED_OTHER;	/* default policy if not specified */
> >  static int num_threads = 1;
> >  static int max_cycles;
> > -static int clocksel = 0;
> > +static clockid_t used_clock;
> >  static int quiet;
> >  static int interval = DEFAULT_INTERVAL;
> >  static int distance = -1;
> > @@ -1031,10 +1031,17 @@ static struct bitmask *main_affinity_mask = NULL;
> >  static int smp = 0;
> >  static int setaffinity = AFFINITY_UNSPECIFIED;
> >  
> > -static int clocksources[] = {
> > -	CLOCK_MONOTONIC,
> > -	CLOCK_REALTIME,
> > -};
> > +static int handleclock(const char *clockarg)
> > +{
> > +	if (strcmp(clockarg, "0") == 0)
> > +		used_clock = CLOCK_MONOTONIC;
> > +	else if (strcmp(clockarg, "1") == 0)
> > +		used_clock = CLOCK_REALTIME;
> > +	else
> > +		return 1;
> > +
> > +	return 0;
> > +}
> 
> What happens to "unexpected" cmdline parameters now? used_clocks will
> not be set and ...

Then handleclock() will return 1 ...

> >  
> >  static void handlepolicy(char *polname)
> >  {
> > @@ -1195,7 +1202,7 @@ static void process_options(int argc, char *argv[], int max_cpus)
> >  			tracelimit = atoi(optarg); break;
> >  		case 'c':
> >  		case OPT_CLOCK:
> > -			clocksel = atoi(optarg); break;
> > +			error |= handleclock(optarg); break;

... which will set the error flag here.

> >  		case OPT_DEFAULT_SYSTEM:
> >  			power_management = 1; break;
> >  		case 'd':
> > @@ -1377,9 +1384,6 @@ static void process_options(int argc, char *argv[], int max_cpus)
> >  			      "on this processor\n");
> >  	}
> >  
> > -	if (clocksel < 0 || clocksel > ARRAY_SIZE(clocksources))
> > -		error = 1;
> > -
> 
> ... the validation check has been removed. As unused_clock is static
> (and with that initialized to zero) all invalid parameter values will
> silently be "migrated" to CLOCK_REALTIME. Right?

I don't think so, see above.

> I would vote for an error/warn message to avoid that a fat fingered
> cmdline argument invalidates your measurements.

With this patch in its current form, the usage guide will be printed
in case of invalid clock ids. I also just noticed that the behavior
*before* this patch is to silently treat non-numeric arguments as
CLOCK_REALTIME.

> >  	if (oscope_reduction < 1)
> >  		error = 1;

(...)
