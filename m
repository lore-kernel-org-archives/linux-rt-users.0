From: Carsten Emde <C.Emde@osadl.org>
Subject: Re: [PATCH 1/1] ARM mm: Fix RT life lock on ASID rollover
Date: Wed, 05 Jun 2013 13:04:39 +0200
Message-ID: <51AF1B47.9010407@osadl.org>
References: <20130604211255.861340476@osadl.org> <20130604212217.241724859@osadl.org> <20130605101725.GC8577@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: RT-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>
To: Will Deacon <will.deacon@arm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:56813 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751803Ab3FELMQ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Jun 2013 07:12:16 -0400
In-Reply-To: <20130605101725.GC8577@mudshark.cambridge.arm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Will,

>> The original mechanism to synchronize all online CPUs after ASID
>> reallocation used an IPI mechanism with IRQs enabled. This is a vali=
d
>> mechanism in mainline. An RT kernel, however, may hang forever due t=
o a
>> life lock between sending the IPI and waiting for the ASID lock to b=
e
>> freed. Such hangers were observed and analyzed using JTAG hardware
>> debugging on an OMAP4430 board. Mean uptime was about two days with =
a
>> maximum of seven days observed once.
>>
>> In 2012, Will Deacon provided a new ASID rollover synchronization
>> mechanism without IPI broadcasting. This *improved* a suboptimal
>> implementation in mainline - but it *fixed* a disastrous bug in RT
>> kernels that was extremely hard to decode.
>
> Ha, that's a nice and unanticipated side-effect :)
Yeah, thanks a lot for fixing it.

> [..]
> You seem to have a few extra bits and pieces in here, which you might=
 not
> care about:
Was a long way from current mainline back to a 3.0 vendor kernel mess -=
=20
so I used a shortcut that obviously picked up some more code than neede=
d.

>> Index: linux-3.0.80-rt108/arch/arm/include/asm/tlbflush.h
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- linux-3.0.80-rt108.orig/arch/arm/include/asm/tlbflush.h
>> +++ linux-3.0.80-rt108/arch/arm/include/asm/tlbflush.h
>> @@ -14,7 +14,6 @@
>>
>>   #include <asm/glue.h>
>>
>> -#define TLB_V3_PAGE    (1 << 0)
>>   #define TLB_V4_U_PAGE  (1 << 1)
>>   #define TLB_V4_D_PAGE  (1 << 2)
>>   #define TLB_V4_I_PAGE  (1 << 3)
>> @@ -22,7 +21,6 @@
>>   #define TLB_V6_D_PAGE  (1 << 5)
>>   #define TLB_V6_I_PAGE  (1 << 6)
>>
>> -#define TLB_V3_FULL    (1 << 8)
>>   #define TLB_V4_U_FULL  (1 << 9)
>>   #define TLB_V4_D_FULL  (1 << 10)
>>   #define TLB_V4_I_FULL  (1 << 11)
>> @@ -34,16 +32,15 @@
>>   #define TLB_V6_D_ASID  (1 << 17)
>>   #define TLB_V6_I_ASID  (1 << 18)
>>
>> -#define TLB_BTB                (1 << 28)
>> +#define TLB_V6_BP      (1 << 19)
>
> This hunk (and related ones) are from a patch adding branch predictor
> maintenance that I also wrote. It's harmless, but you likely don't ne=
ed
> it.
OK, will check.

>> +#ifdef CONFIG_ARM_ERRATA_798181
>> +static inline void dummy_flush_tlb_a15_erratum(void)
>> +{
>> +       /*
>> +        * Dummy TLBIMVAIS. Using the unmapped address 0 and ASID 0.
>> +        */
>> +       asm("mcr p15, 0, %0, c8, c3, 1" : : "r" (0));
>> +       dsb();
>> +}
>> +#else
>> +static inline void dummy_flush_tlb_a15_erratum(void)
>> +{
>> +}
>> +#endif
>
> And this is an A15 erratum workaround from Catalin. Actually, the ori=
ginal
> version of that workaround didn't interact nicely with PREEMPT kernel=
s, so
> you should double-check what you've got (it was fixed recently in mai=
nline).
>
> Furthermore, the workaround requires IPIs on TLB invalidation, so you=
 might
> have your livelock problem again...
Hmm, will check as well.

>>   /*
>> Index: linux-3.0.80-rt108/arch/arm/mm/alignment.c
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- linux-3.0.80-rt108.orig/arch/arm/mm/alignment.c
>> +++ linux-3.0.80-rt108/arch/arm/mm/alignment.c
>> @@ -819,6 +819,7 @@ do_alignment(unsigned long addr, unsigne
>>                  break;
>>
>>          case 0x08000000:        /* ldm or stm, or thumb-2 32bit ins=
truction */
>> +               offset.un =3D 0;
>>                  if (thumb2_32b)
>>                          handler =3D do_alignment_t32_to_handler(&in=
str, regs, &offset);
>>                  else
> Unrelated?
This fixes a compiler warning:
   CC      arch/arm/mm/alignment.o
arch/arm/mm/alignment.c: In function =91do_alignment=92:
arch/arm/mm/alignment.c:327:15: warning: =91offset.un=92 may be used=20
uninitialized in this function [-Wuninitialized]
arch/arm/mm/alignment.c:749:21: note: =91offset.un=92 was declared here

Should have gone into a separate patch.

Thanks,
	-Carsten.
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
