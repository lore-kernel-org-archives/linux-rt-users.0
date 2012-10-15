From: John Kacur <jkacur@redhat.com>
Subject: Re: support compilation with hardening flags
Date: Tue, 16 Oct 2012 01:03:56 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1210160103040.6335@tycho>
References: <1346615170-25310-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463806542-1233084027-1350342237=:6335"
Cc: linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>
To: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:36563 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752975Ab2JOXCJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 15 Oct 2012 19:02:09 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so2709483bkc.19
        for <linux-rt-users@vger.kernel.org>; Mon, 15 Oct 2012 16:02:07 -0700 (PDT)
In-Reply-To: <1346615170-25310-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463806542-1233084027-1350342237=:6335
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

This is a good patch, but once again your subject line and description 
kinda sucks. I'm fixing it up

Signed-off-by: John Kacur <jkacur@redhat.com>

On Sun, 2 Sep 2012, Uwe Kleine-König wrote:

> For Debian 7.0 (aka wheezy) packages it's recommended to use several
> hardening flags, the default on amd64 being:
> 
> 	CFLAGS=-g -O2 -fstack-protector --param=ssp-buffer-size=4 -Wformat -Werror=format-security
> 	CPPFLAGS=-D_FORTIFY_SOURCE=2
> 	LDFLAGS=-Wl,-z,relro
> 
> This patch doesn't fix all warnings but at least makes all programs compile
> again by not using char *variables as printf format strings.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  src/pmqtest/pmqtest.c         |    4 ++--
>  src/ptsematest/ptsematest.c   |    4 ++--
>  src/sigwaittest/sigwaittest.c |    4 ++--
>  src/svsematest/svsematest.c   |    4 ++--
>  4 files changed, 8 insertions(+), 8 deletions(-)
> 
> --- a/src/ptsematest/ptsematest.c
> +++ b/src/ptsematest/ptsematest.c
> @@ -389,12 +389,12 @@
>  					(int) ((receiver[i].sumdiff / receiver[i].samples) + 0.5),
>  					receiver[i].maxdiff);
>  				if (receiver[i].error[0] != '\0') {
> -					printf(receiver[i].error);
> +					printf("%s", receiver[i].error);
>  					errorlines++;
>  					receiver[i].error[0] = '\0';
>  				}
>  				if (sender[i].error[0] != '\0') {
> -					printf(sender[i].error);
> +					printf("%s", sender[i].error);
>  					errorlines++;
>  					receiver[i].error[0] = '\0';
>  				}
> --- a/src/sigwaittest/sigwaittest.c
> +++ b/src/sigwaittest/sigwaittest.c
> @@ -561,12 +561,12 @@
>  					    receiver[i].samples) + 0.5),
>  					    receiver[i].maxdiff);
>  				if (receiver[i].error[0] != '\0') {
> -					printf(receiver[i].error);
> +					printf("%s", receiver[i].error);
>  					receiver[i].error[0] = '\0';
>  					errorlines++;
>  				}
>  				if (sender[i].error[0] != '\0') {
> -					printf(sender[i].error);
> +					printf("%s", sender[i].error);
>  					sender[i].error[0] = '\0';
>  					errorlines++;
>  				}
> --- a/src/svsematest/svsematest.c
> +++ b/src/svsematest/svsematest.c
> @@ -646,12 +646,12 @@
>  					    receiver[i].samples) + 0.5),
>  					    receiver[i].maxdiff);
>  				if (receiver[i].error[0] != '\0') {
> -					printf(receiver[i].error);
> +					printf("%s", receiver[i].error);
>  					receiver[i].error[0] = '\0';
>  					errorlines++;
>  				}
>  				if (sender[i].error[0] != '\0') {
> -					printf(sender[i].error);
> +					printf("%s", sender[i].error);
>  					sender[i].error[0] = '\0';
>  					errorlines++;
>  				}
> --- a/src/pmqtest/pmqtest.c
> +++ b/src/pmqtest/pmqtest.c
> @@ -512,12 +512,12 @@
>  					(int) ((receiver[i].sumdiff / receiver[i].samples) + 0.5),
>  					receiver[i].maxdiff);
>  				if (receiver[i].error[0] != '\0') {
> -					printf(receiver[i].error);
> +					printf("%s", receiver[i].error);
>  					errorlines++;
>  					receiver[i].error[0] = '\0';
>  				}
>  				if (sender[i].error[0] != '\0') {
> -					printf(sender[i].error);
> +					printf("%s", sender[i].error);
>  					errorlines++;
>  					receiver[i].error[0] = '\0';
>  				}
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
---1463806542-1233084027-1350342237=:6335--
