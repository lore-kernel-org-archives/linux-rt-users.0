From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] Various fixups from first bug reports
Date: Fri, 22 Jul 2011 21:20:51 +0200
Message-ID: <20110722192051.GH16561@pengutronix.de>
References: <alpine.LFD.2.02.1107211932440.2702@ionos>
 <1311278277-8222-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1311313414.2940.8.camel@box>
 <20110722065711.GD16561@pengutronix.de>
 <87y5zqzick.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: hermann <brummer-@web.de>
To: Rusty Russell <rusty@rustcorp.com.au>,
	linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Grant Likely <grant.likely@secretlab.ca>,
	devicetree-discuss@lists.ozlabs
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47615 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754950Ab1GVTUx (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Jul 2011 15:20:53 -0400
Content-Disposition: inline
In-Reply-To: <87y5zqzick.fsf@rustcorp.com.au>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

On Fri, Jul 22, 2011 at 08:34:59PM +0930, Rusty Russell wrote:
> On Fri, 22 Jul 2011 08:57:11 +0200, Uwe Kleine-K=F6nig <u.kleine-koen=
ig@pengutronix.de> wrote:
> > > second was with CONFIG_LGUEST_GUEST enabled, module build stage 2=
 failed
> > > with Documentation/lguest not found
> > Hmm, there is Documentation/virtual/lguest. Didn't find where
> > Documentation/lguest is used from a quick look. Rusty?
>=20
> No, it's not compiled from the kernel build, at least in mainline...
>=20
> If it is in the -r tree, you need to
> s,Documentation/lguest,Documentation/virtual/lguest, as it has moved.
I don't understand that and didn't try to reproduce.=20
hermann, maybe you can follow up with your failing .config and try to
reproduce on v3.0 (without rt)?

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
