From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH rt-tests] drop compiling without NPTL support
Date: Tue, 6 Oct 2015 08:49:56 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1510060849280.14006@riemann>
References: <alpine.LFD.2.20.1510052149190.14006@riemann> <1444113838-5123-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="-1463804494-1989304972-1444114197=:14006"
Cc: linux-rt-users@vger.kernel.org, williams@redhat.com
To: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:34077 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073AbbJFGt7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Oct 2015 02:49:59 -0400
Received: by wicfx3 with SMTP id fx3so151147354wic.1
        for <linux-rt-users@vger.kernel.org>; Mon, 05 Oct 2015 23:49:58 -0700 (PDT)
In-Reply-To: <1444113838-5123-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463804494-1989304972-1444114197=:14006
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT



On Tue, 6 Oct 2015, Uwe Kleine-König wrote:

> all programs apart from sendme use pthreads so NPTL=no is hardly useful
> any more.
> ---
>  Makefile | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 1e255a983574..6ce2ecc7fc30 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -4,14 +4,17 @@ AR=$(CROSS_COMPILE)ar
>  
>  OBJDIR = bld
>  
> -HAVE_NPTL ?= yes
> -
> -ifeq ($(HAVE_NPTL),yes)
> -sources = cyclictest.c pi_stress.c pip_stress.c pmqtest.c rt-migrate-test.c
> -endif
> -
> -sources += signaltest.c ptsematest.c sigwaittest.c svsematest.c sendme.c \
> -	  hackbench.c
> +sources = cyclictest.c \
> +	  hackbench.c \
> +	  pip_stress.c \
> +	  pi_stress.c \
> +	  pmqtest.c \
> +	  ptsematest.c \
> +	  rt-migrate-test.c \
> +	  sendme.c \
> +	  signaltest.c \
> +	  sigwaittest.c \
> +	  svsematest.c
>  
>  TARGETS = $(sources:.c=)
>  
> -- 
> 2.1.4

Yes, it's outdated
Signed-off-by: John Kacur <jkacur@redhat.com>
---1463804494-1989304972-1444114197=:14006--
