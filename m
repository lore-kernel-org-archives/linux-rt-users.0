From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: cyclictest hangs with posix interval timers !?
Date: Mon, 8 Jan 2007 12:42:06 +0100
Message-ID: <20070108114206.GQ29495@pengutronix.de>
References: <459CE84F.8000009@imc-berlin.de> <20070104115215.GN29495@pengutronix.de> <459CFDF1.80807@imc-berlin.de> <1167917257.23138.17.camel@localhost.localdomain> <459D16D1.4040306@imc-berlin.de> <1167986882.23138.52.camel@localhost.localdomain> <45A22CFE.7070402@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: tglx@linutronix.de, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:60921 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751482AbXAHLmF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Jan 2007 06:42:05 -0500
To: Steven Scholz <steven.scholz@imc-berlin.de>
Content-Disposition: inline
In-Reply-To: <45A22CFE.7070402@imc-berlin.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, Jan 08, 2007 at 12:37:34PM +0100, Steven Scholz wrote:
> Well the statically linked version on SuSE 10.0 hangs as well.
> 
> Using the crosstool chains
> 
> 	gcc-4.1.1-glibc-2.3.6-linux-2.6.15.1 (2.6.12 headers)
> 	gcc-3.4.4-glibc-2.3.5-linux-2.6.12
> 
> the cyclictest segafaults on the SuSE host and target system. strace attached.
> 
> Any more ideas? Maybe? Please?

How much RAM does your box have?

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
