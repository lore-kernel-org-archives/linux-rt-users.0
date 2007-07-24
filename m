From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: [patch 08/15] use static libs for supportlibs
Date: Tue, 24 Jul 2007 23:14:19 +0200
Message-ID: <20070724211419.GM1678@pengutronix.de>
References: <20070724092517.390730736@metis.extern.pengutronix.de> <20070724092603.324176866@metis.extern.pengutronix.de> <200707241359.05333.dvhltc@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:37029 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756797AbXGXVOV (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 Jul 2007 17:14:21 -0400
Received: from rsc by metis.extern.pengutronix.de with local (Exim 3.36 #1 (Debian))
	id 1IDRhz-0006oI-00
	for <linux-rt-users@vger.kernel.org>; Tue, 24 Jul 2007 23:14:19 +0200
Content-Disposition: inline
In-Reply-To: <200707241359.05333.dvhltc@us.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, Jul 24, 2007 at 01:59:05PM -0700, Darren Hart wrote:
> We were trying to avoid libraries in a futile effort to keep the make
> process simple.... ah well.  This doesn't complicate things at all
> really it turns out, so I'm fine with it.

That's why I made it static libs - that's simple and works without
libtool.

> > Note: the libs should really be renamed, because calling a local library
> > "librt" is a very, very bad idea.
> 
> Agreed.  We were thinking of changing it to librttest - any other suggestions?

Sounds good. You should also think about taking it out of include/ and
put it into something like lib/ or libs/.

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
