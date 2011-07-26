From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [ANNOUNCE] 3.0-rt3
Date: Tue, 26 Jul 2011 11:13:10 +0200
Message-ID: <20110726091310.GP16561@pengutronix.de>
References: <alpine.LFD.2.02.1107241223560.2702@ionos>
 <4E2DF459.3030509@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4E2DF459.3030509@localhost>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, Jul 25, 2011 at 03:55:21PM -0700, Fernando Lopez-Lezcano wrote:
> On 07/24/2011 03:33 AM, Thomas Gleixner wrote:
> >Dear RT Folks,
> >
> >I'm pleased to announce the 3.0-rt3 release.
>=20
> Thanks!!... testing on a dual core laptop, fedora 15, 32 bit:
>=20
> [   32.169727] BUG: MAX_LOCKDEP_ENTRIES too low!
> [   32.169730] turning off the locking correctness validator.
>=20
> (where do I change this?)
I'd guess you need to increase MAX_LOCKDEP_ENTRIES which is defined in
kernel/lockdep_internals.h.

BTW, I hit that, too.

Best regards
Uwe


--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
