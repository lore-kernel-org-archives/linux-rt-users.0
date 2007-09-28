From: Juergen Beisert <jbe@pengutronix.de>
Subject: Re: Network hangs when rt-preempt patch is applied
Date: Fri, 28 Sep 2007 17:10:24 +0200
Message-ID: <200709281710.25613.jbe@pengutronix.de>
References: <200709281213.34994.jbe@pengutronix.de> <1190990989.17385.0.camel@imap.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Walker <dwalker@mvista.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:52799 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758342AbXI1PKd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 28 Sep 2007 11:10:33 -0400
In-Reply-To: <1190990989.17385.0.camel@imap.mvista.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Friday 28 September 2007 16:49, Daniel Walker wrote:
> On Fri, 2007-09-28 at 12:13 +0200, Juergen Beisert wrote:
> > Hi,
> >
> > I'm trying to find out if this is an MPC5200B related driver proble=
m or
> > RT-Preempt related one: Under some network (nmap, nc) load the netw=
ork
> > dies on my target.
> >
> > Target (PowerPC) runs 2.6.23-rc8 plus patch-2.6.23-rc8-rt1.
> >
> > Sometimes it survives the nmap, but mostly it dies immediately. Her=
e it
> > was successfull in the first nmap run, but dies on the second one:
>
> Which networking driver are you using?

Domen Puncer's FEC driver and Sylvain Munaut's bestcomm driver.

Juergen
--=20
Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=A0Pengutronix - Linux Solutions for Science and Industry
=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=A0 =A0 =A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
