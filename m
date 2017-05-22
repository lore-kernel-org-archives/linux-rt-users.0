From: Tommi Rantala <tommi.t.rantala@nokia.com>
Subject: [PATCH 22/34] pi_stress: add missing argument in pi_error() call
Date: Mon, 22 May 2017 11:25:28 +0300
Message-ID: <20170522082540.15467-23-tommi.t.rantala@nokia.com>
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
        id S1757326AbdEVI0b (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 May 2017 04:26:31 -0400
In-Reply-To: <20170522082540.15467-1-tommi.t.rantala@nokia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

src/pi_tests/pi_stress.c: In function 'high_priority':
src/pi_tests/pi_stress.c:993:9: warning: format '%x' expects a matching 'unsigned int' argument [-Wformat=]
        ("high_priority[%d]: pthread_barrier_wait(finish): %x",
         ^

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 src/pi_tests/pi_stress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
index 8972122..e29956c 100644
--- a/src/pi_tests/pi_stress.c
+++ b/src/pi_tests/pi_stress.c
@@ -991,7 +991,7 @@ void *high_priority(void *arg)
 		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
 			pi_error
 			    ("high_priority[%d]: pthread_barrier_wait(finish): %x",
-			     status);
+			     p->id, status);
 			return NULL;
 		}
 		/* update the group stats */
-- 
2.9.3

