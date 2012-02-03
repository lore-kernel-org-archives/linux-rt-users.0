From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: infinite spin in RT when booting with DHCP on
Date: Fri, 3 Feb 2012 20:25:09 +0100
Message-ID: <20120203192509.GR25594@pengutronix.de>
References: <4F292FE0.7090302@digi.com>
 <201202021338.44950.tim.sander@hbm.com>
 <20120202201336.GF25594@pengutronix.de>
 <4F2BB59C.4080206@digi.com>
 <20120203103520.GI25594@pengutronix.de>
 <4F2C07EE.10408@digi.com>
 <1328287427.5882.159.camel@gandalf.stny.rr.com>
 <4F2C1885.8030301@digi.com>
 <1328290789.5882.166.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Hector Palacios <hector.palacios@digi.com>,
	Tim Sander <tim.sander@hbm.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"lclaudio@uudg.org" <lclaudio@uudg.org>,
	"efault@gmx.de" <efault@gmx.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53785 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754779Ab2BCTZP (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 3 Feb 2012 14:25:15 -0500
Content-Disposition: inline
In-Reply-To: <1328290789.5882.166.camel@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

On Fri, Feb 03, 2012 at 12:39:49PM -0500, Steven Rostedt wrote:
> > There doesn't seem to be a maintainer for this driver... should I t=
ake the action of=20
> > posting this to the mainline kernel list?
>=20
> I would send a note to LKML asking why this hasn't been included in
> mainline, and Cc the following:
AFAICT Hector found the patch in a Vendor BSP. I guess they never
forwarded it and so none of the open source guys is to blame. (Note I
didn't check that, but I'd be surprised if I were wrong.)

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
