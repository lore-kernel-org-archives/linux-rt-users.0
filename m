From: Juergen Beisert <jbe@pengutronix.de>
Subject: Re: Geode GX1 + RT-Preempt + ACPI
Date: Mon, 7 May 2007 19:07:52 +0200
Message-ID: <200705071907.53028.jbe@pengutronix.de>
References: <1178551232.5312.3.camel@godzilla.tecnorama.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Alessio Igor Bogani <abogani@texware.it>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:48894 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934469AbXEGRH6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 7 May 2007 13:07:58 -0400
In-Reply-To: <1178551232.5312.3.camel@godzilla.tecnorama.it>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Monday 07 May 2007 17:20, Alessio Igor Bogani wrote:
> I have this same problem
> (http://www.mail-archive.com/linux-rt-users@vger.kernel.org/msg00333.=
html).
>
> Someone can give me some suggestions?

=46irst of all, running a realtime OS on such a machine is no good idea=
, as it=20
is full of system management software that steals you the CPU.

Try to run your kernel with "clocksource=3Dpit" as this hardware has no=
 usefull=20
other timer with interrupt capability.

Hope it helps
Juergen

--=20
Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=A0Pengutronix - Linux Solutions for Science and Industry
=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=A0 =A0 =A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-5121-206917-7 |  Fax: +49-5121-206917-9
