From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH rt-tests 1/3] backfire: remove unused header file
Date: Mon, 5 Oct 2015 15:58:05 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1510051557480.14006@riemann>
References: <1443955723-23042-1-git-send-email-u.kleine-koenig@pengutronix.de> <1443955723-23042-2-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="-1463804494-1559243072-1444053492=:14006"
Cc: Clark Williams <williams@redhat.com>,
	linux-rt-users@vger.kernel.org, Henrik Austad <haustad@cisco.com>,
	Josh Cartwright <joshc@ni.com>,
	=?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <uwe@kleine-koenig.org>
To: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:33186 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751238AbbJEN6Q (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 5 Oct 2015 09:58:16 -0400
Received: by wiclk2 with SMTP id lk2so121916027wic.0
        for <linux-rt-users@vger.kernel.org>; Mon, 05 Oct 2015 06:58:15 -0700 (PDT)
In-Reply-To: <1443955723-23042-2-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463804494-1559243072-1444053492=:14006
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 4 Oct 2015, Uwe Kleine-König wrote:

> From: Uwe Kleine-König <uwe@kleine-koenig.org>
> 
> Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
> ---
>  src/backfire/version.h | 1 -
>  1 file changed, 1 deletion(-)
>  delete mode 100644 src/backfire/version.h
> 
> diff --git a/src/backfire/version.h b/src/backfire/version.h
> deleted file mode 100644
> index 669b388a5363..000000000000
> --- a/src/backfire/version.h
> +++ /dev/null
> @@ -1 +0,0 @@
> -#define VERSION "0.5"
> -- 
> 2.1.4

Signed-off-by: John Kacur <jkacur@redhat.com>

---1463804494-1559243072-1444053492=:14006--
