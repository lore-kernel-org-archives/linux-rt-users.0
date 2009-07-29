From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: Real-Time Clocks and POSIX
Date: Wed, 29 Jul 2009 09:44:48 +0200
Message-ID: <20090729074448.GA7911@pengutronix.de>
References: <0DEF6B92D4B25D479DDA432440101F33C96F33@CHM-EMAIL1.ad.mc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: "Pilhofer, Frank" <fpilhofe@mc.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34103 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861AbZG2Hot (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 29 Jul 2009 03:44:49 -0400
Content-Disposition: inline
In-Reply-To: <0DEF6B92D4B25D479DDA432440101F33C96F33@CHM-EMAIL1.ad.mc.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Frank,

On Tue, Jul 28, 2009 at 01:21:48PM -0400, Pilhofer, Frank wrote:
> I'm looking into real-time clocks.
This is the wrong forum for real-time clocks.  This list is about
realtime systems, not clocks.  The relevant MAINTAINER entry for you is=
:

	REAL TIME CLOCK (RTC) SUBSYSTEM
	P:      Alessandro Zummo
	M:      a.zummo@towertech.it
	L:      rtc-linux@googlegroups.com
	S:      Maintained
	F:      Documentation/rtc.txt
	F:      drivers/rtc/
	F:      include/linux/rtc.h

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
