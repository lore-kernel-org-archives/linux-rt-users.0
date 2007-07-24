From: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: [patch 12/15] fix version and contact information
Date: Tue, 24 Jul 2007 14:07:28 -0700
Message-ID: <200707241407.29079.dvhltc@us.ibm.com>
References: <20070724092517.390730736@metis.extern.pengutronix.de> <20070724092612.384609187@metis.extern.pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Robert Schwebel <r.schwebel@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:41639 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751881AbXGXVHa (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 Jul 2007 17:07:30 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id l6OK1Xcb032428
	for <linux-rt-users@vger.kernel.org>; Tue, 24 Jul 2007 16:01:33 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id l6OL7TIR175546
	for <linux-rt-users@vger.kernel.org>; Tue, 24 Jul 2007 15:07:29 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l6OL7TZL016196
	for <linux-rt-users@vger.kernel.org>; Tue, 24 Jul 2007 15:07:29 -0600
In-Reply-To: <20070724092612.384609187@metis.extern.pengutronix.de>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tuesday 24 July 2007 02:25:29 Robert Schwebel wrote:
> Make sure that the packet is named correctly and bugs are reported to
> the right address.
>
> Signed-off-by: Robert Schwebel <r.schwebel@pengutronix.de>

Acked-by: Darren Hart <dvhltc@us.ibm.com>

>
> ---
>  configure.ac |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Index: configure.ac
> ===================================================================
> --- configure.ac.orig
> +++ configure.ac
> @@ -2,7 +2,7 @@
>  # Process this file with autoconf to produce a configure script.
>  AC_PREREQ(2.61)
>
> -AC_INIT([rttests],[0.0.0],[bugs@pengutronix.de])
> +AC_INIT([rt-test],[0.3],[linux-rt-users@vger.kernel.org])
>  AC_CONFIG_HEADERS([include/rttests_config.h])
>  #AC_CONFIG_SRCDIR([internal/examples/libstats_test.c])
>  AC_CONFIG_MACRO_DIR([config/m4])
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
