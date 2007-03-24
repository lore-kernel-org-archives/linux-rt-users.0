From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: [patch 04/11] Autotool support for IBM RT Cases
Date: Sat, 24 Mar 2007 13:10:49 +0100
Message-ID: <20070324121655.430001000@metis.extern.pengutronix.de>
References: <20070324121045.396218000@metis.extern.pengutronix.de>
Cc: Darren Hart <dvhltc@us.ibm.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:45143 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752618AbXCXMQ5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 24 Mar 2007 08:16:57 -0400
Content-Disposition: inline; filename=libstat-nonvoid-function.diff
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Subject return something in non-void functions
This fixes

libstats_test.c: In function 'stats_container_free':
../include/libstats.h:107: warning: control reaches end of non-void function
libstats_test.c: In function 'stats_container_init':
../include/libstats.h:102: warning: control reaches end of non-void function

Signed-off-by: Robert Schwebel <r.schwebel@pengutronix.de>

 include/libstats.h |    4 ++++
 1 file changed, 4 insertions(+)

Index: include/libstats.h
===================================================================
--- include/libstats.h.orig
+++ include/libstats.h
@@ -99,11 +99,15 @@ int stats_container_init(stats_container
 	data->size = size;
 	data->records = (stats_record_t *)malloc(size*sizeof(stats_record_t));
 	memset(data->records, 0, size*sizeof(stats_record_t));
+
+        return 0;
 }
 
 int stats_container_free(stats_container_t *data)
 {
 	free(data->records);
+
+        return 0;
 }
 
 float stats_stddev(stats_container_t *data)

--
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
