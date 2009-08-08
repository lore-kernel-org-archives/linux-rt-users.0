From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/6] s3c2443-ac97: convert semaphore to mutex
Date: Sat, 8 Aug 2009 08:57:55 +0100
Message-ID: <20090808075754.GB4519@sirena.org.uk>
References: <20090807203939.GA19374@pengutronix.de>
 <1249677761-19470-2-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
	Liam Girdwood <lrg@slimlogic.co.uk>,
	Ben Dooks <ben-linux@fluff.org>,
	Timur Tabi <timur@freescale.com>,
	Eric Miao <eric.miao@marvell.com>, alsa-devel@alsa-project.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754808AbZHHH6P@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1249677761-19470-2-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, Aug 07, 2009 at 10:42:37PM +0200, Uwe Kleine-K=F6nig wrote:

> This fixes a build failure for 2.6.31-rc4-rt1 (ARCH=3Darm, s3c2410_de=
fconfig):

Applied, thanks.
