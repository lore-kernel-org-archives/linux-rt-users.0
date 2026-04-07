Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B62399359
	for <linux-rt-users@vger.kernel.org>; Tue,  7 Apr 2026 08:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775551814; cv=none; b=fa78574MDs2VBHdVTPjR3F49PibJSouT46SAt1lOFxSOaFEFUmHQLbABz6CHiU7q8reAyY8QraYh9Iuo3XIwUMdZbdcDyimpZ0tFspqeyG6kUBSJRYZLVppj/DBojq7LjwNo3WNQFbNbBIgWfZIfiQQ3+julQ+Tyet5YT8BwfHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775551814; c=relaxed/simple;
	bh=/qhI8shA+TehJR0Cx1GTHAa3/WX0BmF5ZLIewcXgdbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DPHzxQo5/3IKgdLAl8p5+vQeevehRu6JcL9WaSG4IoNVfFUnaA1Ps44/q02T59TMN4DQs70XtYIf6EuFbsY+wUY4BhzHmND5Tlhrikq3hnWRWZoVfJFNJkBU4aPdZu62wPYEzL5Dl2P417D84YKWRfx0r6d7h5Nf6e/ifc8icOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y5iMvDEl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IbKimvls; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y5iMvDEl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IbKimvls"
Date: Tue, 7 Apr 2026 10:50:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1775551807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pzOM3E9iZSlqaQspCR2xMhO6i5kIBLf+ePFtGh4CAZo=;
	b=y5iMvDElie5TskkXuZnDHDrUyNLLZ43U75DnotwBeLYjxWe2bFUhKPL1BLs7Kfe2cczeqB
	LdpUPePla6m1mlK4hsDLZlVTzRmZqknpLBfRXVgn1OX1XvcwnNBsln9kUX2VFk2QpDMObE
	IAtOWIsBXaUrAwVnZDcGfmYUctMAHEDNDpvgt+uTADfmyDtMBNbJV7BhbtGUKxk5Llm/jo
	k6PA4EmKNngeXGCyK4WQ323kNhTQfCT1JkgbayjTIu2sNES+yUn+VaCfSd8ANBGfCOsJ41
	Qyj6O8PbtoInlowCbG2CdtERBe8OZEmWsm1eYTUNULYxdTuyDCSOsR6Lovwleg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1775551807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pzOM3E9iZSlqaQspCR2xMhO6i5kIBLf+ePFtGh4CAZo=;
	b=IbKimvls3QHtRCuiNBdbd5o/9P2tHRDNNgSNv64PKYzgeCVPpU6W5PDsVM3XATsV0Y2NEf
	ZjooHAVtLpBIsWDA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Clark Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>, 
	linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 3/6] cyclictest: Fix error error returns for uclibc
 clock_nanosleep() fallback
Message-ID: <20260407104610-a319819e-8194-473b-982f-9afbb27b3b0b@linutronix.de>
References: <20260407-auxclocks-v1-0-1ef80d14eb0a@linutronix.de>
 <20260407-auxclocks-v1-3-1ef80d14eb0a@linutronix.de>
 <c9ad9da28d83b9f991bc735861c6c21b22b79eec.camel@siemens.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c9ad9da28d83b9f991bc735861c6c21b22b79eec.camel@siemens.com>

On Tue, Apr 07, 2026 at 10:16:08AM +0200, Florian Bezdeka wrote:
> On Tue, 2026-04-07 at 08:48 +0200, Thomas Weiﬂschuh (Schneider Electric)
> wrote:
> > clock_nanosleep() is expected to return errors as a positive number,
> > without relying on errno.
> > 
> > Signed-off-by: Thomas Weiﬂschuh (Schneider Electric) <thomas.weissschuh@linutronix.de>
> > ---
> >  src/cyclictest/cyclictest.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> > index 0c30e767e685..dacf0b7a718e 100644
> > --- a/src/cyclictest/cyclictest.c
> > +++ b/src/cyclictest/cyclictest.c
> > @@ -62,12 +62,18 @@
> >  static int clock_nanosleep(clockid_t clock_id, int flags, const struct timespec *req,
> >  			   struct timespec *rem)
> >  {
> > +	int retval;
> > +
> >  	if (clock_id == CLOCK_THREAD_CPUTIME_ID)
> >  		return -EINVAL;
> >  	if (clock_id == CLOCK_PROCESS_CPUTIME_ID)
> >  		clock_id = MAKE_PROCESS_CPUCLOCK(0, CPUCLOCK_SCHED);
> >  
> > -	return syscall(__NR_clock_nanosleep, clock_id, flags, req, rem);
> > +	retval = syscall(__NR_clock_nanosleep, clock_id, flags, req, rem);
> > +	if (retval == 0)
> > +		return 0;
> > +
> > +	return errno;
> 
> That doesn't match with the commit message above, does it? syscall() to
> my knowledge will not set/touch errno. syscall() will return whatever
> came back from the kernel.

syscall() *does* indeed touch errno. From syscall(2):
"A -1 return value indicates an error, and an error number is stored in errno."

Unfortunately there is no standard variant of syscall() which does not
touch errno.

> The value of errno is "undefined" (in terms of "contains the last error
> code, wherever this is coming from") here.
> 
> Looking at patch 4: Looks like this patch can be dropped.

No, this patch (patch 3) is only for the fallback definition of uclibc.
Patch 4 is necessary for all libcs. For some (to me unknown) reason
clock_nanosleep() works different from all the other libc functions.

> >  }
> >  
> >  int sched_setaffinity(__pid_t __pid, size_t __cpusetsize,
> > 
> > -- 
> > 2.53.0
