From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH RT 8/6] [ARM, WATCHDOG] davinci: include mach/timex.h
	in davinci_wdt.c
Date: Sun, 9 Aug 2009 10:43:06 +0100
Message-ID: <20090809094306.GA26591@n2100.arm.linux.org.uk>
References: <20090807203939.GA19374@pengutronix.de> <1249810600-21946-1-git-send-email-u.kleine-koenig@pengutronix.de> <1249810600-21946-2-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Kevin Hilman <khilman@deeprootsystems.com>,
	linux-arm-kernel@lists.arm.linux.org.uk
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753519AbZHIJn2@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1249810600-21946-2-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sun, Aug 09, 2009 at 11:36:39AM +0200, Uwe Kleine-K=F6nig wrote:
> This fixes a a build failure for 2.6.31-rc4-rt1 (ARCH=3Darm,
> davinci_all_defconfig):
>=20
> 	drivers/watchdog/davinci_wdt.c: In function 'wdt_enable':
> 	drivers/watchdog/davinci_wdt.c:102: error: 'CLOCK_TICK_RATE' undecla=
red (first use in this function)
> 	drivers/watchdog/davinci_wdt.c:102: error: (Each undeclared identifi=
er is reported only once
> 	drivers/watchdog/davinci_wdt.c:102: error: for each function it appe=
ars in.)

It should not be using CLOCK_TICK_RATE - there was a move to clean
up the use of that symbol and restrict it just to the i8253 PIT.
Please create something else like DAVINCI_TICK_RATE instead.
