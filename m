From: Tommi Rantala <tommi.t.rantala@nokia.com>
Subject: [PATCH 30/34] cyclicdeadline: remove unused tid parameter from do_runtime()
Date: Mon, 22 May 2017 12:04:20 +0300
Message-ID: <20170522090424.16086-1-tommi.t.rantala@nokia.com>
References: <20170522082540.15467-1-tommi.t.rantala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-rt-users@vger.kernel.org>,
        Tommi Rantala <tommi.t.rantala@nokia.com>
To: Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-db5eur01on0100.outbound.protection.outlook.com ([104.47.2.100]:33571
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751678AbdEVJEn (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 May 2017 05:04:43 -0400
In-Reply-To: <20170522082540.15467-1-tommi.t.rantala@nokia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

src/sched_deadline/cyclicdeadline.c:730:28: warning: unused parameter 'tid' [-Wunused-parameter]
 static u64 do_runtime(long tid, struct sched_data *sd, u64 period)
                            ^~~

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 src/sched_deadline/cyclicdeadline.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index 59f06d5..e8cc559 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -727,7 +727,7 @@ static void print_stat(FILE *fp, struct sched_data *sd, int index, int verbose,
 	}
 }
 
-static u64 do_runtime(long tid, struct sched_data *sd, u64 period)
+static u64 do_runtime(struct sched_data *sd, u64 period)
 {
 	struct thread_stat *stat = &sd->stat;
 	u64 next_period = period + sd->deadline_us;
@@ -822,7 +822,7 @@ void *run_deadline(void *data)
 	period = get_time_us();
 	
 	while (!shutdown) {
-		period = do_runtime(tid, sd, period);
+		period = do_runtime(sd, period);
 		sched_yield();
 	}
 	ret = sched_getattr(0, &attr, sizeof(attr), 0);
@@ -1167,7 +1167,7 @@ int main (int argc, char **argv)
 
 		/* Make sure that we can make our deadlines */
 		start_period = get_time_us();
-		do_runtime(gettid(), sd, start_period);
+		do_runtime(sd, start_period);
 		end_period = get_time_us();
 		if (end_period - start_period > sd->runtime_us) {
 			fprintf(stderr, "Failed to perform task within runtime: Missed by %lld us\n",
-- 
2.9.3

