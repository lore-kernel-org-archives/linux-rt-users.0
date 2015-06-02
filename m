From: John Kacur <jkacur@redhat.com>
Subject: Re: [patch 2/3] cyclictest: Convert the offset of the alignment
 option to microseconds
Date: Tue, 2 Jun 2015 15:00:53 +0200 (CEST)
Message-ID: <alpine.LFD.2.10.1506021458180.13306@riemann>
References: <20150526190333.510838769@glx-um.de> <20150526190443.640221319@glx-um.de> <alpine.LFD.2.10.1505272324180.13094@riemann> <47e6a4612898bdcbcf3073f27ab93708@tglx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>
To: Anna-Maria Gleixner <anna-maria@glx-um.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:35758 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753807AbbFBNBF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 2 Jun 2015 09:01:05 -0400
Received: by wgme6 with SMTP id e6so139308839wgm.2
        for <linux-rt-users@vger.kernel.org>; Tue, 02 Jun 2015 06:01:04 -0700 (PDT)
In-Reply-To: <47e6a4612898bdcbcf3073f27ab93708@tglx.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Sat, 30 May 2015, Anna-Maria Gleixner wrote:

> On 2015-05-27 23:32, John Kacur wrote:
> > On Tue, 26 May 2015, anna-maria@glx-um.de wrote:
> > Don't we need the conversion here too then?
> > >  				offset = atoi(argv[optind]);
> 
> Jap, this is right. I forgot it. I changed the patch.
> I forgot the same in the third patch of this series. I'll fix it and send the
> patch back to you.
> 
> 	Anna-Maria
> 
> 
> The offset is specified in microseconds according to the
> documentation, but, the microseconds to nanoseconds conversion is
> missing so the effective offset has the unit of nanoseconds.
> 
> Signed-off-by: Anna-Maria Gleixner <anna-maria@glx-um.de>
> ---
>  src/cyclictest/cyclictest.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Index: rt-tests/src/cyclictest/cyclictest.c
> ===================================================================
> --- rt-tests.orig/src/cyclictest/cyclictest.c
> +++ rt-tests/src/cyclictest/cyclictest.c
> @@ -1289,9 +1289,9 @@ static void process_options (int argc, c


I fixed your patch manually, but you are doing something wrong generating 
it, see how the function header get's cut off above there?


>  		case OPT_ALIGNED:
>  			aligned=1;
>  			if (optarg != NULL)
> -				offset = atoi(optarg);
> +				offset = atoi(optarg) * 1000;
>  			else if (optind<argc && atoi(argv[optind]))
> -				offset = atoi(argv[optind]);
> +				offset = atoi(argv[optind]) * 1000;
>  			else
>  				offset = 0;
>  			break;
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
