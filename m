From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH] rename pip to pip_stress as pip is too general
Date: Mon, 1 Mar 2010 20:40:42 +0100
Message-ID: <520f0cf11003011140k71a490a7me7d808bad92c1cd8@mail.gmail.com>
References: <1267129480-4542-1-git-send-email-u.kleine-koenig@pengutronix.de>
	 <1267462275-14222-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>
To: =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f220.google.com ([209.85.219.220]:54761 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502Ab0CATko convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 1 Mar 2010 14:40:44 -0500
Received: by ewy20 with SMTP id 20so1505074ewy.21
        for <linux-rt-users@vger.kernel.org>; Mon, 01 Mar 2010 11:40:43 -0800 (PST)
In-Reply-To: <1267462275-14222-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

2010/3/1 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>:
> The command name is already taken by a perl script working with CPAN
> and a Python package installer.
>
> While at it remove trailing whitespace from three lines in
> src/pi_tests/pip_stress.c.
>
> Closes: http://bugs.debian.org/572104
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
> Hiho,
>
> changes since last submission are:
>
> =A0- remove trailing whitespaces
> =A0- different bug number
>
> Best regards
> Uwe
> =A0.gitignore =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A02 +-
> =A0Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 =A04 ++--
> =A0src/include/{pip.h =3D> pip_stress.h} =A0| =A0 =A07 +++----
> =A0src/pi_tests/{pip.c =3D> pip_stress.c} | =A0 10 +++++-----
> =A04 files changed, 11 insertions(+), 12 deletions(-)
> =A0rename src/include/{pip.h =3D> pip_stress.h} (93%)
> =A0rename src/pi_tests/{pip.c =3D> pip_stress.c} (98%)
>
> diff --git a/.gitignore b/.gitignore
> index a06031c..0d77a66 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -23,4 +23,4 @@ ptsematest
> =A0sendme
> =A0sigwaittest
> =A0svsematest
> -pip
> +pip_stress
> diff --git a/Makefile b/Makefile
> index 5bb8774..52f8d64 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1,7 +1,7 @@
> =A0VERSION_STRING =3D 0.66
>
> =A0sources =3D cyclictest.c signaltest.c pi_stress.c rt-migrate-test.=
c =A0 =A0 =A0\
> - =A0 =A0 =A0 =A0 ptsematest.c sigwaittest.c svsematest.c sendme.c pi=
p.c
> + =A0 =A0 =A0 =A0 ptsematest.c sigwaittest.c svsematest.c sendme.c pi=
p_stress.c
>
> =A0TARGETS =3D $(sources:.c=3D)
>
> @@ -79,7 +79,7 @@ svsematest: svsematest.o rt-utils.o rt-get_cpu.o
> =A0sendme: sendme.o rt-utils.o rt-get_cpu.o
> =A0 =A0 =A0 =A0$(CC) $(CFLAGS) -o $@ $^ $(LIBS) $(EXTRA_LIBS)
>
> -pip: pip.o error.o rt-utils.o
> +pip_stress: pip_stress.o error.o rt-utils.o
> =A0 =A0 =A0 =A0$(CC) $(CFLAGS) -o $@ $^ $(LIBS)
>
> =A0CLEANUP =A0=3D $(TARGETS) *.o .depend *.*~ *.orig *.rej rt-tests.s=
pec *.d
> diff --git a/src/include/pip.h b/src/include/pip_stress.h
> similarity index 93%
> rename from src/include/pip.h
> rename to src/include/pip_stress.h
> index b2068be..8ed2452 100644
> --- a/src/include/pip.h
> +++ b/src/include/pip_stress.h
> @@ -1,5 +1,5 @@
> -#ifndef __PIP_H
> -#define __PIP_H
> +#ifndef __PIP_STRESS_H
> +#define __PIP_STRESS_H
>
> =A0#include <stdio.h>
> =A0#include <stdlib.h>
> @@ -37,5 +37,4 @@ int get_rt_prio(pid_t pid);
> =A0#define PROTRW PROT_READ|PROT_WRITE
> =A0#define MMAP_FLAGS MAP_SHARED|MAP_ANONYMOUS
>
> -#endif /* __PIP_H */
> -
> +#endif /* __PIP_STRESS_H */
> diff --git a/src/pi_tests/pip.c b/src/pi_tests/pip_stress.c
> similarity index 98%
> rename from src/pi_tests/pip.c
> rename to src/pi_tests/pip_stress.c
> index 085908b..2b42b8f 100644
> --- a/src/pi_tests/pip.c
> +++ b/src/pi_tests/pip_stress.c
> @@ -1,6 +1,6 @@
> =A0/*
> - =A0 =A0 =A0 Pip - Priority Inheritance with processes
> -
> + =A0 =A0 =A0 Pip stress - Priority Inheritance with processes
> +
> =A0 =A0 Copyright (C) 2009, John Kacur <jkacur@redhat.com>
>
> =A0 =A0 This program is free software: you can redistribute it and/or=
 modify
> @@ -54,7 +54,7 @@
> =A0* scheduling priorities.
> =A0*/
>
> -#include "pip.h"
> +#include "pip_stress.h"
>
> =A0pthread_mutex_t *resource;
>
> @@ -107,7 +107,7 @@ int main(void)
> =A0 =A0 =A0 =A0set_rt_prio(0, prio_min, policy);
>
> =A0 =A0 =A0 =A0/* We restrict this program to the first cpu, inorder =
to increase
> - =A0 =A0 =A0 =A0* the likelihood of a priority inversion */
> + =A0 =A0 =A0 =A0* the likelihood of a priority inversion */
> =A0 =A0 =A0 =A0CPU_ZERO(setp);
> =A0 =A0 =A0 =A0CPU_SET(0, setp);
> =A0 =A0 =A0 =A0res =3D sched_setaffinity(0, sizeof(set), setp);
> @@ -311,7 +311,7 @@ void init_shared_pthread_mutex(pthread_mutex_t *m=
utex, int protocol, int policy)
> =A0 =A0 =A0 =A0Pthread_mutexattr_init(&attr);
> =A0 =A0 =A0 =A0Pthread_mutexattr_setpshared(&attr, PTHREAD_PROCESS_SH=
ARED);
> =A0 =A0 =A0 =A0Pthread_mutexattr_setprotocol(&attr, protocol);
> -
> +
> =A0 =A0 =A0 =A0Pthread_mutex_init(mutex, &attr);
> =A0}
>
> --
> 1.7.0

I have no problem with this rename.
Signed-off-by: John Kacur <jkacur@redhat.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
