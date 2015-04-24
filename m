From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: 3.14.36-rt34 kernel crash on imx6
Date: Fri, 24 Apr 2015 09:02:09 +0200
Message-ID: <20150424070209.GI19431@pengutronix.de>
References: <552F7406.1030806@geral.com>
 <5534C848.4010809@geral.com>
 <20150423163219.3c354d19@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexandre COFFIGNAL <acoffignal@geral.com>,
	rt-users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37449 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933458AbbDXHCO (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 24 Apr 2015 03:02:14 -0400
Content-Disposition: inline
In-Reply-To: <20150423163219.3c354d19@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Helo,

On Thu, Apr 23, 2015 at 04:32:19PM -0400, Steven Rostedt wrote:
> On Mon, 20 Apr 2015 11:35:04 +0200
> Alexandre COFFIGNAL <acoffignal@geral.com> wrote:
> > we are running PREEMPT_RT 3.14.36-rt34 on a imx6 board which works =
really fine.
> > But we see the following trace when we run this very simple app ove=
r ssh :
>=20
> I tried to see if I could reproduce this on my ARM board, but my
> snowball board is dead, and my beaglebone white, for some reason wont
> boot 3.14 (vanilla or -rt).
Another thing to try is 3.14.36 without -rt.

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
