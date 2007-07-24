From: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: [patch 14/15] remove bogus characters from makefile
Date: Tue, 24 Jul 2007 14:10:37 -0700
Message-ID: <200707241410.37813.dvhltc@us.ibm.com>
References: <20070724092517.390730736@metis.extern.pengutronix.de> <20070724092616.948018143@metis.extern.pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Robert Schwebel <r.schwebel@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:38415 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752300AbXGXVKl (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 Jul 2007 17:10:41 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6OLAfDV009193
	for <linux-rt-users@vger.kernel.org>; Tue, 24 Jul 2007 17:10:41 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id l6OLAe3Q206322
	for <linux-rt-users@vger.kernel.org>; Tue, 24 Jul 2007 15:10:40 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l6OLAeaZ024032
	for <linux-rt-users@vger.kernel.org>; Tue, 24 Jul 2007 15:10:40 -0600
In-Reply-To: <20070724092616.948018143@metis.extern.pengutronix.de>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tuesday 24 July 2007 02:25:31 Robert Schwebel wrote:
> Subject says it all ...
>
> Signed-off-by: Robert Schwebel <r.schwebel@pengutronix.de>

Acked-by: Darren Hart <dvhltc@us.ibm.com>


>
> ---
>  func/periodic_cpu_load/GNUmakefile.am |    6 ------
>  1 file changed, 6 deletions(-)
>
> Index: func/periodic_cpu_load/GNUmakefile.am
> ===================================================================
> --- func/periodic_cpu_load/GNUmakefile.am.orig
> +++ func/periodic_cpu_load/GNUmakefile.am
> @@ -29,9 +29,3 @@ periodic_cpu_load_single_LDADD = \
>  MAINTAINERCLEANFILES = \
>          GNUmakefile.in
>
> -~
> -~
> -~
> -~
> -~
> -
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
