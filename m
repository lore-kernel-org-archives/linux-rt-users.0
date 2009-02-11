From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: WARN_ON(!rt_rq->rt_nr_running) question?
Date: Wed, 11 Feb 2009 10:19:11 +0100
Message-ID: <20090211091911.GA29388@pengutronix.de>
References: <229545.37726.qm@web59515.mail.ac4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: raja gobi <raja.gobi@yahoo.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39986 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754236AbZBKJTO (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 11 Feb 2009 04:19:14 -0500
Content-Disposition: inline
In-Reply-To: <229545.37726.qm@web59515.mail.ac4.yahoo.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

On Tue, Feb 10, 2009 at 07:17:57PM -0800, raja gobi wrote:
> This is a question about sched_rt.c. I am hoping this is the correct
> mailing list for such questions. If not, could somebody direct me to
> the correct place?
>=20
> I am using 2.6.25.16 on an MX27 (ARM)
If you're not running an -rt kernel, probably the linux-arm-kernel ML i=
s
the right place to ask.  Or if you think this problem is not ARM
specific, use LKML.  And probably you should Cc: Ingo Molnar.

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
