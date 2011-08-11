From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [ANNOUNCE] 3.0-rt7 - Error with low latency desktop config
Date: Thu, 11 Aug 2011 12:21:39 +0200
Message-ID: <20110811102138.GC11398@pengutronix.de>
References: <1312465990.16729.22.camel@twins>
 <201108091707.49832.tim.sander@hbm.com>
 <20110809173310.GB11398@pengutronix.de>
 <201108101833.54661.tim.sander@hbm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Zijlstra <peterz@infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Paul E. McKenney" <paulmck@us.ibm.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Tim Sander <tim.sander@hbm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60895 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755265Ab1HKKVv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Aug 2011 06:21:51 -0400
Content-Disposition: inline
In-Reply-To: <201108101833.54661.tim.sander@hbm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Aug 10, 2011 at 06:33:54PM +0200, Tim Sander wrote:
> Hi Uwe
>=20
> I triple checked.
> > I think targetinstall should ask about the changed config items.
> It only asks one way, when going from an upatched kernel to an patche=
d one.
> Since i was coming from an preempt rt kernel to an unpatched one no q=
uestions
> where asked (probably since all settings where still in place as i wa=
sn't=20
> using the preempt rt feature with the preempt rt patched kernel sourc=
e
> aka "Low latency desktop")
I guess that when the kernel build updates .config your
${PROJECT_DIR}/config/${PLATFORMNAME}/kernelconfig isn't adapted
accordingly. So yes, it might be out of sync. So better provide
${PROJECT_DIR}/${PLATFORMNAME}/build/linux-3.0/.config please.
=20
> But i think the regression when going from 3.0-rt7 to 3.0.1-rt8 with=20
> CONFIG_PREEMPT_RTB is more worthwhile to discuss. Which i detailed in=
 the=20
> other mail.
You didn't talk about CONFIG_PREEMPT_RTB before, did you? I just used i=
t
as indicator that the .config you sent isn't for an -rt kernel.

Your machine is based on Phytec's pcm043? I could try to test on one of
those an unpatched -rt kernel, but I don't promise to come around to do=
 it.

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
