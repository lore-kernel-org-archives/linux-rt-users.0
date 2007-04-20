From: Peter Feuerer <peter@piie.net>
Subject: Re: arm and ppc plattforms
Date: Fri, 20 Apr 2007 13:17:02 +0200
Message-ID: <1177067822.5648.49.camel@localhost.localdomain>
References: <1177066595.5648.33.camel@localhost.localdomain>
	 <20070420110819.GN9554@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: Robert Schwebel <r.schwebel@pengutronix.de>,
	linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay08.ispgateway.de ([80.67.29.8]:37480 "EHLO
	smtprelay08.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754213AbXDTLXp (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 20 Apr 2007 07:23:45 -0400
In-Reply-To: <20070420110819.GN9554@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Does anybody have experience with Atmel's "AT91RM9200" CPU? E.g.
assembled on conitec's "ARM&EVA" board?
( http://www.conitec.net/english/linuxboard.htm )

On Fri, 2007-04-20 at 13:08 +0200, Robert Schwebel wrote:
> Hi Peter,
> 
> On Fri, Apr 20, 2007 at 12:56:35PM +0200, Peter Feuerer wrote:
> > what ARM and PowerPC processors have been tested with the rt-preempt
> > patch? Which evalkits or developement boards for those processors are
> > you using?
> 
> We have it running on 
> 
> - MPC5200B (PowerPC 603e), phyCORE-MPC5200B-tiny module (Phytec AG)
>   Works like a charm...
> 
> - PXA270 (XScale ARMv5), phyCORE-PXA270 (Phytec AG)
>   Still under development, we've seen sporadic hangs with the last
>   kernels we checked, have to re-test on -rt-current.
> 
> - netX (ARM926EZ-J), all Hilscher Boards (Hilscher)
>   Works, although more testing needs to be done.
> 
> - IXP425 (XScale Big Endian), customer specific board
>   Works perfectly.
> 
> Robert  

Hi Robert, 

thank you very much for the quick answer.

--peter
