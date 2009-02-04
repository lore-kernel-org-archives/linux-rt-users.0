From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: Build error: 2.6.26.8-rt15 on ARM.
Date: Wed, 4 Feb 2009 11:15:03 +0100
Message-ID: <20090204101503.GB12738@pengutronix.de>
References: <49895AB1.2090205@albentia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Iratxo Pichel Ortiz <ipichel@albentia.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54118 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484AbZBDKPF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 4 Feb 2009 05:15:05 -0500
Content-Disposition: inline
In-Reply-To: <49895AB1.2090205@albentia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Feb 04, 2009 at 10:06:57AM +0100, Iratxo Pichel Ortiz wrote:
> I think that I have found a built error on 2.6.26.8-rt15 on ARM (ixp4=
xx):
>
> Here (warning):
>
> In file included from kernel/trace/trace.c:37:
> include/asm/asm-offsets.h:49:1: warning: "VM_EXEC" redefined
> In file included from include/linux/pagemap.h:7,
>                 from kernel/trace/trace.c:19:
> include/linux/mm.h:77:1: warning: this is the location of the previou=
s =20
> definition
IIRC the resolution for that one was not to include both headers that
define VM_EXEC.  Try searching the archives of linux-arm-kernel ML.

> And here (error):
>
> kernel/trace/trace.c: In function 'trace_die_handler':
> kernel/trace/trace.c:3588: error: 'DIE_OOPS' undeclared (first use in=
 =20
> this function)
> kernel/trace/trace.c:3588: error: (Each undeclared identifier is =20
> reported only once
> kernel/trace/trace.c:3588: error: for each function it appears in.)
> make[2]: *** [kernel/trace/trace.o] Error 1
> make[1]: *** [kernel/trace] Error 2
> make: *** [kernel] Error 2
There is a fix already upstream: v2.6.28-rc2-29-g5209f08.  Try
cherry-picking.

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
Peiner Strasse 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-=
0    |
Amtsgericht Hildesheim, HRA 2686              | Fax:   +49-5121-206917-=
5555 |
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
