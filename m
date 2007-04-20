From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: arm and ppc plattforms
Date: Fri, 20 Apr 2007 13:34:11 +0200
Message-ID: <20070420113411.GO9554@pengutronix.de>
References: <1177066595.5648.33.camel@localhost.localdomain> <20070420110819.GN9554@pengutronix.de> <f87351060704200423n45dc5b66h73a399a4df1bfd68@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: Robert Schwebel <r.schwebel@pengutronix.de>,
	Peter Feuerer <peter@piie.net>, linux-rt-users@vger.kernel.org
To: Pradyumna Sampath <pradyumna.sampath@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:58794 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S2992953AbXDTLcB (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 20 Apr 2007 07:32:01 -0400
Content-Disposition: inline
In-Reply-To: <f87351060704200423n45dc5b66h73a399a4df1bfd68@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, Apr 20, 2007 at 04:53:47PM +0530, Pradyumna Sampath wrote:
> I tried the 2.6.21-rc6-rt0 for MPC5200B (ARCH=ppc
> CROSS_COMPILE=ppc_6xx-) and it died with a bunch of compile errors. So
> I was under the impression that the port for PowerPC was'nt complete.
> So I hacked up a small patch (attached) through I could atleast get it
> to compile. But of course it was far from having the implementation
> for the complete -rt patch set.
 

You'll probably have no luck with ARCH=ppc, our port runs with
ARCH=powerpc (and still has some crude hacks inside). You can find the
code in the OSELAS.BSP() for the phyCORE-MPC5200B-tiny module, which can
be found here:

http://www.pengutronix.de/oselas/bsp/phytec/index_en.html#phyCORE-MPC5200B-tiny

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
