From: Tommi Rantala <tommi.t.rantala@nokia.com>
Subject: [PATCH 03/34] cyclictest: always clear stop to avoid -Wmaybe-uninitialized warning
Date: Mon, 22 May 2017 11:25:09 +0300
Message-ID: <20170522082540.15467-4-tommi.t.rantala@nokia.com>
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
        id S1752735AbdEVI0D (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 May 2017 04:26:03 -0400
In-Reply-To: <20170522082540.15467-1-tommi.t.rantala@nokia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

src/cyclictest/cyclictest.c: In function 'timerthread':
src/cyclictest/cyclictest.c:427:30: warning: '*((void *)&stop+8)' may be used uninitialized in this function [-Wmaybe-uninitialized]
  diff += ((int) t1.tv_nsec - (int) t2.tv_nsec) / 1000;
                              ^~~~~~~~~~~~~~~~
src/cyclictest/cyclictest.c:978:39: note: '*((void *)&stop+8)' was declared here
  struct timespec now, next, interval, stop;
                                       ^~~~
src/cyclictest/cyclictest.c:426:54: warning: 'stop.tv_sec' may be used uninitialized in this function [-Wmaybe-uninitialized]
  diff = USEC_PER_SEC * (long long)((int) t1.tv_sec - (int) t2.tv_sec);
                                                      ^~~~~~~~~~~~~~~
src/cyclictest/cyclictest.c:978:39: note: 'stop.tv_sec' was declared here
  struct timespec now, next, interval, stop;
                                       ^~~~

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 src/cyclictest/cyclictest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index b6c2ab7..7cd9f29 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1065,8 +1065,8 @@ static void *timerthread(void *param)
 	next.tv_nsec += interval.tv_nsec;
 	tsnorm(&next);
 
+	memset(&stop, 0, sizeof(stop)); /* grrr */
 	if (duration) {
-		memset(&stop, 0, sizeof(stop)); /* grrr */
 		stop = now;
 		stop.tv_sec += duration;
 	}
-- 
2.9.3

