From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: arm and ppc plattforms
Date: Fri, 20 Apr 2007 13:08:19 +0200
Message-ID: <20070420110819.GN9554@pengutronix.de>
References: <1177066595.5648.33.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: linux-rt-users@vger.kernel.org
To: Peter Feuerer <peter@piie.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:40936 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754450AbXDTLGI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 20 Apr 2007 07:06:08 -0400
Content-Disposition: inline
In-Reply-To: <1177066595.5648.33.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Peter,

On Fri, Apr 20, 2007 at 12:56:35PM +0200, Peter Feuerer wrote:
> what ARM and PowerPC processors have been tested with the rt-preempt
> patch? Which evalkits or developement boards for those processors are
> you using?

We have it running on 

- MPC5200B (PowerPC 603e), phyCORE-MPC5200B-tiny module (Phytec AG)
  Works like a charm...

- PXA270 (XScale ARMv5), phyCORE-PXA270 (Phytec AG)
  Still under development, we've seen sporadic hangs with the last
  kernels we checked, have to re-test on -rt-current.

- netX (ARM926EZ-J), all Hilscher Boards (Hilscher)
  Works, although more testing needs to be done.

- IXP425 (XScale Big Endian), customer specific board
  Works perfectly.

Robert  
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
