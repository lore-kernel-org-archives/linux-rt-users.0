From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: [patch 09/11] return something in non-void functions
Date: Sat, 24 Mar 2007 13:10:54 +0100
Message-ID: <20070324121706.779879000@metis.extern.pengutronix.de>
References: <20070324121045.396218000@metis.extern.pengutronix.de>
Cc: Darren Hart <dvhltc@us.ibm.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:45162 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753373AbXCXMRI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 24 Mar 2007 08:17:08 -0400
Content-Disposition: inline; filename=perf-latency-pthread-cond-latency-void.diff
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Subject says it all ...

Signed-off-by: Robert Schwebel <r.schwebel@pengutronix.de>

 perf/latency/pthread_cond_latency.c |    2 ++
 1 file changed, 2 insertions(+)

Index: perf/latency/pthread_cond_latency.c
===================================================================
--- perf/latency/pthread_cond_latency.c.orig
+++ perf/latency/pthread_cond_latency.c
@@ -178,4 +178,6 @@ main(int argc, char *argv[])
 	}
 	iter = strtol(argv[1], NULL, 0);
 	test_signal(argc == 2, iter);
+
+	return 0;
 }

--
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
