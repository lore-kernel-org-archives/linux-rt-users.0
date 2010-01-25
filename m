From: John Kacur <jkacur@gmail.com>
Subject: Re: [PATCH] Add copyright statements to files in src/lib
Date: Mon, 25 Jan 2010 21:24:37 +0100
Message-ID: <520f0cf11001251224k72f2c6e4we7b958d355f93704@mail.gmail.com>
References: <1264191496-11663-1-git-send-email-u.kleine-koenig@pengutronix.de>
	 <1264450974-6923-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org,
	Carsten Emde <carsten.emde@osadl.org>,
	Clark Williams <williams@redhat.com>
To: =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:38102 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752309Ab0AYUYj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Jan 2010 15:24:39 -0500
Received: by ewy19 with SMTP id 19so162934ewy.21
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Jan 2010 12:24:38 -0800 (PST)
In-Reply-To: <1264450974-6923-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

2010/1/25 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>:
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Cc: John Kacur <jkacur@redhat.com>
> Cc: Carsten Emde <carsten.emde@osadl.org>
> Cc: Clark Williams <williams@redhat.com>
> ---
> Hello,
>
> compared to the previous patch I modified the comment in src/lib/erro=
r.c as
> requested by John via irc.
>
> Best regards
> Uwe
>
> =A0src/lib/error.c =A0 =A0 =A0| =A0 =A06 ++++++
> =A0src/lib/rt-get_cpu.c | =A0 =A04 +++-
> =A0src/lib/rt-utils.c =A0 | =A0 =A08 ++++++++
> =A03 files changed, 17 insertions(+), 1 deletions(-)
>
> diff --git a/src/lib/error.c b/src/lib/error.c
> index d5ad2aa..e9fe58f 100644
> --- a/src/lib/error.c
> +++ b/src/lib/error.c
> @@ -1,3 +1,9 @@
> +/*
> + * Copyright (C) 2009 John Kacur <jkacur@redhat.com>
> + *
> + * error routines, similar to those found in
> + * Advanced Programming in the UNIX Environment 2nd ed.
> + */
> =A0#include "error.h"
>
> =A0/* Print an error message, plus a message for err and exit with er=
ror err */
> diff --git a/src/lib/rt-get_cpu.c b/src/lib/rt-get_cpu.c
> index 6ebda90..83430dd 100644
> --- a/src/lib/rt-get_cpu.c
> +++ b/src/lib/rt-get_cpu.c
> @@ -1,3 +1,6 @@
> +/*
> + * Copyright (C) 2009 John Kacur <jkacur@redhat.com>
> + */
> =A0#include "rt-get_cpu.h"
> =A0#ifdef __NR_getcpu
> =A0#elif defined(__GLIBC__) && defined(__GLIBC_MINOR__) =A0 \
> @@ -22,4 +25,3 @@ int get_cpu_setup(void)
> =A0}
>
> =A0#endif
> -
> diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
> index c760f5a..b5a77de 100644
> --- a/src/lib/rt-utils.c
> +++ b/src/lib/rt-utils.c
> @@ -1,3 +1,11 @@
> +/*
> + * Copyright (C) 2009 Carsten Emde <carsten.emde@osadl.org>
> + * Copyright (C) 2010 Clark Williams <williams@redhat.com>
> + *
> + * based on functions from cyclictest that has
> + * (C) 2008-2009 Clark Williams <williams@redhat.com>
> + * (C) 2005-2007 Thomas Gleixner <tglx@linutronix.de>
> + */
> =A0#include <stdio.h>
> =A0#include <stdlib.h>
> =A0#include <string.h>
> --
> 1.6.6
>
> --

Okay, no objections.
Acked-by: John Kacur <jkacur@redhat.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
