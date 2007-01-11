From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: generating 100% load for cyclictest ?
Date: Thu, 11 Jan 2007 16:10:27 +0100
Message-ID: <20070111151027.GS29495@pengutronix.de>
References: <45A65009.8070902@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:51725 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750696AbXAKPK2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Jan 2007 10:10:28 -0500
To: Steven Scholz <steven.scholz@imc-berlin.de>
Content-Disposition: inline
In-Reply-To: <45A65009.8070902@imc-berlin.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, Jan 11, 2007 at 03:56:09PM +0100, Steven Scholz wrote:
> How is this load created? Any recommendations?

At least these should generate significant load:

- hackbench
- while true; do find /; done
- calibrator (for cache load)

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
