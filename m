From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: cyclictest?
Date: Fri, 11 Jan 2008 07:29:16 +0100
Message-ID: <20080111062916.GV3177@pengutronix.de>
References: <5bdc1c8b0801101634j583da294k319dbaa55405f26e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: RT <linux-rt-users@vger.kernel.org>
To: Mark Knecht <markknecht@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:57511 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751635AbYAKG3S (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 11 Jan 2008 01:29:18 -0500
Content-Disposition: inline
In-Reply-To: <5bdc1c8b0801101634j583da294k319dbaa55405f26e@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Jan 10, 2008 at 04:34:51PM -0800, Mark Knecht wrote:
>    I hadn't heard of cyclictest before an email today. I guess as a
> user instead of a developer I don't pay much attention.
> 
>    Can someone point me toward directions for building this on a Gentoo machine?

I don't known how gentoo does it in details, but you can probably simply
use the ptxdist recipie for cyclictest as an example:

https://iocaste.extern.pengutronix.de/viewsvn/ptxdist/trunks/ptxdist-trunk/rules/cyclictest.make?rev=7171&view=auto

user: guest
pass: guest

It's nothing more than "make CROSS_COMPILE=<your-compiler-prefix>".

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
