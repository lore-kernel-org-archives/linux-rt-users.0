From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: [patch 07/11] unused variables
Date: Sat, 24 Mar 2007 13:10:52 +0100
Message-ID: <20070324121702.239939000@metis.extern.pengutronix.de>
References: <20070324121045.396218000@metis.extern.pengutronix.de>
Cc: Darren Hart <dvhltc@us.ibm.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:45154 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752977AbXCXMRD (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 24 Mar 2007 08:17:03 -0400
Content-Disposition: inline; filename=func-measurement-gtod-infinite-warnings.diff
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Comment out unused variables for now (we use -Werror).

Signed-off-by: Robert Schwebel <r.schwebel@pengutronix.de>

 func/measurement/gtod_latency/gtod_infinite.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: func/measurement/gtod_latency/gtod_infinite.c
===================================================================
--- func/measurement/gtod_latency/gtod_infinite.c.orig
+++ func/measurement/gtod_latency/gtod_infinite.c
@@ -28,11 +28,11 @@
 
 int main(void)
 {
-	int i, rc;
+	int /* i, */ rc;
 	struct timespec ts, p_ts;
 	long long s_time, e_time, diff_time;
 	long long max_time = START_MAX;
-	cpu_set_t mask;
+	/* cpu_set_t mask; */
 	struct sched_param param;
 	time_t tt;
 

--
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
