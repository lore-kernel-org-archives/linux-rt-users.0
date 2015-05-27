From: John Kacur <jkacur@redhat.com>
Subject: Re: [patch 2/3] cyclictest: Convert the offset of the alignment
 option to microseconds
Date: Wed, 27 May 2015 23:32:21 +0200 (CEST)
Message-ID: <alpine.LFD.2.10.1505272324180.13094@riemann>
References: <20150526190333.510838769@glx-um.de> <20150526190443.640221319@glx-um.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>
To: anna-maria@glx-um.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:33722 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064AbbE0VcY (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 27 May 2015 17:32:24 -0400
Received: by wicmx19 with SMTP id mx19so106136051wic.0
        for <linux-rt-users@vger.kernel.org>; Wed, 27 May 2015 14:32:23 -0700 (PDT)
In-Reply-To: <20150526190443.640221319@glx-um.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Tue, 26 May 2015, anna-maria@glx-um.de wrote:

> The offset is specified in microseconds according to the
> documentation, but, the microseconds to nanoseconds conversion is
> missing so the effective offset has the unit of nanoseconds.
> 
> Signed-off-by: Anna-Maria Gleixner <anna-maria@glx-um.de>
> ---
>  src/cyclictest/cyclictest.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: rt-tests/src/cyclictest/cyclictest.c
> ===================================================================
> --- rt-tests.orig/src/cyclictest/cyclictest.c
> +++ rt-tests/src/cyclictest/cyclictest.c
> @@ -1289,7 +1289,7 @@ static void process_options (int argc, c
>  		case OPT_ALIGNED:
>  			aligned=1;
>  			if (optarg != NULL)
> -				offset = atoi(optarg);
> +				offset = atoi(optarg) * 1000;
>  			else if (optind<argc && atoi(argv[optind])

Don't we need the conversion here too then?
>  				offset = atoi(argv[optind]);

>  			else
> 
> 
> --

Thanks

John
