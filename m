From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: [patch 06/11] int main void
Date: Sat, 24 Mar 2007 13:10:51 +0100
Message-ID: <20070324121659.950207000@metis.extern.pengutronix.de>
References: <20070324121045.396218000@metis.extern.pengutronix.de>
Cc: Darren Hart <dvhltc@us.ibm.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:45150 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752949AbXCXMRB (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 24 Mar 2007 08:17:01 -0400
Content-Disposition: inline; filename=func-measurement-gtod-latency-warnings.diff
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Recent compilers barf about incorrect main functions when run with full
warnings switched on.

Signed-off-by: Robert Schwebel <r.schwebel@pengutronix.de>

 func/measurement/gtod_latency/gtod_infinite.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: func/measurement/gtod_latency/gtod_infinite.c
===================================================================
--- func/measurement/gtod_latency/gtod_infinite.c.orig
+++ func/measurement/gtod_latency/gtod_infinite.c
@@ -26,7 +26,7 @@
 #define START_MAX	3000
 #define REPORT_MIN	1000000
 
-main()
+int main(void)
 {
 	int i, rc;
 	struct timespec ts, p_ts;

--
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
