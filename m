From: Henrik Austad <henrik@austad.us>
Subject: Re: error: implicit =?utf-8?Q?declaration_?=
 =?utf-8?B?b2YgZnVuY3Rpb24g4oCYZG9fc29mdGlyceKAmQ==?=
Date: Thu, 17 Oct 2013 14:07:17 +0200
Message-ID: <20131017120717.GA22364@austad.us>
References: <CAMj341OaVOXvcjvw75CoKSF1=YaBcVHa026LQ8VY2KXyUtOBaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Cc: linux-rt-users@vger.kernel.org
To: Matthias =?iso-8859-1?Q?D=FCbon?= <matthias.duebon@ing-duebon.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:57739 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753373Ab3JQMH0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 17 Oct 2013 08:07:26 -0400
Received: by mail-la0-f44.google.com with SMTP id ep20so1463568lab.31
        for <linux-rt-users@vger.kernel.org>; Thu, 17 Oct 2013 05:07:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMj341OaVOXvcjvw75CoKSF1=YaBcVHa026LQ8VY2KXyUtOBaw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2013 at 06:14:01PM +0200, Matthias D=C3=BCbon wrote:
> Hello everyone,

Hi,

> I am just experimenting with the RT preempt patch
> patch-3.10.15-rt11.patch.bz2 and a 3.10.16 kernel for x86 architecture
> with a "standard" .config file.

Standard as in 'make defconfig' or standard as in 'what my distro uses'?

> I configured CONFIG_PREEMPT_RT_FULL=3Dy
>=20
> when building the kernel I got the following error:
>=20
> "kernel/softirq.c: In function =E2=80=98invoke_softirq=E2=80=99:
> kernel/softirq.c:710:3: error: implicit declaration of function
> =E2=80=98do_softirq=E2=80=99 [-Werror=3Dimplicit-function-declaration]"
>=20
> Is this related to my kernel configuration?

Not easy to say without the actual .config.

However, I did note one thing. You are using the preempt-rt patch for=20
3.10.15 and you apply it to 3.10.16 (or was that a typo?)

When I try to do the same thing; lo and behold, I get a reject in=20
kernel/softirq.c.

$ cat kernel/softirq.c.rej=20
--- kernel/softirq.c
+++ kernel/softirq.c
@@ -698,10 +1066,20 @@
=20
 static inline void invoke_softirq(void)
 {
+#ifndef CONFIG_PREEMPT_RT_FULL
        if (!force_irqthreads)
                __do_softirq();
        else
                wakeup_softirqd();
+#else /* PREEMPT_RT_FULL */
+       unsigned long flags;
+
+       local_irq_save(flags);
+       if (__this_cpu_read(ksoftirqd) &&
+           __this_cpu_read(ksoftirqd)->softirqs_raised)
+               wakeup_softirqd();
+       local_irq_restore(flags);
+#endif
 }
=20
 static inline void tick_irq_exit(void)


Do you see anything suspicious here? :)

Try to use v3.10.15 and recompile. I think that'll work a bit better.


--=20
Henrik Austad

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlJf0vUACgkQ6k5VT6v45lmTOQCeLrMuZ5Og3XpbFbz4u7aKvGbX
DTAAn1JKRZfytBbKE9qAyp+k0qtMTUkb
=j6gs
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
