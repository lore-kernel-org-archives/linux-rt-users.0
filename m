From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: cyclictest hangs with posix interval timers !?
Date: Thu, 4 Jan 2007 12:52:15 +0100
Message-ID: <20070104115215.GN29495@pengutronix.de>
References: <459CE84F.8000009@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:48696 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964802AbXADLwO (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 4 Jan 2007 06:52:14 -0500
To: Steven Scholz <steven.scholz@imc-berlin.de>
Content-Disposition: inline
In-Reply-To: <459CE84F.8000009@imc-berlin.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, Jan 04, 2007 at 12:43:11PM +0100, Steven Scholz wrote:
> Will I need a special version of glibc or libpthread? NTPL?
> I am using a cross tool chain gcc-3.4.4-glibc-2.3.5 for i686 built with
> "crosstool".

You usually need NPTL, and if I remember correctly you also needed the
hrtimer-support lib for older glibcs.

Robert 
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
