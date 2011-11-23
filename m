From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [ANNOUNCE] 3.0.10-rt27
Date: Wed, 23 Nov 2011 12:55:55 +0100
Message-ID: <20111123115555.GN19986@pengutronix.de>
References: <1322010805.20742.40.camel@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Carsten Emde <C.Emde@osadl.org>,
	"Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
	kernel@pengutronix.de
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1322010805.20742.40.camel@frodo>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello,

On Tue, Nov 22, 2011 at 08:13:25PM -0500, Steven Rostedt wrote:
> I'm please to announce the 3.0.10-rt27 stable release.
As Debian unstable already switched to 3.1 I provided this release on a
Pengutronix server.

If you want it, you can just add

	deb http://debian.pengutronix.de/debian sid main

to your apt's sources list and after an list update install

	linux-image-3.0.0-2-rt-amd64

(and pengutronix-archive-keyring if you're embarrassed by the warnings
about untrusted sources).

Alternatively just download

	http://debian.pengutronix.de/debian/pool/main/l/linux-2.6/linux-image-=
3.0.0-2-rt-amd64_3.0.0-6ptx3_amd64.deb

and install it using dpkg.

Version 3.0.0-6ptx3 includes 3.0.10-rt27 (well in fact it's 3.0.9-rt26 =
+
3.0.10, but the result is the same).

It should integrate well with a squeeze system, but note that I only
tested it lightly. If you have any problems or suggestions free to
report them to me via this list.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
