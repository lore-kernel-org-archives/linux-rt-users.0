From: Mark Hounschell <markh@compro.net>
Subject: Re: external gpl kernel module build problem on 2.6.26.8-rt16
Date: Thu, 23 Apr 2009 11:14:24 -0400
Message-ID: <49F085D0.60205@compro.net>
References: <49EF8449.2030000@compro.net> <49EF984C.50403@am.sony.com> <49F0479F.70908@cfl.rr.com> <20090423115651.GA15614@pengutronix.de>
Reply-To: markh@compro.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Hounschell <dmarkh@cfl.rr.com>, frank.rowand@am.sony.com,
	linux-rt-users@vger.kernel.org
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.compro.net ([216.54.166.4]:36813 "EHLO mx2.compro.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751825AbZDWPOZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 23 Apr 2009 11:14:25 -0400
In-Reply-To: <20090423115651.GA15614@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> On Thu, Apr 23, 2009 at 06:49:03AM -0400, Mark Hounschell wrote:
>> Frank Rowand wrote:
>>> Mark Hounschell wrote:
>>>> I get the following while trying to build this driver. What does i=
t mean.
>>>>
>>>>  Building modules, stage 2.
>>>>  MODPOST 1 modules
>>>> WARNING: "__bad_func_type" [/local/work/markh/pci5565-linux/driver=
/rfm2g.ko]
>>>> undefined!
>>>>
>>>> Then obviously the module doesn't load for the same reason.
>>>>
>>>> When I grep the kernel for bad_func_type all I see is
>>>>
>>>> include/linux/rt_lock.h:192:extern int __bad_func_type(void);
>>>> include/linux/pickop.h:8:extern int __bad_func_type(void);
>>>> include/linux/pickop.h:16:      else __bad_func_type();
>>>>                 \
>>>> include/linux/pickop.h:27:      else __ret =3D __bad_func_type();
>>>>
>>>> Any help or hints would be appreciated
>>>>
>>>> Thanks in advance
>>>> Mark
>>> #define PICK_FUNCTION(type1, type2, func1, func2, arg0, ...)       =
     \
>>> do {                                                               =
     \
>>>         if (PICK_TYPE_EQUAL((arg0), type1))                        =
     \
>>>                 func1((type1)(arg0), ##__VA_ARGS__);               =
     \
>>>         else if (PICK_TYPE_EQUAL((arg0), type2))                   =
     \
>>>                 func2((type2)(arg0), ##__VA_ARGS__);               =
     \
>>>         else __bad_func_type();                                    =
     \
>>> } while (0)
>>>
>>> And PICK_FUNCTION_RET() uses the same technique.
>>>
>>> Something that invokes PICK_FUNCTION() or PICK_FUNCTION_RET() is pa=
ssing
>>> in an arg0 that is not type1 and is not type2.
>>>
>>> One easy way to figure out what is invoking PICK_FUNCTION()/PICK_FU=
NCTION_RET()
>>> is to look at the output from the cpp of your driver.  The method I=
 usually
>>> use is to add the flags "-C -E" to my compile command (and remove "=
-c").
>>> Then search the cpp output for __bad_func_type.
>>>
>> Thanks for the pointer. How might one do this using the kernel build=
 system
>> though? Isn't the compile command used actually the kernels compile =
command?
>> Can I assume this would entail modifying the kernels top Makefile in=
 some way?
> You can compile using
>=20
> 	make V=3D1
>=20
> With that you can see the complete commands.  Then just take the last
> command (i.e. the failing one) and do s/-c/-C -E/.
>=20
> BTW, my guess is that it has to do with spinlocks and you do somethin=
g
> like:
>=20
> 	spinlock_t lock;
>=20
> 	....
>=20
> 	spin_lock_irqsave(lock, flags);
>=20
> instead of
>=20
> 	spin_lock_irqsave(&lock, flags);
>=20
> Best regards
> Uwe
>=20

Thanks, it turns out, to get the cpp output I had to modified the kerne=
ls
"scripts/Makefile.build" as described above. That got me something to l=
ook at.
Not really understanding all I was seeing I found is wasn't the spin_lo=
ck stuff
causing it but semaphore related stuff such as init_MUTEX/up/down etc. =
I think
I've got it worked out. Thanks for the help

Regards
Mark






--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
