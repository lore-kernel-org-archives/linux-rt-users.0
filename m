From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 1/3] trivial: s/specifed/specified/
Date: Mon, 1 Mar 2010 20:32:57 +0100
Message-ID: <520f0cf11003011132x14c8be02ja6f314c0a21e7cb4@mail.gmail.com>
References: <20100224165611.GA22159@pengutronix.de>
	 <1267030688-12244-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>
To: =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f220.google.com ([209.85.219.220]:64545 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281Ab0CATdI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 1 Mar 2010 14:33:08 -0500
Received: by ewy20 with SMTP id 20so1498945ewy.21
        for <linux-rt-users@vger.kernel.org>; Mon, 01 Mar 2010 11:33:07 -0800 (PST)
In-Reply-To: <1267030688-12244-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

2010/2/24 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>:
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
> =A0src/cyclictest/cyclictest.8 | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.=
8
> index 8f846c6..91e1102 100644
> --- a/src/cyclictest/cyclictest.8
> +++ b/src/cyclictest/cyclictest.8
> @@ -130,7 +130,7 @@ set the ftrace tracer function. Used with the \-b=
 option. Must be one
> =A0of the trace functions available from <debugfs-mountpoint>/kernel/=
debug/tracing/available_tracers
> =A0.TP
> =A0.B \-t, \-\-threads[=3DNUM]
> -Set the number of test threads (default is 1). Create NUM test threa=
ds. If NUM is not specifed, NUM is set to
> +Set the number of test threads (default is 1). Create NUM test threa=
ds. If NUM is not specified, NUM is set to
> =A0the number of available CPUs. See \-d, \-i and \-p for further inf=
ormation.
> =A0.TP
> =A0.B \-m, \-\-mlockall
> --
> 1.6.6.2

This is fine of course.
Acked-by: John Kacur <jkacur@redhat.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
