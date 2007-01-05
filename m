From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: cyclictest hangs with posix interval timers !?
Date: Fri, 5 Jan 2007 10:16:28 +0100
Message-ID: <20070105091628.GU29495@pengutronix.de>
References: <459CE84F.8000009@imc-berlin.de> <20070104115215.GN29495@pengutronix.de> <459CFDF1.80807@imc-berlin.de> <1167917257.23138.17.camel@localhost.localdomain> <459D16D1.4040306@imc-berlin.de> <1167986882.23138.52.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: Steven Scholz <steven.scholz@imc-berlin.de>,
	linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:34775 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965101AbXAEJQ2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 5 Jan 2007 04:16:28 -0500
To: Thomas Gleixner <tglx@linutronix.de>
Content-Disposition: inline
In-Reply-To: <1167986882.23138.52.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, Jan 05, 2007 at 09:48:02AM +0100, Thomas Gleixner wrote:
> This looks like a serious problem with your cross compiler / glibc
> setup. Can you compile cyclictest on one of your desktop machines and
> link it statically?

Steven, if this is a standard ptxdist toolchain it is built with stock
crosstool, so if there is really a problem with the toolchain you might
want to check if crosstool does everything right. However, we havn't
seen such effects, although all our realtime testing is currently done
with the soon-to-be-released OSELAS.Toolchain() toolchains, which are
built with native PTXdist instead of crosstool.

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
