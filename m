From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] Various fixups from first bug reports
Date: Sat, 23 Jul 2011 20:53:04 +0200
Message-ID: <20110723185304.GJ16561@pengutronix.de>
References: <alpine.LFD.2.02.1107211932440.2702@ionos>
 <1311278277-8222-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1311313414.2940.8.camel@box>
 <20110722065711.GD16561@pengutronix.de>
 <87y5zqzick.fsf@rustcorp.com.au>
 <20110722192051.GH16561@pengutronix.de>
 <1311391059.2343.8.camel@box>
 <4E2A9B18.6030000@gareus.org>
 <1311430753.2223.5.camel@box>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robin Gareus <robin@gareus.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Grant Likely <grant.likely@secretlab.ca>,
	devicetree-discuss@lists.ozlabs.org, lguest@lists.ozlabs.org
To: hermann <brummer-@web.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51205 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753265Ab1GWSxJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 23 Jul 2011 14:53:09 -0400
Content-Disposition: inline
In-Reply-To: <1311430753.2223.5.camel@box>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

On Sat, Jul 23, 2011 at 04:19:13PM +0200, hermann wrote:
> Am Samstag, den 23.07.2011, 11:57 +0200 schrieb Robin Gareus:
> Yes, using make-kpkg. I changed line 61 from=20
there is an alternative,

	make deb-pkg

in the vanilla kernel. Depending on why you use make-kpkg it might be
worth a try.

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
