From: Tommi Rantala <tommi.t.rantala@nokia.com>
Subject: [PATCH 27/34] deadline_test: tv_nsec is long
Date: Mon, 22 May 2017 11:25:33 +0300
Message-ID: <20170522082540.15467-28-tommi.t.rantala@nokia.com>
References: <20170522082540.15467-1-tommi.t.rantala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-rt-users@vger.kernel.org>,
        Tommi Rantala <tommi.t.rantala@nokia.com>
To: Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-eopbgr50134.outbound.protection.outlook.com ([40.107.5.134]:2496
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757360AbdEVI0j (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 May 2017 04:26:39 -0400
In-Reply-To: <20170522082540.15467-1-tommi.t.rantala@nokia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

src/sched_deadline/deadline_test.c: In function 'do_sleep':
src/sched_deadline/deadline_test.c:1683:21: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
  while (req.tv_nsec > 1000000000UL) {
                     ^

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 src/sched_deadline/deadline_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/sched_deadline/deadline_test.c b/src/sched_deadline/deadline_test.c
index e5c31d6..6958ad9 100644
--- a/src/sched_deadline/deadline_test.c
+++ b/src/sched_deadline/deadline_test.c
@@ -1679,8 +1679,8 @@ static void do_sleep(u64 next)
 
 	req.tv_nsec = next * 1000;
 	req.tv_sec = 0;
-	while (req.tv_nsec > 1000000000UL) {
-		req.tv_nsec -= 1000000000UL;
+	while (req.tv_nsec > 1000000000L) {
+		req.tv_nsec -= 1000000000L;
 		req.tv_sec++;
 	}
 	nanosleep(&req, NULL);
-- 
2.9.3

