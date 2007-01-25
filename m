From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: RT example
Date: Thu, 25 Jan 2007 08:01:33 +0100
Message-ID: <20070125070133.GY28808@pengutronix.de>
References: <DBDBE3A7EF0.0000058Dejr@inbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: linux-rt-users@vger.kernel.org
To: Junior <ejr@inbox.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:59032 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965575AbXAYHBe (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 25 Jan 2007 02:01:34 -0500
Content-Disposition: inline
In-Reply-To: <DBDBE3A7EF0.0000058Dejr@inbox.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, Jan 24, 2007 at 10:58:41AM -0800, Junior wrote:
> Does anyone have example code using the PREEMPT_RT patch?

You could for example start with cyclictest. It is also a good example
for how to write cyclic realtime programs on Linux.

> I've installed the patch for 2.6.18 and notice I'm actually runiing
> slower that without the patch.  I'm pretty sure it's something I'm
> doing or not doing and an example or some other docs should be enough
> to get me started.

Note that realtime is not about running fast, but running "in time".
That may often mean that the overall system performance goes down.

> PS. I'm using an ARM9 platform 

Do you have clocksource/clockevent support for your ARM9 chip?

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
