From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 1/2] cyclictest: fix wakeup_latency name for tracing
Date: Mon, 29 Nov 2010 16:38:54 +0100
Message-ID: <1291045135-15541-2-git-send-email-w.sang@pengutronix.de>
References: <1291045135-15541-1-git-send-email-w.sang@pengutronix.de>
Cc: Clark Williams <williams@redhat.com>,
	Wolfram Sang <w.sang@pengutronix.de>,
	Luotao Fu <l.fu@pengutronix.de>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52832 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752315Ab0K2PjT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 29 Nov 2010 10:39:19 -0500
In-Reply-To: <1291045135-15541-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The desired directory is named "wakeup", not "wakeup_latency".

Signed-off-by: Luotao Fu <l.fu@pengutronix.de>
Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 src/cyclictest/cyclictest.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 0847aed..abcdd75 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -487,7 +487,7 @@ static void setup_tracer(void)
 				setkernvar(traceroptions, traceptr[i]);
 		}
 		setkernvar("tracing_max_latency", "0");
-		setkernvar("latency_hist/wakeup_latency/reset", "1");
+		setkernvar("latency_hist/wakeup/reset", "1");
 	} else {
 		setkernvar("trace_all_cpus", "1");
 		setkernvar("trace_freerunning", "1");
-- 
1.7.2.3

