From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: Build error: 2.6.26.8-rt15 on ARM.
Date: Sat, 7 Feb 2009 20:39:32 +0100
Message-ID: <20090207193931.GA32296@pengutronix.de>
References: <49895AB1.2090205@albentia.com> <20090204101503.GB12738@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Iratxo Pichel Ortiz <ipichel@albentia.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39483 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752721AbZBGTje (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 7 Feb 2009 14:39:34 -0500
Content-Disposition: inline
In-Reply-To: <20090204101503.GB12738@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

On Wed, Feb 04, 2009 at 11:15:03AM +0100, Uwe Kleine-K=F6nig wrote:
> On Wed, Feb 04, 2009 at 10:06:57AM +0100, Iratxo Pichel Ortiz wrote:
> > I think that I have found a built error on 2.6.26.8-rt15 on ARM (ix=
p4xx):
> >
> > Here (warning):
> >
> > In file included from kernel/trace/trace.c:37:
> > include/asm/asm-offsets.h:49:1: warning: "VM_EXEC" redefined
> > In file included from include/linux/pagemap.h:7,
> >                 from kernel/trace/trace.c:19:
> > include/linux/mm.h:77:1: warning: this is the location of the previ=
ous =20
> > definition
> IIRC the resolution for that one was not to include both headers that
> define VM_EXEC.  Try searching the archives of linux-arm-kernel ML.
I had that warning now on Steven's tip, too.  For me removing
#include asm-offsets.h solved the situation.  Not sure this works in
general though.  And I was unable to find the thread on the ML?!

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
