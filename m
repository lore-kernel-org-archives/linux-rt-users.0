From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: [patch 03/11] fix format to use correct types
Date: Sat, 24 Mar 2007 13:10:48 +0100
Message-ID: <20070324121653.080913000@metis.extern.pengutronix.de>
References: <20070324121045.396218000@metis.extern.pengutronix.de>
Cc: Darren Hart <dvhltc@us.ibm.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:45140 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752701AbXCXMQy (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 24 Mar 2007 08:16:54 -0400
Content-Disposition: inline; filename=libstats-format-errors.diff
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This patch fixes

In file included from libstats_test.c:1:
../include/libstats.h: In function 'stats_hist_print':
../include/libstats.h:207: warning: format '%d' expects type 'int', but argument 2 has type 'long int'
../include/libstats.h:207: warning: format '%d' expects type 'int', but argument 3 has type 'long int'
../include/libstats.h:207: warning: format '%d' expects type 'int', but argument 4 has type 'long int'
../include/libstats.h:209: warning: format '%d' expects type 'int', but argument 2 has type 'long int'
../include/libstats.h:209: warning: format '%d' expects type 'int', but argument 3 has type 'long int'
../include/libstats.h: In function 'stats_container_save':
../include/libstats.h:245: warning: format '%d' expects type 'int', but argument 3 has type 'long int'
../include/libstats.h:245: warning: format '%d' expects type 'int', but argument 4 has type 'long int'
make[1]: *** [libstats_test-libstats_test.o] Error 1

Signed-off-by: Robert Schwebel <r.schwebel@pengutronix.de>

 include/libstats.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: include/libstats.h
===================================================================
--- include/libstats.h.orig
+++ include/libstats.h
@@ -203,10 +203,10 @@ void stats_hist_print(stats_container_t 
 	for (i = 0; i < hist->size; i++) {
 		x = hist->records[i].x;
 		if (i < hist->size-1)
-			printf("[%d,%d) = %d\n", x, 
+			printf("[%ld,%ld) = %ld\n", x, 
 				hist->records[i+1].x, hist->records[i].y);
 		else
-			printf("[%d,-) = %d\n", x, hist->records[i].y);
+			printf("[%ld,-) = %ld\n", x, hist->records[i].y);
 	}
 }
 
@@ -242,7 +242,7 @@ int stats_container_save(char *filename,
             maxx = MAX(maxx, rec->x);            
             miny = MIN(miny, rec->y);            
             maxy = MAX(maxy, rec->y);            
-            fprintf(dat_fd, "%d %d\n", rec->x, rec->y);
+            fprintf(dat_fd, "%ld %ld\n", rec->x, rec->y);
         }
         fclose(dat_fd);
     } 

--
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
