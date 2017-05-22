From: Tommi Rantala <tommi.t.rantala@nokia.com>
Subject: [PATCH 15/34] cyclictest: param is unused in fifothread()
Date: Mon, 22 May 2017 11:25:21 +0300
Message-ID: <20170522082540.15467-16-tommi.t.rantala@nokia.com>
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
        id S1752973AbdEVI0V (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 May 2017 04:26:21 -0400
In-Reply-To: <20170522082540.15467-1-tommi.t.rantala@nokia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

src/cyclictest/cyclictest.c: In function 'fifothread':
src/cyclictest/cyclictest.c:2119:31: warning: unused parameter 'param' [-Wunused-parameter]
 static void *fifothread(void *param)
                               ^~~~~

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 src/cyclictest/cyclictest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 517f061..b4dec98 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -2115,7 +2115,7 @@ static void print_stat(FILE *fp, struct thread_param *par, int index, int verbos
  * thread that creates a named fifo and hands out run stats when someone
  * reads from the fifo.
  */
-static void *fifothread(void *param)
+static void *fifothread(void *param __attribute__((unused)))
 {
 	int ret;
 	int fd;
-- 
2.9.3

