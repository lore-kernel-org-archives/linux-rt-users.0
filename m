From: hermann <brummer-@web.de>
Subject: Re: [PATCH] Various fixups from first bug reports
Date: Fri, 22 Jul 2011 07:43:34 +0200
Message-ID: <1311313414.2940.8.camel@box>
References: <alpine.LFD.2.02.1107211932440.2702@ionos>
	 <1311278277-8222-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from fmmailgate02.web.de ([217.72.192.227]:40696 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753370Ab1GVFnh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Jul 2011 01:43:37 -0400
In-Reply-To: <1311278277-8222-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Am Donnerstag, den 21.07.2011, 21:57 +0200 schrieb Uwe Kleine-K=C3=B6ni=
g:
> From: Thomas Gleixner <tglx@linutronix.de>
>=20
> ---
> Hello,
>=20
> this is the patch Thomas sent earlier in this thread with the two fix=
ups
> folded in that occured in reply to Thomas' patch.
>=20
> Best regards
> Uwe
>=20

Hi

well, I run into 2 ops, witch, I guess not related to the rt patch.

first one was with CONFIG_SENSORS_LTC4245, module build stage 2 failed
with undefined reference to of_find_property

second was with CONFIG_LGUEST_GUEST enabled, module build stage 2 faile=
d
with Documentation/lguest not found

Anyhow, I'm now writing from=20
 System:    Host box Kernel 3.0.0-rc7-rt0 i686 (32 bit gcc 4.5.2)=20
           Desktop Xfce 4.8.2 (Gtk 2.24.4) Distro Debian GNU/Linux
wheezy/sid

many thanks for that, great work,=20

regards
hermann


--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
