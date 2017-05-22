From: Tommi Rantala <tommi.t.rantala@nokia.com>
Subject: [PATCH 26/34] deadline_test: remove unused tid parameter in do_runtime()
Date: Mon, 22 May 2017 11:25:32 +0300
Message-ID: <20170522082540.15467-27-tommi.t.rantala@nokia.com>
References: <20170522082540.15467-1-tommi.t.rantala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-rt-users@vger.kernel.org>,
        Tommi Rantala <tommi.t.rantala@nokia.com>
To: Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-eopbgr50126.outbound.protection.outlook.com ([40.107.5.126]:6656
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757279AbdEVI0i (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 May 2017 04:26:38 -0400
In-Reply-To: <20170522082540.15467-1-tommi.t.rantala@nokia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

src/sched_deadline/deadline_test.c: In function 'do_runtime':
src/sched_deadline/deadline_test.c:1191:28: warning: unused parameter 'tid' [-Wunused-parameter]
 static u64 do_runtime(long tid, struct sched_data *data, u64 period)
                            ^~~

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 src/sched_deadline/deadline_test.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/src/sched_deadline/deadline_test.c b/src/sched_deadline/deadline_test.c
index e5621a3..e5c31d6 100644
--- a/src/sched_deadline/deadline_test.c
+++ b/src/sched_deadline/deadline_test.c
@@ -1165,7 +1165,6 @@ static int read_ctx_switches(int *vol, int *nonvol, int *migrate)
 
 /**
  * do_runtime - Run a loop to simulate a specific task
- * @tid: The thread ID
  * @data: The sched_data descriptor
  * @period: The time of the last period.
  *
@@ -1188,7 +1187,7 @@ static int read_ctx_switches(int *vol, int *nonvol, int *migrate)
  *  @data->total_time - Total time it took to complete all loops
  *  @data->nr_periods - Number of periods that were executed.
  */
-static u64 do_runtime(long tid, struct sched_data *data, u64 period)
+static u64 do_runtime(struct sched_data *data, u64 period)
 {
 	u64 next_period = period + data->deadline_us;
 	u64 now = get_time_us();
@@ -1361,7 +1360,7 @@ void *run_deadline(void *data)
 	period = get_time_us();
 	
 	while (!done) {
-		period = do_runtime(tid, sched_data, period);
+		period = do_runtime(sched_data, period);
 		sched_yield();
 	}
 	ret = sched_getattr(0, &attr, sizeof(attr), 0);
@@ -1722,7 +1721,7 @@ static u64 calculate_loops_per_ms(u64 *overhead)
 	do_sleep(1000);
 
 	start = get_time_us();
-	do_runtime(0, &sd, start + sd.deadline_us);
+	do_runtime(&sd, start + sd.deadline_us);
 	end = get_time_us();
 
 	diff = end - start;
@@ -1751,7 +1750,7 @@ static u64 calculate_loops_per_ms(u64 *overhead)
 	do_sleep(1000);
 
 	start = get_time_us();
-	do_runtime(0, &sd, start + sd.deadline_us);
+	do_runtime(&sd, start + sd.deadline_us);
 	end = get_time_us();
 
 	odiff = end - start;
@@ -1964,7 +1963,7 @@ int main (int argc, char **argv)
 
 		/* Make sure that we can make our deadlines */
 		start_period = get_time_us();
-		do_runtime(gettid(), sd, start_period);
+		do_runtime(sd, start_period);
 		end_period = get_time_us();
 		if (end_period - start_period > sd->runtime_us) {
 			printf("Failed to perform task within runtime: Missed by %lld us\n",
-- 
2.9.3

