Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC73139B4A2
	for <linux-rt-users@vger.kernel.org>; Tue,  7 Apr 2026 08:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775552192; cv=none; b=ic1W4Xlzv33nhM/gwVjWHIA90gycYwBEagHhkGDOrjsW/3osOJl1ksi108JrxS5eOe0fWlC/1PPGpjYe0HjWbLwDicKOAJ4EX0W0YT+F1jWpQuAAbx3t5DcQxFFeI9Sj8OTYPpp8/OqulAHPmijEeJuknDPpmtmPdZHDeQQvCGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775552192; c=relaxed/simple;
	bh=AF06+RaakpV3XfFCe6UqT2fAiI4FvueVqk3WhhGJITE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DjJzlUt437GjVDk5hOzSRuetQqUQNSSTv/P6V4AkVllIIGscK5I0ZVNf1i6FoEXfRCPrBlmnNNTAf6qVnP6tuKjTnlMpj4jVbQOKvhmpiM0k7BHQrvKpq02pcuMm9kWsVhFUjG4QI8AaLriCsCn4zuzvO/fQpED8ZTup3N5qqmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=NlEJCsVL; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="NlEJCsVL"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20260407081609472b8b37d8000207c8
        for <linux-rt-users@vger.kernel.org>;
        Tue, 07 Apr 2026 10:16:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=lqB1YJc52/feYkKJfIPC1uNYjilSBKiquwktnC7FKV8=;
 b=NlEJCsVLu2Y57PSE89OTq3m6T0ySWO2MnhAQ2A1EwmMQUgtI9w2iMuX6LotEsE+sRTIYSI
 1oLprjL9XzhvaGKqWU+XfkqKCZR4X9aJfitPnDXSB9Ir5mhasG6urZCCzsvuC5Jn5w4wQc2q
 jcNhwqT3Tp7pPmue6le1rTphLFU5Yz2QZCvnj/7kBsf4Dtwy9o6CZKpgydNvx8p/OC5dXKB7
 GTUGkeosBXsgcEN/t+osdmRG+PQOvYcaXicKsej1ZQPZ1qFtYui7ZmEDYZYwW5x/irbUu4TL
 2QisKuORUXEXLoee6ZgKtNSDcNUIGLVixfisO9NO+P/P4zog72Ks/3dg==;
Message-ID: <c9ad9da28d83b9f991bc735861c6c21b22b79eec.camel@siemens.com>
Subject: Re: [PATCH 3/6] cyclictest: Fix error error returns for uclibc
 clock_nanosleep() fallback
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= "(Schneider Electric)"
	 <thomas.weissschuh@linutronix.de>, Clark Williams <williams@redhat.com>, 
 John Kacur <jkacur@redhat.com>
Cc: linux-rt-users@vger.kernel.org
Date: Tue, 07 Apr 2026 10:16:08 +0200
In-Reply-To: <20260407-auxclocks-v1-3-1ef80d14eb0a@linutronix.de>
References: <20260407-auxclocks-v1-0-1ef80d14eb0a@linutronix.de>
	 <20260407-auxclocks-v1-3-1ef80d14eb0a@linutronix.de>
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
> clock_nanosleep() is expected to return errors as a positive number,
> without relying on errno.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh (Schneider Electric) <thomas.weisssc=
huh@linutronix.de>
> ---
>  src/cyclictest/cyclictest.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 0c30e767e685..dacf0b7a718e 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -62,12 +62,18 @@
>  static int clock_nanosleep(clockid_t clock_id, int flags, const struct t=
imespec *req,
>  			   struct timespec *rem)
>  {
> +	int retval;
> +
>  	if (clock_id =3D=3D CLOCK_THREAD_CPUTIME_ID)
>  		return -EINVAL;
>  	if (clock_id =3D=3D CLOCK_PROCESS_CPUTIME_ID)
>  		clock_id =3D MAKE_PROCESS_CPUCLOCK(0, CPUCLOCK_SCHED);
> =20
> -	return syscall(__NR_clock_nanosleep, clock_id, flags, req, rem);
> +	retval =3D syscall(__NR_clock_nanosleep, clock_id, flags, req, rem);
> +	if (retval =3D=3D 0)
> +		return 0;
> +
> +	return errno;

That doesn't match with the commit message above, does it? syscall() to
my knowledge will not set/touch errno. syscall() will return whatever
came back from the kernel.

The value of errno is "undefined" (in terms of "contains the last error
code, wherever this is coming from") here.

Looking at patch 4: Looks like this patch can be dropped.

>  }
> =20
>  int sched_setaffinity(__pid_t __pid, size_t __cpusetsize,
>=20
> --=20
> 2.53.0
