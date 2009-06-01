From: GeunSik Lim <leemgs1@gmail.com>
Subject: [PATCH ]cyclictest: fix invalid comment of debugfs mount directory.
Date: Mon, 01 Jun 2009 11:06:27 +0900
Message-ID: <1243821987.20635.42.camel@centos51>
Reply-To: leemgs1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.175]:40644 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753905AbZFACGb (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 31 May 2009 22:06:31 -0400
Received: by wf-out-1314.google.com with SMTP id 26so2442383wfd.4
        for <linux-rt-users@vger.kernel.org>; Sun, 31 May 2009 19:06:33 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



Dear Clark Williams, 

Please, Fix the "debugfs/tracing" name in cyclictest.c source file. 

P.S: Now, version is differenct between shortlog(v0.39) and tags(v0.40). 
     Maybe, You have to check version name of shortlog table. 
     http://git.kernel.org/?p=linux/kernel/git/clrkwllms/rt-tests.git;a=summary

Thanks,
GeunSik Lim. 



Subject: [PATCH ]cyclictest: Fix invalid comment of debugfs mount directory.

The "debugfs/tracing" name is invalid.
Example,
#> mount -t debugfs nodev /sys/kernel/debug [enter]
#> ln -s /sys/kernel/debug /debug [enter]

Fix directory name normally from debugfs/tracing to debug/tracing.

         Signed-off-by: GeunSik Lim <geunsik.lim@samsung.com>
---
 src/cyclictest/cyclictest.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index be9a3f9..32a120a 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -179,7 +179,7 @@ static char functiontracer[MAX_PATH];
 static char traceroptions[MAX_PATH];
 
 /*
- * Finds the path to the debugfs/tracing
+ * Finds the path to the debug/tracing
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

GeunSik Lim (  S A M S U N G     E L E C T R O N I C S  )
e-Mail  :1) geunsik.lim@samsung.com
         2) leemgs@gmail.com , leemgs1@gmail.com
HomePage: http://blog.naver.com/invain/
-----------------------------------------------

