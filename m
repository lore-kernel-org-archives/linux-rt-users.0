From: John Kacur <jkacur@redhat.com>
Subject: [GIT PULL] [PATCH] rt-tests updates
Date: Mon,  8 Mar 2010 14:01:38 +0100
Message-ID: <1268053298-5948-1-git-send-email-jkacur@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: rt-users <linux-rt-users@vger.kernel.org>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	=?utf-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f216.google.com ([209.85.219.216]:45451 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752253Ab0CHNBq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Mar 2010 08:01:46 -0500
Received: by ewy8 with SMTP id 8so35290ewy.28
        for <linux-rt-users@vger.kernel.org>; Mon, 08 Mar 2010 05:01:43 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Clark, could you please pull the following git repo for rt-tests.

git://git.kernel.org/pub/scm/linux/kernel/git/jkacur/rt-tests.git rt-te=
sts-dev

It contains the following updates.

Carsten Emde (4):
  fix-policy-display-for-cyclictest.patch
  remove-incorrect-options-from-smp-help-message-in-cyclictest.patch
  add-smp-option-to-ptsematest.patch
  add-smp-option-to-svsematest.patch

John Kacur (4):
  Revert "simplify equal priority logic for cyclictest"
  cyclictest: Use symbolic names for scheduling policy
  cyclictest: Fix spelling mistake in the man page.
  cyclictest: Make the default scheduling policy SCHED_FIFO

Uwe Kleine-K=C3=B6nig (4):
  trivial: s/specifed/specified/
  install backfire.c to $(srcdir)/backfire/
  Makefile: don't use temporary files in generation of dependency files
  rename pip to pip_stress as pip is too general

 .gitignore                  |    2 +-
 Makefile                    |   10 +-
 src/cyclictest/cyclictest.8 |    4 +-
 src/cyclictest/cyclictest.c |   46 +++---
 src/include/pip.h           |   41 -----
 src/include/pip_stress.h    |   40 +++++
 src/pi_tests/pip.c          |  347 -----------------------------------=
--------
 src/pi_tests/pip_stress.c   |  347 +++++++++++++++++++++++++++++++++++=
++++++++
 src/ptsematest/ptsematest.c |   25 +++-
 src/svsematest/svsematest.c |   25 +++-
 10 files changed, 465 insertions(+), 422 deletions(-)
 delete mode 100644 src/include/pip.h
 create mode 100644 src/include/pip_stress.h
 delete mode 100644 src/pi_tests/pip.c
 create mode 100644 src/pi_tests/pip_stress.c

=46rom 84367c8e0716ab36bad314562ff7d3f934da1c26 Mon Sep 17 00:00:00 200=
1
=46rom: =3D?utf-8?q?Uwe=3D20Kleine-K=3DC3=3DB6nig?=3D <u.kleine-koenig@=
pengutronix.de>
Date: Wed, 24 Feb 2010 17:58:06 +0100
Subject: [PATCH] trivial: s/specifed/specified/

Acked-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.8 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index 8f846c6..91e1102 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -130,7 +130,7 @@ set the ftrace tracer function. Used with the \-b o=
ption. Must be one
 of the trace functions available from <debugfs-mountpoint>/kernel/debu=
g/tracing/available_tracers
 .TP
 .B \-t, \-\-threads[=3DNUM]
-Set the number of test threads (default is 1). Create NUM test threads=
=2E If NUM is not specifed, NUM is set to
+Set the number of test threads (default is 1). Create NUM test threads=
=2E If NUM is not specified, NUM is set to
 the number of available CPUs. See \-d, \-i and \-p for further informa=
tion.
 .TP
 .B \-m, \-\-mlockall
--=20
1.6.0.6


=46rom de3d4d2539f365dc56e6b216cefe076d694c1f80 Mon Sep 17 00:00:00 200=
1
=46rom: =3D?utf-8?q?Uwe=3D20Kleine-K=3DC3=3DB6nig?=3D <u.kleine-koenig@=
pengutronix.de>
Date: Wed, 24 Feb 2010 17:58:07 +0100
Subject: [PATCH] install backfire.c to $(srcdir)/backfire/

Acked-by: John Kacur <jkacur@redhat.com>
---
 Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 043b747..99fbba4 100644
--- a/Makefile
+++ b/Makefile
@@ -110,6 +110,7 @@ install: all
 	install -m 755 src/hwlatdetect/hwlatdetect.py $(DESTDIR)$(PYLIB)/hwla=
tdetect.py
 	ln -s $(PYLIB)/hwlatdetect.py "$(DESTDIR)$(bindir)/hwlatdetect"
 	mkdir -p "$(DESTDIR)$(srcdir)/backfire"
+	install -m 644 src/backfire/backfire.c "$(DESTDIR)$(srcdir)/backfire/=
backfire.c"
 	gzip src/backfire/backfire.4 -c >"$(DESTDIR)$(mandir)/man4/backfire.4=
=2Egz"
 	gzip src/cyclictest/cyclictest.8 -c >"$(DESTDIR)$(mandir)/man8/cyclic=
test.8.gz"
 	gzip src/pi_tests/pi_stress.8 -c >"$(DESTDIR)$(mandir)/man8/pi_stress=
=2E8.gz"
--=20
1.6.0.6


=46rom d2b6363c8b396dca09f9f61a171c39195411c043 Mon Sep 17 00:00:00 200=
1
=46rom: =3D?utf-8?q?Uwe=3D20Kleine-K=3DC3=3DB6nig?=3D <u.kleine-koenig@=
pengutronix.de>
Date: Wed, 24 Feb 2010 17:58:08 +0100
Subject: [PATCH] Makefile: don't use temporary files in generation of d=
ependency files
MIME-Version: 1.0
Content-Type: text/plain; charset=3Dutf-8
Content-Transfer-Encoding: 8bit

These temporary files were a real problem when creating the Debian
package for rt-tests.  debhelper (a generic suite of scripts to ease
packaging) did something like:

	perl -c 'close(STDERR); exec("make distclean");'

which leaked the *.d.$$ files and then wailed that the package containe=
d
untracked changes to the vanilla source.  See
http://bugs.debian.org/570443 for some more details.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Acked-by: John Kacur <jkacur@redhat.com>
---
 Makefile |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 99fbba4..5bb8774 100644
--- a/Makefile
+++ b/Makefile
@@ -43,10 +43,7 @@ VPATH	+=3D src/lib
=20
 # Pattern rule to generate dependency files from .c files
 %.d: %.c
-	@set -e; rm -f $@; \
-	$(CC) -MM $(CFLAGS) $< > $@.$$$$; \
-	sed 's,\($*\)\.o[ :]*,\1.o $@ : ,g' < $@.$$$$ > $@; \
-	rm -f $@.$$$$
+	@$(CC) -MM $(CFLAGS) $< | sed 's,\($*\)\.o[ :]*,\1.o $@ : ,g' > $@ ||=
 rm -f $@
=20
 .PHONY: all
 all: $(TARGETS) hwlatdetect
--=20
1.6.0.6


=46rom 6214410e57d8be054ee58ecdc53cbc4803a3627b Mon Sep 17 00:00:00 200=
1
=46rom: =3D?utf-8?q?Uwe=3D20Kleine-K=3DC3=3DB6nig?=3D <u.kleine-koenig@=
pengutronix.de>
Date: Mon, 1 Mar 2010 17:51:15 +0100
Subject: [PATCH] rename pip to pip_stress as pip is too general
MIME-Version: 1.0
Content-Type: text/plain; charset=3Dutf-8
Content-Transfer-Encoding: 8bit

The command name is already taken by a perl script working with CPAN
and a Python package installer.

While at it remove trailing whitespace from three lines in
src/pi_tests/pip_stress.c.

Closes: http://bugs.debian.org/572104
Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 .gitignore                |    2 +-
 Makefile                  |    4 +-
 src/include/pip.h         |   41 ------
 src/include/pip_stress.h  |   40 +++++
 src/pi_tests/pip.c        |  347 -------------------------------------=
--------
 src/pi_tests/pip_stress.c |  347 +++++++++++++++++++++++++++++++++++++=
++++++++
 6 files changed, 390 insertions(+), 391 deletions(-)
 delete mode 100644 src/include/pip.h
 create mode 100644 src/include/pip_stress.h
 delete mode 100644 src/pi_tests/pip.c
 create mode 100644 src/pi_tests/pip_stress.c

diff --git a/.gitignore b/.gitignore
index a06031c..0d77a66 100644
--- a/.gitignore
+++ b/.gitignore
@@ -23,4 +23,4 @@ ptsematest
 sendme
 sigwaittest
 svsematest
-pip
+pip_stress
diff --git a/Makefile b/Makefile
index 5bb8774..52f8d64 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 VERSION_STRING =3D 0.66
=20
 sources =3D cyclictest.c signaltest.c pi_stress.c rt-migrate-test.c	\
-	  ptsematest.c sigwaittest.c svsematest.c sendme.c pip.c
+	  ptsematest.c sigwaittest.c svsematest.c sendme.c pip_stress.c
=20
 TARGETS =3D $(sources:.c=3D)
=20
@@ -79,7 +79,7 @@ svsematest: svsematest.o rt-utils.o rt-get_cpu.o
 sendme: sendme.o rt-utils.o rt-get_cpu.o
 	$(CC) $(CFLAGS) -o $@ $^ $(LIBS) $(EXTRA_LIBS)
=20
-pip: pip.o error.o rt-utils.o
+pip_stress: pip_stress.o error.o rt-utils.o
 	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)
=20
 CLEANUP  =3D $(TARGETS) *.o .depend *.*~ *.orig *.rej rt-tests.spec *.=
d
diff --git a/src/include/pip.h b/src/include/pip.h
deleted file mode 100644
index b2068be..0000000
--- a/src/include/pip.h
+++ /dev/null
@@ -1,41 +0,0 @@
-#ifndef __PIP_H
-#define __PIP_H
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <errno.h>
-#include <sys/mman.h>
-#include <string.h>
-#include <stdarg.h>
-#include <pthread.h>
-#include <sys/types.h>
-#include <sys/wait.h>
-#include <signal.h>
-#include <sched.h>
-#include <rt-utils.h>
-#include "error.h"
-
-void low(pid_t pid);	/* low priority process */
-void medium(void);	/* medium priority process */
-void high(pid_t pid);	/* high priority process */
-void init_state(void);
-
-void *mmap_page(void);
-long process_shared_mutex_available(void);
-void Pthread_mutexattr_init(pthread_mutexattr_t *attr);
-void Pthread_mutexattr_setpshared(pthread_mutexattr_t *attr, int pshar=
ed);
-void Pthread_mutexattr_setprotocol(pthread_mutexattr_t *attr, int prot=
ocol);
-void Pthread_mutex_init(pthread_mutex_t *mutex, pthread_mutexattr_t *a=
ttr);
-void Pthread_mutex_lock(pthread_mutex_t *mutex);
-void Pthread_mutex_unlock(pthread_mutex_t *mutex);
-
-void init_shared_pthread_mutex(pthread_mutex_t *mutex, int protocol, i=
nt policy);
-int set_rt_prio(pid_t pid, int prio, int policy);
-int get_rt_prio(pid_t pid);
-
-#define PROTRW PROT_READ|PROT_WRITE
-#define MMAP_FLAGS MAP_SHARED|MAP_ANONYMOUS
-
-#endif	/* __PIP_H */
-
diff --git a/src/include/pip_stress.h b/src/include/pip_stress.h
new file mode 100644
index 0000000..8ed2452
--- /dev/null
+++ b/src/include/pip_stress.h
@@ -0,0 +1,40 @@
+#ifndef __PIP_STRESS_H
+#define __PIP_STRESS_H
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
+#include <rt-utils.h>
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
+void Pthread_mutexattr_setpshared(pthread_mutexattr_t *attr, int pshar=
ed);
+void Pthread_mutexattr_setprotocol(pthread_mutexattr_t *attr, int prot=
ocol);
+void Pthread_mutex_init(pthread_mutex_t *mutex, pthread_mutexattr_t *a=
ttr);
+void Pthread_mutex_lock(pthread_mutex_t *mutex);
+void Pthread_mutex_unlock(pthread_mutex_t *mutex);
+
+void init_shared_pthread_mutex(pthread_mutex_t *mutex, int protocol, i=
nt policy);
+int set_rt_prio(pid_t pid, int prio, int policy);
+int get_rt_prio(pid_t pid);
+
+#define PROTRW PROT_READ|PROT_WRITE
+#define MMAP_FLAGS MAP_SHARED|MAP_ANONYMOUS
+
+#endif	/* __PIP_STRESS_H */
diff --git a/src/pi_tests/pip.c b/src/pi_tests/pip.c
deleted file mode 100644
index 085908b..0000000
--- a/src/pi_tests/pip.c
+++ /dev/null
@@ -1,347 +0,0 @@
-/*
-	Pip - Priority Inheritance with processes
-   =20
-    Copyright (C) 2009, John Kacur <jkacur@redhat.com>
-
-    This program is free software: you can redistribute it and/or modi=
fy
-    it under the terms of the GNU General Public License as published =
by
-    the Free Software Foundation, either version 2 of the License, or
-    (at your option) any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program.  If not, see <http://www.gnu.org/licenses=
/>.
-*/
-
-/*
- * This program demonstrates the technique of using priority inheritan=
ce (PI)
- * mutexes with processes instead of threads.
- * The way to do this is to obtain some shared memory - in this case w=
ith
- * mmap that backs a pthread_mutex_t since this will support PI.
- * Pay particular attention to how this is intialized to support proce=
sses.
- * Function init_shared_pthread_mutex() does this by setting the
- * pthread_mutexattr to PTHREAD_PROCESS_SHARED and the mutex protocol =
to
- * PTHREAD_PRIO_INHERIT.
- * In this program we purposely try to invoke a classic priority inver=
sion.
- * A low priority process grabs the mutex and does some work.
- * A high priority process comes a long and is blocked since the mutex=
 is taken.
- * A medium priority process that doesn't require the mutex then takes=
 the
- * processor. Because the processes are restricted to one cpu, the low=
 priority
- * processes never makes any progress because the medium priority proc=
ess
- * runs in an infinite loop. This is a priority inversion because the
- * medium priority process is running at the expensive of the high pri=
ority
- * process. However, since we have used PRIO_INHERIT and are running o=
n a
- * machine that supports preemption, the high priority process will le=
nd it's
- * priority to the low priority process which will preempt the medium =
priority
- * process. The low priority process will then release the mutex which=
 the
- * high priority process can obtain. When the high priority process ge=
ts to run
- * it kills the medium priority process.
- * The state structure keeps track of the progress. Although this prog=
ram
- * is set up to likely trigger an inversion, there is no guarantee tha=
t
- * scheduling will make that happen. After the program completes it re=
ports
- * whether a priority inversion occurred or not. In either case this p=
rogram
- * demonstrates how to use priority inheritance mutexes with processes=
=2E
- * In fact, you would be better off to avoid scenarios in which a prio=
rity
- * inversion occurs if possible - this program tries to trigger them j=
ust
- * to show that it works. If you are having difficulty triggering an i=
nversion,
- * merely increase the time that the low priority process sleeps while
- * holding the lock. (usleep);
- * Also note that you have to run as a user with permission to change
- * scheduling priorities.
- */
-
-#include "pip.h"
-
-pthread_mutex_t *resource;
-
-/* This records the state to determine whether a priority inversion oc=
cured */
-struct State {
-	int low_owns_resource;
-	int high_started;
-	int high_owns_resource;
-	int medium_started;
-	int inversion;
-	pthread_mutex_t *mutex;
-};
-
-struct State *statep;
-
-const int policy =3D SCHED_FIFO;
-const int prio_min;	/* Initialized for the minimum priority of policy =
*/
-
-int main(void)
-{
-	void *mptr;	/* memory pointer */
-	pid_t pid1, pid2;
-	cpu_set_t set, *setp =3D &set;
-	int res;
-	int *minimum_priority =3D (int*)&prio_min;
-
-	*minimum_priority =3D sched_get_priority_min(policy);
-
-	if (check_privs())
-		exit(-1);
-
-	mptr =3D mmap_page();	/* Get a page of shared memory */
-	resource =3D (pthread_mutex_t*)mptr;	/* point our lock to it */
-	mptr +=3D sizeof(pthread_mutex_t);	/* advance the memory pointer */
-
-	/* Initialize our mutex via the resource pointer */
-	init_shared_pthread_mutex(resource, PTHREAD_PRIO_INHERIT, policy);
-
-	statep =3D (struct State*)mptr;
-	mptr +=3D sizeof(struct State);
-
-	init_state();	/* Initialize the state structure */
-
-	statep->mutex =3D (pthread_mutex_t*)mptr;	/* point the next lock to i=
t */
-	mptr +=3D sizeof(pthread_mutex_t);	/* advance the memory pointer */
-
-	/* Initialize our State mutex */
-	init_shared_pthread_mutex(statep->mutex, PTHREAD_PRIO_NONE, policy);
-
-	set_rt_prio(0, prio_min, policy);
-
-	/* We restrict this program to the first cpu, inorder to increase
-	 * the likelihood of a priority inversion */=20
-	CPU_ZERO(setp);
-	CPU_SET(0, setp);
-	res =3D sched_setaffinity(0, sizeof(set), setp);
-	if (res =3D=3D -1) {
-		int err =3D errno;
-		err_msg("sched_setaffinity: ");
-		err_exit(err, NULL);
-	}
-
-	pid1 =3D fork();
-	if (pid1 =3D=3D -1) {
-		perror("fork");
-		exit(1);
-	} else if (pid1 !=3D 0) {		/* parent code */
-		low(pid1);
-	} else {			/* child code */
-		pid2 =3D fork();		/* parent code */
-		if (pid2 =3D=3D -1) {
-			perror("fork: ");
-			exit(-1);
-		} else if (pid2 !=3D 0) {		/* parent code */
-			high(pid2);
-		} else {			/* child code */
-			medium();
-		}
-	}
-
-	exit(0);
-}
-
-/* Initialize the structure that tracks when a priority inversion occu=
rs */
-void init_state(void)
-{
-	/* Init the State structure */
-	statep->low_owns_resource =3D 0;
-	statep->high_started =3D 0;
-	statep->high_owns_resource =3D 0;
-	statep->medium_started =3D 0;
-	/* Assume an inversion will occur until proven false */
-	statep->inversion =3D 1;
-}
-
-/* @pid =3D high priority process pid */
-void low(pid_t pid)
-{
-	int status;
-	Pthread_mutex_lock(resource);
-		Pthread_mutex_lock(statep->mutex);
-			statep->low_owns_resource =3D 1;
-			if (statep->high_owns_resource ||
-					statep->medium_started) {
-				statep->inversion =3D 0;
-			}
-		Pthread_mutex_unlock(statep->mutex);
-		usleep(500);
-	Pthread_mutex_unlock(resource);
-	waitpid(pid, &status, 0);
-}
-
-void medium(void)
-{
-	set_rt_prio(0, prio_min+1, policy);
-	Pthread_mutex_lock(statep->mutex);
-		statep->medium_started =3D 1;
-		if (!statep->high_started)
-			statep->inversion =3D 0;
-	Pthread_mutex_unlock(statep->mutex);
-
-	for(;;);	/* infinite loop */
-}
-
-/* @pid =3D medium priority process pid */
-void high(pid_t pid)
-{
-	int status;
-	set_rt_prio(0, prio_min+2, policy);
-
-	/* Must come after raising the priority */
-	Pthread_mutex_lock(statep->mutex);
-		statep->high_started =3D 1;
-	Pthread_mutex_unlock(statep->mutex);
-
-	Pthread_mutex_lock(resource);
-	Pthread_mutex_lock(statep->mutex);
-		statep->high_owns_resource =3D 1;
-		if (!statep->low_owns_resource || !statep->medium_started) {
-			statep->inversion =3D 0;
-		}
-	Pthread_mutex_unlock(statep->mutex);
-	Pthread_mutex_unlock(resource);
-	kill(pid, SIGKILL);	/* kill the medium thread */
-	waitpid(pid, &status, 0);
-
-	Pthread_mutex_lock(statep->mutex);
-
-	if (statep->inversion)
-		printf("Successfully used priority inheritance to handle an inversio=
n\n");
-	else {
-		printf("No inversion incurred\n");
-	}
-	Pthread_mutex_unlock(statep->mutex);
-}
-
-/* mmap a page of anonymous shared memory */
-void *mmap_page(void)
-{
-	void *mptr;
-	long pgsize =3D sysconf(_SC_PAGE_SIZE);
-
-	mptr =3D mmap(NULL, pgsize, PROTRW, MMAP_FLAGS, 0, 0);
-	if (mptr =3D=3D MAP_FAILED) {
-		perror("In function mmap_page - mmap");
-		exit(-1);
-	}
-
-	return mptr;
-}
-
-long process_shared_mutex_available(void)
-{
-	long res =3D -1;	/* undefined */
-#ifdef _POSIX_THREAD_PROCESS_SHARED
-	res =3D sysconf(_SC_THREAD_PROCESS_SHARED);
-	if (res =3D=3D -1) {
-		int err =3D errno;	/* save the error number */
-		err_msg("%s: sysconf(_SC_THREAD_PROCESS_SHARED): ");
-		err_exit(err, NULL);
-	}
-#else
-#error _POSIX_THREAD_PROCESS_SHARED is not defined
-#endif
-	return res;
-}
-
-void Pthread_mutexattr_init(pthread_mutexattr_t *attr)
-{
-	int err;
-	err =3D pthread_mutexattr_init(attr);
-	if (err) {
-		err_msg("%s: pthread_mutexattr_init(): ", __func__);
-		err_exit(err, NULL);
-	}
-}
-
-void Pthread_mutexattr_setpshared(pthread_mutexattr_t *attr, int pshar=
ed)
-{
-	int err;
-	err =3D pthread_mutexattr_setpshared(attr, pshared);
-	if (err) {
-		err_msg("%s: pthread_mutexattr_setpshared(): ", __func__);
-		err_exit(err, NULL);
-	}
-}
-
-void Pthread_mutexattr_setprotocol(pthread_mutexattr_t *attr, int prot=
ocol)
-{
-	int err;
-	err =3D pthread_mutexattr_setprotocol(attr, protocol);
-	if (err) {
-		err_msg("%s: pthread_mutexattr_setprotocol(): ", __func__);
-		err_exit(err, NULL);
-	}
-}
-
-void Pthread_mutex_init(pthread_mutex_t *mutex, pthread_mutexattr_t *a=
ttr)
-{
-	int err;
-	err =3D pthread_mutex_init(mutex, attr);
-	if (err) {
-		err_msg("%s: pthread_mutex_init(): ", __func__);
-		err_exit(err, NULL);
-	}
-}
-
-void Pthread_mutex_lock(pthread_mutex_t *mutex)
-{
-	int err;
-	err =3D pthread_mutex_lock(mutex);
-	if (err) {
-		err_msg("%s: pthread_mutex_lock(): ", __func__);
-		err_exit(err, NULL);
-	}
-}
-
-void Pthread_mutex_unlock(pthread_mutex_t *mutex)
-{
-	int err;
-	err =3D pthread_mutex_unlock(mutex);
-	if (err) {
-		err_msg("%s: pthread_mutex_unlock(): ", __func__);
-		err_exit(err, NULL);
-	}
-}
-
-void init_shared_pthread_mutex(pthread_mutex_t *mutex, int protocol, i=
nt policy)
-{
-	pthread_mutexattr_t attr;
-
-	process_shared_mutex_available();
-
-	Pthread_mutexattr_init(&attr);
-	Pthread_mutexattr_setpshared(&attr, PTHREAD_PROCESS_SHARED);
-	Pthread_mutexattr_setprotocol(&attr, protocol);
-=09
-	Pthread_mutex_init(mutex, &attr);
-}
-
-/* Set the priority and policy of a process */
-int set_rt_prio(pid_t pid, int prio, int policy)
-{
-	int err;
-	struct sched_param param;
-	struct sched_param *pparam =3D &param;
-	pparam->sched_priority =3D prio;
-	err =3D sched_setscheduler(pid, policy, pparam);
-	if (err) {
-		err =3D errno;	/* save the errno */
-		err_msg_n(err, "%s: sched_setscheduler(): ", __func__);
-		err_msg("%s: prio =3D %d\n", __func__, prio);
-		err_msg("%s: pparam->sched_priority =3D %d\n", __func__, pparam->sch=
ed_priority);
-		err_msg("%s: policy =3D %d\n", __func__, policy);
-	}
-	return err;	/* 0 on success */
-}
-
-int get_rt_prio(pid_t pid)
-{
-	int err;
-	struct sched_param param;
-	err =3D sched_getparam(pid, &param);
-	if (err) {
-		err =3D errno;	/* save the errno */
-		err_msg_n(err, "%s: get_rt_prio(): ", __func__);
-		return -1;
-	}
-	return param.sched_priority;
-}
diff --git a/src/pi_tests/pip_stress.c b/src/pi_tests/pip_stress.c
new file mode 100644
index 0000000..2b42b8f
--- /dev/null
+++ b/src/pi_tests/pip_stress.c
@@ -0,0 +1,347 @@
+/*
+	Pip stress - Priority Inheritance with processes
+
+    Copyright (C) 2009, John Kacur <jkacur@redhat.com>
+
+    This program is free software: you can redistribute it and/or modi=
fy
+    it under the terms of the GNU General Public License as published =
by
+    the Free Software Foundation, either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program.  If not, see <http://www.gnu.org/licenses=
/>.
+*/
+
+/*
+ * This program demonstrates the technique of using priority inheritan=
ce (PI)
+ * mutexes with processes instead of threads.
+ * The way to do this is to obtain some shared memory - in this case w=
ith
+ * mmap that backs a pthread_mutex_t since this will support PI.
+ * Pay particular attention to how this is intialized to support proce=
sses.
+ * Function init_shared_pthread_mutex() does this by setting the
+ * pthread_mutexattr to PTHREAD_PROCESS_SHARED and the mutex protocol =
to
+ * PTHREAD_PRIO_INHERIT.
+ * In this program we purposely try to invoke a classic priority inver=
sion.
+ * A low priority process grabs the mutex and does some work.
+ * A high priority process comes a long and is blocked since the mutex=
 is taken.
+ * A medium priority process that doesn't require the mutex then takes=
 the
+ * processor. Because the processes are restricted to one cpu, the low=
 priority
+ * processes never makes any progress because the medium priority proc=
ess
+ * runs in an infinite loop. This is a priority inversion because the
+ * medium priority process is running at the expensive of the high pri=
ority
+ * process. However, since we have used PRIO_INHERIT and are running o=
n a
+ * machine that supports preemption, the high priority process will le=
nd it's
+ * priority to the low priority process which will preempt the medium =
priority
+ * process. The low priority process will then release the mutex which=
 the
+ * high priority process can obtain. When the high priority process ge=
ts to run
+ * it kills the medium priority process.
+ * The state structure keeps track of the progress. Although this prog=
ram
+ * is set up to likely trigger an inversion, there is no guarantee tha=
t
+ * scheduling will make that happen. After the program completes it re=
ports
+ * whether a priority inversion occurred or not. In either case this p=
rogram
+ * demonstrates how to use priority inheritance mutexes with processes=
=2E
+ * In fact, you would be better off to avoid scenarios in which a prio=
rity
+ * inversion occurs if possible - this program tries to trigger them j=
ust
+ * to show that it works. If you are having difficulty triggering an i=
nversion,
+ * merely increase the time that the low priority process sleeps while
+ * holding the lock. (usleep);
+ * Also note that you have to run as a user with permission to change
+ * scheduling priorities.
+ */
+
+#include "pip_stress.h"
+
+pthread_mutex_t *resource;
+
+/* This records the state to determine whether a priority inversion oc=
cured */
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
+const int policy =3D SCHED_FIFO;
+const int prio_min;	/* Initialized for the minimum priority of policy =
*/
+
+int main(void)
+{
+	void *mptr;	/* memory pointer */
+	pid_t pid1, pid2;
+	cpu_set_t set, *setp =3D &set;
+	int res;
+	int *minimum_priority =3D (int*)&prio_min;
+
+	*minimum_priority =3D sched_get_priority_min(policy);
+
+	if (check_privs())
+		exit(-1);
+
+	mptr =3D mmap_page();	/* Get a page of shared memory */
+	resource =3D (pthread_mutex_t*)mptr;	/* point our lock to it */
+	mptr +=3D sizeof(pthread_mutex_t);	/* advance the memory pointer */
+
+	/* Initialize our mutex via the resource pointer */
+	init_shared_pthread_mutex(resource, PTHREAD_PRIO_INHERIT, policy);
+
+	statep =3D (struct State*)mptr;
+	mptr +=3D sizeof(struct State);
+
+	init_state();	/* Initialize the state structure */
+
+	statep->mutex =3D (pthread_mutex_t*)mptr;	/* point the next lock to i=
t */
+	mptr +=3D sizeof(pthread_mutex_t);	/* advance the memory pointer */
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
+	res =3D sched_setaffinity(0, sizeof(set), setp);
+	if (res =3D=3D -1) {
+		int err =3D errno;
+		err_msg("sched_setaffinity: ");
+		err_exit(err, NULL);
+	}
+
+	pid1 =3D fork();
+	if (pid1 =3D=3D -1) {
+		perror("fork");
+		exit(1);
+	} else if (pid1 !=3D 0) {		/* parent code */
+		low(pid1);
+	} else {			/* child code */
+		pid2 =3D fork();		/* parent code */
+		if (pid2 =3D=3D -1) {
+			perror("fork: ");
+			exit(-1);
+		} else if (pid2 !=3D 0) {		/* parent code */
+			high(pid2);
+		} else {			/* child code */
+			medium();
+		}
+	}
+
+	exit(0);
+}
+
+/* Initialize the structure that tracks when a priority inversion occu=
rs */
+void init_state(void)
+{
+	/* Init the State structure */
+	statep->low_owns_resource =3D 0;
+	statep->high_started =3D 0;
+	statep->high_owns_resource =3D 0;
+	statep->medium_started =3D 0;
+	/* Assume an inversion will occur until proven false */
+	statep->inversion =3D 1;
+}
+
+/* @pid =3D high priority process pid */
+void low(pid_t pid)
+{
+	int status;
+	Pthread_mutex_lock(resource);
+		Pthread_mutex_lock(statep->mutex);
+			statep->low_owns_resource =3D 1;
+			if (statep->high_owns_resource ||
+					statep->medium_started) {
+				statep->inversion =3D 0;
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
+		statep->medium_started =3D 1;
+		if (!statep->high_started)
+			statep->inversion =3D 0;
+	Pthread_mutex_unlock(statep->mutex);
+
+	for(;;);	/* infinite loop */
+}
+
+/* @pid =3D medium priority process pid */
+void high(pid_t pid)
+{
+	int status;
+	set_rt_prio(0, prio_min+2, policy);
+
+	/* Must come after raising the priority */
+	Pthread_mutex_lock(statep->mutex);
+		statep->high_started =3D 1;
+	Pthread_mutex_unlock(statep->mutex);
+
+	Pthread_mutex_lock(resource);
+	Pthread_mutex_lock(statep->mutex);
+		statep->high_owns_resource =3D 1;
+		if (!statep->low_owns_resource || !statep->medium_started) {
+			statep->inversion =3D 0;
+		}
+	Pthread_mutex_unlock(statep->mutex);
+	Pthread_mutex_unlock(resource);
+	kill(pid, SIGKILL);	/* kill the medium thread */
+	waitpid(pid, &status, 0);
+
+	Pthread_mutex_lock(statep->mutex);
+
+	if (statep->inversion)
+		printf("Successfully used priority inheritance to handle an inversio=
n\n");
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
+	long pgsize =3D sysconf(_SC_PAGE_SIZE);
+
+	mptr =3D mmap(NULL, pgsize, PROTRW, MMAP_FLAGS, 0, 0);
+	if (mptr =3D=3D MAP_FAILED) {
+		perror("In function mmap_page - mmap");
+		exit(-1);
+	}
+
+	return mptr;
+}
+
+long process_shared_mutex_available(void)
+{
+	long res =3D -1;	/* undefined */
+#ifdef _POSIX_THREAD_PROCESS_SHARED
+	res =3D sysconf(_SC_THREAD_PROCESS_SHARED);
+	if (res =3D=3D -1) {
+		int err =3D errno;	/* save the error number */
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
+	err =3D pthread_mutexattr_init(attr);
+	if (err) {
+		err_msg("%s: pthread_mutexattr_init(): ", __func__);
+		err_exit(err, NULL);
+	}
+}
+
+void Pthread_mutexattr_setpshared(pthread_mutexattr_t *attr, int pshar=
ed)
+{
+	int err;
+	err =3D pthread_mutexattr_setpshared(attr, pshared);
+	if (err) {
+		err_msg("%s: pthread_mutexattr_setpshared(): ", __func__);
+		err_exit(err, NULL);
+	}
+}
+
+void Pthread_mutexattr_setprotocol(pthread_mutexattr_t *attr, int prot=
ocol)
+{
+	int err;
+	err =3D pthread_mutexattr_setprotocol(attr, protocol);
+	if (err) {
+		err_msg("%s: pthread_mutexattr_setprotocol(): ", __func__);
+		err_exit(err, NULL);
+	}
+}
+
+void Pthread_mutex_init(pthread_mutex_t *mutex, pthread_mutexattr_t *a=
ttr)
+{
+	int err;
+	err =3D pthread_mutex_init(mutex, attr);
+	if (err) {
+		err_msg("%s: pthread_mutex_init(): ", __func__);
+		err_exit(err, NULL);
+	}
+}
+
+void Pthread_mutex_lock(pthread_mutex_t *mutex)
+{
+	int err;
+	err =3D pthread_mutex_lock(mutex);
+	if (err) {
+		err_msg("%s: pthread_mutex_lock(): ", __func__);
+		err_exit(err, NULL);
+	}
+}
+
+void Pthread_mutex_unlock(pthread_mutex_t *mutex)
+{
+	int err;
+	err =3D pthread_mutex_unlock(mutex);
+	if (err) {
+		err_msg("%s: pthread_mutex_unlock(): ", __func__);
+		err_exit(err, NULL);
+	}
+}
+
+void init_shared_pthread_mutex(pthread_mutex_t *mutex, int protocol, i=
nt policy)
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
+	struct sched_param *pparam =3D &param;
+	pparam->sched_priority =3D prio;
+	err =3D sched_setscheduler(pid, policy, pparam);
+	if (err) {
+		err =3D errno;	/* save the errno */
+		err_msg_n(err, "%s: sched_setscheduler(): ", __func__);
+		err_msg("%s: prio =3D %d\n", __func__, prio);
+		err_msg("%s: pparam->sched_priority =3D %d\n", __func__, pparam->sch=
ed_priority);
+		err_msg("%s: policy =3D %d\n", __func__, policy);
+	}
+	return err;	/* 0 on success */
+}
+
+int get_rt_prio(pid_t pid)
+{
+	int err;
+	struct sched_param param;
+	err =3D sched_getparam(pid, &param);
+	if (err) {
+		err =3D errno;	/* save the errno */
+		err_msg_n(err, "%s: get_rt_prio(): ", __func__);
+		return -1;
+	}
+	return param.sched_priority;
+}
--=20
1.6.0.6


=46rom 6fb5b9cd9099112ee7bc091a78aa8d0274c5fdad Mon Sep 17 00:00:00 200=
1
=46rom: John Kacur <jkacur@redhat.com>
Date: Mon, 8 Mar 2010 01:06:29 +0100
Subject: [PATCH] Revert "simplify equal priority logic for cyclictest"
 This reverts commit 582be2a52c43801a10d318de7491f1cc7243d5cf.

Unfortunately this commit introduces a bug because the priority is not
retested, and this can result in reported priorities below 0.
=46or example,

sudo ./cyclictest -t3 -p1
policy: fifo: loadavg: 0.09 0.06 0.05 1/331 21732

T: 0 (21730) P: 1 I:1000 C:    593 Min:     34 Act:  155 Avg:  100 Max:=
     672
T: 1 (21731) P: 0 I:1500 C:    395 Min:     15 Act:   43 Avg:   72 Max:=
     853
T: 2 (21732) P:-1 I:2000 C:    297 Min:     21 Act:   57 Avg:   79 Max:=
     330

Notice that the last priority is reported as -1.

After reverting this commit, we get the correct expected behaviour.

sudo ./cyclictest -t3 -p1
policy: fifo: loadavg: 0.07 0.05 0.04 2/330 21754

T: 0 (21752) P: 1 I:1000 C:  11600 Min:     13 Act: 7072 Avg: 3593 Max:=
    7841
T: 1 (21753) P: 0 I:1500 C:   7737 Min:     12 Act: 1572 Avg:  516 Max:=
    2381
T: 2 (21754) P: 0 I:2000 C:   5804 Min:     12 Act:   53 Avg:   59 Max:=
     548

I think it can be argued that the original code is also clearer, althou=
gh
that is somewhat subjective. With the original code I don't need to tra=
ck
down exactly what "sameprio" means, and it is clear what is being teste=
d.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index dc86b49..d38c0a7 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -801,7 +801,6 @@ static int interval =3D 1000;
 static int distance =3D 500;
 static int affinity =3D 0;
 static int smp =3D 0;
-static int sameprio =3D 0;
=20
 enum {
 	AFFINITY_UNSPECIFIED,
@@ -1043,9 +1042,7 @@ static void process_options (int argc, char *argv=
[])
 	if (num_threads < 1)
 		error =3D 1;
=20
-	if (priority && (smp || numa || histogram))=20
-		sameprio =3D 1;
-=20
+
 	if (error)
 		display_help(1);
 }
@@ -1304,7 +1301,7 @@ int main(int argc, char **argv)
 		}
=20
 		par->prio =3D priority;
-		if (!sameprio)
+		if (priority && !histogram && !smp && !numa)
 			priority--;
                 if      (priority && policy <=3D 1) par->policy =3D SC=
HED_FIFO;
                 else if (priority && policy =3D=3D 2) par->policy =3D =
SCHED_RR;
--=20
1.6.0.6


=46rom e12de2f0629c0bedc8e8a9b52bc4fcb68f320a77 Mon Sep 17 00:00:00 200=
1
=46rom: John Kacur <jkacur@redhat.com>
Date: Mon, 8 Mar 2010 01:38:49 +0100
Subject: [PATCH] cyclictest: Use symbolic names for scheduling policy

- Use symbolic names for scheduling policies, that is, don't assume
	SCHED_RR is 2, use SCHED_RR instead, and so on.

- Fix the logic in handlepolicy(char *polname)
	- remove the test with the unreachable line,
	- make the default SCHED_FIFO if we don't recognize the
	requested policy.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c |   15 +++++----------
 1 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index d38c0a7..066ca79 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -826,13 +826,8 @@ static void handlepolicy(char *polname)
 		policy =3D SCHED_FIFO;
 	else if (strncasecmp(polname, "rr", 2) =3D=3D 0)
 		policy =3D SCHED_RR;
-
-	if (policy =3D=3D SCHED_FIFO || policy =3D=3D SCHED_RR) {
-		if (policy =3D=3D 0)
-			policy =3D 1;
-	}
-	else=20
-		policy =3D 0;
+	else	/* default policy if we don't recognize the request */
+		policy =3D SCHED_FIFO;
 }
=20
 static char *policyname(int policy)
@@ -1303,9 +1298,9 @@ int main(int argc, char **argv)
 		par->prio =3D priority;
 		if (priority && !histogram && !smp && !numa)
 			priority--;
-                if      (priority && policy <=3D 1) par->policy =3D SC=
HED_FIFO;
-                else if (priority && policy =3D=3D 2) par->policy =3D =
SCHED_RR;
-                else                              par->policy =3D SCHE=
D_OTHER;
+                if (priority && policy =3D=3D SCHED_FIFO) par->policy =
=3D SCHED_FIFO;
+                else if (priority && policy =3D=3D SCHED_RR) par->poli=
cy =3D SCHED_RR;
+                else  par->policy =3D SCHED_OTHER;
 		par->clock =3D clocksources[clocksel];
 		par->mode =3D mode;
 		par->timermode =3D timermode;
--=20
1.6.0.6


=46rom ce8c59023206ae409d28abdb3f6f3384ca825431 Mon Sep 17 00:00:00 200=
1
=46rom: John Kacur <jkacur@redhat.com>
Date: Mon, 8 Mar 2010 01:45:35 +0100
Subject: [PATCH] cyclictest: Fix spelling mistake in the man page.

	- In the -mlockall section, change "an" to "and"

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.8 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index 91e1102..a6ddb92 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -134,7 +134,7 @@ Set the number of test threads (default is 1). Crea=
te NUM test threads. If NUM i
 the number of available CPUs. See \-d, \-i and \-p for further informa=
tion.
 .TP
 .B \-m, \-\-mlockall
-Lock current an future memory allocations to prevent being paged out
+Lock current and future memory allocations to prevent being paged out
 .TP
 .B \-v, \-\-verbose
 Output values on stdout for statistics. This option is used to gather =
statistical information about the latency distribution. The output is s=
ent to stdout. The output format is:
--=20
1.6.0.6


=46rom 1263ebde632899a399b59ee8eec926bb81199122 Mon Sep 17 00:00:00 200=
1
=46rom: John Kacur <jkacur@redhat.com>
Date: Mon, 8 Mar 2010 02:02:13 +0100
Subject: [PATCH] cyclictest: Make the default scheduling policy SCHED_F=
IFO

The default scheduling policy if unspecified should be SCHED_FIFO.

Before the change for example.
 sudo ./cyclictest
 policy: other: loadavg: 0.05 0.04 0.05 1/331 22367

 T: 0 (22367) P: 0 I:1000 C:   1321 Min:     14 Act:   89 Avg:   77 Max=
:     942

After the change
 sudo ./cyclictest
 defaulting realtime priority to 2
 policy: fifo: loadavg: 0.03 0.04 0.05 2/331 22387

 T: 0 (22387) P: 2 I:1000 C:    713 Min:     17 Act:   41 Avg:   81 Max=
:     161

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 066ca79..e4febec 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -792,7 +792,7 @@ static int use_nanosleep;
 static int timermode =3D TIMER_ABSTIME;
 static int use_system;
 static int priority;
-static int policy =3D 0;
+static int policy =3D SCHED_FIFO;	/* default policy if not specified *=
/
 static int num_threads =3D 1;
 static int max_cycles;
 static int clocksel =3D 0;
@@ -1037,7 +1037,6 @@ static void process_options (int argc, char *argv=
[])
 	if (num_threads < 1)
 		error =3D 1;
=20
-
 	if (error)
 		display_help(1);
 }
--=20
1.6.0.6


=46rom 7dd5ce77096972beeada84450496eb3489e3e38f Mon Sep 17 00:00:00 200=
1
=46rom: Carsten Emde <C.Emde@osadl.org>
Date: Mon, 8 Mar 2010 09:37:50 +0100
Subject: [PATCH] fix-policy-display-for-cyclictest.patch

If the policy is forced to SCHED_OTHER, since the priority no longer
fits into the SCHED_FIFO or SCHED_RR range, the policy display of
cyclictest is somewhat incorrect.

Display all policies.

Also make the variable policystr static; the condition
"if (!policystr)" is useless, otherwise.

In addition, place the priority logic before decrementing the priority;
a priority of 1 is incorrectly made SCHED_OTHER, otherwise.

Signed-off-by: Carsten Emde <C.Emde@osadl.org>
Acked-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c |   25 +++++++++++++++++++------
 1 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index e4febec..cfa0ada 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -156,6 +156,7 @@ static int histogram =3D 0;
 static int duration =3D 0;
 static int use_nsecs =3D 0;
 static int refresh_on_max;
+static int force_sched_other;
=20
 static pthread_cond_t refresh_on_max_cond =3D PTHREAD_COND_INITIALIZER=
;
 static pthread_mutex_t refresh_on_max_lock =3D PTHREAD_MUTEX_INITIALIZ=
ER;
@@ -1295,11 +1296,14 @@ int main(int argc, char **argv)
 		}
=20
 		par->prio =3D priority;
+                if (priority && (policy =3D=3D SCHED_FIFO || policy =3D=
=3D SCHED_RR))
+			par->policy =3D policy;
+                else {
+			par->policy =3D SCHED_OTHER;
+			force_sched_other =3D 1;
+		}
 		if (priority && !histogram && !smp && !numa)
 			priority--;
-                if (priority && policy =3D=3D SCHED_FIFO) par->policy =
=3D SCHED_FIFO;
-                else if (priority && policy =3D=3D SCHED_RR) par->poli=
cy =3D SCHED_RR;
-                else  par->policy =3D SCHED_OTHER;
 		par->clock =3D clocksources[clocksel];
 		par->mode =3D mode;
 		par->timermode =3D timermode;
@@ -1330,18 +1334,27 @@ int main(int argc, char **argv)
 	while (!shutdown) {
 		char lavg[256];
 		int fd, len, allstopped =3D 0;
-		char *policystr =3D NULL;
+		static char *policystr =3D NULL;
+		static char *slash =3D NULL;
+		static char *policystr2;
=20
 		if (!policystr)
 			policystr =3D policyname(policy);
=20
+		if (!slash) {
+			if (force_sched_other) {
+				slash =3D "/";
+				policystr2 =3D policyname(SCHED_OTHER);
+			} else
+				slash =3D policystr2 =3D "";
+		}
 		if (!verbose && !quiet) {
 			fd =3D open("/proc/loadavg", O_RDONLY, 0666);
 			len =3D read(fd, &lavg, 255);
 			close(fd);
 			lavg[len-1] =3D 0x0;
-			printf("policy: %s: loadavg: %s          \n\n",=20
-			       policystr, lavg);
+			printf("policy: %s%s%s: loadavg: %s          \n\n",
+			       policystr, slash, policystr2, lavg);
 		}
=20
 		for (i =3D 0; i < num_threads; i++) {
--=20
1.6.0.6


=46rom f02c5d5ad010ba3a5bdf54d400bbe4b7a81101bd Mon Sep 17 00:00:00 200=
1
=46rom: Carsten Emde <C.Emde@osadl.org>
Date: Sun, 7 Mar 2010 21:39:57 +0100
Subject: [PATCH] remove-incorrect-options-from-smp-help-message-in-cycl=
ictest.patch

The help message of cyclictest's -S option says that it equals -a -t -n=
 -m -d0.
In reality, it only equals -a -t -n.

Signed-off-by: Carsten Emde <C.Emde@osadl.org>
Acked-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index cfa0ada..3a6a0d0 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -778,8 +778,8 @@ static void display_help(int error)
                "-W       --wakeuprt        rt task wakeup tracing (use=
d with -b)\n"
                "-y POLI  --policy=3DPOLI     policy of realtime thread=
 (1:FIFO, 2:RR)\n"
                "                           format: --policy=3Dfifo(def=
ault) or --policy=3Drr\n"
-	       "-S       --smp             Standard SMP testing (equals -a -t=
 -n -m -d0)\n"
-               "                           same priority on all thread=
s.\n"
+	       "-S       --smp             Standard SMP testing: options -a -=
t -n and\n"
+               "                           same priority of all thread=
s\n"
 	       "-U       --numa            Standard NUMA testing (similar to =
SMP option)\n"
                "                           thread data structures allo=
cated from local node\n",
 	       tracers
--=20
1.6.0.6


=46rom cd34b8b1728a5eaab9a1926fc42383f73e42f2f8 Mon Sep 17 00:00:00 200=
1
=46rom: Carsten Emde <C.Emde@osadl.org>
Date: Sun, 7 Mar 2010 21:48:01 +0100
Subject: [PATCH] add-smp-option-to-ptsematest.patch

Add SMP testing option (-S, --smp) to ptsematest, same as in
cyclictest.

Signed-off-by: Carsten Emde <C.Emde@osadl.org>
Acked-by: John Kacur <jkacur@redhat.com>
---
 src/ptsematest/ptsematest.c |   25 +++++++++++++++++++++++--
 1 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/src/ptsematest/ptsematest.c b/src/ptsematest/ptsematest.c
index 2683a2e..14c3f81 100644
--- a/src/ptsematest/ptsematest.c
+++ b/src/ptsematest/ptsematest.c
@@ -173,6 +173,8 @@ static void display_help(void)
 	"-i INTV  --interval=3DINTV   base interval of thread in us default=3D=
1000\n"
 	"-l LOOPS --loops=3DLOOPS     number of loops: default=3D0(endless)\n=
"
 	"-p PRIO  --prio=3DPRIO       priority\n"
+	"-S       --smp             SMP testing: options -a -t and same prior=
ity\n"
+        "                           of all threads\n"
 	"-t       --threads         one thread per available processor\n"
 	"-t [NUM] --threads=3DNUM     number of threads:\n"
 	"                           without NUM, threads =3D max_cpus\n"
@@ -189,6 +191,8 @@ static int num_threads =3D 1;
 static int max_cycles;
 static int interval =3D 1000;
 static int distance =3D 500;
+static int smp;
+static int sameprio;
=20
 static void process_options (int argc, char *argv[])
 {
@@ -205,16 +209,21 @@ static void process_options (int argc, char *argv=
[])
 			{"interval", required_argument, NULL, 'i'},
 			{"loops", required_argument, NULL, 'l'},
 			{"priority", required_argument, NULL, 'p'},
+			{"smp", no_argument, NULL, 'S'},
 			{"threads", optional_argument, NULL, 't'},
 			{"help", no_argument, NULL, '?'},
 			{NULL, 0, NULL, 0}
 		};
-		int c =3D getopt_long (argc, argv, "a::b:d:i:l:p:t::",
+		int c =3D getopt_long (argc, argv, "a::b:d:i:l:p:St::",
 			long_options, &option_index);
 		if (c =3D=3D -1)
 			break;
 		switch (c) {
 		case 'a':
+			if (smp) {
+				warn("-a ignored due to --smp\n");
+				break;
+			}
 			if (optarg !=3D NULL) {
 				affinity =3D atoi(optarg);
 				setaffinity =3D AFFINITY_SPECIFIED;
@@ -230,7 +239,16 @@ static void process_options (int argc, char *argv[=
])
 		case 'i': interval =3D atoi(optarg); break;
 		case 'l': max_cycles =3D atoi(optarg); break;
 		case 'p': priority =3D atoi(optarg); break;
+		case 'S':
+			smp =3D 1;
+			num_threads =3D max_cpus;
+			setaffinity =3D AFFINITY_USEALL;
+			break;
 		case 't':
+			if (smp) {
+				warn("-t ignored due to --smp\n");
+				break;
+			}
 			if (optarg !=3D NULL)
 				num_threads =3D atoi(optarg);
 			else if (optind<argc && atoi(argv[optind]))
@@ -261,6 +279,9 @@ static void process_options (int argc, char *argv[]=
)
 	if (num_threads < 1)
 		error =3D 1;
=20
+	if (priority && smp)
+		sameprio =3D 1;
+
 	if (error)
 		display_help ();
 }
@@ -327,7 +348,7 @@ int main(int argc, char *argv[])
 		}
 		receiver[i].priority =3D priority;
 		receiver[i].tracelimit =3D tracelimit;
-		if (priority > 0)
+		if (priority > 1 && !sameprio)
 			priority--;
 		receiver[i].delay.tv_sec =3D interval / USEC_PER_SEC;
 		receiver[i].delay.tv_nsec =3D (interval % USEC_PER_SEC) * 1000;
--=20
1.6.0.6


=46rom afb31fb21d3e89cde47d069b622aaada454d6654 Mon Sep 17 00:00:00 200=
1
=46rom: Carsten Emde <C.Emde@osadl.org>
Date: Sun, 7 Mar 2010 21:48:02 +0100
Subject: [PATCH] add-smp-option-to-svsematest.patch

Add SMP testing option (-S, --smp) to svsematest, same as in
cyclictest.

Signed-off-by: Carsten Emde <C.Emde@osadl.org>
Acked-by: John Kacur <jkacur@redhat.com>
---
 src/svsematest/svsematest.c |   25 +++++++++++++++++++++++--
 1 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/src/svsematest/svsematest.c b/src/svsematest/svsematest.c
index a9f8f53..d4ee1c4 100644
--- a/src/svsematest/svsematest.c
+++ b/src/svsematest/svsematest.c
@@ -248,6 +248,8 @@ static void display_help(void)
 	"-i INTV  --interval=3DINTV   base interval of thread in us default=3D=
1000\n"
 	"-l LOOPS --loops=3DLOOPS     number of loops: default=3D0(endless)\n=
"
 	"-p PRIO  --prio=3DPRIO       priority\n"
+	"-S       --smp             SMP testing: options -a -t and same prior=
ity\n"
+        "                           of all threads\n"
 	"-t       --threads         one thread per available processor\n"
 	"-t [NUM] --threads=3DNUM     number of threads:\n"
 	"                           without NUM, threads =3D max_cpus\n"
@@ -263,6 +265,8 @@ static int num_threads =3D 1;
 static int max_cycles;
 static int interval =3D 1000;
 static int distance =3D 500;
+static int smp;
+static int sameprio;
=20
 static void process_options (int argc, char *argv[])
 {
@@ -281,16 +285,21 @@ static void process_options (int argc, char *argv=
[])
 			{"interval", required_argument, NULL, 'i'},
 			{"loops", required_argument, NULL, 'l'},
 			{"priority", required_argument, NULL, 'p'},
+			{"smp", no_argument, NULL, 'S'},
 			{"threads", optional_argument, NULL, 't'},
 			{"help", no_argument, NULL, '?'},
 			{NULL, 0, NULL, 0}
 		};
-		int c =3D getopt_long (argc, argv, "a::b:d:f::i:l:p:t::",
+		int c =3D getopt_long (argc, argv, "a::b:d:f::i:l:p:St::",
 			long_options, &option_index);
 		if (c =3D=3D -1)
 			break;
 		switch (c) {
 		case 'a':
+			if (smp) {
+				warn("-a ignored due to --smp\n");
+				break;
+			}
 			if (optarg !=3D NULL) {
 				affinity =3D atoi(optarg);
 				setaffinity =3D AFFINITY_SPECIFIED;
@@ -317,7 +326,16 @@ static void process_options (int argc, char *argv[=
])
 		case 'i': interval =3D atoi(optarg); break;
 		case 'l': max_cycles =3D atoi(optarg); break;
 		case 'p': priority =3D atoi(optarg); break;
+		case 'S':
+			smp =3D 1;
+			num_threads =3D max_cpus;
+			setaffinity =3D AFFINITY_USEALL;
+			break;
 		case 't':
+			if (smp) {
+				warn("-t ignored due to --smp\n");
+				break;
+			}
 			if (optarg !=3D NULL)
 				num_threads =3D atoi(optarg);
 			else if (optind<argc && atoi(argv[optind]))
@@ -347,6 +365,9 @@ static void process_options (int argc, char *argv[]=
)
 		if (priority < 0 || priority > 99)
 			error =3D 1;
=20
+		if (priority && smp)
+			sameprio =3D 1;
+
 		tracelimit =3D thistracelimit;
 	}
 	if (error)
@@ -525,7 +546,7 @@ int main(int argc, char *argv[])
 		}
 		receiver[i].priority =3D priority;
 		receiver[i].tracelimit =3D tracelimit;
-		if (priority > 0)
+		if (priority > 1 && !sameprio)
 			priority--;
 		receiver[i].delay.tv_sec =3D interval / USEC_PER_SEC;
 		receiver[i].delay.tv_nsec =3D (interval % USEC_PER_SEC) * 1000;
--=20
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
