From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: Performance of RT-patch on PowerPC
Date: Fri, 27 Apr 2007 15:10:33 +0200
Message-ID: <20070427131033.GG22585@pengutronix.de>
References: <4631F2F0.4010907@dutchspace.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: linux-rt-users@vger.kernel.org
To: Johan Borkhuis <j.borkhuis@dutchspace.nl>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:58255 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755810AbXD0NKh (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 27 Apr 2007 09:10:37 -0400
Content-Disposition: inline
In-Reply-To: <4631F2F0.4010907@dutchspace.nl>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, Apr 27, 2007 at 02:56:16PM +0200, Johan Borkhuis wrote:
> As I understood from several emails the arch/ppc branch is not supported 
> by the RT-patch, and also will not because of missing functionality. My 
> BSP (MVME3100, PPC 8540) is based on the ppc architecture however, but I 
> do need hard realtime performance.
> 
> As far as I know there are a couple of choices I have:
> - Port the BSP to the powerpc architecture branch

Which is the future proof variant, because then every kernel release
will work for your board - minus bugs :)

> Before I start on the port of the BSP I would like to know what the 
> status of the RT-patch on PowerPC is. How good and stable does the patch 
> run on PowerPC, and how good is the real time performance on the PowerPC?

We have it running on MPC5200B, and the 'cyclictest -n -p 90 -t 4' worst
case numbers are between 50 and 100 us. For more reliable numbers wait a
few days, we'll re-test with the recently released 2.6.21 soon and I can
post the results here.

> Also I like to know how the RT-patch and Xenomai compare. I did see some 
> measurements and discussions from a couple of years back between Ingo 
> and Kristian Benoit. The RT patch and Xenomai had comparable results, 
> but how is the current situation? Are the current results substantial 
> better for one of these or for both, or are they still on the same level?

I don't think there is significant performace difference, although I
cannot provide numbers. Nevertheless, don't only take latencies into
account but also the fact that development goes on quickly and one has
to have a maintainable system for the future. So IMHO mainline is a
better way, at least on a long term perspective.

Robert 
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
