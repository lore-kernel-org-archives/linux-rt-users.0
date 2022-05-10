Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6230BC433F5
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 May 2022 18:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348841AbiEJST4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 10 May 2022 14:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348927AbiEJSTr (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 10 May 2022 14:19:47 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CF74BFE0
        for <linux-rt-users@vger.kernel.org>; Tue, 10 May 2022 11:15:44 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id t16so14149057qtr.9
        for <linux-rt-users@vger.kernel.org>; Tue, 10 May 2022 11:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fviB87QN+RPuef2838BAmJUsbsVR9Ozu6Dc1Jmz+Rrk=;
        b=JajtdV3qfLAUPD3EI1GPSmFOiG7KW+VF9NRGhTfyMtSkDP1HSr/kG8T0J2o9Rggh1V
         0oxE53wnvGmdUE+WRKCxPIS4lmpgBion8aOrN6m7JdNzKEsvIpcVNimoq0FAzuCu7bUZ
         X0Qk0KVl7jxNdRqioQwo/4T2+y7e1zDMtVzUT8PFp+RWIT9Zrl+zfnRYyzOo+QUlDMq2
         4MXl6KmDQFVeYYzWsgTapGBdFGLvC/Z78yODHdE84eWua/cGstdemTD/CYRrGo7F2iO0
         9+Lg4XX9GY6IsPCEnfcDLJXsd9r7xkBZwD1/Db8mZ1gpVX8hNZ5oWXx4Xckk/+Kh0UYt
         s2zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=fviB87QN+RPuef2838BAmJUsbsVR9Ozu6Dc1Jmz+Rrk=;
        b=ZH1ymSto/Egw5A6LqWgAUexW8pr7IVlqSKQBv+7MqZs0ZZqKsIe0rbTBgmDl6AbvG6
         8WYw575xWn9qINgKEa+qMvmuWS6XAm86aPd6jRbLme86MPwZy0M5+8TFUtove4OfyQL/
         8Wh+ZOxlD0S1CYGwuIvotDAij4TbewuvP04wnSQm8hISg0Pv4FzaWIW+5NxUxYkULKPw
         +5rTCJD6HozkXvgZmzBNfbHs8NKvTd8rE9DuQ5v8VTK2d2Q1rdSJWVaEOopEODa9kpA4
         psP46R2UoSvYInnUc2qtiL6Yk378TaLzca5I1eP5nIeVYdA8NzlyiABZTjeg2HDiuByv
         0FIA==
X-Gm-Message-State: AOAM5306pt0Erwztikht1GgaZbVJsQjhednSTs0Jl3N/fYPSaq0hP0Mp
        J6nyRfh1BPAX+lF0LBX0SV/D4xhKRbs=
X-Google-Smtp-Source: ABdhPJxFBCScebIz5dJfgmw+jA819Q7d4YrFrBnhmow6UIgXDSILMWq1iEPWTJp/SHzgp6+5EQNMHw==
X-Received: by 2002:a05:622a:6111:b0:2f1:d6c1:723c with SMTP id hg17-20020a05622a611100b002f1d6c1723cmr20273103qtb.600.1652206543430;
        Tue, 10 May 2022 11:15:43 -0700 (PDT)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-09-184-147-143-93.dsl.bell.ca. [184.147.143.93])
        by smtp.gmail.com with ESMTPSA id o7-20020a05620a110700b0069fc13ce205sm8773707qkk.54.2022.05.10.11.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 11:15:43 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH] rt-tests: Remove classic_pi
Date:   Tue, 10 May 2022 14:15:20 -0400
Message-Id: <20220510181520.19881-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

This very early program in the rt-tests suite has been completed
rewritten and is now called pi_stress. There is no reason to keep these
old files around.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/pi_tests/classic_pi.c   | 599 ------------------------------------
 src/pi_tests/classic_pi.odg | Bin 12470 -> 0 bytes
 2 files changed, 599 deletions(-)
 delete mode 100644 src/pi_tests/classic_pi.c
 delete mode 100644 src/pi_tests/classic_pi.odg

diff --git a/src/pi_tests/classic_pi.c b/src/pi_tests/classic_pi.c
deleted file mode 100644
index 64af8890276f..000000000000
--- a/src/pi_tests/classic_pi.c
+++ /dev/null
@@ -1,599 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * classic_pi - Classic Priority Inversion deadlock test case
- * Copyright (C) 2006, 2007 Clark Williams <williams@redhat.com>
- */
-
-/* This program tests Priority Inheritance mutexes and their ability
-   to avoid Priority Inversion deadlocks
-  
-   The basic premise here is to set up a deadlock scenario and confirm that PI
-   mutexes resolve the situation. Three worker threads will be created from the
-   main thread: low, medium and high priority threads that use SCHED_FIFO as 
-   their scheduling policy. The low priority thread claims a mutex and then
-   starts "working". The medium priority thread starts and preempts the low 
-   priority thread. Then the high priority thread runs and attempts to claim
-   the mutex owned by the low priority thread. Without priority inheritance, 
-   this will deadlock the program. With priority inheritance, the low priority 
-   thread receives a priority boost, finishes it's "work" and releases the mutex,
-   which allows the high priority thread to run and finish and then the medium
-   priority thread finishes. 
-   
-   That's the theory, anyway... 
-   
-   CW - 2006  */
-
-#include <stdio.h>
-#include <errno.h>
-#include <stdlib.h>
-#include <stdarg.h>
-#include <pthread.h>
-#include <sched.h>
-#include <unistd.h>
-#include <string.h>
-#include <signal.h>
-#include <getopt.h>
-
-/* test timeout */
-#define TIMEOUT 2
-
-/* determine if the C library supports Priority Inheritance mutexes */
-#if defined(_POSIX_THREAD_PRIO_INHERIT) && _POSIX_THREAD_PRIO_INHERIT != -1
-#define HAVE_PI_MUTEX 1
-#else
-#define HAVE_PI_MUTEX 0
-#endif
-
-int use_pi_mutex = HAVE_PI_MUTEX;
-
-#define SUCCESS 0
-#define FAILURE 1
-
-/* the number of times we cause a priority inversion situation */
-int inversions = 1;
-
-int verbose = 0;
-
-struct option options [] = {
-	{ "verbose", no_argument, NULL, 'v' },
-	{ "quiet", no_argument, NULL, 'q' },
-	{ "no-pi", no_argument, NULL, 'n'}, 
-	{ "inversions" , required_argument, NULL, 'i'},
-};
-
-/* define priorities for the threads */
-#define SKEL_PRIO(x) (x)
-#define MAIN_PRIO(x) (x - 1)
-#define HIGH_PRIO(x) (x - 2)
-#define MED_PRIO(x)  (x - 3)
-#define LOW_PRIO(x)  (x - 4)
-
-enum thread_names {LOW=0, MEDIUM, HIGH, NUM_WORKER_THREADS};
-
-pthread_mutex_t mutex;
-pthread_mutexattr_t mutex_attr;
-
-pthread_barrier_t all_threads_ready;
-pthread_barrier_t all_threads_done;
-
-// state barriers
-pthread_barrier_t start_barrier;
-pthread_barrier_t locked_barrier;
-pthread_barrier_t elevate_barrier;
-pthread_barrier_t finish_barrier;
-
-volatile int deadlocked = 0;
-volatile int high_has_run = 0;
-volatile int low_unlocked = 0;
-
-cpu_set_t cpu_mask;
-
-struct thread_parameters {
-	pthread_t tid;
-	int inversions;
-} thread_parameters[NUM_WORKER_THREADS];
-
-/* forward prototypes */
-void *low_priority(void *arg);
-void *med_priority(void *arg);
-void *high_priority(void *arg);
-int setup_thread_attr(pthread_attr_t *attr, int prio, cpu_set_t *mask);
-int set_cpu_affinity(cpu_set_t *mask);
-void error(char *, ...);
-void info(char *, ...);
-
-int
-initialize_barriers(void)
-{
-	int status;
-
-	status = pthread_barrier_init(&all_threads_ready, NULL, NUM_WORKER_THREADS+1);
-	if (status) {
-		error("initialize_barriers: failed to initialize all_threads_ready\n");
-		return FAILURE;
-	}
-	status = pthread_barrier_init(&all_threads_done, NULL, NUM_WORKER_THREADS+1);
-	if (status) {
-		error("initialize_barriers: failed to initialize all_threads_done\n");
-		return FAILURE;
-	}
-	status = pthread_barrier_init(&start_barrier, NULL, NUM_WORKER_THREADS);
-	if (status) {
-		error("initialize_barriers: failed to initialize start_barrier\n");
-		return FAILURE;
-	}
-	status = pthread_barrier_init(&locked_barrier, NULL, 2);
-	if (status) {
-		error("initializing_barriers: failed to intialize locked_barrier\n");
-		return FAILURE;
-	}
-	status = pthread_barrier_init(&elevate_barrier, NULL, 2);
-	if (status) {
-		error("initializing_barriers: failed to initialize elevate_barrier\n");
-		return FAILURE;
-	}
-	status = pthread_barrier_init(&finish_barrier, NULL, NUM_WORKER_THREADS);
-	if (status) {
-		error("initializing_barriers: failed to initialize finish_barrier\n");
-		return FAILURE;
-	}
-	return SUCCESS;
-}	
-
-void cleanup(void)
-{
-	int i;
-	int status;
-	for (i = 0; i < NUM_WORKER_THREADS; i++) {
-		status = pthread_kill(thread_parameters[i].tid, SIGQUIT);
-		if (status)
-			error("cleanup: error sending SIGQUIT to thread %d\n", 
-			      thread_parameters[i].tid);
-	}
-}
-
-void handler(int signal)
-{
-	info("handler: %s fired\n", sys_siglist[signal]);
-	cleanup();
-	if (signal == SIGALRM) {
-		error("handler: DEADLOCK detected!\n");
-		deadlocked = 1;
-	}
-}
-
-void usage(void)
-{
-	printf ("classic_pi [options]\n");
-	printf ("   options:\n");
-	printf ("        -v|--verbose\n");
-	printf ("        -q|--quiet\n");
-	printf ("        -n|--no-pi\n");
-	printf ("        -i <n> |--inversions=<n>\n");
-}
-
-int main(int argc, char **argv)
-{
-	int status;
-	int prio_max;
-	pthread_attr_t thread_attr;
-	struct sched_param thread_param;
-	int opt;
-
-	/* Make sure we see all message, even those on stdout.  */
-	setvbuf (stdout, NULL, _IONBF, 0);
-
-	/* process command line arguments */
-	while ((opt = getopt_long(argc, argv, "+", options, NULL)) != -1) {
-		switch (opt) {
-		case '?':
-			usage();
-			exit(1);
-		case 'v':
-			verbose = 1;
-			break;
-		case 'q':
-			verbose = 0;
-			break;
-		case 'n':
-			use_pi_mutex = 0;
-			break;
-		case 'i':
-			inversions = strtol(optarg, NULL, 10);
-			info("main: doing %d inversion loops\n", inversions);
-			break;
-		}
-	}
-
-	/* initialize default attributes for the mutex */
-	status = pthread_mutexattr_init(&mutex_attr);
-	if (status) {
-		error("main: initializing mutex attribute: 0x%x\n", status);
-		return FAILURE;
-	}
-
-	if (use_pi_mutex) {
-		/* set priority inheritance attribute for mutex */
-		status = pthread_mutexattr_setprotocol(&mutex_attr, 
-						       PTHREAD_PRIO_INHERIT);
-		if (status) {
-			error("main: setting mutex attribute policy: 0x%x\n", status);
-			return FAILURE;
-		}
-	}
-	info("main: Priority Inheritance turned %s\n", use_pi_mutex ? "on" : "off");
-
-	/* initialize our mutex */
-	status = pthread_mutex_init(&mutex, &mutex_attr);
-	if (status) {
-		error("main: initializing mutex: 0x%x\n", status);
-		return FAILURE;
-	}
-
-	/* set up our barriers */
-	status = initialize_barriers();
-	if (status)
-		return FAILURE;
-
-	/* set up CPU affinity so we only use one processor */
-	if (set_cpu_affinity(&cpu_mask))
-		return FAILURE;
-		
-	/* boost us to max priority (so we keep running) :) */
-	prio_max = sched_get_priority_max(SCHED_FIFO);
-	thread_param.sched_priority = MAIN_PRIO(prio_max);
-	status = pthread_setschedparam(pthread_self(), SCHED_FIFO, &thread_param);
-	if (status) {
-		error("main: boosting to max priority: 0x%x\n", status);
-		/* Don't fail if we don't have the right privledges */
-		return SUCCESS;
-	}
-
-	/* start the low priority thread */
-	info("main: creating low priority thread\n");
-	setup_thread_attr(&thread_attr, LOW_PRIO(prio_max), &cpu_mask);
-	thread_parameters[LOW].inversions = inversions;
-	status = pthread_create(&thread_parameters[LOW].tid, 
-				&thread_attr, 
-				low_priority, 
-				&thread_parameters[LOW]);
-	if (status != 0) {
-		error("main: creating low_priority thread: 0x%x\n", status);
-		return FAILURE;
-	}
-
-	/* create the medium priority thread */
-	info("main: creating medium priority thread\n");
-	setup_thread_attr(&thread_attr, MED_PRIO(prio_max), &cpu_mask);
-	thread_parameters[MEDIUM].inversions = inversions;
-	status = pthread_create(&thread_parameters[MEDIUM].tid, 
-				&thread_attr, 
-				med_priority, 
-				&thread_parameters[MEDIUM]);
-	if (status != 0) {
-		error("main: creating med_priority thread: 0x%x\n", status);
-		return FAILURE;
-	}
-
-	/* create the high priority thread */
-	info("main: creating high priority thread\n");
-	if (setup_thread_attr(&thread_attr, HIGH_PRIO(prio_max), &cpu_mask))
-		return FAILURE;
-	thread_parameters[HIGH].inversions = inversions;
-	status = pthread_create(&thread_parameters[HIGH].tid, 
-				&thread_attr, 
-				high_priority, 
-				&thread_parameters[HIGH]);
-	if (status != 0) {
-		error("main: creating high_priority thread: 0x%x\n", status);
-		cleanup();
-		return FAILURE;
-	}
-
-	signal(SIGINT, handler);
-	signal(SIGALRM, handler);
-
-	info("main: releasing all threads\n");
-	status = pthread_barrier_wait(&all_threads_ready);
-	if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-		error("main: pthread_barrier_wait(all_threads_ready): 0x%x\n", status);
-		cleanup();
-		return FAILURE;
-	}
-	info("main: all threads initialized, waiting for mutex to be claimed\n");
-
-	alarm(TIMEOUT * inversions);
-	info("main: waiting for threads to finish\n");
-	
-	status = pthread_barrier_wait(&all_threads_done);
-	if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-		error("main: pthread_barrier_wait(all_threads_done): 0x%x\n", status);
-		cleanup();
-		return FAILURE;
-	}
-	alarm(0);
-	info("main: all threads terminated!\n");
-	if (deadlocked) {
-		info("main: test failed\n");
-		return FAILURE;
-	}
-	info("main: test passed\n");
-	return SUCCESS;
-}
-
-
-int setup_thread_attr(pthread_attr_t *attr, int prio, cpu_set_t *mask)
-{
-	int status;
-	struct sched_param thread_param;
-
-	status = pthread_attr_init(attr);
-	if (status) {
-		error("setup_thread_attr: initializing thread attribute: 0x%x\n", status);
-		return FAILURE;
-	}
-	status = pthread_attr_setschedpolicy(attr, SCHED_FIFO);
-	if (status) {
-		error("setup_thread_attr: setting attribute policy to SCHED_FIFO: 0x%x\n", status);
-		return FAILURE;
-	}
-	status = pthread_attr_setinheritsched(attr, PTHREAD_EXPLICIT_SCHED);
-	if (status) {
-		error("setup_thread_attr: setting explicit scheduling inheritance: 0x%x\n", status);
-		return FAILURE;
-	}
-	thread_param.sched_priority = prio;
-	status = pthread_attr_setschedparam(attr, &thread_param);
-	if (status) {
-		error("setup_thread_attr: setting scheduler param: 0x%x\n", status);
-		return FAILURE;
-	}
-	status = pthread_attr_setaffinity_np(attr, sizeof(cpu_set_t), mask);
-	if (status) {
-		error("setup_thread_attr: setting affinity attribute: 0x%x\n", status);
-		return FAILURE;
-	}
-	return SUCCESS;
-}
-
-int set_cpu_affinity(cpu_set_t *cpu_set)
-{
-	int status, i;
-	cpu_set_t current_mask, new_mask;
-
-	/* Now set our CPU affinity to only run one one processor */
-	status = sched_getaffinity(0, sizeof(cpu_set_t), &current_mask);
-	if (status) {
-		error("set_cpu_affinity: getting CPU affinity mask: 0x%x\n", status);
-		return FAILURE;
-	}
-	for (i = 0; i < sizeof(cpu_set_t) * 8; i++) {
-		if (CPU_ISSET(i, &current_mask))
-			break;
-	}
-	if (i >= sizeof(cpu_set_t) * 8) {
-		error("set_cpu_affinity: No schedulable CPU found!\n");
-		return FAILURE;
-	}
-	CPU_ZERO(&new_mask);
-	CPU_SET(i, &new_mask);
-	status = sched_setaffinity(0, sizeof(cpu_set_t), &new_mask);
-	if (status) {
-		error("set_cpu_affinity: setting CPU affinity mask: 0x%x\n", status);
-		return FAILURE;
-	}
-	info("set_cpu_affinity: using processr %d\n", i);
-	*cpu_set = new_mask;
-	return SUCCESS;
-}
-
-void report_threadinfo(char *name)
-{
-	int status;
-	struct sched_param thread_param;
-	int thread_policy;
-
-	status = pthread_getschedparam(pthread_self(), &thread_policy, &thread_param);
-	if (status) {
-		error("report_threadinfo: failed to get scheduler param: 0x%x\n", status);
-		exit(FAILURE);
-	}
-	info("%s: running as %s thread at priority %d\n",
-	     name, thread_policy == SCHED_FIFO ? "FIFO" :
-	     thread_policy == SCHED_RR ? "RR" : "OTHER",
-	     thread_param.sched_priority);
-}
-
-void *low_priority(void *arg)
-{
-	int status;
-	struct thread_parameters *p = (struct thread_parameters *)arg;
-
-	report_threadinfo("low_priority");
-
-	info("low_priority: entering ready state\n");
-
-	/* wait for all threads to be ready */
-	status = pthread_barrier_wait(&all_threads_ready);
-	if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-		error("low_priority: pthread_barrier_wait(all_threads_ready): %x", status);
-		return NULL;
-	}
-
-	info("low_priority: starting inversion loop (%d)\n", p->inversions);
-	while (p->inversions-- > 0) {
-		/* initial state */
-		info("low_priority: entering start wait (%d)\n", p->inversions+1);
-		status = pthread_barrier_wait(&start_barrier);
-		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-			error("low_priority: pthread_barrier_wait(start): %x\n", status);
-			return NULL;
-		}
-		info("low_priority: claiming mutex\n");
-		pthread_mutex_lock(&mutex);
-		info("low_priority: mutex locked\n");
-
-		info("low_priority: entering locked wait\n");
-		status = pthread_barrier_wait(&locked_barrier);
-		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-			error("low_priority: pthread_barrier_wait(locked): %x\n", status);
-			return NULL;
-		}
-
-		/* wait for priority boost */
-		info("low_priority: entering elevated wait\n");
-		low_unlocked = 0; /* prevent race with med_priority */
-		status = pthread_barrier_wait(&elevate_barrier);
-		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-			error("low_priority: pthread_barrier_wait(elevate): %x\n", status);
-			return NULL;
-		}
-		low_unlocked = 1;
-
-		/* release the mutex */
-		info("low_priority: unlocking mutex\n");
-		pthread_mutex_unlock(&mutex);
-
-		/* finish state */
-		info("low_priority: entering finish wait\n");
-		status = pthread_barrier_wait(&finish_barrier);
-		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-			error("low_priority: pthread_barrier_wait(elevate): %x\n", status);
-			return NULL;
-		}
-		
-	}
-	/* let main know we're done */
-	info("low_priority: entering exit state\n");
-	status = pthread_barrier_wait(&all_threads_done);
-	if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-		error("low_priority: pthread_barrier_wait(all_threads_done): %x", status);
-		return NULL;
-	}
-	info("low_priority: exiting\n");
-	return NULL;
-}
-
-void *med_priority(void *arg)
-{
-	int status;
-	struct thread_parameters *p = (struct thread_parameters *)arg;
-
-	report_threadinfo("med_priority");
-
-	info("med_priority: entering ready state\n");
-	/* wait for all threads to be ready */
-	status = pthread_barrier_wait(&all_threads_ready);
-	if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-		error("med_priority: pthread_barrier_wait(all_threads_ready): %x", status);
-		return NULL;
-	}
-
-	info("med_priority: starting inversion loop (%d)\n", p->inversions);
-	while (p->inversions-- > 0) {
-		/* start state */
-		info("med_priority: entering start state (%d)\n", p->inversions+1);
-		status = pthread_barrier_wait(&start_barrier);
-		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-			error("med_priority: pthread_barrier_wait(start): %x", status);
-			return NULL;
-		}
-		info("med_priority: entering elevate state\n");
-		do {
-			status = pthread_barrier_wait(&elevate_barrier);
-			if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-				error("med_priority: pthread_barrier_wait(elevate): %x", status);
-				return NULL;
-			}
-		} while (!high_has_run && !low_unlocked);
-		info("med_priority: entering finish state\n");
-		status = pthread_barrier_wait(&finish_barrier);
-		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-			error("med_priority: pthread_barrier_wait(finished): %x", status);
-			return NULL;
-		}
-	}
-
-	info("med_priority: entering exit state\n");
-	status = pthread_barrier_wait(&all_threads_done);
-	if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-		error("med_priority: pthread_barrier_wait(all_threads_done): %x", status);
-		return NULL;
-	}
-	info("med_priority: exiting\n");
-	return NULL;
-}
-
-void *high_priority(void *arg)
-{
-	int status;
-	struct thread_parameters *p = (struct thread_parameters *)arg;
-
-	report_threadinfo("high_priority");
-
-	info("high_priority: entering ready state\n");
-
-	/* wait for all threads to be ready */
-	status = pthread_barrier_wait(&all_threads_ready);
-	if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-		error("high_priority: pthread_barrier_wait(all_threads_ready): %x", status);
-		return NULL;
-	}
-
-	info("high_priority: starting inversion loop (%d)\n", p->inversions);
-	while (p->inversions-- > 0) {
-		high_has_run = 0;
-		info("high_priority: entering start state (%d)\n", p->inversions+1);
-		status = pthread_barrier_wait(&start_barrier);
-		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-			error("high_priority: pthread_barrier_wait(start): %x", status);
-			return NULL;
-		}
-		info("high_priority: entering running state\n");
-		status = pthread_barrier_wait(&locked_barrier);
-		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-			error("high_priority: pthread_barrier_wait(running): %x", status);
-			return NULL;
-		}
-		info("high_priority: locking mutex\n");
-		pthread_mutex_lock(&mutex);
-		info("high_priority: got mutex\n");
-		high_has_run = 1;
-		info("high_priority: unlocking mutex\n");
-		pthread_mutex_unlock(&mutex);
-		info("high_priority: entering finish state\n");
-		status = pthread_barrier_wait(&finish_barrier);
-		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-			error("high_priority: pthread_barrier_wait(finish): %x", status);
-			return NULL;
-		}
-	}
-       
-	info("high_priority: entering exit state\n");
-	status = pthread_barrier_wait(&all_threads_done);
-	if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-		error("high_priority: pthread_barrier_wait(all_threads_done): %x", status);
-		return NULL;
-	}
-	info("high_priority: exiting\n");	
-	return NULL;
-}
-
-void error(char *fmt, ...)
-{
-	va_list ap;
-	fputs("ERROR: ", stderr);
-	va_start(ap, fmt);
-	vfprintf(stderr, fmt, ap);
-	va_end(ap);
-}
-
-void info(char *fmt, ...)
-{
-	if (verbose) {
-		va_list ap;
-		va_start(ap, fmt);
-		vprintf(fmt, ap);
-		va_end(ap);
-	}
-}
diff --git a/src/pi_tests/classic_pi.odg b/src/pi_tests/classic_pi.odg
deleted file mode 100644
index 889294b2db74c25fb99d0b356a661f067d653f8a..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 12470
zcmbt)2V4`&7j6I%q^KZW=}meGAiaY$>Aeaeflv}4L7Fr{DbkS=K)NW>i-0r{RC*T>
z0i`Jd(os}O-UhE%uh0Ac-S>MFHaoj>&NtsVGi+wh9DQwq6I38v*|;Ywo<kt`j1Q>e
z4r1VNhr2`3ejZSJ4-Ypu#2yVtB809X90if~C^$+G=>bJJA|c-HPy|}g$;;lu84f||
z{{s-f_`5IwH5DWR26yuII)*}t3Zc;UXm6B*y_e8;Jz}6+9Ff13fC~2?^z0!Js2dc3
zL3#;6yuG||41C?)2tfMUL^$FgeB2jM{+$jT(E2+am>bd_4gEm|r~f;dKN;bH^zilo
zoZ$VJ5r5LV@Q2<!ypT>_P}DEx|4H*tJaL`<blQK_LL-rG|67as4=myC_D)cgkTM+Y
zZtsEm&BVcikPRyW5D0e&0LuDs2-+L4Nk~Na*CP7Y1?~(MmQoi{5%fSfMd|BaCMRJa
z0rbc<HB=3OGYjq@2Eah7h0!lSAYedsjMack5GVxrfI>oWU&kk)+Sb+v0%3s<2#dvi
z9iNV?ATS671A#CgP#^9-2)G7=K`<}~0|xbhLD=JFFbo8PfiN&o9}I*&mIh-$FboKT
z0rg=(*kfgI9|+b5!t{aq`asxYEHD-X!-6naP#>;895jFp0|BalEYOJS2`Dfy7y}0P
zfx+10j)7|!42*$+`(R+~F%O^_h5=(R;64l(drS+EhV_9lec--6F!q=wpbW!;F<5XP
z7K}Y64HyBi2517j03txoKvw`Z00w9S;y^oa11K06tPcjm9$N@>3|wO{us#e7du%Yk
z18Bzd!TS1O*kk(vT7WbL3+uzeu*dEIyal)i@CV=kz+%8ez$U;5fHgo9-~|u?dIq2Y
zYyb?<2E>7O;093oFc|EyD*+3Ej)CjGJ`DEQvw*<>51_dZi@_c{8W<K}9011yo(5bC
z_!4j);4Q#CfIk2S02Tu#0;B;ffHgo9-~|u?dIq2YYyb?<2E>7O;092z$72S#60i{H
z7`VnB4<RuAz<>iI3=Ao5_TYvH7!zO+0IvgX#tkswOTZlfOF$X$2jBp}V!%XzG=K%L
z2517j03txo05pINfC1WoIM5E<z|F%3-2C|eFAXDlxTgS(rmB*$Zx&>h8$_p09m7j!
zB5X(v0`;26;)$J^-Nf~ysiv!1u6*^zzdub$0VxO)f&S}>xn|XiSdgHa+2bRlwuz?v
zR7c^YkJhhMJV_@8R;-Uvol@P!=j_}%P)$305~QiQqBfbz8L)_XmCpb1!?tbI(x$v`
z@#6Z7E0wOTaK8rSAT==>dIO?xN~1Z8FGu09+`p%3KW9DZ`He5WG#p3L?Vjb|G_z_p
zPSwQKScpiQjf-V-USyx-SEm?&Jyy^*ykKSuwg}+LHqofQe*UxsZBMm#oZU{|3+sC5
z?d)3$78iTR@zgSb>$F7POrfN_7Znx{1Swzm-^tJV*f%fEv9)7u@y<_rw6-5cAi<^a
z!7yxe+4x++r|?5dA)8TsXTsK7Dt*kU@Ux0#Be5QFw+7-@dyJwdhR+p+6)Q=-wi>%L
zA5$#cFf9@>qfrO{I??M@>C?h5<NVny^7LnL-t;wUFx@&YjAcswqMdhX#r?pmVe<<e
zDhp;}4Bz<6r}BI5b1;(C45h9ma}?k2A&<UFJ1UNz8Hsk)3_uwNs%XX)7p^m#>=}HR
zh~XY)9Z6?;nSLwUuAz5A=~+~lG#ObLU3p4P?#_5{u&?i~nWS>8=(3rqX4boli1cnY
z%G0)lMN@ON7rDZ0LRYo&jEa^`-5V-Ml&Ur{rldpCdJT^%qBREAH=-kHa+2qLjy4}t
z7V7g5l0JjALi5=!J>;=;P+OI-8Ic?1R9lYzk|L>gCym=Pk48Of0yL~xyl$28fCtJk
zlr`(t&duUN0KUA!o3}{H=W)^4KqHl`X%NvfQ(3mxUUsO?$EI|a1e6gzOLt-6h6fGD
zqAdj%{~7GZ{WwTQ6R4F@f9HlGyK0Vz2}WTs#g6BS#M?7P-b(2fy2(zkv)m%Rl%={U
zN&d0kTLoezcFXHc9m)s0J5=*(wk}&Bv$Pl+@0;CT&$U!_Cw!3}D)_dg(N$`qw>7NK
ze+V+})shpG4z=5tX)s`~;3n6JTMUrG?1Y7LdIzh%PSgl%t6DpB&cyGO;+&OVPq9+x
zqpTg{7^lRjADOGBeeAxFM)mb(LfsDDedvT8uSgUDmz0RX_34t5j-|k>q8&L+X72?%
zCkz}^GtVcLl7)<OFz2%Ig}X6dNcG&VJ*|?Z7p)}dlwC-b_B^3yKjZQC+b7tUzRw(A
z>(lhrj75iDe!mqz^?~OUA7Y#ycDnmo&Uq8()I39(>a(y#(##SlmaUC3bN$rS7<u85
zD;yf_T-u3)h-eG;5Wmk0p~f+rAkyJ;HN{2{dgw%Ff)s<wS-MNz3F2%jZ?1?s#=l6w
zE6sH5qK{?W;ri;?xv-?ZQ+tU)Wjyx%@^U2E3@rQBH)pEJiIfNT=Da#ey_q1X1bUj4
zWkNkWJ^M1lNn1v}`BHomuMQY^P535vbLMAjJ{Ez;%_0{Dygtg==6a{|y%X@HOA_nY
z-#g2l>n$|tg7h0@S0`Sb(VR^&V|~4SN#rA+#gf`3tMc2Ya``e;1xuta6TC9z40tDx
zKMgOdb&t_f(AGvKEIs{3I_@&sTqp(o*pvGr%sGaDg0B3;5W$;TTD$ZwgOUxBioO`}
za4zBgBeiGzX#F^$xDf_I=wk%6dIu<bl+;tnA*n2mz3|oGnWtdsxu-O;JF>oKb-b<G
zmqLo2>JMI4?oVunO1Thhq{C`q^EO<PpA(%cJM-|Q+iq=3ueOQ#!@pdJK;9yD;$V9X
zCw<*kS>DAseY>))*<PB3_XV0rAqsLWWk|&>y~XY0tWa$|kI~k|?mg*G<eD*KAL)@_
z5IvvGCoUPV4z);A+U9Ajj@}{@tPEkVf(l3B=?p&bCM%{f9(B5D)o&U(n9HMh)0e)y
zDuXMWS;mz8Ahs=AnzpCMf6)K>t9SKWpUx**8+1kAnkhPq-+RDtGFJCwtO)&eUp_Mb
zwrjC8VbURSeOEIf1;x`5AHaGAgAJzNt`%6PoXaF$uY0SMxFuK5I3ry-P4j3>@WZoN
z`K~hWwWo5C%4a@|O5A*R5<*6@=IT9|(JmpU@0)J_ahz_Z%8JSolwm{ldcl{qnTBLv
zyU+GU>E~+@D!L^d+Jl9)?InEY$;+oo>u(a#qje!eEm9{}c?~FDt=!wkf5pfh((jsw
zT#_W*CU7WO3t798Ff6u8bZS@nl-L;x=j`QRBp1Q@g#G!3&600-5G0pppnC`?&7EbY
zd}J4W+S1sP#g!)4^nQs1zQ-`eVk?7q0rTCa{uNoyipy6kCHGw!_1>RrAT1IZXAoWh
zWq!tk*pvwnlqj!|S$})b@cFO>D?8{Q&^Q&5PVF7I((P)omZ{r$o$W(GD8dJSLlTjO
zfA^AbnJP~`d-KqpjVMcU?WU22wknzWsqsW%1+C<3rUT~_Nm2)kM#sx<rdV(I_LQ7y
z`+P3lM;Biv?c`GC_&{<TkuLw;C8jgG>vGbgk^9u}aKG>p<}UWNbNY;uMF+OIjq*IV
z4`}lF*^d?%a+38Vd%5GKdbSqj=7Njq$aMss69(U(Y}S3pwv}(}+M+%teROy8C>ZzV
z!E5_XREr1%ikJNH=JBT&8r*^xh4yoUqHymlYu0x0QxcTH8~26L4Xwl9Ajs;^P$TQ}
zwSmqd`0#zpAxd{}qH1XV_-as8K=X!A&LT|XFwd=<kNZt&Qv!h_>p+ay&O%=Txai=0
zQv^r$G#G<Qd?R)A62-+&uJ&xS|L)E{QX$D|sj2>LGsUX-nMqMf`@~A)MC&z3s-B``
zf7&hIB`Q%Hl8l|}n33>z+SGz-FGjSS;V7X`1$~jNllq?hZrXgGb8nHbBehe@fnQ<p
z)JS4sQ(k))Y5MDVR}tectnuBJ3HluLCI^bQBhv5ZtY?)OPL6o{G|iwdWs*GhJbdmj
z=i*Z4VZH;s86$2+)yNO~QaSzUeyi0Mm(FnBH`a<WLrV@mE+Q2bYPpOto$3qbZPvTJ
z_Lr)mmPg)C=s()*Wiq9A2&9A^>VWHQpfuz@DHe{sT*mGJ@At+7&!`^0-M3?SlGHuq
z#EK++sK4!2iMchEN~`?xVSdP|Yh{R8Kh%V^)pS$xN11NwWSRiqB)LLQb9TWb!J&{r
zpU|+%0QA?_>*1YYWhdV-ap&<clgVvcmRlA*H{}hodS{c2c-#7vzj|7O!Lwmd)ozY`
zJu9cDN`YWwa3U^G6_~J%-0pFjYJxR_i$v;BxsySpb<gqh_n5Pf?r;n};VS)fpR>d0
z`AAlYob$RLwl=(xM{H(xw4|vbJVqD-ni1%qHl#+lpAUY4CpNSprk~6mG}V~3fa<Bz
zZJOnZE^4^$XCy?N>}4L!yXX5z-Ib~H1ebe<+oRSc-aPtMvr<RJF|>p&g461))RS#}
z>Vzumw>1i(pM2g61nmZ=!<LIEP4;!HQXHLA=zHtw)W{4G#^eSK;wEi8BX%cZT}UZ;
z6-3~!SR~K$0gU1st2d~+eOuX(=jV`=zR4J;7p$I~@-Y<5opqsmW`R$vHMgP?Bj1-{
z{D~$aFAqf#8FDKHWOI<3Jm)uF536{U#sOPCS##AjE`h36DvW8ML-Qm-U(&fMae;X+
z6|e}zm4xE-I!S1%yWa=nX8IK4_(UCLMeXPIq>dU5RV=moY=al&Z(Y`*Gi7kHTDjw9
zk+_1v>tvH*xnu<YKo{f4Nq>`&vGN^pblz326Lwrtk;2ZL1|`w8G(0cto(Xr(zSnt6
zNIjg{ARdb{odRXjRhl?TvCMwXG^r`DxjarI#a@{i^(^i~L|W)QN4(V1o5K&3x2!Uv
z4(v8wUH*1i<ZBy;U1nnHw_6xDa}u(I#d{jgujjiY!}so@^f)^M&3Cf0u!NB(c664j
z=tQ;gSV<@nS3>ovij#7?HkcckPWfdNMOcoA1siv3iN0Nm=Im@V-BpL&CP*o#i&?ox
zaObs|m}!`Ph5<!m>{AmS*qI!tuE3P5e*ZAiuzv(@d__*8ge%lO*0nCbW?NIn_=@_|
z*|-NWS(ot}n(G)}Ye77iDR#Or7mDgkl{;e0N3O|^U`~$4h)+N6OYhU}bFet2>*RgQ
zWmqNB!J7QahdMeBwKdv_+vo`4a%=aUT}xAVqj|V}OSY@lqfVB?DboJ?wD6G{`Ae&u
z%a**X5?}`Vdzvh)d2&G>VKf%uDf%RryliUI%cu?Gh?9_YG|zRGQq}!yx(kR~1{pXi
zyL&KfXWTWWo&|DO;ct$21kXA(w#C>#Dz>hpkF@Wk&$O@Rolh^0Vx4cWeZG5-m7<ho
zJqvrdr=V-cE8kbc+~zI+F*zmjE^4G!GiT>~%a)g3alkE+r;r!sm#TC|MEwal`A*)8
zvaPUV{g9EgdFL6LP}KWGbM?gblXJ>7w^<kU!f2z04sH<7v}%MS1aIjJ-+iJHZfir9
zH+lQn(x-QuetCZ1K06Ti+c{_3TA$5J!`u(ta5y`2&_el0O>nORVaIu`x*LD+7Ku~X
z$;>Okj~9f9O2~r)UQ$u7RW)W`jPNdT?2T!L>$#*@M1K+xv2!$cr@AxT;5FkSa%n~F
zI_P0)?nSDHMhZP_aPcwIXonh3XfHqYa=}b0>rHH$m{p(oy?7nxX%=G>YjwTebo|`p
zqRV5@?((eIm7s}N)mzBSb@ebMwY8yXI`12ED-4oyT;sbz>;dMx(={AZh6}27cFvyN
z4so%bSDgJ7<9CCet+11h#qnu8EJ~S~#DB<8X*_OcmmKzf7-N$kr#|%ZiBvtUvCpg?
zI?6U@of4z!Rjs*8@0_t2s3qBZ;4z45efXr{F<SdQm_I@`=57hM*i7xhzz&Kmr($-R
zi}#5}Z%X9n!Q$oRnRre4Bfc(#lhvoHuBYPW$egdM78CW_qHk56UneLbbLpMf-{}_%
z$aDg4Yc@S_l3=QUgXON-b*`_z3T$Bre}OwQHdR3OKKW5F9G@E-E7m?c6ZW)`g!7f~
zc;9=pa6QO$Et2c&puN$CC-Y#f`hZ)<iTkgGFF#w5=-X@`6RW$Wd)ea%eL@e+Xv3&f
zA$8+rM%X85GTPe}(nJ%6W<+MGT%C>nr6rw>-(1cztgcj*GyV0os_tA`B4lfpX)aw}
zdZx2vg42IMVk|r^f2El~#~lrG3WPU8#oCSJ2kizF@Pne>%YFz0Z$?1Sw&IrdyZnct
zO9b6n0@AXZgskW9o|!o}wrxggGchbv&eGK(q$XxBCbT#aY1RbxUblZx)H{6P+R7bQ
z#v3k$@(ZOJL)0VdPfNbO<7_2}srVF8$YxyWPFLz0VDNzE!;{v%tkc;>+30VotMqp*
z51T3T+j8FUf81KpciZ%D94bK-7c7Ee5}Lny#_4Eq^3;n|^Dpn!UzE`bcvn$)_D+R;
z6;Zski&}@?c^;B<H?Y<Fv=b*U*n0&ym2z;1nZ3q-?nerRT#*cK3VHuJ=+g|H%@dYj
zRpc&XJLL4ecZa2{4aHPjr{Y8(ikP?v?hTzL(1P<jOlK7OyeFUL`gWey{lY8%lpHbC
zsstUg;_@|Y*3cA|0JpI59%7`;0|KjY8b1~`xM%||I4WPd^;nV+1i~H1A!8`o9=EKK
zRRF$Nu0g#}K+sr@O+-+bjRlH;ARXZdCpk6~V|4*ZHU)VSStJYwhd`x&#E}JnfU`Xd
zpo&0Ae{Ygw^Y%hWA4i;}5%%s-lr$P5{cGr1`d4Y`<Bq=H@pXeET;<rD(P$58At4_h
zA3-0mAkxc8NJL6XO6a(i?XRvJA%Dwxczd}WOF2S>fEY6_xDA9e1x18@$l@6OS5i3H
zUnzM2u~7i<IQ;!zF@Dwg6$^<({!JR^kMHg}rVhke#e}|J|6q-Bhr9jP9&xe)5Tv^Y
zz|+AE`fI252)O%yg~7=lTlyW~uaW-8l#u^1{y0a;%O1PS35xh0*_YP?tkOH4AK$GK
z6z0%@BfNcC{@Gv$1kzog5VVklq_Ddfhq5=^%~3!~_>!=!&~Jd>JAfnLXt+IKp%)al
zfgrEqX7A<7Vg`3}gWJ2K{!;o~=)3B%3NWDs9D#iTdBDvQ0>V-Pq7ud;BGTfb(&FI1
zwErn5>j;tlx6XcP!ioJ8SJGHSTw3gsG#D`DN8@)Q9$s)DhUX~Y;P+?xzqJ3N@PE@5
zmlhV5221@#`&jF{5RQzSJ;KQwi2ln%5dtPg#}xj)^&J)J2)GjABmnV)0IxIhm;S=}
z?e;%q9sk<?k=F;jrU90`A|eG~ACJ@zy}w1iYkH%gUILC#7#sn0WH}bZJqYC3G!ZZ)
ziwK+0UlZqlii!R=G4OvA6Z>22?*|udD+`W7!y(@pA{}s368JCjMxf=`L?v(vfBj2J
z<4pK@^*6%t?SGHl;zGd2&fe}02z$62N(lX<irY%TOC^Ty{b4`lI-rwFd=mH`m?vHV
zp3pYmW5{cF4eCZE$rPth=4TIt&u7&0z5>oN{ySuP7g!yw>h3+OMh9m|z%xFp>&{#D
zL`+OfT&9dT<AYT665x@g`~GJ#H@LL3H#t2OHB(ccUoC5MdfdRab0=W6Xw^kvFi>z$
zetA!l(NvN<qNk(RNa~B9yWcl@wA2BEZCvu8fYtu>1G&u|hDV?L)uszOXpx7Ck1j41
zE`0q$5zKUC{Z0A}O|y=k^dS?P=}qeRwE#8#EOi4t4wk4GQ&NN5Xu)lcD@~3>rE8Ad
zZ6uuvTybLE>^5gEU3nYvd@MiNiq_{t0)GTE9If4&=Jb#v=pF4^U@F=QR`*pbPj0)q
z^r<Gdt0Ku6^`Czg9+nZL3GIAYuX;^2=E%xgeKra=eJU4)6pl`RG-|Xo`m&IwqbquH
zaPPvWxtrRKMm^g?IoW~%^U9<-iR2+@WH`0041o}(s|?;<v!WI?Kl3@l1foQ(oDSD7
zey$Olio|mT6Qky`Z|IwQ1skYZU$ZL9n0Qb@CdC?CdIgP%L{d9bAj#uZvB@&kw#(P_
zF`EY`y3^lB(k^S5Xt`3s&-CX#ZyB_6&&M8q@ojB(pWh`xD2fR(c68gt!fxA^zL9|M
zrUb~S2%$S`EsjF3jzKu7@kX5Trx(P1^Q2v<_4aNNXsc&9@HcT?E;xO;QB{^^O`wr9
zzXshuoGT*{Rx4gG-&^$>g_U|=-79)V!F)~l^EPU{bxQ8W<4ry_)Fcmhb=bVKJe@>g
zi)befvq?Q!GqLd)^+|-He6lx{(%XO*F?ml~dHtg7)RA9OyPH0BIrR+BRGd4zY?acL
zFL$}k{k*uj*=6Z?+rjMzv-0hFec0+}Et^KkN2RZ98;pw_AIpBcNW2u}ycXQm+H(C!
z?r<<|BUtwS%lBy$=ic>-rmvI7kG!U+wB~KBhp4JO(%c{q#1|V_QM#y#=t&jfY&NN@
zmenFz^P|H<v8lA*3p?ZxRr=;!tFow!9@Q9+bSp~)%dk-%eR|T#cjY-;Btt=NzhFG>
zEkl-nF*l`ravp1nU`yPKP8S3N^XTJF1KpO^4U!3sj0qQ-s@d^olS%HH3v)?+kN9IJ
z?}kKo8oG|M*Cq)zk5Zi;CU3{FN-=(`lH?nyH$I!F?xF6@yk#LBYpN@eUDT_U@#(c_
znXM?o_VdFrgEik`H6K607Kw_PyxiyTG~HD6&H9Wj{Mg;?>vggxQ^&Pg<+sSbkz}+l
z-|N=cY8>l1CH{5#Ks9dCTQX?lVb-0J%Vv_QUt`eZlTm^yU*|@2>ALRgPVS4KQw7%$
zvOGE8#BK@oKIqa2M!A@#H{NEaq$n-6Ve_A!GzlMNy^<XS;+gi@{?c;gmZU`tOG^o1
z;`Q?TPbs-N?%bQnvs`_RX>uJlK%7q#oH1{Pe6;1r{anG!*irAlU2pgry{~$r|GgLN
z)$Ru;FE;g_^!DxDLra;}&+T}<$^-=z6XzE-?!{+Knb&Y!j}XdLDnsTy*N`)lo#BJ@
zw2V*Xsdu60G+{(iE{D1`tDd8UcBfJ&Ut_FB%<_jQ$Kq%QXRG!I*I%G-ZrjM6@v^22
z>Up(htA0hh^-~@ET&pHCqmKfZ*N0n~)DC`E_Dx~=SyM^Gi+crr>gzfUt9gQ@n+($p
z{=TPo0%W=eu-P|h2RIGd(5t6!qQBmVIM+DTetBKIM|?>*cqy_doF?uZH;F*iu6T16
z(XgWP+=UTsv5NW!A7SxYrt_Y{Ve0o2J3aSih$kK-p4_=cP#Ez9oJVEJ9UBnn11k)3
zLk`=d(+rGh@{MLY5+oIN8?Ec6bGvWM8t_=70<|Ri6E<!A$dQTt_Ts5-w5e><)w-4r
zVH&<A>I`!5(FcjCuUO+YO=HFS;MIDr;}Mx?-Gk!JopThY;?3FDUg9^|%vrFn@i&@e
z`SVG_H;5W^?wpghA(`AV%u79-v$;;ft<e+M;kElH@zb;#$>kW0`Dzs(Djm(ajZ)P`
z-N`&T!!I50TbCO2J=`%e#6r_6<|Qe&%dhy(nT__SJyC9jD}iE@>3eHt7zYX~j%3E0
zSwL&G4NaO;7(Qv=zRcaR8xpBgYRR8{qJ2x;MTCfF=aQgA!)ErDXWQ~~V+mzwBr197
zy_PM$4H(oGph=Z&Q$59Be%L*2uIi^TXIts)Y53)Z`30Eamsn>mSFOxLs#d&d$u?UD
zt}EMjlG-ojUAm^v2M6Coo@6{(ez%ssjz!V<*}}+j_KSYLp}yqT`$=}YNs_h6vPBta
z{sdRAkYvhp{Ft(bA}UNB$fA_+Zo)B_>Y@iPNNq&|pPg5IThA_Y1Rj@Je6$!ZddEsa
zMj`R(VO$wxpRD(aKhyn*SxcQ>$NqOWK*DybbmwAAlEqC(@ST|;{F7_gb(tjbG*WzL
zW(a?jXjh&Z%?V*eK3*jKJX%=^#4wf^p(R9n;$rE?sPU+i@2bp9QJt<kWf45IrkC`0
zNZaMQ)V1t4lD1dbDDZS|!S2DcHDY^C=6+~-5m&!`zClBrSA&ne_D#vt7&k>D|M;c>
z_Lo@MIbQac?@@zhxzI|fue;*wskEt&hBoBU=|@(kC4p=<*KWR^iQYu{C!b%NvUF4m
ziI6q0%`{!~+7YW;LOi}Ob--LcW`H+Za6_QZ>2e(f0<VS8Wc9PL?S`RPk3sv~wuhSS
z<1w|z`=RqN_vZ%fp()xmi~%!ZQo6uX;{m!Ms=vFMwDXiuj26}pJgI_k7+uhqyE$yg
zPT@!!M}6AEdpN)AousYrHuvAZ^}ki}!Y}KAdBZ8QA48vp)3WUq(6*n7AHYuAo{k<^
zBh&}h8^3Ht6A?SkoDa?f-VRfN<KGuJWPlb5ipDJ{k0awVmR6{F396utiZ0<m=ld!R
zoSAJLXtHN*C(VfyNRicLbc7aOoKkH^-?UCvpZFM_;^}l>mgB1STOWkH^itc{ThcQ*
z&B`w*I43aeaCsDd)D=e6>D4}8N0<;e*etjye{itt7InnyP@<?VuZ!W<?RtyX+WAVR
zCNLq1B!m~XNbr~zsqM`koau&HK?A%wIjn3fuByT&FvVwsIMXr*m+tS3@IVpe`hsbw
zxtV^$93{cL5Mo047>|HKiLxu*V6QW37G-bV=<x)evvfD-p&_yDTN?B#8O$7;R{5eY
z_(;OlXfRFG>dW0SkkXqxVVAYkao3I~C?D^IsaWk2Ggmb;Y_*1>-q(G{K#MIKr^1yK
zvlC0m#Du8VdqIP8^IG&_O2YX;Fq9F0px-%)#A4VW$&%UQz^t71^)@GpQ$YrTHeBk#
zigD@cPtybk281X(>RG(*C(hFf-8+bwcaocRqVSx>mu|B5U|K8nh>u~clT~$)M9RoG
zcs+IGaD2!sNaCOBEV@|x^)-{sCe1xM{G?)ef<Al7>&XVyt_zUd`mYI~U{z}E3(Z%R
zly~Jl>}iE*DYBWOzD+5ecwu<qsm|L{T4&Pa?%TyRyT#WdM+}PM3Etp8dzx_G_jD@H
ztqKyGuSHKoWbVW>#QDSrotVD5$clgBqfs+i|9B#8c;1KnZNoX)oQW}54j(yf+2Jsr
zw%_L3Ji+NFS!0D~-7v-PPY2o9u6B>4@fe2Ksb!pg<TUiv`p)!{zMKm&23sa};Z=cm
z^m1!tci5p|TSB1!?1zOC>p;H2xtU}yEzEVaSWYJEGtmO2%c0EF4gDSZ9}Kw(jcWbK
zAFs+{v|QYV6u(u*CCZ(Ddb7b(|08{l>g|MFdBSHmeb8e@g}DP~*@?F09evPDYYX81
zUBUkR3$j!r)FEr?u=Ek}4kv<{0*ArpooyyhRl>UF&1<F)us$5!a|-JkVg>ppUEU;g
z5mh6!(X<&`+XS+<pB+CGmBv5_v4$ft>EvF`FQalzq%I)Wni16Xp+{}wQB^8c%mJZ9
z^k?tfbIRyE$sxwCSztj~`v`eK4;#v)xBOxFz5V%IXGG*f2guYk$K@PVy}YS({gps=
z3h_}q6QyU**WjAdYo9<|{&*4dn+8)W%5Cjl3r;Y^t&N3u=_=zO{0mPmJY;31W-QjH
zd+Y7+Ug-&zLIdx}`rP7|#%;-WFGnCLW3&X-_%QF4;>q$1SRBVYgWGeJ?}o<v#@XFL
z@?-DOVp4Np;>v_t6$+aZhkf?+3VvcdH3<uf+wWT!QC)HT9bu6Y&hC5~=s@O+M|3Z@
z^lKjAlZCcCU10bWLeq58M)jq>?)kY}lFaLR8B6jC1tDP^>DMBg{8N#5_NxkJMl&7T
zG@=e3%R51eZWM)Me06@3CJzmyJB05({w$$H{;EcdVbwkE4EJu7=AuRV09r!zQsPjF
z=;>$3o0`T3g`(IqQdIszWsk3S2`keDITk^L3)!A%<%-6;IGwYxB*~H?zM!?a{uoVG
z)_8U^<f+Ky`HZrXi~SW69f~Bfq@sQY0W8%DFSA&8q11Dtvw9JsOZQT&Iy4wgfY_^C
zKXb5`ou#R+la(B+|Gcg7G34Emo9nqN=>s*@1NS8LUAXdNd>>xoH#%CWpy70&Q>OTs
znz-@gRps=!-Q)S)CKVU$O^@sx*}7P}ui_V{&%AgW=#s{Tn(7E0ZMJ*CA1EAC&N|NQ
z^;mmUm>cr-8jPF_@*!o|X0%U%JXY;6VjViPLcKO__Lj}()wM&j?$CGp#iP$E#<lIQ
zrnJ6yAKYc^2(Ho+58i$y;6rq@cR#<IyWk*yN*GZ_gp%T!zd9m@^<)b0Tb+~lVEF2H
z-+mJjC|?oKVpd{dtDCWhy1$&-Bot=VG`5i3d8%%)v20&$bExAm(Njjk^-`FF#c}{m
zkKE=H%R*C+KBjuDFrfk>*-SCoSHiBNnp;69m;w*n>)Ld+m+k2?4xf+<>o^5bC<jXh
z4WD4zk1OSI9Gj2LU4pcHW4or6Fts10E4WT%F&2!6i#^6(<0&BkUSUT#|JRQPkO&33
zqGqflpsA}a<PL<MU{KU?PUxc)C1g7bRmjFZHTfQmcUoChM&GlY)9XYmfn^+2#2faz
zZ{sr_%)nB;d0IfHuD@MSV($G^JUU4s%j?Q3Aq3+mV0SOmv8sxnkqEY59UHAar!F31
zY%617?X)RTYQ9-ii%*@Zjt=4M9+4J)l#)lF@^0cQ6lp03_3<bWTlCCVaPpylskMl{
zrY|y=WooD&lgxa@#@hP1zCo>RLs(MRdN`N!T^Xf_XwMgyPca)wjEg-aKcXZSluXJE
z378w5y?G~>^>o>isP9`O7$*9dFDiG~^eo2>nbjM&Cs;Vz1E&1j(A+Z-*<`xoD~=vx
zQ8WopcviwY3gZ$#Zio|vEn~CU9w?tC48Cn&ct9!YQxvEZY?h?lY;axve9&#Bec6DS
zflF%f>1_8eEod-2jq<faGZ{kImV-@}eFR4=2z2AtLY_HNqkV{H-VonQ9DO7+=}A62
z%0&}7zZ#^ymW1`4Hp{_{(@~V4CKL|@qCNhR$HS)r{d;0DZh`Q#{75s_*Z!y0PYDnR
zmw5ZL7y#AZlXrj3CH{`{>*o89gkW4Y@y`+kRDZ|$m)zq2MGhC5`B`Rx>hGXGGmHPL
zi8O#Ke@FQ>)A-+UaJj}mi|(Ir{*ih7?@0f&EAkIWKQod4D@yAhP=016|2qovPm_S!
z?jKP8uT15Cg8iPW{1Z<Em>mC4nae-s!jB2|Yu*Pg!SZLB0JcRSKhrILSNwHf1(z1`
zvsjY<nk4c=57+*uU6-GFU>YE8ABZpF_F#T!{h;~lGW?%In|S`;V~f9|{Q5k`E!lq-
rFOGjM;D6Wr^$CG{UjHl=y#Mm_*4HM)MK3{Tfsf`15Xg)lclCb&vwGTl

-- 
2.35.3

