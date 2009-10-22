From: John Kacur <jkacur@redhat.com>
Subject: [PATCH -rt] Updates-from-Jon-Masters-for-hwlat_detector.c.patch
Date: Fri, 23 Oct 2009 00:12:04 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0910230007030.3737@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>
To: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Jon Masters <jcm@redhat.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757172AbZJVWMU@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello Thomas

I took Jon Masters' latest hwlat_detector patch for upstream, and grabbed 
the bits that aren't currently in -rt. The patch is fairly small.

Please consider it for the next -rt release.

John

>From 97e12a96f58eea70c6a223ac849ec894165884b5 Mon Sep 17 00:00:00 2001
From: Jon Masters <jcm@jonmasters.org>
Date: Thu, 22 Oct 2009 19:33:56 +0200
Subject: [PATCH] Updates from Jon Masters for hwlat_detector.c

Signed-off-by: Jon Masters <jcm@jonmasters.org>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 drivers/misc/Kconfig          |    2 +-
 drivers/misc/hwlat_detector.c |   16 ++++++++++++----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 15cd6bc..35f441c 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -95,7 +95,7 @@ config IBM_ASM
 config HWLAT_DETECTOR
 	tristate "Testing module to detect hardware-induced latencies"
 	depends on DEBUG_FS
-	select RING_BUFFER
+	depends on RING_BUFFER
 	default m
 	---help---
 	  A simple hardware latency detector. Use this module to detect
diff --git a/drivers/misc/hwlat_detector.c b/drivers/misc/hwlat_detector.c
index be6553f..7191e17 100644
--- a/drivers/misc/hwlat_detector.c
+++ b/drivers/misc/hwlat_detector.c
@@ -262,6 +262,8 @@ static int get_sample(void *unused)
 		/* Keep a running maximum ever recorded hardware latency */
 		if (sample > data.max_sample)
 			data.max_sample = sample;
+
+		wake_up(&data.wq); /* wake up reader(s) */
 	}
 
 	ret = 0;
@@ -299,8 +301,6 @@ static int kthread_fn(void *unused)
 			goto err_out;
 		}
 
-		wake_up(&data.wq); /* wake up reader(s) */
-
 		interval = data.sample_window - data.sample_width;
 		do_div(interval, USEC_PER_MSEC); /* modifies interval value */
 
@@ -607,7 +607,11 @@ static ssize_t  debug_enable_fwrite(struct file *filp,
 		if (!enabled)
 			goto unlock;
 		enabled = 0;
-		stop_kthread();
+		err = stop_kthread();
+		if (0 != err) {
+			printk(KERN_ERR BANNER "cannot stop kthread\n");
+			return -EFAULT;
+		}
 		wake_up(&data.wq);		/* reader(s) should return */
 	}
 unlock:
@@ -1194,9 +1198,13 @@ out:
  */
 static void detector_exit(void)
 {
+	int err;
+
 	if (enabled) {
 		enabled = 0;
-		stop_kthread();
+		err = stop_kthread();
+		if (0 != err)
+			printk(KERN_ERR BANNER "cannot stop kthread\n");
 	}
 
 	free_debugfs();
-- 
1.6.0.6

 
