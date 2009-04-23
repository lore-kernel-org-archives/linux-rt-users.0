From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: external gpl kernel module build problem on 2.6.26.8-rt16
Date: Thu, 23 Apr 2009 13:56:51 +0200
Message-ID: <20090423115651.GA15614@pengutronix.de>
References: <49EF8449.2030000@compro.net> <49EF984C.50403@am.sony.com> <49F0479F.70908@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: frank.rowand@am.sony.com, markh@compro.net,
	linux-rt-users@vger.kernel.org
To: Mark Hounschell <dmarkh@cfl.rr.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45953 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752373AbZDWL46 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 23 Apr 2009 07:56:58 -0400
Content-Disposition: inline
In-Reply-To: <49F0479F.70908@cfl.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

On Thu, Apr 23, 2009 at 06:49:03AM -0400, Mark Hounschell wrote:
> Frank Rowand wrote:
> > Mark Hounschell wrote:
> >> I get the following while trying to build this driver. What does i=
t mean.
> >>
> >>  Building modules, stage 2.
> >>  MODPOST 1 modules
> >> WARNING: "__bad_func_type" [/local/work/markh/pci5565-linux/driver=
/rfm2g.ko]
> >> undefined!
> >>
> >> Then obviously the module doesn't load for the same reason.
> >>
> >> When I grep the kernel for bad_func_type all I see is
> >>
> >> include/linux/rt_lock.h:192:extern int __bad_func_type(void);
> >> include/linux/pickop.h:8:extern int __bad_func_type(void);
> >> include/linux/pickop.h:16:      else __bad_func_type();
> >>                 \
> >> include/linux/pickop.h:27:      else __ret =3D __bad_func_type();
> >>
> >> Any help or hints would be appreciated
> >>
> >> Thanks in advance
> >> Mark
> >=20
> > #define PICK_FUNCTION(type1, type2, func1, func2, arg0, ...)       =
     \
> > do {                                                               =
     \
> >         if (PICK_TYPE_EQUAL((arg0), type1))                        =
     \
> >                 func1((type1)(arg0), ##__VA_ARGS__);               =
     \
> >         else if (PICK_TYPE_EQUAL((arg0), type2))                   =
     \
> >                 func2((type2)(arg0), ##__VA_ARGS__);               =
     \
> >         else __bad_func_type();                                    =
     \
> > } while (0)
> >=20
> > And PICK_FUNCTION_RET() uses the same technique.
> >=20
> > Something that invokes PICK_FUNCTION() or PICK_FUNCTION_RET() is pa=
ssing
> > in an arg0 that is not type1 and is not type2.
> >=20
> > One easy way to figure out what is invoking PICK_FUNCTION()/PICK_FU=
NCTION_RET()
> > is to look at the output from the cpp of your driver.  The method I=
 usually
> > use is to add the flags "-C -E" to my compile command (and remove "=
-c").
> > Then search the cpp output for __bad_func_type.
> >=20
>=20
> Thanks for the pointer. How might one do this using the kernel build =
system
> though? Isn't the compile command used actually the kernels compile c=
ommand?
> Can I assume this would entail modifying the kernels top Makefile in =
some way?
You can compile using

	make V=3D1

With that you can see the complete commands.  Then just take the last
command (i.e. the failing one) and do s/-c/-C -E/.

BTW, my guess is that it has to do with spinlocks and you do something
like:

	spinlock_t lock;

	....

	spin_lock_irqsave(lock, flags);

instead of

	spin_lock_irqsave(&lock, flags);

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
