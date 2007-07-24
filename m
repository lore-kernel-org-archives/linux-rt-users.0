From: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: [patch 11/15] periodic_cpuload_single needs support libs
Date: Tue, 24 Jul 2007 14:07:01 -0700
Message-ID: <200707241407.01886.dvhltc@us.ibm.com>
References: <20070724092517.390730736@metis.extern.pengutronix.de> <20070724092610.124184533@metis.extern.pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Robert Schwebel <r.schwebel@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:56349 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401AbXGXVHD (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 Jul 2007 17:07:03 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6OL73Pg018643
	for <linux-rt-users@vger.kernel.org>; Tue, 24 Jul 2007 17:07:03 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id l6OL72Yh195524
	for <linux-rt-users@vger.kernel.org>; Tue, 24 Jul 2007 15:07:02 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l6OL72Hp018495
	for <linux-rt-users@vger.kernel.org>; Tue, 24 Jul 2007 15:07:02 -0600
In-Reply-To: <20070724092610.124184533@metis.extern.pengutronix.de>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tuesday 24 July 2007 02:25:28 Robert Schwebel wrote:
> This file needs the support libraries, so link against them.
>
> Signed-off-by: Robert Schwebel <r.schwebel@pengutronix.de>

Acked-by: Darren Hart <dvhltc@us.ibm.com>

>
> ---
>  func/periodic_cpu_load/GNUmakefile.am |    5 +++++
>  1 file changed, 5 insertions(+)
>
> Index: func/periodic_cpu_load/GNUmakefile.am
> ===================================================================
> --- func/periodic_cpu_load/GNUmakefile.am.orig
> +++ func/periodic_cpu_load/GNUmakefile.am
> @@ -21,6 +21,11 @@ periodic_cpu_load_LDADD = \
>           ${top_builddir}/include/librt.a \
>           ${top_builddir}/include/libstats.a
>
> +periodic_cpu_load_single_LDADD = \
> +	$(top_builddir)/include/libjvmsim.a \
> +	$(top_builddir)/include/librt.a \
> +	$(top_builddir)/include/libstats.a
> +
>  MAINTAINERCLEANFILES = \
>          GNUmakefile.in
>
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
