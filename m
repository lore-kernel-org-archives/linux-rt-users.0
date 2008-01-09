From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: High latencies on MPC5200 with patch-2.6.24-rc5-rt1
Date: Wed, 9 Jan 2008 10:03:45 +0100
Message-ID: <20080109090345.GG3177@pengutronix.de>
References: <47834CB7.1030102@grandegger.com> <20080108154947.GB3177@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:32800 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753057AbYAIJiY (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 9 Jan 2008 04:38:24 -0500
Content-Disposition: inline
In-Reply-To: <20080108154947.GB3177@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Jan 08, 2008 at 04:49:47PM +0100, Robert Schwebel wrote:
> This is on an idle system:

I've quickly ported the patch stack to 2.6.24-rc5-rt1, and it doesn't
really work:

----------8<----------
root@phyCORE-MPC5200B-tiny:~ cyclictest -n -p80 -t1 -i10000 -l 1000
0.44 0.35 0.15 1/44 483

T: 0 (  483) P:80 I:   10000 C:     992 Min: -490034 Act: -410032 Avg: -243020 Max:     -10
----------8<----------

Even on an idle system I get negative values and a "running" Act value.

I'll have to clean up the patch stack and check what's going on.

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
