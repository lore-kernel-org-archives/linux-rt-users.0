From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 3/3] Makefile: don't use temporary files in generation of
	dependency files
Date: Mon, 1 Mar 2010 20:39:56 +0100
Message-ID: <520f0cf11003011139v298f7603oe39a70c649875360@mail.gmail.com>
References: <20100224165611.GA22159@pengutronix.de>
	 <1267030688-12244-3-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>
To: =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:32360 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307Ab0CATj6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 1 Mar 2010 14:39:58 -0500
Received: by ey-out-2122.google.com with SMTP id 25so486144eya.19
        for <linux-rt-users@vger.kernel.org>; Mon, 01 Mar 2010 11:39:56 -0800 (PST)
In-Reply-To: <1267030688-12244-3-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

2010/2/24 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>:
> These temporary files were a real problem when creating the Debian
> package for rt-tests. =A0debhelper (a generic suite of scripts to eas=
e
> packaging) did something like:
>
> =A0 =A0 =A0 =A0perl -c 'close(STDERR); exec("make distclean");'
>
> which leaked the *.d.$$ files and then wailed that the package contai=
ned
> untracked changes to the vanilla source. =A0See
> http://bugs.debian.org/570443 for some more details.
>
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
> =A0Makefile | =A0 =A05 +----
> =A01 files changed, 1 insertions(+), 4 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 99fbba4..5bb8774 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -43,10 +43,7 @@ VPATH =A0 =A0 =A0 =A0+=3D src/lib
>
> =A0# Pattern rule to generate dependency files from .c files
> =A0%.d: %.c
> - =A0 =A0 =A0 @set -e; rm -f $@; \
> - =A0 =A0 =A0 $(CC) -MM $(CFLAGS) $< > $@.$$$$; \
> - =A0 =A0 =A0 sed 's,\($*\)\.o[ :]*,\1.o $@ : ,g' < $@.$$$$ > $@; \
> - =A0 =A0 =A0 rm -f $@.$$$$
> + =A0 =A0 =A0 @$(CC) -MM $(CFLAGS) $< | sed 's,\($*\)\.o[ :]*,\1.o $@=
 : ,g' > $@ || rm -f $@
>
> =A0.PHONY: all
> =A0all: $(TARGETS) hwlatdetect
> --
> 1.6.6.2
>

This is fine too, it may even be faster.
Acked-by: John Kacur <jkacur@redhat.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
