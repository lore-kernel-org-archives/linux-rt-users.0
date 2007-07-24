From: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: [patch 06/15] fix cppflags vs. cflags issues
Date: Tue, 24 Jul 2007 13:29:34 -0700
Message-ID: <200707241329.34351.dvhltc@us.ibm.com>
References: <20070724092517.390730736@metis.extern.pengutronix.de> <20070724092558.882010364@metis.extern.pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Robert Schwebel <r.schwebel@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e5.ny.us.ibm.com ([32.97.182.145]:51214 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752671AbXGXU3g (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 Jul 2007 16:29:36 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6OKTZb6016586
	for <linux-rt-users@vger.kernel.org>; Tue, 24 Jul 2007 16:29:35 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id l6OKTZqs344236
	for <linux-rt-users@vger.kernel.org>; Tue, 24 Jul 2007 16:29:35 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l6OKTZmH002797
	for <linux-rt-users@vger.kernel.org>; Tue, 24 Jul 2007 16:29:35 -0400
In-Reply-To: <20070724092558.882010364@metis.extern.pengutronix.de>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tuesday 24 July 2007 02:25:23 you wrote:
> Put preprocessor stuff into CPPFLAGS, not into CFLAGS.
>
> Signed-off-by: Robert Schwebel <r.schwebel@pengutronix.de>

Acked-by: Darren Hart <dvhltc@us.ibm.com>

>
> ---
>  func/gtod_latency/GNUmakefile.am         |    6 +++---
>  func/matrix_mult/GNUmakefile.am          |    7 +++++--
>  func/measurement/GNUmakefile.am          |    6 +++---
>  func/periodic_cpu_load/GNUmakefile.am    |    6 +++---
>  func/pi-tests/GNUmakefile.am             |   29
> ++++------------------------- func/pthread_kill_latency/GNUmakefile.am |   
> 8 ++++----
>  func/sched_jitter/GNUmakefile.am         |    3 ++-
>  7 files changed, 24 insertions(+), 41 deletions(-)
>
> Index: func/gtod_latency/GNUmakefile.am
> ===================================================================
> --- func/gtod_latency/GNUmakefile.am.orig
> +++ func/gtod_latency/GNUmakefile.am
> @@ -5,11 +5,11 @@ bin_PROGRAMS = \
>  AM_CPPFLAGS = \
>  	-I$(top_srcdir)/include \
>  	-I$(top_builddir)/include \
> -	-I$(DESTDIR)/usr/include/nptl
> +	-I$(DESTDIR)/usr/include/nptl \
> +	-D_GNU_SOURCE
>
>  gtod_infinite_CFLAGS = \
> -	-O2 \
> -	-D_GNU_SOURCE
> +	-O2
>
>  LDADD = \
>           ${top_srcdir}/include/libjvmsim.o \
> Index: func/matrix_mult/GNUmakefile.am
> ===================================================================
> --- func/matrix_mult/GNUmakefile.am.orig
> +++ func/matrix_mult/GNUmakefile.am
> @@ -9,9 +9,12 @@ AM_CPPFLAGS = \
>          -I$(top_builddir)/include \
>          -I$(DESTDIR)/usr/include/nptl
>
> +matrix_mult_CPPFLAGS = \
> +	$(AM_CPPFLAGS) \
> +	-D_GNU_SOURCE
> +
>  matrix_mult_CFLAGS = \
> -        -O2 \
> -        -D_GNU_SOURCE
> +        -O2
>
>  LDADD = \
>           ${top_srcdir}/include/libjvmsim.o \
> Index: func/measurement/GNUmakefile.am
> ===================================================================
> --- func/measurement/GNUmakefile.am.orig
> +++ func/measurement/GNUmakefile.am
> @@ -6,11 +6,11 @@ bin_PROGRAMS = \
>  AM_CPPFLAGS = \
>  	-I$(top_srcdir)/include \
>  	-I$(top_builddir)/include \
> -	-I$(DESTDIR)/usr/include/nptl
> +	-I$(DESTDIR)/usr/include/nptl \
> +	-D_GNU_SOURCE
>
>  AM_CFLAGS = \
> -	-O2 \
> -	-D_GNU_SOURCE
> +	-O2
>
>  AM_LDFLAGS = \
>  	-L$(DESTDIR)/usr/lib/nptl \
> Index: func/periodic_cpu_load/GNUmakefile.am
> ===================================================================
> --- func/periodic_cpu_load/GNUmakefile.am.orig
> +++ func/periodic_cpu_load/GNUmakefile.am
> @@ -6,11 +6,11 @@ bin_PROGRAMS = \
>  AM_CPPFLAGS = \
>          -I$(top_srcdir)/include \
>          -I$(top_builddir)/include \
> -        -I$(DESTDIR)/usr/include/nptl
> +        -I$(DESTDIR)/usr/include/nptl \
> +	-D_GNU_SOURCE
>
>  AM_CFLAGS = \
> -        -O2 \
> -        -D_GNU_SOURCE
> +        -O2
>
>  AM_LDFLAGS = \
>          -L$(DESTDIR)/usr/lib/nptl \
> Index: func/pi-tests/GNUmakefile.am
> ===================================================================
> --- func/pi-tests/GNUmakefile.am.orig
> +++ func/pi-tests/GNUmakefile.am
> @@ -19,7 +19,8 @@ endif
>  AM_CPPFLAGS = \
>  	-I$(top_srcdir)/include \
>  	-I$(top_builddir)/include \
> -	-I$(DESTDIR)/usr/include/nptl
> +	-I$(DESTDIR)/usr/include/nptl \
> +	-D_GNU_SOURCE
>
>  AM_CFLAGS = \
>  	-O2
> @@ -35,31 +36,9 @@ AM_LDFLAGS = \
>          -lrt \
>          -lm
>
> -testpi_0_CPPFLAGS = \
> -	-D_GNU_SOURCE
> -
> -testpi_1_CPPFLAGS = \
> -	-D_GNU_SOURCE
> -
> -testpi_2_CPPFLAGS = \
> -	-D_GNU_SOURCE
> -
> -testpi_4_CPPFLAGS = \
> -	-D_GNU_SOURCE
> -
> -testpi_5_CPPFLAGS = \
> -	-D_GNU_SOURCE
> -
> -testpi_6_CPPFLAGS = \
> -        -D_GNU_SOURCE
> -
> -
>  testpi_7_CPPFLAGS = \
> -        -D_GNU_SOURCE
> -
> -
> -sbrk_mutex_CPPFLAGS = \
> -        -D_GNU_SOURCE
> +	$(AM_CPPFLAGS) \
> +	-I$(srcdir)
>
>  MAINTAINERCLEANFILES = \
>  	GNUmakefile.in
> Index: func/pthread_kill_latency/GNUmakefile.am
> ===================================================================
> --- func/pthread_kill_latency/GNUmakefile.am.orig
> +++ func/pthread_kill_latency/GNUmakefile.am
> @@ -5,12 +5,12 @@ endif
>  AM_CPPFLAGS = \
>  	-I$(top_srcdir)/include \
>  	-I$(top_builddir)/include \
> -	-I$(DESTDIR)/usr/include/nptl
> -
> -pthread_kill_latency_CFLAGS = \
> -	-O2 \
> +	-I$(DESTDIR)/usr/include/nptl \
>  	-D_GNU_SOURCE
>
> +AM_CFLAGS = \
> +	-O2
> +
>  LDADD = \
>           ${top_srcdir}/include/libjvmsim.o \
>           ${top_srcdir}/include/librt.o \
> Index: func/sched_jitter/GNUmakefile.am
> ===================================================================
> --- func/sched_jitter/GNUmakefile.am.orig
> +++ func/sched_jitter/GNUmakefile.am
> @@ -3,7 +3,8 @@ bin_PROGRAMS = sched_jitter
>  AM_CPPFLAGS = \
>  	-I$(top_srcdir)/include \
>  	-I$(top_builddir)/include \
> -	-I$(DESTDIR)/usr/include/nptl
> +	-I$(DESTDIR)/usr/include/nptl \
> +	-D_GNU_SOURCE
>
>  sched_jitter_CFLAGS = \
>  	-O2
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
