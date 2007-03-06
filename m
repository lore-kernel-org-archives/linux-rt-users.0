From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: Status of -rt for linux-2.6.20/arch/powerpc
Date: Tue, 6 Mar 2007 09:27:44 +0100
Message-ID: <20070306082744.GE23584@pengutronix.de>
References: <OF77E4A7D3.89DEBB42-ON65257296.002B7648-65257296.002B9889@abbasiapacific.com.sg>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: tglx@linutronix.de, pradyumna.sampath@in.abb.com
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:53134 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932792AbXCFI1q (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Mar 2007 03:27:46 -0500
Content-Disposition: inline
In-Reply-To: <OF77E4A7D3.89DEBB42-ON65257296.002B7648-65257296.002B9889@abbasiapacific.com.sg>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Prady,

On Tue, Mar 06, 2007 at 01:32:26PM +0530, pradyumna.sampath@in.abb.com
wrote:
> I came across the errors that Wolfgang Grandegger describes http://
> article.gmane.org/gmane.linux.rt.user/224. I downloaded the latest
> patch, -rt8 and I continue to get the same merge errors and the make
> fail in arch/ powerpc/kernel/time.c.
> 
> Is there a patch which has these fixed? Im trying to get RT-PREEMPT
> working on my Lite5200 board.

We have a very raw patch series which makes rt-preempt working on
MPC5200B (tested on phyCORE-MPC5200B-tiny, but it should not be that
much different from your lite board).

Thomas, how can we proceed in that direction. The main problem with the
patch I've sent you is that it hacks away the generic powerpc timer
implementation in arch/powerpc/kernel/time.c and implements a minimum
working set for the MPC5200. As we currently neither have the ressources
nor access to other powerpc machines than the MPC5200B, it may be
interesting that somebody with better powerpc access would do it 'the
right way'.

I'll repost the series in a separate mail.

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
