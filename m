From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: [patch 00/10] ARM patch series for -rt15
Date: Fri, 15 Dec 2006 23:36:58 +0100
Message-ID: <20061215223658.009035000@metis.extern.pengutronix.de>
Cc: tglx@linutronix.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:51284 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030362AbWLOXLg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Dec 2006 18:11:36 -0500
To: linux-rt-users@vger.kernel.org
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Thomas,

this is our current series to make -rt work on ARM, currently based on
2.6.19-rt15. The clockevent patches are already merged in 2.6.20-rc1 via
Russell, so they are provided here only for completeness. I'm going to
update the latency plots recently posted on the OSADL list when I'm back
in the office on monday, to check if the longer latencies on i.MX are
still there.

I'm looking forward to your comments.

Robert
--
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
