From: Joakim Hernberg <jhernberg@alchemy.lu>
Subject: Re: [PATCH] make HWLAT_DETECTOR kernel config either disabled or a
 module, never builtin.
Date: Sun, 13 Dec 2015 11:39:35 +0100
Message-ID: <20151213113935.59cfd847@balder.valhalla.alchemy.lu>
References: <20150923193340.0881074b@tor.valhalla.alchemy.lu>
	<20151211165240.GG6720@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
	<u.kleine-koenig@pengutronix.de>, John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailsafe.webbplatsen.se ([94.247.172.109]:65046 "EHLO
	mailsafe.webbplatsen.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541AbbLMKjv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 13 Dec 2015 05:39:51 -0500
In-Reply-To: <20151211165240.GG6720@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 11 Dec 2015 17:52:40 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> * Joakim Hernberg | 2015-09-23 19:33:40 [+0200]:
>=20
> >Since the HWLAT_DETECTOR driver supposedly shouldn't be builtin, but
> >a module when used at all, it would make sense to limit the
> >configuration choices: =20
>=20
> what is wrong with it beeing built-in? The default is m already.
>=20
> >Signed-off-by: Joakim Hernberg <jhernberg@alchemy.lu>
> >Suggested-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>=
 =20
>=20
> Sebastian

I looked at the IRC logs from when this was discussed.  The hwlatdetect
script looks for the kernel module and will fail if it's built-in (or
compressed).  Also this quote from irc: <jkacur> I need to look
at the code, but offhand, I think we said, it cannot be a built-in by d=
esign

These were the reasons for the patch.

--=20

   Joakim
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
