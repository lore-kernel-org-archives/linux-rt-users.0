Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54340 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387606AbfAKOYY (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 11 Jan 2019 09:24:24 -0500
Received: by mail-wm1-f65.google.com with SMTP id a62so2559325wmh.4
        for <linux-rt-users@vger.kernel.org>; Fri, 11 Jan 2019 06:24:23 -0800 (PST)
From: John Kacur <jkacur@redhat.com>
Subject: [PATCH] cyclictest: fix_with_expected_identifier_in_latest
Date: Fri, 11 Jan 2019 15:24:09 +0100
Message-Id: <20190111142409.9733-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: rt-users <linux-rt-users@vger.kernel.org>
Cc: Li Xiaoming <lixm.fnst@cn.fujitsu.com>, Zhong Lu <zhongl.fnst@cn.fujitsu.com>, John Kacur <jkacur@redhat.com>

From: Li Xiaoming <lixm.fnst@cn.fujitsu.com>

An error occurred during the build process:
src/cyclictest/cyclictest.c:1396:2: error: expected identifier or '(' before 'if'
  if (option_affinity) {

The expected identifier "}"  for  "if (option_affinity){" occurs in another place.

Signed-off-by: Li Xiaoming <lixm.fnst@cn.fujitsu.com>
Signed-off-by: Zhong Lu <zhongl.fnst@cn.fujitsu.com>

- Fixed the indentation of the bracket
- Fixed the indentation of the block where NUMA is not defined

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 188a202c5171..68b3836405c1 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1386,11 +1386,11 @@ static void process_options (int argc, char *argv[], int max_cpus)
 			numa = 1;
 			num_threads = max_cpus;
 			setaffinity = AFFINITY_USEALL;
+		}
 #else
-			warn("cyclictest was not built with the numa option\n");
-			numa = 0;
+		warn("cyclictest was not built with the numa option\n");
+		numa = 0;
 #endif
-		}
 	}
 
 	if (option_affinity) {
-- 
2.20.1
