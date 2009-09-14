From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 5/6] pi_stress clean-ups, fix hang.
Date: Mon, 14 Sep 2009 16:38:31 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0909141636480.4675@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: williams@redhat.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37272 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755572AbZINOic (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Sep 2009 10:38:32 -0400
Received: from int-mx03.intmail.prod.int.phx2.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n8EEcZkt021272
	for <linux-rt-users@vger.kernel.org>; Mon, 14 Sep 2009 10:38:36 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>From ba6cda49e292e0066e7e874c3614803f2b07cc0f Mon Sep 17 00:00:00 2001
From: John Kacur <jkacur@redhat.com>
Date: Fri, 4 Sep 2009 12:57:42 +0200
Subject: [PATCH] Change the name of the cleanup() function to set_shutdown_flag()

Change the name of the cleanup() function to set_shutdown_flag() since that
is what it actually does!
---
 src/pi_tests/pi_stress.c |   25 ++++++++++++-------------
 1 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
index 5a5c35a..38ddbd6 100644
--- a/src/pi_tests/pi_stress.c
+++ b/src/pi_tests/pi_stress.c
@@ -230,7 +230,7 @@ void process_command_line(int argc, char **argv);
 void usage(void);
 int block_signals(void);
 int allow_sigterm(void);
-void cleanup(void);
+void set_shutdown_flag(void);
 int initialize_group(struct group_parameters *group);
 int create_group(struct group_parameters *group);
 unsigned long total_inversions(void);
@@ -332,7 +332,7 @@ main (int argc, char **argv)
 	status = pthread_barrier_wait(&all_threads_ready);
 	if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
 		error("main: pthread_barrier_wait(all_threads_ready): 0x%x\n", status);
-		cleanup();
+		set_shutdown_flag();
 		return FAILURE;
 	}
 
@@ -342,7 +342,7 @@ main (int argc, char **argv)
 		fputs(DOWN_ONE, stdout);
 		printf("Stopping test\n");
 	}
-	cleanup();
+	set_shutdown_flag();
 
 	// wait for all threads to notice the shutdown flag
 	if (have_errors == 0 && interrupted == 0) {
@@ -560,7 +560,7 @@ reporter(void *arg)
 		// if we specified a duration, see if it has expired
 		if (end && time(NULL) > end) {
 			info("duration reached (%d seconds)\n", duration);
-			cleanup();
+			set_shutdown_flag();
 			continue;
 		}
 
@@ -573,7 +573,7 @@ reporter(void *arg)
 		// check watchdog stuff
 		if ((watchdog_check())) {
 			error("reporter stopping due to watchdog event\n");
-			cleanup();
+			set_shutdown_flag();
 			break;
 		}
 			
@@ -582,7 +582,7 @@ reporter(void *arg)
 		
 	}
 	debug("reporter: finished\n");
-	cleanup();
+	set_shutdown_flag();
 	return NULL;
 }
 
@@ -671,7 +671,7 @@ low_priority(void *arg)
 			return NULL;
 		}
 	}
-	cleanup();
+	set_shutdown_flag();
 	debug("low_priority[%d]: entering done barrier\n", p->id);
 	/* wait for all threads to finish */
 	status = pthread_barrier_wait(&all_threads_done);
@@ -734,7 +734,7 @@ med_priority(void *arg)
 			return NULL;
 		}
 	}
-	cleanup();
+	set_shutdown_flag();
 
 	debug("med_priority[%d]: entering done barrier\n", p->id);
 	/* wait for all threads to finish */
@@ -812,7 +812,7 @@ high_priority(void *arg)
 		p->watchdog++;
 
 	}
-	cleanup();
+	set_shutdown_flag();
 
 	debug("high_priority[%d]: entering done barrier\n", p->id);
 
@@ -929,9 +929,8 @@ allow_sigterm(void)
 	return SUCCESS;
 }
 
-// clean up before exiting
-void
-cleanup(void)
+/* clean up before exiting */
+void set_shutdown_flag(void)
 {
 	if (shutdown == 0) {
 		// tell anyone that's looking that we're done
@@ -1045,7 +1044,7 @@ create_group(struct group_parameters *group)
 				group);
 	if (status != 0) {
 		error("creating high_priority thread: %s\n", strerror(status));
-		cleanup();
+		set_shutdown_flag();
 		return FAILURE;
 	}
 	return SUCCESS;
-- 
1.6.0.6

