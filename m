Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF363AA1B2
	for <linux-rt-users@vger.kernel.org>; Tue,  7 Apr 2026 10:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775558373; cv=none; b=uCqznXu/kkaSpnclJGfiboYheVun/Xnj60WNuGmBXRUSgL6T3ODM2IAP9C36OoSaqFNXO9JlD0EIgl8ZG6eAbeyn9rdJUTd2eVdxVvvfQkHbY/Dz1sev3e9FJUUubtkGncnX8CaEhdMw4zkqEK/OTyAdkO3fVSzg5O6FQotGAHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775558373; c=relaxed/simple;
	bh=TafFvF5vUG8OZxMCr8uhUwXtdR9zM9vHnia7/WHBXzs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kqvz0u2uv5zt84A/sSZC6POVayKYNn1q4cKDc7ox5acpvxiUaz1Rg6fD5GcGRsfMmuYcIGkOfoAKbmiMd0oqfQC8aMvza03JGVfi4Clh7PNH+Fu1IP6AsWyb3E9l7yhrOUuhhG6vb+yVRaWwfAlCdIUapRay63oVNVxjItgLJBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=eqmZmRIp; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="eqmZmRIp"
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 2026040708590247790f65a6000207a0
        for <linux-rt-users@vger.kernel.org>;
        Tue, 07 Apr 2026 10:59:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=NJQ7zjj0Y8BcGaHJDmTsP23/fOSsq61kxNxpUEXBrgc=;
 b=eqmZmRIpiSOcGTjcY6j/KGCqHG8FiKqH5u3T2dy9EOjXPXusI4RhMc1UovYTXORT9ObqEg
 DXQNsmr+tepTg4llI7z0YAO7lbI453hCptMvY6NXsNj9vdHI7Q+47MIo1ixulfuDuRTNSNa6
 /KcjTIXCPmjrimlqYyFA2KtBNhdYZsEzNRaBdijDtle+GQ5/xU2m9O7cFskX2Itqjhvmbqp9
 ouFB7kl4sUofcu8RO+59hSzP2p4UPjKFHEfb6rI05AXy+rslPZXBNIn99BnEwzOIsrOOLyCI
 cG253PuG1GlrrB6aNTfO8Wyba7qWWtIUReF3g49x+BX94eARoacWLq9g==;
Message-ID: <90d5b8544743831fb3701bb0d440c8383532ad30.camel@siemens.com>
Subject: Re: [PATCH 3/6] cyclictest: Fix error error returns for uclibc
 clock_nanosleep() fallback
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= "(Schneider Electric)"
	 <thomas.weissschuh@linutronix.de>
Cc: Clark Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>, 
	linux-rt-users@vger.kernel.org
Date: Tue, 07 Apr 2026 10:59:02 +0200
In-Reply-To: <20260407104610-a319819e-8194-473b-982f-9afbb27b3b0b@linutronix.de>
References: <20260407-auxclocks-v1-0-1ef80d14eb0a@linutronix.de>
	 <20260407-auxclocks-v1-3-1ef80d14eb0a@linutronix.de>
	 <c9ad9da28d83b9f991bc735861c6c21b22b79eec.camel@siemens.com>
	 <20260407104610-a319819e-8194-473b-982f-9afbb27b3b0b@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Tue, 2026-04-07 at 10:50 +0200, Thomas Wei=C3=9Fschuh (Schneider Electri=
c)
wrote:
> On Tue, Apr 07, 2026 at 10:16:08AM +0200, Florian Bezdeka wrote:
> > On Tue, 2026-04-07 at 08:48 +0200, Thomas Wei=C3=9Fschuh (Schneider Ele=
ctric)
> > wrote:
> > > clock_nanosleep() is expected to return errors as a positive number,
> > > without relying on errno.
> > >=20
> > > Signed-off-by: Thomas Wei=C3=9Fschuh (Schneider Electric) <thomas.wei=
ssschuh@linutronix.de>
> > > ---
> > >  src/cyclictest/cyclictest.c | 8 +++++++-
> > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.=
c
> > > index 0c30e767e685..dacf0b7a718e 100644
> > > --- a/src/cyclictest/cyclictest.c
> > > +++ b/src/cyclictest/cyclictest.c
> > > @@ -62,12 +62,18 @@
> > >  static int clock_nanosleep(clockid_t clock_id, int flags, const stru=
ct timespec *req,
> > >  			   struct timespec *rem)
> > >  {
> > > +	int retval;
> > > +
> > >  	if (clock_id =3D=3D CLOCK_THREAD_CPUTIME_ID)
> > >  		return -EINVAL;
> > >  	if (clock_id =3D=3D CLOCK_PROCESS_CPUTIME_ID)
> > >  		clock_id =3D MAKE_PROCESS_CPUCLOCK(0, CPUCLOCK_SCHED);
> > > =20
> > > -	return syscall(__NR_clock_nanosleep, clock_id, flags, req, rem);
> > > +	retval =3D syscall(__NR_clock_nanosleep, clock_id, flags, req, rem)=
;
> > > +	if (retval =3D=3D 0)
> > > +		return 0;
> > > +
> > > +	return errno;
> >=20
> > That doesn't match with the commit message above, does it? syscall() to
> > my knowledge will not set/touch errno. syscall() will return whatever
> > came back from the kernel.
>=20
> syscall() *does* indeed touch errno. From syscall(2):
> "A -1 return value indicates an error, and an error number is stored in e=
rrno."

Right. I stopped reading to early.=20

I would vote for

if (retval =3D=3D -1)
	return errno;

then. But that's just a minor detail.

>=20
> Unfortunately there is no standard variant of syscall() which does not
> touch errno.
>=20
> > The value of errno is "undefined" (in terms of "contains the last error
> > code, wherever this is coming from") here.
> >=20
> > Looking at patch 4: Looks like this patch can be dropped.
>=20
> No, this patch (patch 3) is only for the fallback definition of uclibc.
> Patch 4 is necessary for all libcs. For some (to me unknown) reason
> clock_nanosleep() works different from all the other libc functions.

POSIX...
> >=20

Thanks for the clarifications. Here as well as in the other thread.

Best regards,
Florian
