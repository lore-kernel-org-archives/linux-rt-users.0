From: Tommi Rantala <tommi.t.rantala@nokia.com>
Subject: [PATCH 28/34] deadline_test: use %llu for printing unsigned long longs
Date: Mon, 22 May 2017 11:25:34 +0300
Message-ID: <20170522082540.15467-29-tommi.t.rantala@nokia.com>
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
        id S1757366AbdEVI0n (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 May 2017 04:26:43 -0400
In-Reply-To: <20170522082540.15467-1-tommi.t.rantala@nokia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 src/sched_deadline/deadline_test.c | 42 +++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/src/sched_deadline/deadline_test.c b/src/sched_deadline/deadline_test.c
index 6958ad9..c8cf755 100644
--- a/src/sched_deadline/deadline_test.c
+++ b/src/sched_deadline/deadline_test.c
@@ -1334,7 +1334,7 @@ void *run_deadline(void *data)
 	attr.sched_runtime = sched_data->runtime_us * 1000;
 	attr.sched_deadline = sched_data->deadline_us * 1000;
 
-	printf("thread[%ld] runtime=%lldus deadline=%lldus loops=%lld\n",
+	printf("thread[%ld] runtime=%lluus deadline=%lluus loops=%llu\n",
 	       gettid(), sched_data->runtime_us,
 	       sched_data->deadline_us, sched_data->loops_per_period);
 
@@ -1737,8 +1737,8 @@ static u64 calculate_loops_per_ms(u64 *overhead)
 
 	loops = 1000ULL * test_loops / sd.last_time;
 
-	printf("%lld test loops took %lldus total (%lld internal)\n"
-	       "calculated loops for 1000us=%lld\n",
+	printf("%llu test loops took %lluus total (%llu internal)\n"
+	       "calculated loops for 1000us=%llu\n",
 	       test_loops, diff, sd.last_time, loops);
 
 	sd.deadline_us = 2000;
@@ -1763,9 +1763,9 @@ static u64 calculate_loops_per_ms(u64 *overhead)
 
 	*overhead = odiff - sd.last_time;
 
-	printf("%lld test loops took %lldus total (%lld internal)\n"
-	       "New calculated loops for 1000us=%lld\n"
-	       "Diff from last calculation: %lld loops\n",
+	printf("%llu test loops took %lluus total (%llu internal)\n"
+	       "New calculated loops for 1000us=%llu\n"
+	       "Diff from last calculation: %llu loops\n",
 	       test_loops, odiff, sd.last_time, loops, loops - test_loops);
 
 	return loops;
@@ -1919,7 +1919,7 @@ int main (int argc, char **argv)
 	printf(" nr_cpus:%d", nr_cpus);
 	if (setcpu)
 		printf(" (%s)", setcpu);
-	printf(" loops:%lld overhead:%lldus\n", loops, overhead);
+	printf(" loops:%llu overhead:%lluus\n", loops, overhead);
 
  again:
 	/* Set up the data while sill in SCHED_FIFO */
@@ -1931,9 +1931,9 @@ int main (int argc, char **argv)
 		 */
 		runtime = interval * percent / 100;
 		if (runtime < overhead) {
-			fprintf(stderr, "Run time too short: %lld us\n",
+			fprintf(stderr, "Run time too short: %llu us\n",
 				runtime);
-			fprintf(stderr, "Read context takes %lld us\n",
+			fprintf(stderr, "Read context takes %llu us\n",
 				overhead);
 			exit(-1);
 		}
@@ -1966,14 +1966,14 @@ int main (int argc, char **argv)
 		do_runtime(sd, start_period);
 		end_period = get_time_us();
 		if (end_period - start_period > sd->runtime_us) {
-			printf("Failed to perform task within runtime: Missed by %lld us\n",
+			printf("Failed to perform task within runtime: Missed by %llu us\n",
 				end_period - start_period - sd->runtime_us);
 			overhead += end_period - start_period - sd->runtime_us;
-			printf("New overhead=%lldus\n", overhead);
+			printf("New overhead=%lluus\n", overhead);
 			goto again;
 		}
 
-		printf("  Tested at %lldus of %lldus\n",
+		printf("  Tested at %lluus of %lluus\n",
 		       end_period - start_period, sd->runtime_us);
 
 		interval += step;
@@ -2076,18 +2076,18 @@ int main (int argc, char **argv)
 		printf("\n[%d]\n", sd->tid);
 		printf("missed deadlines  = %d\n", sd->missed_deadlines);
 		printf("missed periods    = %d\n", sd->missed_periods);
-		printf("Total adjustments = %lld us\n", sd->total_adjust);
-		printf("# adjustments = %lld avg: %lld us\n",
+		printf("Total adjustments = %llu us\n", sd->total_adjust);
+		printf("# adjustments = %llu avg: %llu us\n",
 		       sd->nr_adjust, sd->total_adjust / sd->nr_adjust);
-		printf("deadline   : %lld us\n", sd->deadline_us);
-		printf("runtime    : %lld us\n", sd->runtime_us);
-		printf("nr_periods : %lld\n", sd->nr_periods);
-		printf("max_time: %lldus", sd->max_time);
-		printf("\tmin_time: %lldus", sd->min_time);
-		printf("\tavg_time: %lldus\n", sd->total_time / sd->nr_periods);
+		printf("deadline   : %llu us\n", sd->deadline_us);
+		printf("runtime    : %llu us\n", sd->runtime_us);
+		printf("nr_periods : %llu\n", sd->nr_periods);
+		printf("max_time: %lluus", sd->max_time);
+		printf("\tmin_time: %lluus", sd->min_time);
+		printf("\tavg_time: %lluus\n", sd->total_time / sd->nr_periods);
 		printf("ctx switches vol:%d nonvol:%d migration:%d\n",
 		       sd->vol, sd->nonvol, sd->migrate);
-		printf("highes prime: %lld\n", sd->prime);
+		printf("highes prime: %llu\n", sd->prime);
 		printf("\n");
 	}
 
-- 
2.9.3

