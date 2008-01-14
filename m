From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: 2.6.24-rc7-rt1
Date: Mon, 14 Jan 2008 21:08:36 +0100
Message-ID: <20080114200836.GR27137@pengutronix.de>
References: <1200250801.9190.7.camel@localhost.localdomain> <20080113202522.GD27137@pengutronix.de> <Pine.LNX.4.58.0801131544430.10093@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: RT <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:34675 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751234AbYANUIi (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Jan 2008 15:08:38 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0801131544430.10093@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, Jan 13, 2008 at 03:48:33PM -0500, Steven Rostedt wrote:
> Yeah, I didn't make any attempt to fix latency_tracing for PPC on this
> release. I expected as much. I do have a couple of PPC boxes that I
> can play with, and I'll see if I can get that working too before -rt2.
> But I want to get a stable x86 release out fast.

It compiles now, although I still don't get any kernel output any more
if I enable CONFIG_FUNCTION_TRACE. Sorry for not being more verbose, I'm
out of office right now and my arms are not long enough to connect the
BDI ;)

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
