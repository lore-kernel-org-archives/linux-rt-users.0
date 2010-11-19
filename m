From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: Locating processes impacting my rt application
Date: Fri, 19 Nov 2010 15:53:14 +0100
Message-ID: <20101119145314.GS8942@pengutronix.de>
References: <4CE428CB.20808@willowgarage.com> <4CE480BF.7050603@linux.intel.com> <4CE5A4A3.4040202@cygnusx-1.org> <B5339992F194184BABF87ECF0296990D034E5F0F@GLKMS2105.GREENLNK.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: "Leggo, Adam (UK)" <Adam.Leggo2@baesystems.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53001 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753210Ab0KSOxT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 19 Nov 2010 09:53:19 -0500
Content-Disposition: inline
In-Reply-To: <B5339992F194184BABF87ECF0296990D034E5F0F@GLKMS2105.GREENLNK.NET>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Adam,

On Fri, Nov 19, 2010 at 12:05:11PM -0000, Leggo, Adam (UK) wrote:
> Hello,=20
>=20
> I have been working on a simulator that sends large amount of data to
> another system. I am having a problem where something in the system i=
s
> interupting my processing loops for an extended period. I would like
> some suggestions on how to find the offending process and prevent it
> from impacting my applications while it is running.
Maybe an SMI is the problem here.  Did you try hwlatdetect?

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
