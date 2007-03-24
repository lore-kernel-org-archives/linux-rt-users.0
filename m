From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: [patch 02/11] unused variables
Date: Sat, 24 Mar 2007 13:10:47 +0100
Message-ID: <20070324121650.789971000@metis.extern.pengutronix.de>
References: <20070324121045.396218000@metis.extern.pengutronix.de>
Cc: Darren Hart <dvhltc@us.ibm.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:45123 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752620AbXCXMQw (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 24 Mar 2007 08:16:52 -0400
Content-Disposition: inline; filename=libstats-unused-x.diff
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This fixes an unused variable.

In file included from libstats_test.c:1:
../include/libstats.h:161: warning: unused variable 'x'

Signed-off-by: Robert Schwebel <r.schwebel@pengutronix.de>

 include/libstats.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: include/libstats.h
===================================================================
--- include/libstats.h.orig
+++ include/libstats.h
@@ -158,7 +158,7 @@ int stats_hist(stats_container_t *hist, 
 	int i;
 	int ret;
 	long min, max, width;
-	long x, y, b;
+	long /* x, */ y, b;
 	
 	ret = 0;
 
@@ -199,7 +199,7 @@ int stats_hist(stats_container_t *hist, 
 
 void stats_hist_print(stats_container_t *hist)
 {
-	long i, x, x1;
+	long i, x /* , x1 */;
 	for (i = 0; i < hist->size; i++) {
 		x = hist->records[i].x;
 		if (i < hist->size-1)

--
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
