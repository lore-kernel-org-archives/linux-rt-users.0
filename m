From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: [patch 08/15] use static libs for supportlibs
Date: Tue, 24 Jul 2007 11:25:25 +0200
Message-ID: <20070724092603.324176866@metis.extern.pengutronix.de>
References: <20070724092517.390730736@metis.extern.pengutronix.de>
Cc: linux-rt-users@vger.kernel.org
To: Darren Hart <dvhltc@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:60046 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932086AbXGXKDc (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 Jul 2007 06:03:32 -0400
Content-Disposition: inline; filename=use_libs_not_ofiles.diff
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

The usual automake way for including local support libs is static
libraries, so refactore it to use them.

Note: the libs should really be renamed, because calling a local library
"librt" is a very, very bad idea.

Signed-off-by: Robert Schwebel <r.schwebel@pengutronix.de>

---
 configure.ac                             |    2 ++
 func/async_handler/GNUmakefile.am        |    6 +++---
 func/gtod_latency/GNUmakefile.am         |    6 +++---
 func/matrix_mult/GNUmakefile.am          |    6 +++---
 func/periodic_cpu_load/GNUmakefile.am    |    6 +++---
 func/pi-tests/GNUmakefile.am             |    6 +++---
 func/prio-preempt/GNUmakefile.am         |    6 +++---
 func/prio-wake/GNUmakefile.am            |    6 +++---
 func/pthread_kill_latency/GNUmakefile.am |    6 +++---
 func/sched_jitter/GNUmakefile.am         |    2 +-
 func/sched_latency/GNUmakefile.am        |    6 +++---
 include/GNUmakefile.am                   |   19 +++++++++++++++++++
 12 files changed, 49 insertions(+), 28 deletions(-)

Index: func/gtod_latency/GNUmakefile.am
===================================================================
--- func/gtod_latency/GNUmakefile.am.orig
+++ func/gtod_latency/GNUmakefile.am
@@ -12,9 +12,9 @@ gtod_infinite_CFLAGS = \
 	-O2
 
 LDADD = \
-         ${top_srcdir}/include/libjvmsim.o \
-         ${top_srcdir}/include/librt.o \
-         ${top_srcdir}/include/libstats.o
+         ${top_builddir}/include/libjvmsim.a \
+         ${top_builddir}/include/librt.a \
+         ${top_builddir}/include/libstats.a
 
 LDFLAGS = \
 	-L$(DESTDIR)/usr/lib/nptl \
Index: func/matrix_mult/GNUmakefile.am
===================================================================
--- func/matrix_mult/GNUmakefile.am.orig
+++ func/matrix_mult/GNUmakefile.am
@@ -17,9 +17,9 @@ matrix_mult_CFLAGS = \
         -O2
 
 LDADD = \
-         ${top_srcdir}/include/libjvmsim.o \
-         ${top_srcdir}/include/librt.o \
-         ${top_srcdir}/include/libstats.o
+         ${top_builddir}/include/libjvmsim.a \
+         ${top_builddir}/include/librt.a \
+         ${top_builddir}/include/libstats.a
 
 matrix_mult_LDFLAGS = \
         -lpthread -lrt -lm
Index: func/periodic_cpu_load/GNUmakefile.am
===================================================================
--- func/periodic_cpu_load/GNUmakefile.am.orig
+++ func/periodic_cpu_load/GNUmakefile.am
@@ -17,9 +17,9 @@ AM_LDFLAGS = \
         -lpthread -lrt -lm
 
 periodic_cpu_load_LDADD = \
-         ${top_srcdir}/include/libjvmsim.o \
-         ${top_srcdir}/include/librt.o \
-         ${top_srcdir}/include/libstats.o
+         ${top_builddir}/include/libjvmsim.a \
+         ${top_builddir}/include/librt.a \
+         ${top_builddir}/include/libstats.a
 
 MAINTAINERCLEANFILES = \
         GNUmakefile.in
Index: func/pi-tests/GNUmakefile.am
===================================================================
--- func/pi-tests/GNUmakefile.am.orig
+++ func/pi-tests/GNUmakefile.am
@@ -25,9 +25,9 @@ AM_CPPFLAGS = \
 AM_CFLAGS = \
 	-O2
 LDADD = \
-         ${top_srcdir}/include/libjvmsim.o \
-         ${top_srcdir}/include/librt.o \
-         ${top_srcdir}/include/libstats.o
+         ${top_builddir}/include/libjvmsim.a \
+         ${top_builddir}/include/librt.a \
+         ${top_builddir}/include/libstats.a
 
 
 AM_LDFLAGS = \
Index: func/prio-preempt/GNUmakefile.am
===================================================================
--- func/prio-preempt/GNUmakefile.am.orig
+++ func/prio-preempt/GNUmakefile.am
@@ -10,9 +10,9 @@ AM_CPPFLAGS = \
 prio_preempt_CFLAGS = \
 	-O2
 LDADD = \
-         ${top_srcdir}/include/libjvmsim.o \
-         ${top_srcdir}/include/librt.o \
-         ${top_srcdir}/include/libstats.o
+         ${top_builddir}/include/libjvmsim.a \
+         ${top_builddir}/include/librt.a \
+         ${top_builddir}/include/libstats.a
 
 prio_preempt_LDFLAGS = \
         -lpthread \
Index: func/prio-wake/GNUmakefile.am
===================================================================
--- func/prio-wake/GNUmakefile.am.orig
+++ func/prio-wake/GNUmakefile.am
@@ -8,9 +8,9 @@ AM_CPPFLAGS = \
 	-I$(DESTDIR)/usr/include/nptl
 
 LDADD = \
-         ${top_srcdir}/include/libjvmsim.o \
-         ${top_srcdir}/include/librt.o \
-         ${top_srcdir}/include/libstats.o
+         ${top_builddir}/include/libjvmsim.a \
+         ${top_builddir}/include/librt.a \
+         ${top_builddir}/include/libstats.a
 
 prio_wake_CFLAGS = \
 	-O2
Index: func/pthread_kill_latency/GNUmakefile.am
===================================================================
--- func/pthread_kill_latency/GNUmakefile.am.orig
+++ func/pthread_kill_latency/GNUmakefile.am
@@ -12,9 +12,9 @@ AM_CFLAGS = \
 	-O2
 
 LDADD = \
-         ${top_srcdir}/include/libjvmsim.o \
-         ${top_srcdir}/include/librt.o \
-         ${top_srcdir}/include/libstats.o
+         ${top_builddir}/include/libjvmsim.a \
+         ${top_builddir}/include/librt.a \
+         ${top_builddir}/include/libstats.a
 
 pthread_kill_latency_LDFLAGS = \
         -lpthread -lrt -lm
Index: func/sched_jitter/GNUmakefile.am
===================================================================
--- func/sched_jitter/GNUmakefile.am.orig
+++ func/sched_jitter/GNUmakefile.am
@@ -10,7 +10,7 @@ sched_jitter_CFLAGS = \
 	-O2
 
 LDADD = \
-         ${top_srcdir}/include/libstats.o
+         ${top_builddir}/include/libstats.a
 
 sched_jitter_LDFLAGS = \
         -L/usr/lib/nptl \
Index: func/sched_latency/GNUmakefile.am
===================================================================
--- func/sched_latency/GNUmakefile.am.orig
+++ func/sched_latency/GNUmakefile.am
@@ -11,9 +11,9 @@ sched_latency_CFLAGS = \
 	-O2
 
 LDADD = \
-         ${top_srcdir}/include/libjvmsim.o \
-         ${top_srcdir}/include/librt.o \
-         ${top_srcdir}/include/libstats.o
+         ${top_builddir}/include/libjvmsim.a \
+         ${top_builddir}/include/librt.a \
+         ${top_builddir}/include/libstats.a
 
 sched_latency_LDFLAGS = \
         -L/usr/lib/nptl \
Index: include/GNUmakefile.am
===================================================================
--- /dev/null
+++ include/GNUmakefile.am
@@ -0,0 +1,19 @@
+noinst_LIBRARIES = \
+	libjvmsim.a \
+	librt.a \
+	libstats.a
+
+AM_CPPFLAGS = \
+	-I$(top_srcdir)/include \
+	-I$(top_builddir)/include \
+	-D_GNU_SOURCE
+
+EXTRA_DIST = \
+	libjvmsim.h \
+	librt.h \
+	libstats.h \
+	list.h
+
+MAINTAINERCLEANFILES = \
+	GNUmakefile.in
+
Index: configure.ac
===================================================================
--- configure.ac.orig
+++ configure.ac
@@ -17,6 +17,8 @@ LDFLAGS="-L/usr/lib/nptl -lpthread"
 
 AM_INIT_AUTOMAKE([foreign no-exeext dist-bzip2])
 
+AC_PROG_RANLIB
+
 #
 # Checks for header files.
 #
Index: func/async_handler/GNUmakefile.am
===================================================================
--- func/async_handler/GNUmakefile.am.orig
+++ func/async_handler/GNUmakefile.am
@@ -16,9 +16,9 @@ AM_CFLAGS = \
         -D_GNU_SOURCE
 
 LDADD = \
-         ${top_srcdir}/include/libjvmsim.o \
-         ${top_srcdir}/include/librt.o \
-         ${top_srcdir}/include/libstats.o
+         ${top_builddir}/include/libjvmsim.a \
+         ${top_builddir}/include/librt.a \
+         ${top_builddir}/include/libstats.a
 
 AM_LDFLAGS = \
         -lpthread -lrt -lm

--
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
