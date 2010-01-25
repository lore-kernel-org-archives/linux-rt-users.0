From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: ARM fixes for 2.6.31.12-rt20
Date: Mon, 25 Jan 2010 14:07:25 +0100
Message-ID: <20100125130725.GA8159@pengutronix.de>
References: <alpine.LFD.2.00.0908282326460.19335@localhost.localdomain> <alpine.LFD.2.00.0909152257590.8957@localhost.localdomain> <alpine.LFD.2.00.0909190027400.2889@localhost.localdomain> <alpine.LFD.2.00.0910061210400.2646@localhost.localdomain> <alpine.LFD.2.00.0910141115020.9428@localhost.localdomain> <alpine.LFD.2.00.0911061743210.12138@localhost.localdomain> <alpine.LFD.2.00.0911101326280.2725@localhost.localdomain> <alpine.LFD.2.00.1001212102220.2906@localhost.localdomain> <20100125103341.GA3712@pengutronix.de> <alpine.LFD.2.00.1001251142210.2906@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Carsten Emde <ce@ceag.ch>,
	Clark Williams <williams@redhat.com>,
	Frank Rowand <frank.rowand@am.sony.com>,
	Robin Gareus <robin@gareus.org>,
	Gregory Haskins <ghaskins@novell.com>,
	Philippe Reynes <philippe.reynes@isismpp.fr>,
	Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
	Will Schmidt <will_schmidt@vnet.ibm.com>,
	Darren Hart <dvhltc@us.ibm.com>, Jan Blunck <jblunck@suse.de>,
	Sven-Thorsten Dietrich <sdietrich@novell.com>,
	Jon Masters <jcm@redhat.com>,
	Mark Knecht <markknecht@gmail.com>,
	John Kacur <jkacur@redhat.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753074Ab0AYNHi@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1001251142210.2906@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello Thomas,

On Mon, Jan 25, 2010 at 01:45:26PM +0100, Thomas Gleixner wrote:
> On Mon, 25 Jan 2010, Uwe Kleine-K=F6nig wrote:
> > Hello,
> >=20
> > I have done build tests for ARCH=3Darm on 2.6.31.12-rt20 and to fix=
 most
> > platforms I needed to cherry pick three commits from post-2.6.31
> > mainline:
> >=20
> > 	9fd868f ([WATCHDOG] davinci: use clock framework for timer frequen=
cy)
> > 	b9696ea (net: Fix IXP 2000 network driver building.)
> > 	0bfb34f (ARM: S3C2440: mini2440: Fix missing CONFIG_S3C_DEV_USB_HO=
ST)
>=20
> I have a hard time to see, why these patches fix most
> platforms. AFAICT tell each one is fixing a single mach or board.=20
That's right.  The more exact wording is:  After cherry picking these
most platforms (i.e. 133/137) compile without error.

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
