From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: Interrupt Latency 2.6.33.7 rt30
Date: Fri, 26 Aug 2011 09:48:36 +0200
Message-ID: <20110826074836.GO16557@pengutronix.de>
References: <4E56B8A5.6080306@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Christian Kraus <chk.dax@gmx.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33768 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751781Ab1HZHsh (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 26 Aug 2011 03:48:37 -0400
Content-Disposition: inline
In-Reply-To: <4E56B8A5.6080306@gmx.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Aug 25, 2011 at 11:03:33PM +0200, Christian Kraus wrote:
> Hello
> I have wrote a GPIO-driver, that toggle the value of a GPIO when a
> interrupt is comming from an another GPIO.
> When I measure the latency between the interrupt and the toggled Pin
> it's about ten times higher than without the rt-patch.
> (without Patch =3D 8-11 us
>  with Patch =3D 30-110 us)
It's expected and known that an rt kernel has a worse average latency.
Having said that I cannot say if the increase you see is "too much".

The best option you have is asking ftrace what happens in these 30-110
us after making sure you have a decent sched_clock implementation.

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
