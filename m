Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F8314884C
	for <linux-rt-users@vger.kernel.org>; Tue,  7 Apr 2026 09:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775552882; cv=none; b=t2g/szI3jVmpOeiobUn+uWgKcB1BN2E0bF0Dk7AfVZn1ftHoeTqeyiIcEV5QFXm1rK/nky5i0mZXG5U44InWayUvsj+iMGOQ+TKNh48nTCJQaz2X31t4cnyw+aOSX4KARNc8aT9cQ4xJGZzF9NxtaXLFxkyUzZzgnHM6tp+lIcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775552882; c=relaxed/simple;
	bh=4ty+xRHiX3RXdPmxT48HLKgigMpDciUioWdab/wXFIo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ve3+jbaS1xyXFjlsI1ddOHJgKoRri3NWtLpVrcW9p8X+9tveSzHyYar4Pq1mvOykqrxEaUEevlRxt+H1RHh2OTlagqN4KPd8JJeJmK4RBFBwPIGYDzW8k1QUEALWi7MgMoXANUUkK3wNIKkIRyhA8Dx5T36vN3oh8YmQvJ0M9Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Jp7enZPJ; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Jp7enZPJ"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2026040708273922b5ac2b90000207b1
        for <linux-rt-users@vger.kernel.org>;
        Tue, 07 Apr 2026 10:27:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=2umOk1j7MgOd7+zYPCUFcQj3/7e8ead2zNfb2n9qgX8=;
 b=Jp7enZPJsl6PIbggSwY03pjf/QfytsrtyUi67/+8AdJQsmVyqvopCfD1ON3O8vZpJlNwUS
 CP+0Q6TT/jZjgQPsBYq8zpzsJz1zFbmwFjubxftdLci/+iva1/LMoq/1fAqsvV6OpKGbM3FO
 9CAXqhJ2oyklGJJlTsSbJoPTQMQoXesYB7PeR1LLz/pX7CVqIMgmrWjkMSoPZz3diRHXzQb5
 sj1Z9BN/3KlI/e86C9CZn5E0KaVq3haS17JpL61IizViMjttW6AChVbI2Fmj8NhHyeIHbaq0
 uhoOVdeazejJjVk9pUEFrRSOUSbP3vEhwova0QIe8QxPs3vKq6zlYUGw==;
Message-ID: <578d66745469e6263ba3fd6c7a0ec4d92d4f39d9.camel@siemens.com>
Subject: Re: [PATCH 1/6] cyclictest: Centralize clock option parsing
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= "(Schneider Electric)"
	 <thomas.weissschuh@linutronix.de>, Clark Williams <williams@redhat.com>, 
 John Kacur <jkacur@redhat.com>
Cc: linux-rt-users@vger.kernel.org
Date: Tue, 07 Apr 2026 10:27:39 +0200
In-Reply-To: <20260407-auxclocks-v1-1-1ef80d14eb0a@linutronix.de>
References: <20260407-auxclocks-v1-0-1ef80d14eb0a@linutronix.de>
	 <20260407-auxclocks-v1-1-1ef80d14eb0a@linutronix.de>
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

On Tue, 2026-04-07 at 08:48 +0200, Thomas Wei=C3=9Fschuh (Schneider Electri=
c)
wrote:
> Currently the lookup of the clockid from the commandline options is done
> in multiple places. This makes the addition of symbolic clock names and
> new clocks cumbersome.
>=20
> Move all of the clock option parsing into a new helper function.
>=20
> As a side-effect fix an off-by-one error in the validation of the
> clock command line argument.
>=20
> The new variable can not be named 'clock' as that would conflict with
> the libc function of the same name.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh (Schneider Electric) <thomas.weisssc=
huh@linutronix.de>
> ---
>  src/cyclictest/cyclictest.c | 35 ++++++++++++++++++-----------------
>  1 file changed, 18 insertions(+), 17 deletions(-)
>=20
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 960c90560668..592cf9d9387d 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -1022,7 +1022,7 @@ static int priority;
>  static int policy =3D SCHED_OTHER;	/* default policy if not specified */
>  static int num_threads =3D 1;
>  static int max_cycles;
> -static int clocksel =3D 0;
> +static clockid_t used_clock;
>  static int quiet;
>  static int interval =3D DEFAULT_INTERVAL;
>  static int distance =3D -1;
> @@ -1031,10 +1031,17 @@ static struct bitmask *main_affinity_mask =3D NUL=
L;
>  static int smp =3D 0;
>  static int setaffinity =3D AFFINITY_UNSPECIFIED;
> =20
> -static int clocksources[] =3D {
> -	CLOCK_MONOTONIC,
> -	CLOCK_REALTIME,
> -};
> +static int handleclock(const char *clockarg)
> +{
> +	if (strcmp(clockarg, "0") =3D=3D 0)
> +		used_clock =3D CLOCK_MONOTONIC;
> +	else if (strcmp(clockarg, "1") =3D=3D 0)
> +		used_clock =3D CLOCK_REALTIME;
> +	else
> +		return 1;
> +
> +	return 0;
> +}

What happens to "unexpected" cmdline parameters now? used_clocks will
not be set and ...

> =20
>  static void handlepolicy(char *polname)
>  {
> @@ -1195,7 +1202,7 @@ static void process_options(int argc, char *argv[],=
 int max_cpus)
>  			tracelimit =3D atoi(optarg); break;
>  		case 'c':
>  		case OPT_CLOCK:
> -			clocksel =3D atoi(optarg); break;
> +			error |=3D handleclock(optarg); break;
>  		case OPT_DEFAULT_SYSTEM:
>  			power_management =3D 1; break;
>  		case 'd':
> @@ -1377,9 +1384,6 @@ static void process_options(int argc, char *argv[],=
 int max_cpus)
>  			      "on this processor\n");
>  	}
> =20
> -	if (clocksel < 0 || clocksel > ARRAY_SIZE(clocksources))
> -		error =3D 1;
> -

... the validation check has been removed. As unused_clock is static
(and with that initialized to zero) all invalid parameter values will
silently be "migrated" to CLOCK_REALTIME. Right?

I would vote for an error/warn message to avoid that a fat fingered
cmdline argument invalidates your measurements.

>  	if (oscope_reduction < 1)
>  		error =3D 1;
> =20
> @@ -1983,7 +1987,6 @@ int main(int argc, char **argv)
>  		warn("High resolution timers not available\n");
> =20
>  	if (check_clock_resolution) {
> -		int clock;
>  		uint64_t diff;
>  		int k;
>  		uint64_t min_non_zero_diff =3D UINT64_MAX;
> @@ -1994,9 +1997,7 @@ int main(int argc, char **argv)
>  		struct timespec *time;
>  		int times;
> =20
> -		clock =3D clocksources[clocksel];
> -
> -		if (clock_getres(clock, &res))
> +		if (clock_getres(used_clock, &res))
>  			warn("clock_getres failed");
>  		else
>  			reported_resolution =3D (NSEC_PER_SEC * res.tv_sec) + res.tv_nsec;
> @@ -2009,9 +2010,9 @@ int main(int argc, char **argv)
>  		 * This will reliably capture resolution <=3D 500 usec.
>  		 */
>  		times =3D 1000;
> -		clock_gettime(clock, &prev);
> +		clock_gettime(used_clock, &prev);
>  		for (k=3D0; k < times; k++)
> -			clock_gettime(clock, &now);
> +			clock_gettime(used_clock, &now);
> =20
>  		diff =3D calcdiff_ns(now, prev);
>  		if (diff =3D=3D 0) {
> @@ -2035,7 +2036,7 @@ int main(int argc, char **argv)
>  		time =3D calloc(times, sizeof(*time));
> =20
>  		for (k=3D0; k < times; k++)
> -			clock_gettime(clock, &time[k]);
> +			clock_gettime(used_clock, &time[k]);
> =20
>  		info(ct_debug, "For %d consecutive calls to clock_gettime():\n", times=
);
>  		info(ct_debug, "time, delta time (nsec)\n");
> @@ -2193,7 +2194,7 @@ int main(int argc, char **argv)
>  		}
>  		if (priospread)
>  			priority--;
> -		par->clock =3D clocksources[clocksel];
> +		par->clock =3D used_clock;
>  		par->mode =3D mode;
>  		par->timermode =3D timermode;
>  		par->signal =3D signum;
>=20
> --=20
> 2.53.0
