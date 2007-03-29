From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: autotoolize tests
Date: Thu, 29 Mar 2007 17:44:18 +0200
Message-ID: <20070329154418.GK32369@pengutronix.de>
References: <20070328152625.GA2470@linux.vnet.ibm.com> <20070329130830.GH32369@pengutronix.de> <20070329153654.GC4300@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: linux-rt-users@vger.kernel.org
To: Chirag Jog <chirag@linux.vnet.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:36575 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030279AbXC2PqQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 29 Mar 2007 11:46:16 -0400
Content-Disposition: inline
In-Reply-To: <20070329153654.GC4300@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, Mar 29, 2007 at 09:06:54PM +0530, Chirag Jog wrote:
> > Hmm, which autoreconf version are you using? It works here, with automake 1.9
> 
> > and autoconf 2.61:
> 
> I was using autoconf 2.59
> I have upgraded to 2.61
> It works now!!

They seem to have fixed autoreconf; are you ok with using 2.61, or shall
I send a patch that adds a manual autogen.sh which works without
autoreconf?

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
