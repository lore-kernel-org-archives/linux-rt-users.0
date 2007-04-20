From: Theodore Tso <tytso@mit.edu>
Subject: Re: arm and ppc plattforms
Date: Fri, 20 Apr 2007 12:01:06 -0400
Message-ID: <20070420160106.GA21151@thunk.org>
References: <1177066595.5648.33.camel@localhost.localdomain> <20070420110819.GN9554@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Feuerer <peter@piie.net>, linux-rt-users@vger.kernel.org
To: Robert Schwebel <r.schwebel@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from THUNK.ORG ([69.25.196.29]:46105 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767152AbXDTQBO (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 20 Apr 2007 12:01:14 -0400
Content-Disposition: inline
In-Reply-To: <20070420110819.GN9554@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, Apr 20, 2007 at 01:08:19PM +0200, Robert Schwebel wrote:
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

Hi Robert,


You mind if I add these to along with your name/conctact to:

http://rt.wiki.kernel.org/index.php/CONFIG_PREEMPT_RT_Patch#Platforms_Tested_and_in_Use_with_CONFIG_PREEMPT_RT

... or maybe you could add these platforms yourself?  

I think it would be useful if we had a collated set of tested
platforms on the real-time wiki.  I'm sure Peter isn't the only one
who might be interested in this kind of information!

						- Ted
