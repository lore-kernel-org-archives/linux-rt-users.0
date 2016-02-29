From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: acmesystems Arietta (AT91SAM9G25)
Date: Mon, 29 Feb 2016 09:10:40 +0100
Message-ID: <20160229081039.GC2613@pengutronix.de>
References: <nat4ql$41m$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Jean-Denis Girard <jd.girard@sysnux.pf>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:35390 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751978AbcB2IKn (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 29 Feb 2016 03:10:43 -0500
Content-Disposition: inline
In-Reply-To: <nat4ql$41m$1@ger.gmane.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Jean-Denis,

On Sat, Feb 27, 2016 at 11:35:17AM -1000, Jean-Denis Girard wrote:
> I'm very interested in running RT Linux on my Arietta boad: the quest=
ion
> has been raised on the acmesystems forum
> (https://groups.google.com/forum/#!topic/acmesystems/_AyrGYMXBmc), so
> I'm not alone!
>=20
> I have tried 4.4.2-rt7. When configuring PREEMPT__LL, my config works
> fine, but when just changing to PREEMPT_RT_FULL, it won't boot.

Alexandre Belloni wrote something about rt and at91 that might be worth
to look into. I don't know how much of it is obsolete with 4.4.2-rt7,
though.

http://article.gmane.org/gmane.linux.rt.user/14728

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
