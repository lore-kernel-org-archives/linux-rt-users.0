From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 2/5] rt-tests: Add a new test pip - priority inheritance with processes
Date: Wed, 23 Dec 2009 17:02:57 +0100
Message-ID: <1261584180-13922-3-git-send-email-jkacur@redhat.com>
References: <1261584180-13922-1-git-send-email-jkacur@redhat.com>
 <1261584180-13922-2-git-send-email-jkacur@redhat.com>
Cc: John Kacur <jkacur@redhat.com>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Clark Williams <williams@redhat.com>,
	Carsten Emde <carsten.emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:28500 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753058AbZLWQDL (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 23 Dec 2009 11:03:11 -0500
Received: by fg-out-1718.google.com with SMTP id 19so3180901fgg.1
        for <linux-rt-users@vger.kernel.org>; Wed, 23 Dec 2009 08:03:09 -0800 (PST)
In-Reply-To: <1261584180-13922-2-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This test is similar to pi_stress in that it purpursely triggers a priority-
inversion. However, instead of using pthreads it uses processes.
Since pthread_mutex_t are the only objects backed by priority inheritance
this is accomplished by having the processes use a pthread_mutex_t in
shared memory. See the header of pip.c for more information as well as the
code of course.

In addition this patch starts a src/include directory as a common place
to put header files.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 .gitignore          |    2 +-
 Makefile            |    7 +-
 src/include/error.h |   15 +++
 src/include/pip.h   |   40 ++++++
 src/lib/error.h     |   14 --
 src/pi_tests/pip.c  |  344 +++++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 405 insertions(+), 17 deletions(-)
 create mode 100644 src/include/error.h
 create mode 100644 src/include/pip.h
 delete mode 100644 src/lib/error.h
 create mode 100644 src/pi_tests/pip.c

diff --git a/.gitignore b/.gitignore
index d03a635..a914a3f 100644
--- a/.gitignore
+++ b/.gitignore
@@ -22,4 +22,4 @@ ptsematest
 sendme
 sigwaittest
 svsematest
-
+pip
diff --git a/Makefile b/Makefile
index 137cd0f..df5a2f4 100644
--- a/Makefile
+++ b/Makefile
@@ -2,7 +2,7 @@ VERSION_STRING = 0.59
 
 TARGETS	= cyclictest signaltest pi_stress \
 	  hwlatdetect rt-migrate-test ptsematest sigwaittest svsematest \
-	  sendme
+	  sendme pip
 LIBS 	= -lpthread -lrt
 EXTRA_LIBS ?= -ldl	# for get_cpu
 DESTDIR	?=
@@ -11,7 +11,7 @@ bindir  ?= $(prefix)/bin
 mandir	?= $(prefix)/share/man
 srcdir	?= $(prefix)/src
 
-CFLAGS = -D_GNU_SOURCE -Wall -Wno-nonnull -Isrc/lib
+CFLAGS = -D_GNU_SOURCE -Wall -Wno-nonnull -Isrc/lib -Isrc/include
 
 ifndef DEBUG
 	CFLAGS	+= -O2
@@ -63,6 +63,9 @@ svsematest: svsematest.o rt-utils.o rt-get_cpu.o
 sendme: sendme.o rt-utils.o rt-get_cpu.o
 	$(CC) $(CFLAGS) -o $@ $^ $(LIBS) $(EXTRA_LIBS)
 
+pip: pip.o error.o
+	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)
+
 CLEANUP  = $(TARGETS) *.o .depend *.*~ *.orig *.rej rt-tests.spec
 CLEANUP += $(if $(wildcard .git), ChangeLog)
 
diff --git a/src/include/error.h b/src/include/error.h
new file mode 100644
index 0000000..512b3a6
--- /dev/null
+++ b/src/include/error.h
@@ -0,0 +1,15 @@
+#ifndef __ERROR_H
+#define __ERROR_H
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdarg.h>
+#include <string.h>
+
+void err_exit(int err, char *fmt, ...);
+void err_msg(char *fmt, ...);
+void err_msg_n(int err, char *fmt, ...);
+void err_quit(char *fmt, ...);
+void err_doit(int err, const char *fmt, va_list ap);
+
+#endif	/* __ERROR_H */
diff --git a/src/include/pip.h b/src/include/pip.h
new file mode 100644
index 0000000..01a31c3
--- /dev/null
+++ b/src/include/pip.h
@@ -0,0 +1,40 @@
+#ifndef __PIP_H
+#define __PIP_H
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <errno.h>
+#include <sys/mman.h>
+#include <string.h>
+#include <stdarg.h>
+#include <pthread.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <signal.h>
+#include <sched.h>
+#include "error.h"
+
+void low(pid_t pid);	/* low priority process */
+void medium(void);	/* medium priority process */
+void high(pid_t pid);	/* high priority process */
+void init_state(void);
+
+void *mmap_page(void);
+long process_shared_mutex_available(void);
+void Pthread_mutexattr_init(pthread_mutexattr_t *attr);
+void Pthread_mutexattr_setpshared(pthread_mutexattr_t *attr, int pshared);
+void Pthread_mutexattr_setprotocol(pthread_mutexattr_t *attr, int protocol);
+void Pthread_mutex_init(pthread_mutex_t *mutex, pthread_mutexattr_t *attr);
+void Pthread_mutex_lock(pthread_mutex_t *mutex);
+void Pthread_mutex_unlock(pthread_mutex_t *mutex);
+
+void init_shared_pthread_mutex(pthread_mutex_t *mutex, int protocol, int policy);
+int set_rt_prio(pid_t pid, int prio, int policy);
+int get_rt_prio(pid_t pid);
+
+#define PROTRW PROT_READ|PROT_WRITE
+#define MMAP_FLAGS MAP_SHARED|MAP_ANONYMOUS
+
+#endif	/* __PIP_H */
+
diff --git a/src/lib/error.h b/src/lib/error.h
deleted file mode 100644
index 90d6e94..0000000
--- a/src/lib/error.h
+++ /dev/null
@@ -1,14 +0,0 @@
-#ifndef __ERROR_H
-#define __ERROR_H
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <stdarg.h>
-
-void err_exit(int err, char *fmt, ...);
-void err_msg(char *fmt, ...);
-void err_msg_n(int err, char *fmt, ...);
-void err_quit(char *fmt, ...);
-void err_doit(int err, const char *fmt, va_list ap);
-
-#endif	/* __ERROR_H */
diff --git a/src/pi_tests/pip.c b/src/pi_tests/pip.c
new file mode 100644
index 0000000..ce3f5d9
--- /dev/null
+++ b/src/pi_tests/pip.c
@@ -0,0 +1,344 @@
+/*
+	Pip - Priority Inheritance with processes
+    
+    Copyright (C) 2009, John Kacur <jkacur@redhat.com>
+
+    This program is free software: you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation, either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program.  If not, see <http://www.gnu.org/licenses/>.
+*/
+
+/*
+ * This program demonstrates the technique of using priority inheritance (PI)
+ * mutexes with processes instead of threads.
+ * The way to do this is to obtain some shared memory - in this case with
+ * mmap that backs a pthread_mutex_t since this will support PI.
+ * Pay particular attention to how this is intialized to support processes.
+ * Function init_shared_pthread_mutex() does this by setting the
+ * pthread_mutexattr to PTHREAD_PROCESS_SHARED and the mutex protocol to
+ * PTHREAD_PRIO_INHERIT.
+ * In this program we purposely try to invoke a classic priority inversion.
+ * A low priority process grabs the mutex and does some work.
+ * A high priority process comes a long and is blocked since the mutex is taken.
+ * A medium priority process that doesn't require the mutex then takes the
+ * processor. Because the processes are restricted to one cpu, the low priority
+ * processes never makes any progress because the medium priority process
+ * runs in an infinite loop. This is a priority inversion because the
+ * medium priority process is running at the expensive of the high priority
+ * process. However, since we have used PRIO_INHERIT and are running on a
+ * machine that supports preemption, the high priority process will lend it's
+ * priority to the low priority process which will preempt the medium priority
+ * process. The low priority process will then release the mutex which the
+ * high priority process can obtain. When the high priority process gets to run
+ * it kills the medium priority process.
+ * The state structure keeps track of the progress. Although this program
+ * is set up to likely trigger an inversion, there is no guarantee that
+ * scheduling will make that happen. After the program completes it reports
+ * whether a priority inversion occurred or not. In either case this program
+ * demonstrates how to use priority inheritance mutexes with processes.
+ * In fact, you would be better off to avoid scenarios in which a priority
+ * inversion occurs if possible - this program tries to trigger them just
+ * to show that it works. If you are having difficulty triggering an inversion,
+ * merely increase the time that the low priority process sleeps while
+ * holding the lock. (usleep);
+ * Also note that you have to run as a user with permission to change
+ * scheduling priorities.
+ */
+
+#include "pip.h"
+
+pthread_mutex_t *resource;
+
+/* This records the state to determine whether a priority inversion occured */
+struct State {
+	int low_owns_resource;
+	int high_started;
+	int high_owns_resource;
+	int medium_started;
+	int inversion;
+	pthread_mutex_t *mutex;
+};
+
+struct State *statep;
+
+const int policy = SCHED_FIFO;
+const int prio_min;	/* Initialized for the minimum priority of policy */
+
+int main(void)
+{
+	void *mptr;	/* memory pointer */
+	pid_t pid1, pid2;
+	cpu_set_t set, *setp = &set;
+	int res;
+	int *minimum_priority = (int*)&prio_min;
+
+	*minimum_priority = sched_get_priority_min(policy);
+
+	mptr = mmap_page();	/* Get a page of shared memory */
+	resource = (pthread_mutex_t*)mptr;	/* point our lock to it */
+	mptr += sizeof(pthread_mutex_t);	/* advance the memory pointer */
+
+	/* Initialize our mutex via the resource pointer */
+	init_shared_pthread_mutex(resource, PTHREAD_PRIO_INHERIT, policy);
+
+	statep = (struct State*)mptr;
+	mptr += sizeof(struct State);
+
+	init_state();	/* Initialize the state structure */
+
+	statep->mutex = (pthread_mutex_t*)mptr;	/* point the next lock to it */
+	mptr += sizeof(pthread_mutex_t);	/* advance the memory pointer */
+
+	/* Initialize our State mutex */
+	init_shared_pthread_mutex(statep->mutex, PTHREAD_PRIO_NONE, policy);
+
+	set_rt_prio(0, prio_min, policy);
+
+	/* We restrict this program to the first cpu, inorder to increase
+	 * the likelihood of a priority inversion */ 
+	CPU_ZERO(setp);
+	CPU_SET(0, setp);
+	res = sched_setaffinity(0, sizeof(set), setp);
+	if (res == -1) {
+		int err = errno;
+		err_msg("sched_setaffinity: ");
+		err_exit(err, NULL);
+	}
+
+	pid1 = fork();
+	if (pid1 == -1) {
+		perror("fork");
+		exit(1);
+	} else if (pid1 != 0) {		/* parent code */
+		low(pid1);
+	} else {			/* child code */
+		pid2 = fork();		/* parent code */
+		if (pid2 == -1) {
+			perror("fork: ");
+			exit(-1);
+		} else if (pid2 != 0) {		/* parent code */
+			high(pid2);
+		} else {			/* child code */
+			medium();
+		}
+	}
+
+	exit(0);
+}
+
+/* Initialize the structure that tracks when a priority inversion occurs */
+void init_state(void)
+{
+	/* Init the State structure */
+	statep->low_owns_resource = 0;
+	statep->high_started = 0;
+	statep->high_owns_resource = 0;
+	statep->medium_started = 0;
+	/* Assume an inversion will occur until proven false */
+	statep->inversion = 1;
+}
+
+/* @pid = high priority process pid */
+void low(pid_t pid)
+{
+	int status;
+	Pthread_mutex_lock(resource);
+		Pthread_mutex_lock(statep->mutex);
+			statep->low_owns_resource = 1;
+			if (statep->high_owns_resource ||
+					statep->medium_started) {
+				statep->inversion = 0;
+			}
+		Pthread_mutex_unlock(statep->mutex);
+		usleep(500);
+	Pthread_mutex_unlock(resource);
+	waitpid(pid, &status, 0);
+}
+
+void medium(void)
+{
+	set_rt_prio(0, prio_min+1, policy);
+	Pthread_mutex_lock(statep->mutex);
+		statep->medium_started = 1;
+		if (!statep->high_started)
+			statep->inversion = 0;
+	Pthread_mutex_unlock(statep->mutex);
+
+	for(;;);	/* infinite loop */
+}
+
+/* @pid = medium priority process pid */
+void high(pid_t pid)
+{
+	int status;
+	set_rt_prio(0, prio_min+2, policy);
+
+	/* Must come after raising the priority */
+	Pthread_mutex_lock(statep->mutex);
+		statep->high_started = 1;
+	Pthread_mutex_unlock(statep->mutex);
+
+	Pthread_mutex_lock(resource);
+	Pthread_mutex_lock(statep->mutex);
+		statep->high_owns_resource = 1;
+		if (!statep->low_owns_resource || !statep->medium_started) {
+			statep->inversion = 0;
+		}
+	Pthread_mutex_unlock(statep->mutex);
+	Pthread_mutex_unlock(resource);
+	kill(pid, SIGKILL);	/* kill the medium thread */
+	waitpid(pid, &status, 0);
+
+	Pthread_mutex_lock(statep->mutex);
+
+	if (statep->inversion)
+		printf("Successfully used priority inheritance to handle an inversion\n");
+	else {
+		printf("No inversion incurred\n");
+	}
+	Pthread_mutex_unlock(statep->mutex);
+}
+
+/* mmap a page of anonymous shared memory */
+void *mmap_page(void)
+{
+	void *mptr;
+	long pgsize = sysconf(_SC_PAGE_SIZE);
+
+	mptr = mmap(NULL, pgsize, PROTRW, MMAP_FLAGS, 0, 0);
+	if (mptr == MAP_FAILED) {
+		perror("In function mmap_page - mmap");
+		exit(-1);
+	}
+
+	return mptr;
+}
+
+long process_shared_mutex_available(void)
+{
+	long res = -1;	/* undefined */
+#ifdef _POSIX_THREAD_PROCESS_SHARED
+	res = sysconf(_SC_THREAD_PROCESS_SHARED);
+	if (res == -1) {
+		int err = errno;	/* save the error number */
+		err_msg("%s: sysconf(_SC_THREAD_PROCESS_SHARED): ");
+		err_exit(err, NULL);
+	}
+#else
+#error _POSIX_THREAD_PROCESS_SHARED is not defined
+#endif
+	return res;
+}
+
+void Pthread_mutexattr_init(pthread_mutexattr_t *attr)
+{
+	int err;
+	err = pthread_mutexattr_init(attr);
+	if (err) {
+		err_msg("%s: pthread_mutexattr_init(): ", __func__);
+		err_exit(err, NULL);
+	}
+}
+
+void Pthread_mutexattr_setpshared(pthread_mutexattr_t *attr, int pshared)
+{
+	int err;
+	err = pthread_mutexattr_setpshared(attr, pshared);
+	if (err) {
+		err_msg("%s: pthread_mutexattr_setpshared(): ", __func__);
+		err_exit(err, NULL);
+	}
+}
+
+void Pthread_mutexattr_setprotocol(pthread_mutexattr_t *attr, int protocol)
+{
+	int err;
+	err = pthread_mutexattr_setprotocol(attr, protocol);
+	if (err) {
+		err_msg("%s: pthread_mutexattr_setprotocol(): ", __func__);
+		err_exit(err, NULL);
+	}
+}
+
+void Pthread_mutex_init(pthread_mutex_t *mutex, pthread_mutexattr_t *attr)
+{
+	int err;
+	err = pthread_mutex_init(mutex, attr);
+	if (err) {
+		err_msg("%s: pthread_mutex_init(): ", __func__);
+		err_exit(err, NULL);
+	}
+}
+
+void Pthread_mutex_lock(pthread_mutex_t *mutex)
+{
+	int err;
+	err = pthread_mutex_lock(mutex);
+	if (err) {
+		err_msg("%s: pthread_mutex_lock(): ", __func__);
+		err_exit(err, NULL);
+	}
+}
+
+void Pthread_mutex_unlock(pthread_mutex_t *mutex)
+{
+	int err;
+	err = pthread_mutex_unlock(mutex);
+	if (err) {
+		err_msg("%s: pthread_mutex_unlock(): ", __func__);
+		err_exit(err, NULL);
+	}
+}
+
+void init_shared_pthread_mutex(pthread_mutex_t *mutex, int protocol, int policy)
+{
+	pthread_mutexattr_t attr;
+
+	process_shared_mutex_available();
+
+	Pthread_mutexattr_init(&attr);
+	Pthread_mutexattr_setpshared(&attr, PTHREAD_PROCESS_SHARED);
+	Pthread_mutexattr_setprotocol(&attr, protocol);
+	
+	Pthread_mutex_init(mutex, &attr);
+}
+
+/* Set the priority and policy of a process */
+int set_rt_prio(pid_t pid, int prio, int policy)
+{
+	int err;
+	struct sched_param param;
+	struct sched_param *pparam = &param;
+	pparam->sched_priority = prio;
+	err = sched_setscheduler(pid, policy, pparam);
+	if (err) {
+		err = errno;	/* save the errno */
+		err_msg_n(err, "%s: sched_setscheduler(): ", __func__);
+		err_msg("%s: prio = %d\n", __func__, prio);
+		err_msg("%s: pparam->sched_priority = %d\n", __func__, pparam->sched_priority);
+		err_msg("%s: policy = %d\n", __func__, policy);
+	}
+	return err;	/* 0 on success */
+}
+
+int get_rt_prio(pid_t pid)
+{
+	int err;
+	struct sched_param param;
+	err = sched_getparam(pid, &param);
+	if (err) {
+		err = errno;	/* save the errno */
+		err_msg_n(err, "%s: get_rt_prio(): ", __func__);
+		return -1;
+	}
+	return param.sched_priority;
+}
-- 
1.6.5.2

