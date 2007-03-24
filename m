From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: [patch 08/11] implicit declarations
Date: Sat, 24 Mar 2007 13:10:53 +0100
Message-ID: <20070324121704.489904000@metis.extern.pengutronix.de>
References: <20070324121045.396218000@metis.extern.pengutronix.de>
Cc: Darren Hart <dvhltc@us.ibm.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:45157 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753070AbXCXMRG (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 24 Mar 2007 08:17:06 -0400
Content-Disposition: inline; filename=perf-latency-pthread-cond-latency-implicit-declarations.diff
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Add some header files to avoid implicit declaration warnings.

Signed-off-by: Robert Schwebel <r.schwebel@pengutronix.de>

 perf/latency/pthread_cond_latency.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: perf/latency/pthread_cond_latency.c
===================================================================
--- perf/latency/pthread_cond_latency.c.orig
+++ perf/latency/pthread_cond_latency.c
@@ -21,9 +21,13 @@
  */
 
 #include <stdio.h>
+#include <stdlib.h>
+#include <poll.h>
 #include <pthread.h>
 #include <sys/time.h>
+#include <sys/types.h>
 #include <sched.h>
+#include <unistd.h>
 
 pthread_mutex_t child_mutex = PTHREAD_MUTEX_INITIALIZER;
 volatile int child_waiting = 0;

--
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
