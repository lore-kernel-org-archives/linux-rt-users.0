From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: [patch 05/11] ret may be used uninitialized
Date: Sat, 24 Mar 2007 13:10:50 +0100
Message-ID: <20070324121657.699939000@metis.extern.pengutronix.de>
References: <20070324121045.396218000@metis.extern.pengutronix.de>
Cc: Darren Hart <dvhltc@us.ibm.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:45146 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752927AbXCXMQ7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 24 Mar 2007 08:16:59 -0400
Content-Disposition: inline; filename=libstat-maybe-uninitialized.diff
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This patch fixes a "may be used uninitialized" warning.

Signed-off-by: Robert Schwebel <r.schwebel@pengutronix.de>

 include/libstats.h |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

Index: include/libstats.h
===================================================================
--- include/libstats.h.orig
+++ include/libstats.h
@@ -216,7 +216,6 @@ void stats_hist_print(stats_container_t 
 
 int stats_container_save(char *filename, char *title, char *xlabel, char *ylabel, stats_container_t *data, char *mode)
 {
-    int ret;
     int i;
     int minx, maxx, miny, maxy;
     FILE *dat_fd;
@@ -236,7 +235,7 @@ int stats_container_save(char *filename,
     /* generate the data file */
     if (!(dat_fd = fopen(datfile, "w"))) {
         perror("Failed to open dat file");
-        ret = -1;
+        return -1;
     } else {
         minx = maxx = data->records[0].x;
         miny = maxy = data->records[0].y;
@@ -254,7 +253,7 @@ int stats_container_save(char *filename,
     /* generate the plt file */
     if (!(plt_fd = fopen(pltfile, "w"))) {
         perror("Failed to open plt file");
-        ret = -1;
+        return -1;
     } else {
         fprintf(plt_fd, "set terminal png\n");
         fprintf(plt_fd, "set output \"%s.png\"\n", pltfile);
@@ -272,6 +271,6 @@ int stats_container_save(char *filename,
         fclose(plt_fd);
     } 
 
-    return ret;
+    return 0;
 }
 #endif /* LIBSTAT_H */

--
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
