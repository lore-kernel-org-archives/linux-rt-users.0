From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] Various fixups from first bug reports
Date: Fri, 22 Jul 2011 08:57:11 +0200
Message-ID: <20110722065711.GD16561@pengutronix.de>
References: <alpine.LFD.2.02.1107211932440.2702@ionos>
 <1311278277-8222-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1311313414.2940.8.camel@box>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Grant Likely <grant.likely@secretlab.ca>,
	devicetree-discuss@lists.ozlabs.org,
	Rusty Russell <rusty@rustcorp.com.au>, lguest@lists.ozlabs.org
To: hermann <brummer-@web.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53172 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755Ab1GVG5O (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Jul 2011 02:57:14 -0400
Content-Disposition: inline
In-Reply-To: <1311313414.2940.8.camel@box>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

(These two issues occured on 3.0-rc7-rt0, I think they apply to
mainline, too.)

On Fri, Jul 22, 2011 at 07:43:34AM +0200, hermann wrote:
> well, I run into 2 ops, witch, I guess not related to the rt patch.
>=20
> first one was with CONFIG_SENSORS_LTC4245, module build stage 2 faile=
d
> with undefined reference to of_find_property
of_find_property isn't exported to modules. Maybe of_get_property shoul=
d
be used? Should of_find_property be static then? Alternatively export
of_find_property, too. Grant?

> second was with CONFIG_LGUEST_GUEST enabled, module build stage 2 fai=
led
> with Documentation/lguest not found
Hmm, there is Documentation/virtual/lguest. Didn't find where
Documentation/lguest is used from a quick look. Rusty?

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
