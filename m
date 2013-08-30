From: Mike Galbraith <bitbucket@online.de>
Subject: [PATCH RT]  hwlat-detector: Don't ignore threshold module parameter
Date: Fri, 30 Aug 2013 07:57:25 +0200
Message-ID: <1377842245.5422.7.camel@marge.simpson.net>
References: <20130819213324.405942342@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:54444 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752498Ab3H3F5g (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 30 Aug 2013 01:57:36 -0400
In-Reply-To: <20130819213324.405942342@goodmis.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

If the user specified a threshold at module load time, use it.

Signed-off-by: Mike Galbraith <bitbucket@online.de>

--- a/drivers/misc/hwlat_detector.c	2013-08-30 07:16:05.387959392 +0200
+++ b/drivers/misc/hwlat_detector.c	2013-08-30 07:10:52.958670183 +0200
@@ -413,7 +413,7 @@ static int init_stats(void)
 		goto out;
 
 	__reset_stats();
-	data.threshold = DEFAULT_LAT_THRESHOLD;	    /* threshold us */
+	data.threshold = threshold ?: DEFAULT_LAT_THRESHOLD;	    /* threshold us */
 	data.sample_window = DEFAULT_SAMPLE_WINDOW; /* window us */
 	data.sample_width = DEFAULT_SAMPLE_WIDTH;   /* width us */
 


