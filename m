From: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: [patch 10/15] fixup maintainerclean
Date: Tue, 24 Jul 2007 14:27:03 -0700
Message-ID: <200707241427.04043.dvhltc@us.ibm.com>
References: <20070724092517.390730736@metis.extern.pengutronix.de> <20070724092607.856146831@metis.extern.pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Robert Schwebel <r.schwebel@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e2.ny.us.ibm.com ([32.97.182.142]:37500 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752900AbXGXV1F (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 Jul 2007 17:27:05 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6OLR5UJ015884
	for <linux-rt-users@vger.kernel.org>; Tue, 24 Jul 2007 17:27:05 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id l6OLR4Tb480616
	for <linux-rt-users@vger.kernel.org>; Tue, 24 Jul 2007 17:27:04 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l6OLR4wu015158
	for <linux-rt-users@vger.kernel.org>; Tue, 24 Jul 2007 17:27:04 -0400
In-Reply-To: <20070724092607.856146831@metis.extern.pengutronix.de>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tuesday 24 July 2007 02:25:27 Robert Schwebel wrote:
> Add some more things which have to be cleaned on maintainer-clean; this
> does also remove directories in the case that something went wrong
> during development, leaving the tree in a non-clean state.
>

Couple questions on this one - we do have to understand it to maintain it :-)

> Signed-off-by: Robert Schwebel <r.schwebel@pengutronix.de>
>
> ---
>  GNUmakefile.am |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> Index: GNUmakefile.am
> ===================================================================
> --- GNUmakefile.am.orig
> +++ GNUmakefile.am
> @@ -9,5 +9,10 @@ EXTRA_DIST = \
>  	autogen.sh
>
>  MAINTAINERCLEANFILES = \
> -        GNUmakefile.in
> +	GNUmakefile.in \
> +	$(DIST_ARCHIVES)

What are these?

> +
> +maintainer-clean-local:
> +	-chmod -R a+rw $(distdir)
> +	-rm -fr $(distdir)

And this?

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
