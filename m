From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: [patch 15/15] coding style fixes
Date: Wed, 25 Jul 2007 01:07:32 +0200
Message-ID: <20070724230732.GN1678@pengutronix.de>
References: <20070724092517.390730736@metis.extern.pengutronix.de> <20070724092619.223951206@metis.extern.pengutronix.de> <200707241426.50995.dvhltc@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:42785 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752467AbXGXXHd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 Jul 2007 19:07:33 -0400
Received: from rsc by metis.extern.pengutronix.de with local (Exim 3.36 #1 (Debian))
	id 1IDTTY-00034v-00
	for <linux-rt-users@vger.kernel.org>; Wed, 25 Jul 2007 01:07:32 +0200
Content-Disposition: inline
In-Reply-To: <200707241426.50995.dvhltc@us.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, Jul 24, 2007 at 02:26:50PM -0700, Darren Hart wrote:
> > Index: func/gtod_latency/GNUmakefile.am
> > ===================================================================
> > --- func/gtod_latency/GNUmakefile.am.orig
> > +++ func/gtod_latency/GNUmakefile.am
> > @@ -12,9 +12,9 @@ gtod_infinite_CFLAGS = \
> >  	-O2
> >
> >  LDADD = \
> > -         ${top_builddir}/include/libjvmsim.a \
> > -         ${top_builddir}/include/librt.a \
> > -         ${top_builddir}/include/libstats.a
> > +         $(top_builddir)/include/libjvmsim.a \
> > +         $(top_builddir)/include/librt.a \
> > +         $(top_builddir)/include/libstats.a
> 
> Not sure if something got lost in translation... what did you change here?  I 
> think you intended to make them tabs?  will merge in as tabs.

${...} vs. $(...), plus tabs

Robert 
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
