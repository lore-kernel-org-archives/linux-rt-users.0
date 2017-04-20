From: Jianxun Zhang <jianxun.zhang@linux.intel.com>
Subject: [PATCH] Make -x option position-agnostic
Date: Thu, 20 Apr 2017 10:09:42 -0700
Message-ID: <1492708182-104442-1-git-send-email-jianxun.zhang@linux.intel.com>
Cc: vedang.patel@intel.com,
        Jianxun Zhang <jianxun.zhang@linux.intel.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:22954 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S971400AbdDTRF3 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 20 Apr 2017 13:05:29 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Change 9d2c9edd86943dfea399a0176826af8bb92bf97c introduces
the new option of POSIX timer and makes MODE_CLOCK_NANOSLEEP
the default choice. But there are two places explicitly set
MODE_CLOCK_NANOSLEEP to the variable use_nanosleep in the code,
so the actual value of the variable after parsing depends on
the position of '-x' to '-U' and '-S'.

These command pairs result in different values in the variable:
'cyclictest -S -x' VS 'cyclictest -x -S'
'cyclictest -U -x' VS 'cyclictest -x -U'

This change ensures -x work regardless its position by removing
the two lines in these cases.

Signed-off-by: Jianxun Zhang <jianxun.zhang@linux.intel.com>
---
Note: This patch is submitted after a very limited test in its scope. No real RT test was performed. Maintainers may want to do a full test or a closer review for anything I missed.

There are other findings regarding to the parsing logic but I don't think they are critical as long as the usage gives correct test results. I could amend these with more patches later.

Thanks

 src/cyclictest/cyclictest.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 0b13441..381191c 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1705,7 +1705,6 @@ static void process_options (int argc, char *argv[], int max_cpus)
 			smp = 1;
 			num_threads = max_cpus;
 			setaffinity = AFFINITY_USEALL;
-			use_nanosleep = MODE_CLOCK_NANOSLEEP;
 			break;
 		case 't':
 		case OPT_THREADS:
@@ -1744,7 +1743,6 @@ static void process_options (int argc, char *argv[], int max_cpus)
 #ifdef NUMA
 			num_threads = max_cpus;
 			setaffinity = AFFINITY_USEALL;
-			use_nanosleep = MODE_CLOCK_NANOSLEEP;
 #else
 			warn("cyclictest was not built with the numa option\n");
 			warn("ignoring --numa or -U\n");
-- 
2.7.4

