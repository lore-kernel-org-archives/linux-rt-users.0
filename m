From: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: [patch 07/15] distribute all necessary files
Date: Tue, 24 Jul 2007 13:51:24 -0700
Message-ID: <200707241351.25063.dvhltc@us.ibm.com>
References: <20070724092517.390730736@metis.extern.pengutronix.de> <20070724092601.047964714@metis.extern.pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Robert Schwebel <r.schwebel@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e1.ny.us.ibm.com ([32.97.182.141]:48809 "EHLO e1.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932715AbXGXUv1 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 Jul 2007 16:51:27 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6OKpQTE028156
	for <linux-rt-users@vger.kernel.org>; Tue, 24 Jul 2007 16:51:26 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id l6OKpQSS414614
	for <linux-rt-users@vger.kernel.org>; Tue, 24 Jul 2007 16:51:26 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l6OKpPsD009387
	for <linux-rt-users@vger.kernel.org>; Tue, 24 Jul 2007 16:51:26 -0400
In-Reply-To: <20070724092601.047964714@metis.extern.pengutronix.de>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tuesday 24 July 2007 02:25:24 Robert Schwebel wrote:
> Some files are missing in the distro kit, add them. We also add config
> to the list of subdirs.
>
> Signed-off-by: Robert Schwebel <r.schwebel@pengutronix.de>

Acked-by: Darren Hart <dvhltc@us.ibm.com>


>
> ---
>  GNUmakefile.am               |    3 +++
>  func/pi-tests/GNUmakefile.am |    3 +++
>  2 files changed, 6 insertions(+)
>
> Index: func/pi-tests/GNUmakefile.am
> ===================================================================
> --- func/pi-tests/GNUmakefile.am.orig
> +++ func/pi-tests/GNUmakefile.am
> @@ -40,6 +40,9 @@ testpi_7_CPPFLAGS = \
>  	$(AM_CPPFLAGS) \
>  	-I$(srcdir)
>
> +EXTRA_DIST = \
> +	test-skeleton.c
> +
>  MAINTAINERCLEANFILES = \
>  	GNUmakefile.in
>
> Index: GNUmakefile.am
> ===================================================================
> --- GNUmakefile.am.orig
> +++ GNUmakefile.am
> @@ -1,9 +1,12 @@
>  SUBDIRS = \
> +	config \
>          include \
>          func \
>          perf \
>          stress
>
> +EXTRA_DIST = \
> +	autogen.sh
>
>  MAINTAINERCLEANFILES = \
>          GNUmakefile.in
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
