From: GeunSik Lim <leemgs1@gmail.com>
Subject: [PATCH V2 ]cyclictest: fix invalid comment of debugfs mount
	directory.
Date: Tue, 02 Jun 2009 14:14:02 +0900
Message-ID: <1243919642.20635.53.camel@centos51>
References: <1243821987.20635.42.camel@centos51>
Reply-To: leemgs1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>, lclaudio@uudg.org
To: williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-px0-f191.google.com ([209.85.216.191]:39286 "EHLO
	mail-px0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753132AbZFBFOI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 2 Jun 2009 01:14:08 -0400
Received: by pxi29 with SMTP id 29so3173097pxi.33
        for <linux-rt-users@vger.kernel.org>; Mon, 01 Jun 2009 22:14:09 -0700 (PDT)
In-Reply-To: <1243821987.20635.42.camel@centos51>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



 
Dear Clark Williams, 

This is tracing directory's comment related patch files.
Please, merge my patch.

Regards,
GeunSik Lim. 




Subject: [PATCH V2] cyclictest: Fix invalid comment of debugfs mount directory.

The "debugfs/tracing" name is invalid in cyclictest.c source file.
Example,
#> mount -t debugfs nodev /sys/kernel/debug [enter]
#> ln -s /sys/kernel/debug /debug [enter]
#> ls /debug/tracing [enter]

I updated a initial patch thanks to Luis Claudio R. Goncalves.
Fix directory name normally from debugfs/tracing to */tracing.

         Signed-off-by: GeunSik Lim <geunsik.lim@samsung.com>
         Reviewed-by  : Luis Claudio R. Goncalves <lclaudio@uudg.org>
---
 src/cyclictest/cyclictest.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index be9a3f9..2186de2 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -179,7 +179,9 @@ static char functiontracer[MAX_PATH];
 static char traceroptions[MAX_PATH];
 
 /*
- * Finds the path to the debugfs/tracing
+ * Finds the path to the tracing direcroty inside the default 
+ * mountpoint of debugfs filesystem.
+ * - debugfs related reference: http://lwn.net/Articles/334546/
  */
 static int set_debugfileprefix(void)
 {
-- 
1.6.3.1



-----------------------------------------------
To unsubscribe from this list: send the line "unsubscribe linux-***" 
in the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

GeunSik Lim ( Samsung Electronics )
e-Mail  :1) geunsik.lim@samsung.com
         2) leemgs@gmail.com , leemgs1@gmail.com
HomePage: http://blog.naver.com/invain/
-----------------------------------------------

