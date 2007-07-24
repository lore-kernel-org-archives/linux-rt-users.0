From: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: [patch 15/15] coding style fixes
Date: Tue, 24 Jul 2007 14:26:50 -0700
Message-ID: <200707241426.50995.dvhltc@us.ibm.com>
References: <20070724092517.390730736@metis.extern.pengutronix.de> <20070724092619.223951206@metis.extern.pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Robert Schwebel <r.schwebel@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e4.ny.us.ibm.com ([32.97.182.144]:42413 "EHLO e4.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753388AbXGXV0x (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 Jul 2007 17:26:53 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6OLQq8g028220
	for <linux-rt-users@vger.kernel.org>; Tue, 24 Jul 2007 17:26:52 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id l6OLQqWn551002
	for <linux-rt-users@vger.kernel.org>; Tue, 24 Jul 2007 17:26:52 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l6OLQqaU023060
	for <linux-rt-users@vger.kernel.org>; Tue, 24 Jul 2007 17:26:52 -0400
In-Reply-To: <20070724092619.223951206@metis.extern.pengutronix.de>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tuesday 24 July 2007 02:25:32 Robert Schwebel wrote:
> The coding style was really messed up all over the tree. This patch
> collects all changes to refactor Makefiles in a sane way.

Took a little munging to get into svn, and had to make one more space to tabs 
conversion... Thanks for all the cleanup - very much appreciated.

>
> Signed-off-by: Robert Schwebel <r.schwebel@pengutronix.de>

Acked-by: Darren Hart <dvhltc@us.ibm.com>

>
> ---
>  GNUmakefile.am                           |    8 ++++----
>  config/GNUmakefile.am                    |    2 +-
>  func/GNUmakefile.am                      |   27
> +++++++++++++-------------- func/async_handler/GNUmakefile.am        |   24
> +++++++++++------------- func/gtod_latency/GNUmakefile.am         |   10
> +++-------
>  func/gtod_latency/GNUmakefile.am.rej     |   21 ---------------------
>  func/matrix_mult/GNUmakefile.am          |    6 +++---
>  func/measurement/GNUmakefile.am          |    3 +--
>  func/periodic_cpu_load/GNUmakefile.am    |    6 +++---
>  func/pi-tests/GNUmakefile.am             |   14 +++++++-------
>  func/prio-preempt/GNUmakefile.am         |   13 +++++++------
>  func/prio-wake/GNUmakefile.am            |   13 ++++++-------
>  func/pthread_kill_latency/GNUmakefile.am |    8 ++++----
>  func/sched_jitter/GNUmakefile.am         |   11 +++++------
>  func/sched_latency/GNUmakefile.am        |   15 +++++++--------
>  perf/GNUmakefile.am                      |    1 +
>  stress/GNUmakefile.am                    |    5 ++---
>  17 files changed, 78 insertions(+), 109 deletions(-)
>
> Index: func/gtod_latency/GNUmakefile.am
> ===================================================================
> --- func/gtod_latency/GNUmakefile.am.orig
> +++ func/gtod_latency/GNUmakefile.am
> @@ -12,9 +12,9 @@ gtod_infinite_CFLAGS = \
>  	-O2
>
>  LDADD = \
> -         ${top_builddir}/include/libjvmsim.a \
> -         ${top_builddir}/include/librt.a \
> -         ${top_builddir}/include/libstats.a
> +         $(top_builddir)/include/libjvmsim.a \
> +         $(top_builddir)/include/librt.a \
> +         $(top_builddir)/include/libstats.a

Not sure if something got lost in translation... what did you change here?  I 
think you intended to make them tabs?  will merge in as tabs.

>
>  LDFLAGS = \
>  	-L$(DESTDIR)/usr/lib/nptl \
> @@ -23,10 +23,6 @@ LDFLAGS = \
>  gtod_latency_CFLAGS = \
>  	-O2
>
> -#rdtsc_latency_LDADD = \
> -#	-L$(DESTDIR)/usr/lib/nptl \
> -#	-lpthread -lrt -lm
> -
>  MAINTAINERCLEANFILES = \
>  	GNUmakefile.in
>
> Index: func/matrix_mult/GNUmakefile.am
> ===================================================================
> --- func/matrix_mult/GNUmakefile.am.orig
> +++ func/matrix_mult/GNUmakefile.am
> @@ -17,9 +17,9 @@ matrix_mult_CFLAGS = \
>          -O2
>
>  LDADD = \
> -         ${top_builddir}/include/libjvmsim.a \
> -         ${top_builddir}/include/librt.a \
> -         ${top_builddir}/include/libstats.a
> +	$(top_builddir)/include/libjvmsim.a \
> +	$(top_builddir)/include/librt.a \
> +	$(top_builddir)/include/libstats.a
>
>  matrix_mult_LDFLAGS = \
>          -lpthread -lrt -lm
> Index: func/measurement/GNUmakefile.am
> ===================================================================
> --- func/measurement/GNUmakefile.am.orig
> +++ func/measurement/GNUmakefile.am
> @@ -1,7 +1,6 @@
> -
>  bin_PROGRAMS = \
>  	preempt_timing \
> -	rdtsc-latency
> +	rdtsc-latency
>
>  AM_CPPFLAGS = \
>  	-I$(top_srcdir)/include \
> Index: func/periodic_cpu_load/GNUmakefile.am
> ===================================================================
> --- func/periodic_cpu_load/GNUmakefile.am.orig
> +++ func/periodic_cpu_load/GNUmakefile.am
> @@ -17,9 +17,9 @@ AM_LDFLAGS = \
>          -lpthread -lrt -lm
>
>  periodic_cpu_load_LDADD = \
> -         ${top_builddir}/include/libjvmsim.a \
> -         ${top_builddir}/include/librt.a \
> -         ${top_builddir}/include/libstats.a
> +	$(top_builddir)/include/libjvmsim.a \
> +	$(top_builddir)/include/librt.a \
> +	$(top_builddir)/include/libstats.a
>
>  periodic_cpu_load_single_LDADD = \
>  	$(top_builddir)/include/libjvmsim.a \
> Index: func/pi-tests/GNUmakefile.am
> ===================================================================
> --- func/pi-tests/GNUmakefile.am.orig
> +++ func/pi-tests/GNUmakefile.am
> @@ -24,17 +24,17 @@ AM_CPPFLAGS = \
>
>  AM_CFLAGS = \
>  	-O2
> -LDADD = \
> -         ${top_builddir}/include/libjvmsim.a \
> -         ${top_builddir}/include/librt.a \
> -         ${top_builddir}/include/libstats.a
>
> +LDADD = \
> +	$(top_builddir)/include/libjvmsim.a \
> +	$(top_builddir)/include/librt.a \
> +	$(top_builddir)/include/libstats.a
>
>  AM_LDFLAGS = \
>  	-L$(DESTDIR)/usr/lib/nptl \
> -        -lpthread \
> -        -lrt \
> -        -lm
> +	-lpthread \
> +	-lrt \
> +	-lm
>
>  testpi_7_CPPFLAGS = \
>  	$(AM_CPPFLAGS) \
> Index: func/prio-preempt/GNUmakefile.am
> ===================================================================
> --- func/prio-preempt/GNUmakefile.am.orig
> +++ func/prio-preempt/GNUmakefile.am
> @@ -9,15 +9,16 @@ AM_CPPFLAGS = \
>
>  prio_preempt_CFLAGS = \
>  	-O2
> +
>  LDADD = \
> -         ${top_builddir}/include/libjvmsim.a \
> -         ${top_builddir}/include/librt.a \
> -         ${top_builddir}/include/libstats.a
> +	$(top_builddir)/include/libjvmsim.a \
> +	$(top_builddir)/include/librt.a \
> +	$(top_builddir)/include/libstats.a
>
>  prio_preempt_LDFLAGS = \
> -        -lpthread \
> -        -lrt \
> -        -lm
> +	-lpthread \
> +	-lrt \
> +	-lm
>
>  MAINTAINERCLEANFILES = \
>  	GNUmakefile.in
> Index: func/prio-wake/GNUmakefile.am
> ===================================================================
> --- func/prio-wake/GNUmakefile.am.orig
> +++ func/prio-wake/GNUmakefile.am
> @@ -8,18 +8,17 @@ AM_CPPFLAGS = \
>  	-I$(DESTDIR)/usr/include/nptl
>
>  LDADD = \
> -         ${top_builddir}/include/libjvmsim.a \
> -         ${top_builddir}/include/librt.a \
> -         ${top_builddir}/include/libstats.a
> +	$(top_builddir)/include/libjvmsim.a \
> +	$(top_builddir)/include/librt.a \
> +	$(top_builddir)/include/libstats.a
>
>  prio_wake_CFLAGS = \
>  	-O2
>
>  prio_wake_LDFLAGS = \
> -        -lpthread  \
> -        -lrt  \
> -        -lm
> -
> +	-lpthread  \
> +	-lrt  \
> +	-lm
>
>  MAINTAINERCLEANFILES = \
>  	GNUmakefile.in
> Index: func/pthread_kill_latency/GNUmakefile.am
> ===================================================================
> --- func/pthread_kill_latency/GNUmakefile.am.orig
> +++ func/pthread_kill_latency/GNUmakefile.am
> @@ -12,12 +12,12 @@ AM_CFLAGS = \
>  	-O2
>
>  LDADD = \
> -         ${top_builddir}/include/libjvmsim.a \
> -         ${top_builddir}/include/librt.a \
> -         ${top_builddir}/include/libstats.a
> +	$(top_builddir)/include/libjvmsim.a \
> +	$(top_builddir)/include/librt.a \
> +	$(top_builddir)/include/libstats.a
>
>  pthread_kill_latency_LDFLAGS = \
> -        -lpthread -lrt -lm
> +	-lpthread -lrt -lm
>
>  MAINTAINERCLEANFILES = \
>  	GNUmakefile.in
> Index: func/sched_jitter/GNUmakefile.am
> ===================================================================
> --- func/sched_jitter/GNUmakefile.am.orig
> +++ func/sched_jitter/GNUmakefile.am
> @@ -10,14 +10,13 @@ sched_jitter_CFLAGS = \
>  	-O2
>
>  LDADD = \
> -         ${top_builddir}/include/libstats.a
> +	$(top_builddir)/include/libstats.a
>
>  sched_jitter_LDFLAGS = \
> -        -L/usr/lib/nptl \
> -        -lpthread \
> -        -lrt \
> -        -lm
> -
> +	-L/usr/lib/nptl \
> +	-lpthread \
> +	-lrt \
> +	-lm
>
>  MAINTAINERCLEANFILES = \
>  	GNUmakefile.in
> Index: func/sched_latency/GNUmakefile.am
> ===================================================================
> --- func/sched_latency/GNUmakefile.am.orig
> +++ func/sched_latency/GNUmakefile.am
> @@ -11,16 +11,15 @@ sched_latency_CFLAGS = \
>  	-O2
>
>  LDADD = \
> -         ${top_builddir}/include/libjvmsim.a \
> -         ${top_builddir}/include/librt.a \
> -         ${top_builddir}/include/libstats.a
> +	$(top_builddir)/include/libjvmsim.a \
> +	$(top_builddir)/include/librt.a \
> +	$(top_builddir)/include/libstats.a
>
>  sched_latency_LDFLAGS = \
> -        -L/usr/lib/nptl \
> -        -lpthread \
> -        -lrt \
> -        -lm
> -
> +	-L/usr/lib/nptl \
> +	-lpthread \
> +	-lrt \
> +	-lm
>
>  MAINTAINERCLEANFILES = \
>  	GNUmakefile.in
> Index: stress/GNUmakefile.am
> ===================================================================
> --- stress/GNUmakefile.am.orig
> +++ stress/GNUmakefile.am
> @@ -1,7 +1,6 @@
>  SUBDIRS = \
> -        pi-tests
> +	pi-tests
>
>  MAINTAINERCLEANFILES = \
> -        GNUmakefile.in
> -
> +	GNUmakefile.in
>
> Index: func/async_handler/GNUmakefile.am
> ===================================================================
> --- func/async_handler/GNUmakefile.am.orig
> +++ func/async_handler/GNUmakefile.am
> @@ -1,29 +1,27 @@
>  if HAVE_PTHREAD_MUTEXATTR_SETPROTOCOL
>  bin_PROGRAMS = \
> -        async_handler \
> +	async_handler \
>  	async_handler_jk \
>  	async_handler_tsc
>  endif
>
> -
>  AM_CPPFLAGS = \
> -        -I$(top_srcdir)/include \
> -        -I$(top_builddir)/include \
> -        -I$(DESTDIR)/usr/include/nptl
> +	-I$(top_srcdir)/include \
> +	-I$(top_builddir)/include \
> +	-I$(DESTDIR)/usr/include/nptl
>
>  AM_CFLAGS = \
> -        -O2 \
> -        -D_GNU_SOURCE
> +	-O2 \
> +	-D_GNU_SOURCE
>
>  LDADD = \
> -         ${top_builddir}/include/libjvmsim.a \
> -         ${top_builddir}/include/librt.a \
> -         ${top_builddir}/include/libstats.a
> +	$(top_builddir)/include/libjvmsim.a \
> +	$(top_builddir)/include/librt.a \
> +	$(top_builddir)/include/libstats.a
>
>  AM_LDFLAGS = \
> -        -lpthread -lrt -lm
> +	-lpthread -lrt -lm
>
>  MAINTAINERCLEANFILES = \
> -        GNUmakefile.in
> -
> +	GNUmakefile.in
>
> Index: func/GNUmakefile.am
> ===================================================================
> --- func/GNUmakefile.am.orig
> +++ func/GNUmakefile.am
> @@ -1,19 +1,18 @@
> -SUBDIRS=\
> -	async_handler\
> -	gtod_latency\
> -	matrix_mult\
> -	measurement\
> -	periodic_cpu_load\
> -	pi-tests\
> -	prio-preempt\
> -	prio-wake\
> -	pthread_kill_latency\
> -	sched_football\
> -	sched_jitter\
> -	sched_latency\
> +SUBDIRS = \
> +	async_handler \
> +	gtod_latency \
> +	matrix_mult \
> +	measurement \
> +	periodic_cpu_load \
> +	pi-tests \
> +	prio-preempt \
> +	prio-wake \
> +	pthread_kill_latency \
> +	sched_football \
> +	sched_jitter \
> +	sched_latency \
>  	thread_clock
>
> -
>  MAINTAINERCLEANFILES = \
>          GNUmakefile.in
>
> Index: config/GNUmakefile.am
> ===================================================================
> --- config/GNUmakefile.am.orig
> +++ config/GNUmakefile.am
> @@ -1,3 +1,3 @@
>  MAINTAINERCLEANFILES = \
> -        GNUmakefile.in
> +	GNUmakefile.in
>
> Index: GNUmakefile.am
> ===================================================================
> --- GNUmakefile.am.orig
> +++ GNUmakefile.am
> @@ -1,9 +1,9 @@
>  SUBDIRS = \
>  	config \
> -        include \
> -        func \
> -        perf \
> -        stress
> +	include \
> +	func \
> +	perf \
> +	stress
>
>  EXTRA_DIST = \
>  	autogen.sh
> Index: perf/GNUmakefile.am
> ===================================================================
> --- perf/GNUmakefile.am.orig
> +++ perf/GNUmakefile.am
> @@ -3,3 +3,4 @@ SUBDIRS = \
>
>  MAINTAINERCLEANFILES = \
>  	GNUmakefile.in
> +
> Index: func/gtod_latency/GNUmakefile.am.rej
> ===================================================================
> --- func/gtod_latency/GNUmakefile.am.rej
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -*************** gtod_infinite_CFLAGS = \
> -*** 12,20 ****
> -  	-O2
> -
> -  LDADD = \
> --          ${top_srcdir}/include/libjvmsim.a \
> --          ${top_srcdir}/include/librt.a \
> --          ${top_srcdir}/include/libstats.a
> -
> -  LDFLAGS = \
> -  	-L$(DESTDIR)/usr/lib/nptl \
> ---- 12,20 ----
> -  	-O2
> -
> -  LDADD = \
> -+ 	$(top_srcdir)/include/libjvmsim.a \
> -+ 	$(top_srcdir)/include/librt.a \
> -+ 	$(top_srcdir)/include/libstats.a
> -
> -  LDFLAGS = \
> -  	-L$(DESTDIR)/usr/lib/nptl \
>
> --
>  Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
>  Pengutronix - Linux Solutions for Science and Industry
>    Handelsregister:  Amtsgericht Hildesheim, HRA 2686
>      Hannoversche Str. 2, 31134 Hildesheim, Germany
>    Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9



-- 
Darren Hart
IBM Linux Technology Center
Realtime Linux Team
