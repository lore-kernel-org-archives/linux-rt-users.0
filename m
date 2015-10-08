From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH rt-tests] Fix some trivial typos found by codespell(1)
Date: Thu,  8 Oct 2015 23:12:32 +0200
Message-ID: <1444338752-30701-1-git-send-email-u.kleine-koenig@pengutronix.de>
Cc: linux-rt-users@vger.kernel.org
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from arcturus.kleine-koenig.org ([78.47.169.190]:55616 "EHLO
	arcturus.kleine-koenig.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756422AbbJHVMp (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 8 Oct 2015 17:12:45 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Inheritence ==> Inheritance
occured ==> occurred
surpress ==> suppress
---
 src/pi_tests/classic_pi.c    | 2 +-
 src/pi_tests/pi_stress.c     | 4 ++--
 src/pi_tests/pip_stress.c    | 2 +-
 src/pi_tests/tst-mutexpi10.c | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/pi_tests/classic_pi.c b/src/pi_tests/classic_pi.c
index 59e907bc98cc..695ee4c4bd03 100644
--- a/src/pi_tests/classic_pi.c
+++ b/src/pi_tests/classic_pi.c
@@ -18,7 +18,7 @@
    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301
    USA */
 
-/* This program tests Priority Inheritence mutexes and their ability
+/* This program tests Priority Inheritance mutexes and their ability
    to avoid Priority Inversion deadlocks
   
    The basic premise here is to set up a deadlock scenario and confirm that PI
diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
index a4e6e3df1a3d..a02f70629aa4 100644
--- a/src/pi_tests/pi_stress.c
+++ b/src/pi_tests/pi_stress.c
@@ -132,7 +132,7 @@ unsigned long report_interval = (unsigned long)SEC_TO_USEC(0.75);
 int shutdown = 0;		/* global indicating we should shut down */
 pthread_mutex_t shutdown_mtx;	/* associated mutex */
 
-/* indicate if errors have occured */
+/* indicate if errors have occurred */
 int have_errors = 0;
 
 /* indicated that keyboard interrupt has happened */
@@ -1025,7 +1025,7 @@ void usage(void)
 	printf("usage: pi_stress <options>\n");
 	printf("    options:\n");
 	printf("\t--verbose\t- lots of output\n");
-	printf("\t--quiet\t\t- surpress running output\n");
+	printf("\t--quiet\t\t- suppress running output\n");
 	printf
 	    ("\t--duration=<n>- length of the test run in seconds [infinite]\n");
 	printf("\t--groups=<n>\t- set the number of inversion groups [%d]\n",
diff --git a/src/pi_tests/pip_stress.c b/src/pi_tests/pip_stress.c
index 812a7030aa9d..a0477cc2a35d 100644
--- a/src/pi_tests/pip_stress.c
+++ b/src/pi_tests/pip_stress.c
@@ -64,7 +64,7 @@ useconds_t usleep_val = 500;
 
 pthread_mutex_t *resource;
 
-/* This records the state to determine whether a priority inversion occured */
+/* This records the state to determine whether a priority inversion occurred */
 struct State {
 	int low_owns_resource;
 	int high_started;
diff --git a/src/pi_tests/tst-mutexpi10.c b/src/pi_tests/tst-mutexpi10.c
index 0244b4a7a7c1..a63ea23ba621 100644
--- a/src/pi_tests/tst-mutexpi10.c
+++ b/src/pi_tests/tst-mutexpi10.c
@@ -21,7 +21,7 @@
    Boston, MA 02111-1307, USA.  */
 
 
-/* This program tests Priority Inheritence mutexes and their ability
+/* This program tests Priority Inheritance mutexes and their ability
    to avoid Priority Inversion deadlocks
   
    The basic premise here is to set up a deadlock scenario and confirm that PI
-- 
2.1.4

