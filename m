From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH rt-tests] pi_stress: remove timestamp of compilation from
 version output
Date: Tue, 17 Feb 2015 17:46:45 +0100 (CET)
Message-ID: <alpine.LFD.2.10.1502171745580.15981@riemann>
References: <1424185739-29680-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1599515052-1424191615=:15981"
Cc: Clark Williams <clark.williams@gmail.com>,
	linux-rt-users@vger.kernel.org
To: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:59945 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621AbbBQQq7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 Feb 2015 11:46:59 -0500
Received: by mail-wg0-f44.google.com with SMTP id k14so27294431wgh.3
        for <linux-rt-users@vger.kernel.org>; Tue, 17 Feb 2015 08:46:57 -0800 (PST)
In-Reply-To: <1424185739-29680-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1599515052-1424191615=:15981
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Tue, 17 Feb 2015, Uwe Kleine-König wrote:

> Having the date and time of compilation is hardly useful and is in the
> way for reproducible building binaries.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> a few people work on getting reproducible builds for Debian. Using
> __DATE__ and __TIME__ obviously makes the rt-tests package fail to
> compile in a deterministic fashion.
> 
> Best regards
> Uwe
> 
>  src/pi_tests/pi_stress.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
> index e273d62..9b33fad 100644
> --- a/src/pi_tests/pi_stress.c
> +++ b/src/pi_tests/pi_stress.c
> @@ -1235,7 +1235,6 @@ void process_command_line(int argc, char **argv)
>  			break;
>  		case 'V':
>  			printf("pi_stress v%1.2f ", VERSION_STRING);
> -			printf("(%s %s)\n", __DATE__, __TIME__);
>  			exit(0);
>  		case 'u':
>  			uniprocessor = 1;
> -- 
> 2.1.4
> 
> --

This patch is okay with me.
Signed-off-by: John Kacur <jkacur@redhat.com>> 
--0-1599515052-1424191615=:15981--
