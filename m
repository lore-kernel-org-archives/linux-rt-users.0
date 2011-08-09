From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [ANNOUNCE] 3.0-rt7 - Error with low latency desktop config
Date: Tue, 9 Aug 2011 16:09:23 +0200
Message-ID: <20110809140923.GA11398@pengutronix.de>
References: <1312465990.16729.22.camel@twins>
 <201108091548.06875.tim.sander@hbm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Zijlstra <peterz@infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Paul E. McKenney" <paulmck@us.ibm.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Tim Sander <tim.sander@hbm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201108091548.06875.tim.sander@hbm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, Aug 09, 2011 at 03:48:06PM +0200, Tim Sander wrote:
> Hi
>=20
> When running a slightly patched 3.0-rt7 kernel  as a low latency desk=
top config=20
> with the kconfig as attached i get appended error below.=20
>=20
> I'm not sure if you are interested in these errors but since you are =
aiming=20
> for inclusion into mainline, i think these errors are also worthwhile=
?
>=20
> Note this is not a vanilla 3.0-rt7 since that does not run on our har=
dware,=20
> but tried to make sure that this error is not from my platform patche=
s.
The config doesn't look like a 3.0-rt7 one. There is neither

	PREEMPT_RTB=3Dy

nor

	# PREEMPT_RTB is not set

in it.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
