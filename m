From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: [patch 01/11] add autotool build files
Date: Sat, 24 Mar 2007 13:10:46 +0100
Message-ID: <20070324121648.501177000@metis.extern.pengutronix.de>
References: <20070324121045.396218000@metis.extern.pengutronix.de>
Cc: Darren Hart <dvhltc@us.ibm.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:45101 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752581AbXCXMQu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 24 Mar 2007 08:16:50 -0400
Content-Disposition: inline; filename=autotoolize.diff
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This patch adds the infrastructure for autotoolization.

Signed-off-by: Robert Schwebel <r.schwebel@pengutronix.de>

 GNUmakefile.am                               |   32 +++++++++
 autogen.sh                                   |   23 ++++++
 config/GNUmakefile.am                        |    3
 config/m4/.secret-world-domination-project   |    2
 configure.ac                                 |   95 +++++++++++++++++++++++++++
 examples/GNUmakefile.am                      |   15 ++++
 examples/Makefile                            |    8 --
 func/GNUmakefile.am                          |   13 +++
 func/measurement/GNUmakefile.am              |   30 ++++++++
 func/measurement/gtod_latency/GNUmakefile.am |   23 ++++++
 func/pi-tests/GNUmakefile.am                 |   48 +++++++++++++
 func/prio-preempt/GNUmakefile.am             |   18 +++++
 func/prio-wake/GNUmakefile.am                |   18 +++++
 func/pthread_kill_latency/GNUmakefile.am     |   19 +++++
 func/sched_football/GNUmakefile.am           |   18 +++++
 func/sched_latency/GNUmakefile.am            |   18 +++++
 func/thread_clock/GNUmakefile.am             |   16 ++++
 func/winc/GNUmakefile.am                     |   22 ++++++
 include/GNUmakefile.am                       |    8 ++
 include/rttests_config.h.in                  |   94 ++++++++++++++++++++++++++
 logs/GNUmakefile.am                          |    3
 perf/GNUmakefile.am                          |    5 +
 perf/latency/GNUmakefile.am                  |   20 +++++
 scripts/GNUmakefile.am                       |    3
 stress/GNUmakefile.am                        |    6 +
 stress/pi-tests/GNUmakefile.am               |   23 ++++++
 26 files changed, 575 insertions(+), 8 deletions(-)

Index: autogen.sh
===================================================================
--- /dev/null
+++ autogen.sh
@@ -0,0 +1,23 @@
+#!/bin/bash
+
+#
+# usage:
+#
+# banner <target name>
+#
+banner() {
+	echo
+	TG=`echo $1 | sed -e "s,/.*/,,g"`
+	LINE=`echo $TG |sed -e "s/./-/g"`
+	echo $LINE
+	echo $TG
+	echo $LINE
+	echo
+}
+
+banner "autoreconf"
+
+autoreconf --force --install --symlink -Wall || exit $?
+rm -f include/rttests_config.h.in~
+
+banner "Finished"
Index: config/GNUmakefile.am
===================================================================
--- /dev/null
+++ config/GNUmakefile.am
@@ -0,0 +1,3 @@
+MAINTAINERCLEANFILES = \
+	GNUmakefile.in
+
Index: configure.ac
===================================================================
--- /dev/null
+++ configure.ac
@@ -0,0 +1,95 @@
+# -*- Autoconf -*-
+# Process this file with autoconf to produce a configure script.
+AC_PREREQ(2.59)
+
+AC_INIT([rttests], [0.0.0], [bugs@pengutronix.de])
+AC_CONFIG_HEADERS([include/rttests_config.h])
+AC_CONFIG_SRCDIR([examples/libstats_test.c])
+AC_CONFIG_MACRO_DIR([config/m4])
+AC_CONFIG_AUX_DIR([config/autoconf])
+AC_CANONICAL_BUILD
+AC_CANONICAL_HOST
+
+AM_MAINTAINER_MODE
+
+CFLAGS="${CFLAGS} -Wall"
+
+AM_INIT_AUTOMAKE([foreign no-exeext dist-bzip2])
+
+#
+# Checks for header files.
+#
+AC_HEADER_DIRENT
+AC_HEADER_STDC
+AC_HEADER_SYS_WAIT
+dnl AC_CHECK_HEADERS([limits.h])
+
+
+#
+# Checks for typedefs, structures, and compiler characteristics.
+#
+AC_C_CONST
+AC_C_INLINE
+AC_TYPE_SIZE_T
+AC_HEADER_TIME
+
+
+#
+# Checks for library functions.
+#
+
+AC_CHECK_FUNCS([pthread_mutexattr_setprotocol])
+AM_CONDITIONAL(
+    [HAVE_PTHREAD_MUTEXATTR_SETPROTOCOL],
+    [test "$ac_cv_func_pthread_mutexattr_setprotocol" = "yes"])
+
+AC_CHECK_FUNCS([pthread_mutexattr_setrobust_np])
+AM_CONDITIONAL(
+    [HAVE_PTHREAD_MUTEXATTR_SETROBUST_NP],
+    [test "$ac_cv_func_pthread_mutexattr_setrobust_np" = "yes"])
+
+#
+# Debugging
+#
+AC_MSG_CHECKING([whether to enable debugging])
+AC_ARG_ENABLE(debug,
+    AS_HELP_STRING([--enable-debug], [enable debugging @<:@default=yes@:>@]),
+	[case "$enableval" in
+	y | yes) CONFIG_DEBUG=yes ;;
+        *) CONFIG_DEBUG=no ;;
+    esac],
+    [CONFIG_DEBUG=yes])
+AC_MSG_RESULT([${CONFIG_DEBUG}])
+if test "${CONFIG_DEBUG}" = "yes"; then
+    CFLAGS="${CFLAGS} -Werror -Wsign-compare -Wfloat-equal -Wformat-security -g -O1"
+    AC_DEFINE(DEBUG, 1, [debugging])
+else
+    CFLAGS="${CFLAGS} -O2"
+fi
+
+
+AC_CONFIG_FILES([
+	GNUmakefile
+	config/GNUmakefile
+	include/GNUmakefile
+	examples/GNUmakefile
+	func/GNUmakefile
+	func/measurement/GNUmakefile
+	func/measurement/gtod_latency/GNUmakefile
+	func/pi-tests/GNUmakefile
+	func/prio-preempt/GNUmakefile
+	func/prio-wake/GNUmakefile
+	func/pthread_kill_latency/GNUmakefile
+	func/sched_football/GNUmakefile
+	func/sched_latency/GNUmakefile
+	func/thread_clock/GNUmakefile
+	func/winc/GNUmakefile
+	logs/GNUmakefile
+	perf/GNUmakefile
+	perf/latency/GNUmakefile
+	scripts/GNUmakefile
+	stress/GNUmakefile
+	stress/pi-tests/GNUmakefile
+	])
+AC_OUTPUT
+
Index: examples/GNUmakefile.am
===================================================================
--- /dev/null
+++ examples/GNUmakefile.am
@@ -0,0 +1,15 @@
+bin_PROGRAMS = libstats_test
+
+AM_CPPFLAGS = \
+	-I$(top_srcdir)/include \
+	-I$(top_builddir)/include
+
+libstats_test_CFLAGS = \
+	-O3
+
+libstats_test_LDADD = \
+	-lm
+
+MAINTAINERCLEANFILES = \
+	GNUmakefile.in
+
Index: func/GNUmakefile.am
===================================================================
--- /dev/null
+++ func/GNUmakefile.am
@@ -0,0 +1,13 @@
+SUBDIRS = \
+	measurement \
+	pi-tests \
+	prio-preempt \
+	prio-wake \
+	pthread_kill_latency \
+	sched_football \
+	sched_latency \
+	thread_clock \
+	winc
+
+MAINTAINERCLEANFILES = \
+	GNUmakefile.in
Index: func/measurement/GNUmakefile.am
===================================================================
--- /dev/null
+++ func/measurement/GNUmakefile.am
@@ -0,0 +1,30 @@
+SUBDIRS = \
+	gtod_latency
+
+bin_PROGRAMS = \
+	preempt_timing \
+	rdtsc-latency
+
+AM_CPPFLAGS = \
+	-I$(top_srcdir)/include \
+	-I$(top_builddir)/include \
+	-I$(DESTDIR)/usr/include/nptl
+
+preempt_timing_CFLAGS = \
+	-O2 \
+	-D_GNU_SOURCE
+
+# preempt_timing_LDADD = \
+#	-L$(DESTDIR)/usr/lib/nptl \
+#	-lpthread -lrt -lm
+
+rdtsc_latency_CFLAGS = \
+	-O2
+
+#rdtsc_latency_LDADD = \
+#	-L$(DESTDIR)/usr/lib/nptl \
+#	-lpthread -lrt -lm
+
+MAINTAINERCLEANFILES = \
+	GNUmakefile.in
+
Index: func/measurement/gtod_latency/GNUmakefile.am
===================================================================
--- /dev/null
+++ func/measurement/gtod_latency/GNUmakefile.am
@@ -0,0 +1,23 @@
+bin_PROGRAMS = \
+	gtod_latency \
+	gtod_infinite
+
+AM_CPPFLAGS = \
+	-I$(top_srcdir)/include \
+	-I$(top_builddir)/include
+
+gtod_latency_CFLAGS = \
+	-O2
+
+gtod_latency_LDADD = \
+	-lm
+
+gtod_infinite_CFLAGS = \
+	-O2
+
+gtod_infinite_LDADD = \
+	-lrt
+
+MAINTAINERCLEANFILES = \
+	GNUmakefile.in
+
Index: func/pi-tests/GNUmakefile.am
===================================================================
--- /dev/null
+++ func/pi-tests/GNUmakefile.am
@@ -0,0 +1,48 @@
+bin_PROGRAMS = \
+	testpi-0
+
+if HAVE_PTHREAD_MUTEXATTR_SETPROTOCOL
+bin_PROGRAMS += \
+	testpi-1 \
+	testpi-2 \
+	testpi-4 \
+	testpi-5 \
+	testpi-7
+endif
+
+if HAVE_PTHREAD_MUTEXATTR_SETROBUST_NP
+bin_PROGRAMS += \
+	testpi-6 \
+	sbrk_mutex
+endif
+
+AM_CPPFLAGS = \
+	-I$(top_srcdir)/include \
+	-I$(top_builddir)/include \
+	-I$(DESTDIR)/usr/include/nptl
+
+AM_CFLAGS = \
+	-O2
+
+AM_LDFLAGS = \
+	-L$(DESTDIR)/usr/lib/nptl
+
+testpi_0_CPPFLAGS = \
+	-D_GNU_SOURCE
+
+testpi_1_CPPFLAGS = \
+	-D_GNU_SOURCE
+
+testpi_2_CPPFLAGS = \
+	-D_GNU_SOURCE
+
+testpi_4_CPPFLAGS = \
+	-D_GNU_SOURCE
+
+MAINTAINERCLEANFILES = \
+	GNUmakefile.in
+
+
+# CFLAGS=-O2 -g -Wall -D_GNU_SOURCE -I/usr/include/nptl -I ../../include
+# LDFLAGS=-L/usr/lib/nptl -lpthread -lrt -lm
+
Index: func/prio-preempt/GNUmakefile.am
===================================================================
--- /dev/null
+++ func/prio-preempt/GNUmakefile.am
@@ -0,0 +1,18 @@
+if HAVE_PTHREAD_MUTEXATTR_SETPROTOCOL
+bin_PROGRAMS = prio-preempt
+endif
+
+AM_CPPFLAGS = \
+	-I$(top_srcdir)/include \
+	-I$(top_builddir)/include \
+	-I$(DESTDIR)/usr/include/nptl
+
+prio_preempt_CFLAGS = \
+	-O2
+
+#prio_preempt_LDADD = \
+#	-lpthread -lrt -lm
+
+MAINTAINERCLEANFILES = \
+	GNUmakefile.in
+
Index: func/prio-wake/GNUmakefile.am
===================================================================
--- /dev/null
+++ func/prio-wake/GNUmakefile.am
@@ -0,0 +1,18 @@
+if HAVE_PTHREAD_MUTEXATTR_SETPROTOCOL
+bin_PROGRAMS = prio-wake
+endif
+
+AM_CPPFLAGS = \
+	-I$(top_srcdir)/include \
+	-I$(top_builddir)/include \
+	-I$(DESTDIR)/usr/include/nptl
+
+prio_wake_CFLAGS = \
+	-O2
+
+prio_wake_LDADD = \
+	-lpthread -lrt -lm
+
+MAINTAINERCLEANFILES = \
+	GNUmakefile.in
+
Index: func/pthread_kill_latency/GNUmakefile.am
===================================================================
--- /dev/null
+++ func/pthread_kill_latency/GNUmakefile.am
@@ -0,0 +1,19 @@
+if HAVE_PTHREAD_MUTEXATTR_SETPROTOCOL
+bin_PROGRAMS = pthread_kill_latency
+endif
+
+AM_CPPFLAGS = \
+	-I$(top_srcdir)/include \
+	-I$(top_builddir)/include \
+	-I$(DESTDIR)/usr/include/nptl
+
+pthread_kill_latency_CFLAGS = \
+	-O2 \
+	-D_GNU_SOURCE
+
+#pthread_kill_latency_LDADD = \
+#	-lpthread -lrt -lm
+
+MAINTAINERCLEANFILES = \
+	GNUmakefile.in
+
Index: func/sched_football/GNUmakefile.am
===================================================================
--- /dev/null
+++ func/sched_football/GNUmakefile.am
@@ -0,0 +1,18 @@
+#if HAVE_PTHREAD_MUTEXATTR_SETPROTOCOL
+bin_PROGRAMS = sched_football
+#endif
+
+AM_CPPFLAGS = \
+	-I$(top_srcdir)/include \
+	-I$(top_builddir)/include \
+	-I$(DESTDIR)/usr/include/nptl
+
+sched_football_CFLAGS = \
+	-O3
+
+sched_football_LDADD = \
+	-lpthread
+
+MAINTAINERCLEANFILES = \
+	GNUmakefile.in
+
Index: func/sched_latency/GNUmakefile.am
===================================================================
--- /dev/null
+++ func/sched_latency/GNUmakefile.am
@@ -0,0 +1,18 @@
+if HAVE_PTHREAD_MUTEXATTR_SETPROTOCOL
+bin_PROGRAMS = sched_latency
+endif
+
+AM_CPPFLAGS = \
+	-I$(top_srcdir)/include \
+	-I$(top_builddir)/include \
+	-I$(DESTDIR)/usr/include/nptl
+
+sched_latency_CFLAGS = \
+	-O2
+
+#sched_latency_LDADD = \
+#	-lpthread
+
+MAINTAINERCLEANFILES = \
+	GNUmakefile.in
+
Index: func/thread_clock/GNUmakefile.am
===================================================================
--- /dev/null
+++ func/thread_clock/GNUmakefile.am
@@ -0,0 +1,16 @@
+bin_PROGRAMS = tc-1
+
+AM_CPPFLAGS = \
+	-I$(top_srcdir)/include \
+	-I$(top_builddir)/include \
+	-I$(DESTDIR)/usr/include/nptl
+
+tc_1_CFLAGS = \
+	-O2
+
+tc_1_LDADD = \
+	-lpthread -lrt
+
+MAINTAINERCLEANFILES = \
+	GNUmakefile.in
+
Index: func/winc/GNUmakefile.am
===================================================================
--- /dev/null
+++ func/winc/GNUmakefile.am
@@ -0,0 +1,22 @@
+if HAVE_PTHREAD_MUTEXATTR_SETPROTOCOL
+bin_PROGRAMS = \
+	async_handler
+endif
+
+# async_handler_jk
+
+AM_CPPFLAGS = \
+	-I$(top_srcdir)/include \
+	-I$(top_builddir)/include \
+	-I$(DESTDIR)/usr/include/nptl
+
+async_handler_CFLAGS = \
+	-O2 \
+	-D_GNU_SOURCE
+
+#async_handler_LDADD = \
+#	-lpthread -lrt -lm
+
+MAINTAINERCLEANFILES = \
+	GNUmakefile.in
+
Index: GNUmakefile.am
===================================================================
--- /dev/null
+++ GNUmakefile.am
@@ -0,0 +1,32 @@
+SUBDIRS = \
+	config \
+	examples \
+	func \
+	include \
+	logs \
+	perf \
+	scripts \
+	stress
+
+EXTRA_DIST = \
+	autogen.sh \
+	config/m4/.secret-world-domination-project
+
+MAINTAINERCLEANFILES = \
+	configure \
+	GNUmakefile.in \
+	aclocal.m4 \
+	config/autoconf/compile \
+	config/autoconf/config.guess \
+	config/autoconf/config.sub \
+	config/autoconf/depcomp \
+	config/autoconf/install-sh \
+	config/autoconf/ltmain.sh \
+	config/autoconf/mdate-sh \
+	config/autoconf/missing \
+	config/autoconf/texinfo.tex \
+	config/m4/acx_pthread.m4 \
+	config/m4/libtool.m4 \
+	config/m4/ltoptions.m4 \
+	config/m4/ltsugar.m4 \
+	config/m4/ltversion.m4
Index: include/GNUmakefile.am
===================================================================
--- /dev/null
+++ include/GNUmakefile.am
@@ -0,0 +1,8 @@
+noinst_HEADERS = \
+	libjvmsim.h \
+	librt.h \
+	libstats.h
+
+MAINTAINERCLEANFILES = \
+	GNUmakefile.in
+
Index: include/rttests_config.h.in
===================================================================
--- /dev/null
+++ include/rttests_config.h.in
@@ -0,0 +1,94 @@
+/* include/rttests_config.h.in.  Generated from configure.ac by autoheader.  */
+
+/* debugging */
+#undef DEBUG
+
+/* Define to 1 if you have the <dirent.h> header file, and it defines `DIR'.
+   */
+#undef HAVE_DIRENT_H
+
+/* Define to 1 if you have the <inttypes.h> header file. */
+#undef HAVE_INTTYPES_H
+
+/* Define to 1 if you have the <memory.h> header file. */
+#undef HAVE_MEMORY_H
+
+/* Define to 1 if you have the <ndir.h> header file, and it defines `DIR'. */
+#undef HAVE_NDIR_H
+
+/* Define to 1 if you have the `pthread_mutexattr_setprotocol' function. */
+#undef HAVE_PTHREAD_MUTEXATTR_SETPROTOCOL
+
+/* Define to 1 if you have the `pthread_mutexattr_setrobust_np' function. */
+#undef HAVE_PTHREAD_MUTEXATTR_SETROBUST_NP
+
+/* Define to 1 if you have the <stdint.h> header file. */
+#undef HAVE_STDINT_H
+
+/* Define to 1 if you have the <stdlib.h> header file. */
+#undef HAVE_STDLIB_H
+
+/* Define to 1 if you have the <strings.h> header file. */
+#undef HAVE_STRINGS_H
+
+/* Define to 1 if you have the <string.h> header file. */
+#undef HAVE_STRING_H
+
+/* Define to 1 if you have the <sys/dir.h> header file, and it defines `DIR'.
+   */
+#undef HAVE_SYS_DIR_H
+
+/* Define to 1 if you have the <sys/ndir.h> header file, and it defines `DIR'.
+   */
+#undef HAVE_SYS_NDIR_H
+
+/* Define to 1 if you have the <sys/stat.h> header file. */
+#undef HAVE_SYS_STAT_H
+
+/* Define to 1 if you have the <sys/types.h> header file. */
+#undef HAVE_SYS_TYPES_H
+
+/* Define to 1 if you have <sys/wait.h> that is POSIX.1 compatible. */
+#undef HAVE_SYS_WAIT_H
+
+/* Define to 1 if you have the <unistd.h> header file. */
+#undef HAVE_UNISTD_H
+
+/* Name of package */
+#undef PACKAGE
+
+/* Define to the address where bug reports for this package should be sent. */
+#undef PACKAGE_BUGREPORT
+
+/* Define to the full name of this package. */
+#undef PACKAGE_NAME
+
+/* Define to the full name and version of this package. */
+#undef PACKAGE_STRING
+
+/* Define to the one symbol short name of this package. */
+#undef PACKAGE_TARNAME
+
+/* Define to the version of this package. */
+#undef PACKAGE_VERSION
+
+/* Define to 1 if you have the ANSI C header files. */
+#undef STDC_HEADERS
+
+/* Define to 1 if you can safely include both <sys/time.h> and <time.h>. */
+#undef TIME_WITH_SYS_TIME
+
+/* Version number of package */
+#undef VERSION
+
+/* Define to empty if `const' does not conform to ANSI C. */
+#undef const
+
+/* Define to `__inline__' or `__inline' if that's what the C compiler
+   calls it, or to nothing if 'inline' is not supported under any name.  */
+#ifndef __cplusplus
+#undef inline
+#endif
+
+/* Define to `unsigned int' if <sys/types.h> does not define. */
+#undef size_t
Index: logs/GNUmakefile.am
===================================================================
--- /dev/null
+++ logs/GNUmakefile.am
@@ -0,0 +1,3 @@
+MAINTAINERCLEANFILES = \
+	GNUmakefile.in
+
Index: perf/GNUmakefile.am
===================================================================
--- /dev/null
+++ perf/GNUmakefile.am
@@ -0,0 +1,5 @@
+SUBDIRS = \
+	latency
+
+MAINTAINERCLEANFILES = \
+	GNUmakefile.in
Index: perf/latency/GNUmakefile.am
===================================================================
--- /dev/null
+++ perf/latency/GNUmakefile.am
@@ -0,0 +1,20 @@
+bin_PROGRAMS = \
+	pthread_cond_latency \
+	pthread_cond_many
+
+AM_CPPFLAGS = \
+	-I$(top_srcdir)/include \
+	-I$(top_builddir)/include
+
+AM_CFLAGS = \
+	-O2
+
+pthread_cond_latency_LDADD = \
+	-lpthread
+
+pthread_cond_many_LDADD = \
+	-lpthread
+
+MAINTAINERCLEANFILES = \
+	GNUmakefile.in
+
Index: scripts/GNUmakefile.am
===================================================================
--- /dev/null
+++ scripts/GNUmakefile.am
@@ -0,0 +1,3 @@
+MAINTAINERCLEANFILES = \
+	GNUmakefile.in
+
Index: stress/GNUmakefile.am
===================================================================
--- /dev/null
+++ stress/GNUmakefile.am
@@ -0,0 +1,6 @@
+SUBDIRS = \
+	pi-tests
+
+MAINTAINERCLEANFILES = \
+	GNUmakefile.in
+
Index: stress/pi-tests/GNUmakefile.am
===================================================================
--- /dev/null
+++ stress/pi-tests/GNUmakefile.am
@@ -0,0 +1,23 @@
+if HAVE_PTHREAD_MUTEXATTR_SETPROTOCOL
+bin_PROGRAMS = lookup_pi_state
+endif
+
+#	testpi-3
+
+AM_CPPFLAGS = \
+	-I$(top_srcdir)/include \
+	-I$(top_builddir)/include \
+	-I$(DESTDIR)/usr/include/nptl
+
+AM_CFLAGS = \
+	-O2
+
+#testpi_3_CFLAGS = \
+#	-D_GNU_SOURCE
+
+#testpi_3_LDADD = \
+#	-lpthread -lrt -lm
+
+MAINTAINERCLEANFILES = \
+	GNUmakefile.in
+
Index: config/m4/.secret-world-domination-project
===================================================================
--- /dev/null
+++ config/m4/.secret-world-domination-project
@@ -0,0 +1,2 @@
+
+
Index: examples/Makefile
===================================================================
--- examples/Makefile
+++ /dev/null
@@ -1,8 +0,0 @@
-CFLAGS += -O3 -lm -I../include
-CXXFLAGS += -lm -I../include
-bins = libstats_test
-
-all: ${bins}
-
-clean:
-	rm -f ${bins}

--
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
