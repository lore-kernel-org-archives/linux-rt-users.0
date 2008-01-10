From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: High latencies on MPC5200 with patch-2.6.24-rc5-rt1
Date: Thu, 10 Jan 2008 17:23:51 +0100
Message-ID: <20080110162351.GN3177@pengutronix.de>
References: <47834CB7.1030102@grandegger.com> <20080108154947.GB3177@pengutronix.de> <20080109090345.GG3177@pengutronix.de> <20080109225107.GV3177@pengutronix.de> <20080110000124.GW3177@pengutronix.de> <47861ACE.9060301@grandegger.com> <20080110143527.GI3177@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org, John Stultz <johnstul@us.ibm.com>
To: Wolfgang Grandegger <wg@grandegger.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:59657 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756075AbYAJQX5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 10 Jan 2008 11:23:57 -0500
Content-Disposition: inline
In-Reply-To: <20080110143527.GI3177@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Jan 10, 2008 at 03:35:27PM +0100, Robert Schwebel wrote:
> > Could you run your cyclictest much longer?
> 
> I'll re-test with your parameters.

Done, here are the results (data and histogram):

http://www.pengutronix.de/software/realtime-preempt/20080110-1-cyclictest/20080110-1-phyCORE-MPC5200B-tiny-data.png
http://www.pengutronix.de/software/realtime-preempt/20080110-1-cyclictest/20080110-1-phyCORE-MPC5200B-tiny-histo.png

Especially the data plot is interesting: it shows that most of the shots
are below 80 us, but there are regular peaks. If you look carefully, you
also see that the peaks are "growing", which usually means that there is
some interference.

Time to activate latency hunting...

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
