From: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: [patch 09/15] add a makefile for stress/pi-tests
Date: Tue, 24 Jul 2007 14:00:36 -0700
Message-ID: <200707241400.36998.dvhltc@us.ibm.com>
References: <20070724092517.390730736@metis.extern.pengutronix.de> <20070724092605.592242611@metis.extern.pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Robert Schwebel <r.schwebel@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e4.ny.us.ibm.com ([32.97.182.144]:44496 "EHLO e4.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757114AbXGXVAi (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 Jul 2007 17:00:38 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6OL0cuL003185
	for <linux-rt-users@vger.kernel.org>; Tue, 24 Jul 2007 17:00:38 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id l6OL0cND505156
	for <linux-rt-users@vger.kernel.org>; Tue, 24 Jul 2007 17:00:38 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l6OL0bBm026703
	for <linux-rt-users@vger.kernel.org>; Tue, 24 Jul 2007 17:00:37 -0400
In-Reply-To: <20070724092605.592242611@metis.extern.pengutronix.de>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tuesday 24 July 2007 02:25:26 Robert Schwebel wrote:
> This directory should have a GNUmakefile.am.
>
> Signed-off-by: Robert Schwebel <r.schwebel@pengutronix.de>

Acked-by: Darren Hart <dvhltc@us.ibm.com>

>
> ---
>  stress/pi-tests/GNUmakefile.am |   22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> Index: stress/pi-tests/GNUmakefile.am
> ===================================================================
> --- /dev/null
> +++ stress/pi-tests/GNUmakefile.am
> @@ -0,0 +1,22 @@
> +bin_PROGRAMS = \
> +	testpi-3 \
> +	lookup_pi_state
> +
> +AM_CPPFLAGS = \
> +	-I$(top_srcdir)/include \
> +	-I$(top_builddir)/include \
> +	-I$(DESTDIR)/usr/include/nptl \
> +	-D_GNU_SOURCE
> +
> +AM_CFLAGS = \
> +	-O2
> +
> +LDADD = \
> +	$(top_builddir)/include/libjvmsim.a \
> +	$(top_builddir)/include/librt.a \
> +	$(top_builddir)/include/libstats.a \
> +	-lpthread -lrt -lm
> +
> +MAINTAINERCLEANFILES = \
> +	GNUmakefile.in
> +
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
