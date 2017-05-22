From: Tommi Rantala <tommi.t.rantala@nokia.com>
Subject: [PATCH 05/34] cyclictest: fix signed vs unsigned compiler warnings
Date: Mon, 22 May 2017 11:25:11 +0300
Message-ID: <20170522082540.15467-6-tommi.t.rantala@nokia.com>
References: <20170522082540.15467-1-tommi.t.rantala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-rt-users@vger.kernel.org>,
        Tommi Rantala <tommi.t.rantala@nokia.com>
To: Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-eopbgr50097.outbound.protection.outlook.com ([40.107.5.97]:43936
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752804AbdEVI0K (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 May 2017 04:26:10 -0400
In-Reply-To: <20170522082540.15467-1-tommi.t.rantala@nokia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

src/cyclictest/cyclictest.c: In function 'kernvar':
src/cyclictest/cyclictest.c:357:40: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
    if (write(path, value, sizeofvalue) == sizeofvalue)
                                        ^~
src/cyclictest/cyclictest.c: In function 'raise_soft_prio':
src/cyclictest/cyclictest.c:797:59: warning: signed and unsigned type in conditional expression [-Wsign-compare]
  soft_max = (rlim.rlim_cur == RLIM_INFINITY) ? policy_max : rlim.rlim_cur;
                                                           ^
src/cyclictest/cyclictest.c:798:59: warning: signed and unsigned type in conditional expression [-Wsign-compare]
  hard_max = (rlim.rlim_max == RLIM_INFINITY) ? policy_max : rlim.rlim_max;
                                                           ^

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 src/cyclictest/cyclictest.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 75f1fcd..4f94b06 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -354,7 +354,7 @@ static int kernvar(int mode, const char *name, char *value, size_t sizeofvalue)
 				value[got-1] = '\0';
 			}
 		} else if (mode == O_WRONLY) {
-			if (write(path, value, sizeofvalue) == sizeofvalue)
+			if (write(path, value, sizeofvalue) == (ssize_t)sizeofvalue)
 				retval = 0;
 		}
 		close(path);
@@ -792,8 +792,8 @@ static int raise_soft_prio(int policy, const struct sched_param *param)
 		return err;
 	}
 
-	soft_max = (rlim.rlim_cur == RLIM_INFINITY) ? policy_max : rlim.rlim_cur;
-	hard_max = (rlim.rlim_max == RLIM_INFINITY) ? policy_max : rlim.rlim_max;
+	soft_max = (rlim.rlim_cur == RLIM_INFINITY) ? policy_max : (int)rlim.rlim_cur;
+	hard_max = (rlim.rlim_max == RLIM_INFINITY) ? policy_max : (int)rlim.rlim_max;
 
 	if (prio > soft_max && prio <= hard_max) {
 		rlim.rlim_cur = prio;
-- 
2.9.3

