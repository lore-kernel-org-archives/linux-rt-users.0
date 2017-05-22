From: Tommi Rantala <tommi.t.rantala@nokia.com>
Subject: [PATCH 21/34] pi_stress: use %lu for unsigned long
Date: Mon, 22 May 2017 11:25:27 +0300
Message-ID: <20170522082540.15467-22-tommi.t.rantala@nokia.com>
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
        id S1752771AbdEVI0a (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 May 2017 04:26:30 -0400
In-Reply-To: <20170522082540.15467-1-tommi.t.rantala@nokia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

src/pi_tests/pi_stress.c: In function 'low_priority':
src/pi_tests/pi_stress.c:712:12: warning: format '%d' expects argument of type 'int', but argument 3 has type 'long unsigned int' [-Wformat=]
   pi_debug("low_priority[%d]: entering start wait (%d)\n", p->id,
            ^
src/pi_tests/pi_stress.c: In function 'med_priority':
src/pi_tests/pi_stress.c:840:12: warning: format '%d' expects argument of type 'int', but argument 3 has type 'long unsigned int' [-Wformat=]
   pi_debug("med_priority[%d]: entering start state (%d)\n", p->id,
            ^
src/pi_tests/pi_stress.c: In function 'high_priority':
src/pi_tests/pi_stress.c:964:12: warning: format '%d' expects argument of type 'int', but argument 3 has type 'long unsigned int' [-Wformat=]
   pi_debug("high_priority[%d]: entering start state (%d)\n", p->id,
            ^

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 src/pi_tests/pi_stress.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
index 116869a..8972122 100644
--- a/src/pi_tests/pi_stress.c
+++ b/src/pi_tests/pi_stress.c
@@ -709,7 +709,7 @@ void *low_priority(void *arg)
 		}
 
 		/* initial state */
-		pi_debug("low_priority[%d]: entering start wait (%d)\n", p->id,
+		pi_debug("low_priority[%d]: entering start wait (%lu)\n", p->id,
 		      count++);
 		status = pthread_barrier_wait(&p->start_barrier);
 		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
@@ -837,7 +837,7 @@ void *med_priority(void *arg)
 		}
 
 		/* start state */
-		pi_debug("med_priority[%d]: entering start state (%d)\n", p->id,
+		pi_debug("med_priority[%d]: entering start state (%lu)\n", p->id,
 		      count++);
 		status = pthread_barrier_wait(&p->start_barrier);
 		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
@@ -961,7 +961,7 @@ void *high_priority(void *arg)
 			}
 			pthread_mutex_unlock(&shutdown_mtx);
 		}
-		pi_debug("high_priority[%d]: entering start state (%d)\n", p->id,
+		pi_debug("high_priority[%d]: entering start state (%lu)\n", p->id,
 		      count++);
 		status = pthread_barrier_wait(&p->start_barrier);
 		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-- 
2.9.3

