From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 3/7] hwlat-detector: Dont ignore threshold module parameter
Date: Thu, 21 Nov 2013 11:59:51 -0500
Message-ID: <20131121170116.897853471@goodmis.org>
References: <20131121165948.354971355@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Mike Galbraith <bitbucket@online.de>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0003-hwlat-detector-Don-t-ignore-threshold-module-paramet.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.8.13.13-rt25-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Mike Galbraith <bitbucket@online.de>

If the user specified a threshold at module load time, use it.

Cc: stable-rt@vger.kernel.org
Acked-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Mike Galbraith <bitbucket@online.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 drivers/misc/hwlat_detector.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/hwlat_detector.c b/drivers/misc/hwlat_detector.c
index 6f61d5f..d2676b8 100644
--- a/drivers/misc/hwlat_detector.c
+++ b/drivers/misc/hwlat_detector.c
@@ -413,7 +413,7 @@ static int init_stats(void)
 		goto out;
 
 	__reset_stats();
-	data.threshold = DEFAULT_LAT_THRESHOLD;	    /* threshold us */
+	data.threshold = threshold ?: DEFAULT_LAT_THRESHOLD;	    /* threshold us */
 	data.sample_window = DEFAULT_SAMPLE_WINDOW; /* window us */
 	data.sample_width = DEFAULT_SAMPLE_WIDTH;   /* width us */
 
-- 
1.8.4.rc3
