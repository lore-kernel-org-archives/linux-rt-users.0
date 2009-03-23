From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: potential and requirements of RT-patched Linux
Date: Mon, 23 Mar 2009 21:38:07 +0100
Message-ID: <20090323203807.GX5367@pengutronix.de>
References: <200903231606.n2NG6Zqc001174@post.webmailer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Thomas =?iso-8859-15?Q?H=E4berle?= <thomas.haeberle@vipco.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45274 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753773AbZCWUiK (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 23 Mar 2009 16:38:10 -0400
Content-Disposition: inline
In-Reply-To: <200903231606.n2NG6Zqc001174@post.webmailer.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Mar 23, 2009 at 05:06:35PM +0100, Thomas H=E4berle wrote:
> I am currently collecting information about the potential and
> requirements of a RT-patched Linux.  Some systems, numbers and thus
> perspectives are already on the RT-patch-wiki site, but I would like
> to know more about your recent experiences since the last contributio=
n
> to the "Platforms Tested and in Use with CONFIG_PREEMPT_RT" table is
> about a year old.
>=20
> What systems are you developing on? What about PowerPCs? What
> performance can I roughly expect if I take my little MPC5200 (500MHz,
> 64MB DRAM) and run it with a RT-patched Linux? Can I control my own
> laser-robot like the Trumpf guys? ;-) > No, seriously: The realtime
> capabilities on high-end hardware are quite impressive, but how do
> they change downward to smaller embedded systems? It's surely not a
> linear regession, is it?

http://www.pengutronix.de/oselas/realtime/results/20081014-1/

rsc
--=20
Pengutronix e.K.                           |                           =
  |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0  =
  |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-555=
5 |
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
