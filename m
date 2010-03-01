From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 2/3] install backfire.c to $(srcdir)/backfire/
Date: Mon, 1 Mar 2010 20:32:08 +0100
Message-ID: <520f0cf11003011132r64a7f337va877df4c81a662c1@mail.gmail.com>
References: <20100224165611.GA22159@pengutronix.de>
	 <1267030688-12244-2-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>
To: =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f220.google.com ([209.85.219.220]:50768 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118Ab0CATcK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 1 Mar 2010 14:32:10 -0500
Received: by ewy20 with SMTP id 20so1498104ewy.21
        for <linux-rt-users@vger.kernel.org>; Mon, 01 Mar 2010 11:32:09 -0800 (PST)
In-Reply-To: <1267030688-12244-2-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

2010/2/24 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>:
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
> =A0Makefile | =A0 =A01 +
> =A01 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 043b747..99fbba4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -110,6 +110,7 @@ install: all
> =A0 =A0 =A0 =A0install -m 755 src/hwlatdetect/hwlatdetect.py $(DESTDI=
R)$(PYLIB)/hwlatdetect.py
> =A0 =A0 =A0 =A0ln -s $(PYLIB)/hwlatdetect.py "$(DESTDIR)$(bindir)/hwl=
atdetect"
> =A0 =A0 =A0 =A0mkdir -p "$(DESTDIR)$(srcdir)/backfire"
> + =A0 =A0 =A0 install -m 644 src/backfire/backfire.c "$(DESTDIR)$(src=
dir)/backfire/backfire.c"
> =A0 =A0 =A0 =A0gzip src/backfire/backfire.4 -c >"$(DESTDIR)$(mandir)/=
man4/backfire.4.gz"
> =A0 =A0 =A0 =A0gzip src/cyclictest/cyclictest.8 -c >"$(DESTDIR)$(mand=
ir)/man8/cyclictest.8.gz"
> =A0 =A0 =A0 =A0gzip src/pi_tests/pi_stress.8 -c >"$(DESTDIR)$(mandir)=
/man8/pi_stress.8.gz"
> --
> 1.6.6.2
>

Hi Uwe

What is the purpose of this patch?
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
