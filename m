From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [ANNOUNCE] 3.0-rt7 - Error with low latency desktop config
Date: Tue, 9 Aug 2011 19:33:10 +0200
Message-ID: <20110809173310.GB11398@pengutronix.de>
References: <1312465990.16729.22.camel@twins>
 <201108091548.06875.tim.sander@hbm.com>
 <20110809140923.GA11398@pengutronix.de>
 <201108091707.49832.tim.sander@hbm.com>
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
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41310 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754153Ab1HIRdU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Aug 2011 13:33:20 -0400
Content-Disposition: inline
In-Reply-To: <201108091707.49832.tim.sander@hbm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Tim,

On Tue, Aug 09, 2011 at 05:07:49PM +0200, Tim Sander wrote:
> Hi Uwe
>=20
> I just double checked.
> > The config doesn't look like a 3.0-rt7 one. There is neither
> >=20
> > 	PREEMPT_RTB=3Dy
> >=20
> > nor
> >=20
> > 	# PREEMPT_RTB is not set
> If i switch the configs with "Kernel Feature"-> "Preemption Model" -
> >"(Preemtible Kernel) Low-Latency Desktop"
> there are no such config options visible even with a -rt7 kernel.
> (My workflow in ptxdist is
> comment (in/out) rtpatch in patches/linux-3.0/series
> ptxdist clean kernel && ptxdist targetinstall kernel
> deploy.sh
I think targetinstall should ask about the changed config items.

> Otherwise ptxdist would cheat on me and at=20
> $(PROJECT_DIR)/configs/$(PLATFORM)/kernelconfig would be out of sync.=
)
check if ${PROJECT_DIR}/${PLATFORMNAME}/build/linux-3.0/ (or similar)
really has the rt patch applied. (e.g. is there a localversion-rt file?=
)

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
