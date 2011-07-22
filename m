From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Various fixups from first bug reports
Date: Fri, 22 Jul 2011 20:34:59 +0930
Message-ID: <87y5zqzick.fsf@rustcorp.com.au>
References: <alpine.LFD.2.02.1107211932440.2702@ionos> <1311278277-8222-1-git-send-email-u.kleine-koenig@pengutronix.de> <1311313414.2940.8.camel@box> <20110722065711.GD16561@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Grant Likely <grant.likely@secretlab.ca>,
	devicetree-discuss@lists.ozlabs.org, lguest@lists.ozlabs.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>, hermann <brummer-@web.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:56353 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753637Ab1GVLno convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Jul 2011 07:43:44 -0400
In-Reply-To: <20110722065711.GD16561@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 22 Jul 2011 08:57:11 +0200, Uwe Kleine-K=C3=B6nig <u.kleine-koe=
nig@pengutronix.de> wrote:
> Hello,
>=20
> (These two issues occured on 3.0-rc7-rt0, I think they apply to
> mainline, too.)
>=20
> On Fri, Jul 22, 2011 at 07:43:34AM +0200, hermann wrote:
> > well, I run into 2 ops, witch, I guess not related to the rt patch.
> >=20
> > first one was with CONFIG_SENSORS_LTC4245, module build stage 2 fai=
led
> > with undefined reference to of_find_property
> of_find_property isn't exported to modules. Maybe of_get_property sho=
uld
> be used? Should of_find_property be static then? Alternatively export
> of_find_property, too. Grant?
>=20
> > second was with CONFIG_LGUEST_GUEST enabled, module build stage 2 f=
ailed
> > with Documentation/lguest not found
> Hmm, there is Documentation/virtual/lguest. Didn't find where
> Documentation/lguest is used from a quick look. Rusty?

No, it's not compiled from the kernel build, at least in mainline...

If it is in the -r tree, you need to
s,Documentation/lguest,Documentation/virtual/lguest, as it has moved.

Cheers,
Rusty.
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
