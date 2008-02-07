From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: Re: IBM test question
Date: Thu, 07 Feb 2008 17:27:53 +0100
Message-ID: <47AB3189.7080505@parrot.com>
References: <47AB0C53.3050703@parrot.com> <20080207163440.174181f2@frecb000686.frec.bull.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from co203.xi-lite.net ([149.6.83.203]:43287 "EHLO
	toronto.xi-lite.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754962AbYBGQ2q (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 7 Feb 2008 11:28:46 -0500
In-Reply-To: <20080207163440.174181f2@frecb000686.frec.bull.fr>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi S=E9bastien,

S=E9bastien Dugu=E9 wrote:
>   Hello Matthieu,
>=20
> On Thu, 07 Feb 2008 14:49:07 +0100 Matthieu CASTET <matthieu.castet@p=
arrot.com> wrote:
>=20
>> hi,
>>
>> I am trying to use some IBM rt test on arm.
>>
>>
>> I define atomic_add to
>> assert(i=3D=3D1);
>> return ++(v->counter);
>>
>> That's a bit ugly, but that should work for my need.
>=20
>   That would be the poor man's atomic_inc() and not sure it really do=
es
> what you think it does ;). Just for the record, pre-armv6 cores have =
no support
> for userland atomic operations (aside from swapping).
I can, if I use a kernel helper :) [1]

BTW what should do the atomic_add.
On i386 it does the atomic add and return the value in memory before th=
e=20
add (Exchange and Add).
On powerpc, it seems to do the atomic add and return the new value.


>=20
>> But I have a problem with the sched_latency test.
>> On my platform the thread creation is quite slow (25ms), so with the=
=20
>> default value, I got a PERIOD MISSED.
>=20
>   The IBM RT tests have been integrated into the LTP and I recently
> sent some updates to those testcases. Notably one the patches did imp=
rove
> the thread starting time. Other patches did touch this particular tes=
t too.
>=20
>   Could you try the latest release (from LTP) and tell me if things
> have improved for you.
Ok I will try them.
>=20
>   Also, the PASS/FAIL criteria are quite arbitrary. They happen to be=
 fine
> for most recent PC-class hardware but surely not for embedded systems=
 and
> should be tuned according to your RT requirements.
Yes I saw that.


>=20
>> Also my cpu is quite slow (compared to last intel core or powerpc). =
=46or=20
>> example a sched_jitter run take 6s.
>=20
>   Ouch! What's your CPU (core type, clock speed)?
Arm926 ~104.65 Mhz

Thanks,

Matthieu

[1]
#define __arch_compare_and_exchange_val_32_acq(mem, newval, oldval) \
   ({ register __typeof (oldval) a_oldval asm ("r0");=20
        \
      register __typeof (oldval) a_newval asm ("r1") =3D (newval);=20
        \
      register __typeof (mem) a_ptr asm ("r2") =3D (mem);=20
        \
      register __typeof (oldval) a_tmp asm ("r3");=20
        \
      register __typeof (oldval) a_oldval2 asm ("r4") =3D (oldval);=20
        \
      __asm__ __volatile__=20
        \
              ("0:\tldr\t%[tmp],[%[ptr]]\n\t"=20
        \
               "cmp\t%[tmp], %[old2]\n\t"=20
        \
               "bne\t1f\n\t"=20
        \
               "mov\t%[old], %[old2]\n\t"=20
        \
               "mov\t%[tmp], #0xffff0fff\n\t"=20
        \
               "mov\tlr, pc\n\t"=20
        \
               "add\tpc, %[tmp], #(0xffff0fc0 - 0xffff0fff)\n\t"=20
        \
               "bcc\t0b\n\t"=20
        \
               "mov\t%[tmp], %[old2]\n\t"=20
        \
               "1:"=20
        \
               : [old] "=3D&r" (a_oldval), [tmp] "=3D&r" (a_tmp)=20
        \
               : [new] "r" (a_newval), [ptr] "r" (a_ptr),=20
        \
                 [old2] "r" (a_oldval2)=20
        \
               : "ip", "lr", "cc", "memory");=20
        \
      a_tmp; })
	do {
		int oldval =3D v->counter;
		int ret;
		ret =3D __arch_compare_and_exchange_val_32_acq(&v->counter, oldval+i,=
=20
oldval);
	} while (ret !=3D oldval);
	return oldval;
