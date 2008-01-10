From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: High latencies on MPC5200 with patch-2.6.24-rc5-rt1
Date: Thu, 10 Jan 2008 22:27:39 +0100
Message-ID: <20080110212739.GR3177@pengutronix.de>
References: <47834CB7.1030102@grandegger.com> <20080108154947.GB3177@pengutronix.de> <20080109090345.GG3177@pengutronix.de> <20080109225107.GV3177@pengutronix.de> <20080110000124.GW3177@pengutronix.de> <47861ACE.9060301@grandegger.com> <20080110143527.GI3177@pengutronix.de> <20080110162351.GN3177@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org, John Stultz <johnstul@us.ibm.com>
To: Wolfgang Grandegger <wg@grandegger.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:54595 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751010AbYAJV1s (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 10 Jan 2008 16:27:48 -0500
Content-Disposition: inline
In-Reply-To: <20080110162351.GN3177@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Jan 10, 2008 at 05:23:51PM +0100, Robert Schwebel wrote:
> Done, here are the results (data and histogram):

Here's a better overview now:

http://www.pengutronix.de/oselas/realtime/results/20080110-1-cyclictest_en.html

The second plot series is without net, which proves my assumption that
it is some interference between network interrupt code and cyclictest.
It was taken with 'ifdown eth0', booted from flash and logging into a
ramdisk. The peaks are completely gond, with the maximum below 70 us.

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
