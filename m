From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH rt-tests 2/3] rt-migrate-test: remove space before \n
Date: Tue, 6 Oct 2015 09:04:43 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1510060904240.14006@riemann>
References: <1444071917-1450-1-git-send-email-u.kleine-koenig@pengutronix.de> <1444071917-1450-2-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="-1463804494-253304992-1444115084=:14006"
Cc: linux-rt-users@vger.kernel.org, williams@redhat.com
To: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:33907 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522AbbJFHEq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Oct 2015 03:04:46 -0400
Received: by wicfx3 with SMTP id fx3so151621245wic.1
        for <linux-rt-users@vger.kernel.org>; Tue, 06 Oct 2015 00:04:45 -0700 (PDT)
In-Reply-To: <1444071917-1450-2-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463804494-253304992-1444115084=:14006
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT



On Mon, 5 Oct 2015, Uwe Kleine-König wrote:

> This fixes a checkpatch warning
> 
> 	WARNING: unnecessary whitespace before a quoted newline
> ---
>  src/rt-migrate-test/rt-migrate-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate-test/rt-migrate-test.c
> index 85a78dab7403..d7b68ddac3e5 100644
> --- a/src/rt-migrate-test/rt-migrate-test.c
> +++ b/src/rt-migrate-test/rt-migrate-test.c
> @@ -178,7 +178,7 @@ static void usage(char **argv)
>  	printf("%s %1.2f\n", p, VERSION);
>  	printf("Usage:\n"
>  	       "%s <options> nr_tasks\n\n"
> -	       "-p prio --prio  prio        base priority to start RT tasks with (2) \n"
> +	       "-p prio --prio  prio        base priority to start RT tasks with (2)\n"
>  	       "-r time --run-time time     Run time (ms) to busy loop the threads (20)\n"
>  	       "-s time --sleep-time time   Sleep time (ms) between intervals (100)\n"
>  	       "-m time --maxerr time       Max allowed error (microsecs)\n"
> -- 
> 2.1.4
> 

Fine, Signed-off-by: John Kacur <jkacur@redhat.com>
---1463804494-253304992-1444115084=:14006--
