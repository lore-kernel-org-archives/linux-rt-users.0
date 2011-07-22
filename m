From: hermann <brummer-@web.de>
Subject: Re: [PATCH] Various fixups from first bug reports
Date: Fri, 22 Jul 2011 09:40:50 +0200
Message-ID: <1311320450.2940.11.camel@box>
References: <alpine.LFD.2.02.1107211932440.2702@ionos>
	 <1311278277-8222-1-git-send-email-u.kleine-koenig@pengutronix.de>
	 <1311313414.2940.8.camel@box>  <20110722065711.GD16561@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Grant Likely <grant.likely@secretlab.ca>,
	devicetree-discuss@lists.ozlabs.org,
	Rusty Russell <rusty@rustcorp.com.au>, lguest@lists.ozlabs.org
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from fmmailgate03.web.de ([217.72.192.234]:58484 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374Ab1GVHk6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Jul 2011 03:40:58 -0400
In-Reply-To: <20110722065711.GD16561@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Am Freitag, den 22.07.2011, 08:57 +0200 schrieb Uwe Kleine-K=C3=B6nig:
> > second was with CONFIG_LGUEST_GUEST enabled, module build stage 2
> failed
> > with Documentation/lguest not found
> Hmm, there is Documentation/virtual/lguest. Didn't find where
> Documentation/lguest is used from a quick look. Rusty?
>=20
> Best regards
> Uwe=20

Sorry, I'm far from being a expert, all I can say is that disable=20
CONFIG_LGUEST and
CONFIG_LGUEST_GUEST also (auto)disable
CONFIG_PARAVIRT_SPINLOCKS
and then it works, at least here.

regards
hermann

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
