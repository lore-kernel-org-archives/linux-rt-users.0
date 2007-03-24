From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: [patch 10/11] return something in non-void functions
Date: Sat, 24 Mar 2007 13:10:55 +0100
Message-ID: <20070324121709.059866000@metis.extern.pengutronix.de>
References: <20070324121045.396218000@metis.extern.pengutronix.de>
Cc: Darren Hart <dvhltc@us.ibm.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:45165 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753413AbXCXMRK (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 24 Mar 2007 08:17:10 -0400
Content-Disposition: inline; filename=perf-latency-pthread-cond-many-void.diff
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Subject says it all ...

Signed-off-by: Robert Schwebel <r.schwebel@pengutronix.de>

 perf/latency/pthread_cond_many.c |    2 ++
 1 file changed, 2 insertions(+)

Index: perf/latency/pthread_cond_many.c
===================================================================
--- perf/latency/pthread_cond_many.c.orig
+++ perf/latency/pthread_cond_many.c
@@ -248,4 +248,6 @@ main(int argc, char *argv[])
 	}
 
 	test_signal(iter, nthreads);
+
+	return 0;
 }

--
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
