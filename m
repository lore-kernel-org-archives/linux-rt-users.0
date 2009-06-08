From: GeunSik Lim <leemgs1@gmail.com>
Subject: [RESEND] [PATCH V2 ]cyclictest: fix invalid comment of debugfs
	mount directory.
Date: Mon, 08 Jun 2009 10:52:09 +0900
Message-ID: <1244425929.20635.90.camel@centos51>
References: <1243821987.20635.42.camel@centos51>
	 <1243919642.20635.53.camel@centos51>
Reply-To: leemgs1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>, lclaudio@uudg.org
To: williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:39418 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175AbZFHBwQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 7 Jun 2009 21:52:16 -0400
Received: by wa-out-1112.google.com with SMTP id j5so583344wah.21
        for <linux-rt-users@vger.kernel.org>; Sun, 07 Jun 2009 18:52:17 -0700 (PDT)
In-Reply-To: <1243919642.20635.53.camel@centos51>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



Dear Clark Williams, 

This is tracing(ftrace) directory's comment related patch file.
Please, merge this patch.



Regards,
GeunSik Lim. 


Subject: [RESEND] [PATCH V2 ]cyclictest: Fix invalid comment of debugfs mount directory.

The "debugfs/tracing" name is invalid as the mountpont of debugfs filesystem.

For example,
/sys/kernel/debug/tracing/ or
/debug/tracing/ or
/debugfs/tracing/ ...

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

