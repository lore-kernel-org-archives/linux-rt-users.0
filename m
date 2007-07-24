From: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: [patch 08/15] use static libs for supportlibs
Date: Tue, 24 Jul 2007 13:59:05 -0700
Message-ID: <200707241359.05333.dvhltc@us.ibm.com>
References: <20070724092517.390730736@metis.extern.pengutronix.de> <20070724092603.324176866@metis.extern.pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Robert Schwebel <r.schwebel@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e2.ny.us.ibm.com ([32.97.182.142]:52978 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750960AbXGXU7H (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 Jul 2007 16:59:07 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6OKx6Qr005137
	for <linux-rt-users@vger.kernel.org>; Tue, 24 Jul 2007 16:59:06 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id l6OKx6KW503228
	for <linux-rt-users@vger.kernel.org>; Tue, 24 Jul 2007 16:59:06 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l6OKx6cM016746
	for <linux-rt-users@vger.kernel.org>; Tue, 24 Jul 2007 16:59:06 -0400
In-Reply-To: <20070724092603.324176866@metis.extern.pengutronix.de>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tuesday 24 July 2007 02:25:25 Robert Schwebel wrote:
> The usual automake way for including local support libs is static
> libraries, so refactore it to use them.

We were trying to avoid libraries in a futile effort to keep the make process 
simple.... ah well.  This doesn't complicate things at all really it turns 
out, so I'm fine with it.

>
> Note: the libs should really be renamed, because calling a local library
> "librt" is a very, very bad idea.

Agreed.  We were thinking of changing it to librttest - any other suggestions?

>
> Signed-off-by: Robert Schwebel <r.schwebel@pengutronix.de>

Acked-by: Darren Hart <dvhltc@us.ibm.com>

>
> ---
>  configure.ac                             |    2 ++
>  func/async_handler/GNUmakefile.am        |    6 +++---
>  func/gtod_latency/GNUmakefile.am         |    6 +++---
>  func/matrix_mult/GNUmakefile.am          |    6 +++---
>  func/periodic_cpu_load/GNUmakefile.am    |    6 +++---
>  func/pi-tests/GNUmakefile.am             |    6 +++---
>  func/prio-preempt/GNUmakefile.am         |    6 +++---
>  func/prio-wake/GNUmakefile.am            |    6 +++---
>  func/pthread_kill_latency/GNUmakefile.am |    6 +++---
>  func/sched_jitter/GNUmakefile.am         |    2 +-
>  func/sched_latency/GNUmakefile.am        |    6 +++---
>  include/GNUmakefile.am                   |   19 +++++++++++++++++++
>  12 files changed, 49 insertions(+), 28 deletions(-)
>
> Index: func/gtod_latency/GNUmakefile.am
> ===================================================================
> --- func/gtod_latency/GNUmakefile.am.orig
> +++ func/gtod_latency/GNUmakefile.am
> @@ -12,9 +12,9 @@ gtod_infinite_CFLAGS = \
>  	-O2
>
>  LDADD = \
> -         ${top_srcdir}/include/libjvmsim.o \
> -         ${top_srcdir}/include/librt.o \
> -         ${top_srcdir}/include/libstats.o
> +         ${top_builddir}/include/libjvmsim.a \
> +         ${top_builddir}/include/librt.a \
> +         ${top_builddir}/include/libstats.a
>
>  LDFLAGS = \
>  	-L$(DESTDIR)/usr/lib/nptl \
> Index: func/matrix_mult/GNUmakefile.am
> ===================================================================
> --- func/matrix_mult/GNUmakefile.am.orig
> +++ func/matrix_mult/GNUmakefile.am
> @@ -17,9 +17,9 @@ matrix_mult_CFLAGS = \
>          -O2
>
>  LDADD = \
> -         ${top_srcdir}/include/libjvmsim.o \
> -         ${top_srcdir}/include/librt.o \
> -         ${top_srcdir}/include/libstats.o
> +         ${top_builddir}/include/libjvmsim.a \
> +         ${top_builddir}/include/librt.a \
> +         ${top_builddir}/include/libstats.a
>
>  matrix_mult_LDFLAGS = \
>          -lpthread -lrt -lm
> Index: func/periodic_cpu_load/GNUmakefile.am
> ===================================================================
> --- func/periodic_cpu_load/GNUmakefile.am.orig
> +++ func/periodic_cpu_load/GNUmakefile.am
> @@ -17,9 +17,9 @@ AM_LDFLAGS = \
>          -lpthread -lrt -lm
>
>  periodic_cpu_load_LDADD = \
> -         ${top_srcdir}/include/libjvmsim.o \
> -         ${top_srcdir}/include/librt.o \
> -         ${top_srcdir}/include/libstats.o
> +         ${top_builddir}/include/libjvmsim.a \
> +         ${top_builddir}/include/librt.a \
> +         ${top_builddir}/include/libstats.a
>
>  MAINTAINERCLEANFILES = \
>          GNUmakefile.in
> Index: func/pi-tests/GNUmakefile.am
> ===================================================================
> --- func/pi-tests/GNUmakefile.am.orig
> +++ func/pi-tests/GNUmakefile.am
> @@ -25,9 +25,9 @@ AM_CPPFLAGS = \
>  AM_CFLAGS = \
>  	-O2
>  LDADD = \
> -         ${top_srcdir}/include/libjvmsim.o \
> -         ${top_srcdir}/include/librt.o \
> -         ${top_srcdir}/include/libstats.o
> +         ${top_builddir}/include/libjvmsim.a \
> +         ${top_builddir}/include/librt.a \
> +         ${top_builddir}/include/libstats.a
>
>
>  AM_LDFLAGS = \
> Index: func/prio-preempt/GNUmakefile.am
> ===================================================================
> --- func/prio-preempt/GNUmakefile.am.orig
> +++ func/prio-preempt/GNUmakefile.am
> @@ -10,9 +10,9 @@ AM_CPPFLAGS = \
>  prio_preempt_CFLAGS = \
>  	-O2
>  LDADD = \
> -         ${top_srcdir}/include/libjvmsim.o \
> -         ${top_srcdir}/include/librt.o \
> -         ${top_srcdir}/include/libstats.o
> +         ${top_builddir}/include/libjvmsim.a \
> +         ${top_builddir}/include/librt.a \
> +         ${top_builddir}/include/libstats.a
>
>  prio_preempt_LDFLAGS = \
>          -lpthread \
> Index: func/prio-wake/GNUmakefile.am
> ===================================================================
> --- func/prio-wake/GNUmakefile.am.orig
> +++ func/prio-wake/GNUmakefile.am
> @@ -8,9 +8,9 @@ AM_CPPFLAGS = \
>  	-I$(DESTDIR)/usr/include/nptl
>
>  LDADD = \
> -         ${top_srcdir}/include/libjvmsim.o \
> -         ${top_srcdir}/include/librt.o \
> -         ${top_srcdir}/include/libstats.o
> +         ${top_builddir}/include/libjvmsim.a \
> +         ${top_builddir}/include/librt.a \
> +         ${top_builddir}/include/libstats.a
>
>  prio_wake_CFLAGS = \
>  	-O2
> Index: func/pthread_kill_latency/GNUmakefile.am
> ===================================================================
> --- func/pthread_kill_latency/GNUmakefile.am.orig
> +++ func/pthread_kill_latency/GNUmakefile.am
> @@ -12,9 +12,9 @@ AM_CFLAGS = \
>  	-O2
>
>  LDADD = \
> -         ${top_srcdir}/include/libjvmsim.o \
> -         ${top_srcdir}/include/librt.o \
> -         ${top_srcdir}/include/libstats.o
> +         ${top_builddir}/include/libjvmsim.a \
> +         ${top_builddir}/include/librt.a \
> +         ${top_builddir}/include/libstats.a
>
>  pthread_kill_latency_LDFLAGS = \
>          -lpthread -lrt -lm
> Index: func/sched_jitter/GNUmakefile.am
> ===================================================================
> --- func/sched_jitter/GNUmakefile.am.orig
> +++ func/sched_jitter/GNUmakefile.am
> @@ -10,7 +10,7 @@ sched_jitter_CFLAGS = \
>  	-O2
>
>  LDADD = \
> -         ${top_srcdir}/include/libstats.o
> +         ${top_builddir}/include/libstats.a
>
>  sched_jitter_LDFLAGS = \
>          -L/usr/lib/nptl \
> Index: func/sched_latency/GNUmakefile.am
> ===================================================================
> --- func/sched_latency/GNUmakefile.am.orig
> +++ func/sched_latency/GNUmakefile.am
> @@ -11,9 +11,9 @@ sched_latency_CFLAGS = \
>  	-O2
>
>  LDADD = \
> -         ${top_srcdir}/include/libjvmsim.o \
> -         ${top_srcdir}/include/librt.o \
> -         ${top_srcdir}/include/libstats.o
> +         ${top_builddir}/include/libjvmsim.a \
> +         ${top_builddir}/include/librt.a \
> +         ${top_builddir}/include/libstats.a
>
>  sched_latency_LDFLAGS = \
>          -L/usr/lib/nptl \
> Index: include/GNUmakefile.am
> ===================================================================
> --- /dev/null
> +++ include/GNUmakefile.am
> @@ -0,0 +1,19 @@
> +noinst_LIBRARIES = \
> +	libjvmsim.a \
> +	librt.a \
> +	libstats.a
> +
> +AM_CPPFLAGS = \
> +	-I$(top_srcdir)/include \
> +	-I$(top_builddir)/include \
> +	-D_GNU_SOURCE
> +
> +EXTRA_DIST = \
> +	libjvmsim.h \
> +	librt.h \
> +	libstats.h \
> +	list.h
> +
> +MAINTAINERCLEANFILES = \
> +	GNUmakefile.in
> +
> Index: configure.ac
> ===================================================================
> --- configure.ac.orig
> +++ configure.ac
> @@ -17,6 +17,8 @@ LDFLAGS="-L/usr/lib/nptl -lpthread"
>
>  AM_INIT_AUTOMAKE([foreign no-exeext dist-bzip2])
>
> +AC_PROG_RANLIB
> +
>  #
>  # Checks for header files.
>  #
> Index: func/async_handler/GNUmakefile.am
> ===================================================================
> --- func/async_handler/GNUmakefile.am.orig
> +++ func/async_handler/GNUmakefile.am
> @@ -16,9 +16,9 @@ AM_CFLAGS = \
>          -D_GNU_SOURCE
>
>  LDADD = \
> -         ${top_srcdir}/include/libjvmsim.o \
> -         ${top_srcdir}/include/librt.o \
> -         ${top_srcdir}/include/libstats.o
> +         ${top_builddir}/include/libjvmsim.a \
> +         ${top_builddir}/include/librt.a \
> +         ${top_builddir}/include/libstats.a
>
>  AM_LDFLAGS = \
>          -lpthread -lrt -lm
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
