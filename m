From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] rename pip to pip_stress as pip is too general
Date: Mon,  1 Mar 2010 17:51:15 +0100
Message-ID: <1267462275-14222-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1267129480-4542-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36748 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435Ab0CAQuz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 1 Mar 2010 11:50:55 -0500
In-Reply-To: <1267129480-4542-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The command name is already taken by a perl script working with CPAN
and a Python package installer.

While at it remove trailing whitespace from three lines in
src/pi_tests/pip_stress.c.

Closes: http://bugs.debian.org/572104
Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
Hiho,

changes since last submission are:

  - remove trailing whitespaces
  - different bug number

Best regards
Uwe
 .gitignore                           |    2 +-
 Makefile                             |    4 ++--
 src/include/{pip.h =3D> pip_stress.h}  |    7 +++----
 src/pi_tests/{pip.c =3D> pip_stress.c} |   10 +++++-----
 4 files changed, 11 insertions(+), 12 deletions(-)
 rename src/include/{pip.h =3D> pip_stress.h} (93%)
 rename src/pi_tests/{pip.c =3D> pip_stress.c} (98%)

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
diff --git a/src/include/pip.h b/src/include/pip_stress.h
similarity index 93%
rename from src/include/pip.h
rename to src/include/pip_stress.h
index b2068be..8ed2452 100644
--- a/src/include/pip.h
+++ b/src/include/pip_stress.h
@@ -1,5 +1,5 @@
-#ifndef __PIP_H
-#define __PIP_H
+#ifndef __PIP_STRESS_H
+#define __PIP_STRESS_H
=20
 #include <stdio.h>
 #include <stdlib.h>
@@ -37,5 +37,4 @@ int get_rt_prio(pid_t pid);
 #define PROTRW PROT_READ|PROT_WRITE
 #define MMAP_FLAGS MAP_SHARED|MAP_ANONYMOUS
=20
-#endif	/* __PIP_H */
-
+#endif	/* __PIP_STRESS_H */
diff --git a/src/pi_tests/pip.c b/src/pi_tests/pip_stress.c
similarity index 98%
rename from src/pi_tests/pip.c
rename to src/pi_tests/pip_stress.c
index 085908b..2b42b8f 100644
--- a/src/pi_tests/pip.c
+++ b/src/pi_tests/pip_stress.c
@@ -1,6 +1,6 @@
 /*
-	Pip - Priority Inheritance with processes
-   =20
+	Pip stress - Priority Inheritance with processes
+
     Copyright (C) 2009, John Kacur <jkacur@redhat.com>
=20
     This program is free software: you can redistribute it and/or modi=
fy
@@ -54,7 +54,7 @@
  * scheduling priorities.
  */
=20
-#include "pip.h"
+#include "pip_stress.h"
=20
 pthread_mutex_t *resource;
=20
@@ -107,7 +107,7 @@ int main(void)
 	set_rt_prio(0, prio_min, policy);
=20
 	/* We restrict this program to the first cpu, inorder to increase
-	 * the likelihood of a priority inversion */=20
+	 * the likelihood of a priority inversion */
 	CPU_ZERO(setp);
 	CPU_SET(0, setp);
 	res =3D sched_setaffinity(0, sizeof(set), setp);
@@ -311,7 +311,7 @@ void init_shared_pthread_mutex(pthread_mutex_t *mut=
ex, int protocol, int policy)
 	Pthread_mutexattr_init(&attr);
 	Pthread_mutexattr_setpshared(&attr, PTHREAD_PROCESS_SHARED);
 	Pthread_mutexattr_setprotocol(&attr, protocol);
-=09
+
 	Pthread_mutex_init(mutex, &attr);
 }
=20
--=20
1.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
