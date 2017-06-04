From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] no compile warnings from cyclictest
Date: Sun, 4 Jun 2017 11:47:38 +0200
Message-ID: <20170604094738.vvuamqandisz67c5@pengutronix.de>
References: <trinity-e47892ae-17fb-4f87-8381-f313303cfe09-1496484084736@3capp-webde-bs10>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Cc: linux-rt-users@vger.kernel.org
To: rolf.freitag@email.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:52743 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750847AbdFDJrk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 4 Jun 2017 05:47:40 -0400
Content-Disposition: inline
In-Reply-To: <trinity-e47892ae-17fb-4f87-8381-f313303cfe09-1496484084736@3capp-webde-bs10>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

On Sat, Jun 03, 2017 at 12:01:24PM +0200, rolf.freitag@email.de wrote:
> Hi,
> 
> compiling cyclictest gives 4 warnings of type
> 
>   warning: ignoring return value of 'write'
> 
> and three of type
> 
>   warning: ... may be used uninitialized in this function
> 
> So i eleminated the first sort with a trash variable, which adds up 
> the return values and recycles them (their entropy) at the end via
> srand(). This also avoids a write-only variable.
> I eleminated the second sort by initializing the variables.
> 
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -222,6 +222,7 @@ static int use_fifo = 0;
>  static pthread_t fifo_threadid;
>  static int laptop = 0;
>  static int use_histfile = 0;
> +static unsigned int trash; // for unused return values, to avoid compiler warnings because of ignored return values

What is the good reason to collect these in a global variable?
Ah, later in the patch you use it for srand. Is this a good idea? If so,
document it here.

Oh, and AFAIK cyclictest uses C comments, not C++.

>  #ifdef ARCH_HAS_SMI_COUNTER
>  static int smi = 0;
> @@ -491,10 +492,10 @@ static void tracemark(char *fmt, ...)
>         va_end(ap);
>  
>         /* write the tracemark message */
> -       write(tracemark_fd, tracebuf, len);
> +       trash += write(tracemark_fd, tracebuf, len);

IMHO that's not very sensible. The compiler tells you, that you ignore
the return value of write and that might be a bad thing. So the (more)
sensible options are:

 - add proper error checking and let (here) tracemark fail if the write
   fails (and retry if the return value is positive but less than len).

 - you don't care about the return value, so use:

 	(void)write(tracemark_fd, tracebuf, len)

 - keep the warnings until someone else fixes them properly.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
