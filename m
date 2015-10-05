From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH rt-tests 1/3] all programs apart from sendme use pthreads
 so skip them on NPTL!=yes
Date: Mon, 5 Oct 2015 21:50:11 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1510052149190.14006@riemann>
References: <1444071917-1450-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="-1463804494-1531780376-1444074612=:14006"
Cc: linux-rt-users@vger.kernel.org, williams@redhat.com
To: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:36784 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752502AbbJETuP (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 5 Oct 2015 15:50:15 -0400
Received: by wicgb1 with SMTP id gb1so135158229wic.1
        for <linux-rt-users@vger.kernel.org>; Mon, 05 Oct 2015 12:50:14 -0700 (PDT)
In-Reply-To: <1444071917-1450-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463804494-1531780376-1444074612=:14006
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT



On Mon, 5 Oct 2015, Uwe Kleine-König wrote:

> ---
>  Makefile | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 6c96c9f31a19..af669263a5fb 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -7,11 +7,19 @@ OBJDIR = bld
>  HAVE_NPTL ?= yes
>  
>  ifeq ($(HAVE_NPTL),yes)
> -sources = cyclictest.c pi_stress.c pip_stress.c pmqtest.c rt-migrate-test.c
> +sources = cyclictest.c \
> +	  hackbench.c \
> +	  pip_stress.c \
> +	  pi_stress.c \
> +	  pmqtest.c \
> +	  ptsematest.c \
> +	  rt-migrate-test.c \
> +	  signaltest.c \
> +	  sigwaittest.c \
> +	  svsematest.c
>  endif
>  
> -sources += signaltest.c ptsematest.c sigwaittest.c svsematest.c sendme.c \
> -	  hackbench.c
> +sources += sendme.c
>  
>  TARGETS = $(sources:.c=)
>  
> -- 
> 2.1.4

Ok, I thought that might be useful for bionic, but now I can see, that 
it's pretty much useless. Why don't you just remove HAVE_NPTL altogether?

Thanks
John
---1463804494-1531780376-1444074612=:14006--
