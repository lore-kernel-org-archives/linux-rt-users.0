From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [ANNOUNCE] 3.0-rt6
Date: Thu, 4 Aug 2011 22:15:00 +0200
Message-ID: <20110804201500.GL31521@pengutronix.de>
References: <alpine.LFD.2.02.1107282213000.31246@ionos>
 <4E3A3D7C.6050403@localhost>
 <1312450965.16729.7.camel@twins>
 <4E3AED68.5060506@ccrma.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4E3AED68.5060506@ccrma.stanford.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, Aug 04, 2011 at 12:05:12PM -0700, Fernando Lopez-Lezcano wrote:
> Was going to try this but it appears it is in rt7, trying to build
> rt7 fails with:
>=20
> ERROR: "of_find_property" [drivers/tty/serial/of_serial.ko] undefined=
!
> ERROR: "of_find_property" [drivers/hwmon/ltc4245.ko] undefined!
This is known but unfixed, see
http://mid.gmane.org/20110722065711.GD16561@pengutronix.de

You should be able to workaround that by jugling with the .config. I.e.
disable OF or something like that.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
