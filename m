From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: [patch 00/15] fixes for rt-test build system
Date: Tue, 24 Jul 2007 19:09:34 +0200
Message-ID: <20070724170934.GD1678@pengutronix.de>
References: <20070724092517.390730736@metis.extern.pengutronix.de> <200707240952.49296.dvhltc@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: linux-rt-users@vger.kernel.org
To: Darren Hart <dvhltc@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:58895 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754855AbXGXRKY (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 Jul 2007 13:10:24 -0400
Content-Disposition: inline
In-Reply-To: <200707240952.49296.dvhltc@us.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, Jul 24, 2007 at 09:52:49AM -0700, Darren Hart wrote:
> On Tuesday 24 July 2007 02:25:17 Robert Schwebel wrote:
> > Hi Darren,
> >
> > This is a patch queue which fixes up the remaining issues with your
> > recently released rt-test packet. The focus of this series was on
> 
> Very much appreciated.  I am no autotools expert, so please be patient with my 
> questions :-)

Ok :-)

> > - fixing all GNUmakefile.am files do do the right thing; there have been
> >   bogus Makefiles which somehow leaked into your tree
> 
> An artifact of the migration to autotools - we caught it after the release.  
> Apologies for the mess.

Yup, no problem. That's what the patch queue is for ...

> > - fix 'make dist-check', which should be your preferred distribution
> >   tarball building mechanism in the future. Please don't do that
> >   manually, as the autotools make sure you don't forget half of the
> >   files if you use their mechanism :-)
> 
> Cool.

Autotools *are* cool [1]!

Robert

[1] /me waits for tglx posting a link to http://www.cafepress.com/leuksman.7112875
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
