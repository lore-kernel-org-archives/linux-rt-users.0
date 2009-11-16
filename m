From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 2/3] pi_stress: Fix trailing-whitespace warnings.
Date: Mon, 16 Nov 2009 21:17:42 +0100
Message-ID: <1258402663-13621-3-git-send-email-jkacur@redhat.com>
References: <1258402663-13621-1-git-send-email-jkacur@redhat.com>
 <1258402663-13621-2-git-send-email-jkacur@redhat.com>
Cc: John Kacur <jkacur@redhat.com>,
	rt-users <linux-rt-users@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:37391 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753253AbZKPURo (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 16 Nov 2009 15:17:44 -0500
Received: by bwz27 with SMTP id 27so6073319bwz.21
        for <linux-rt-users@vger.kernel.org>; Mon, 16 Nov 2009 12:17:48 -0800 (PST)
In-Reply-To: <1258402663-13621-2-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/pi_tests/pi_stress.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
index 865e3b4..d90d4a9 100644
--- a/src/pi_tests/pi_stress.c
+++ b/src/pi_tests/pi_stress.c
@@ -1,8 +1,8 @@
 /*
    pi_stress - Priority Inheritance stress test
-  
+
    Copyright (C) 2006, 2007 Clark Williams <williams@redhat.com>
-  
+
    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
@@ -19,25 +19,25 @@
    USA */
 
 /* This program stress tests pthreads priority inheritance mutexes
-  
+
    The logic is built upon the state machine that performs the "classic_pi"
    deadlock scenario. A state machine or "inversion group" is a group of three
    threads as described below.
 
    The basic premise here is to set up a deadlock scenario and confirm that PI
    mutexes resolve the situation. Three worker threads will be created from the
-   main thread: low, medium and high priority threads that use SCHED_FIFO as 
+   main thread: low, medium and high priority threads that use SCHED_FIFO as
    their scheduling policy. The low priority thread claims a mutex and then
-   starts "working". The medium priority thread starts and preempts the low 
+   starts "working". The medium priority thread starts and preempts the low
    priority thread. Then the high priority thread runs and attempts to claim
-   the mutex owned by the low priority thread. Without priority inheritance, 
-   this will deadlock the program. With priority inheritance, the low priority 
+   the mutex owned by the low priority thread. Without priority inheritance,
+   this will deadlock the program. With priority inheritance, the low priority
    thread receives a priority boost, finishes it's "work" and releases the mutex,
    which allows the high priority thread to run and finish and then the medium
-   priority thread finishes. 
+   priority thread finishes.
+
+   That's the theory, anyway...
 
-   That's the theory, anyway... 
-   
    CW - 2006  */
 
 #include <stdio.h>
@@ -99,7 +99,7 @@ time_t start, finish;
 // the number of groups to create
 int ngroups = 0;
 
-// the number of times a group causes a priority inversion situation 
+// the number of times a group causes a priority inversion situation
 // default to infinite
 int inversions = -1;
 
@@ -705,7 +705,7 @@ void *low_priority(void *arg)
 		debug("low_priority[%d]: unlocking mutex\n", p->id);
 		pthread_mutex_unlock(&p->mutex);
 
-		// finish state 
+		// finish state
 		debug("low_priority[%d]: entering finish wait\n", p->id);
 		status = pthread_barrier_wait(&p->finish_barrier);
 		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-- 
1.6.2.5

