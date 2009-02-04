From: Iratxo Pichel Ortiz <ipichel@albentia.com>
Subject: Re: Build error: 2.6.26.8-rt15 on ARM.
Date: Wed, 04 Feb 2009 15:10:07 +0100
Message-ID: <4989A1BF.6090606@albentia.com>
References: <49895AB1.2090205@albentia.com> <20090204101503.GB12738@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from llsd410-a04.servidoresdns.net ([82.223.190.35]:43290 "EHLO
	llsd410-a04.servidoresdns.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751682AbZBDOKM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 4 Feb 2009 09:10:12 -0500
In-Reply-To: <20090204101503.GB12738@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thanks!

Uwe Kleine-K=F6nig wrote:
> On Wed, Feb 04, 2009 at 10:06:57AM +0100, Iratxo Pichel Ortiz wrote:
>  =20
>> I think that I have found a built error on 2.6.26.8-rt15 on ARM (ixp=
4xx):
>>
>> Here (warning):
>>
>> In file included from kernel/trace/trace.c:37:
>> include/asm/asm-offsets.h:49:1: warning: "VM_EXEC" redefined
>> In file included from include/linux/pagemap.h:7,
>>                 from kernel/trace/trace.c:19:
>> include/linux/mm.h:77:1: warning: this is the location of the previo=
us =20
>> definition
>>    =20
> IIRC the resolution for that one was not to include both headers that
> define VM_EXEC.  Try searching the archives of linux-arm-kernel ML.
>
>  =20
>> And here (error):
>>
>> kernel/trace/trace.c: In function 'trace_die_handler':
>> kernel/trace/trace.c:3588: error: 'DIE_OOPS' undeclared (first use i=
n =20
>> this function)
>> kernel/trace/trace.c:3588: error: (Each undeclared identifier is =20
>> reported only once
>> kernel/trace/trace.c:3588: error: for each function it appears in.)
>> make[2]: *** [kernel/trace/trace.o] Error 1
>> make[1]: *** [kernel/trace] Error 2
>> make: *** [kernel] Error 2
>>    =20
> There is a fix already upstream: v2.6.28-rc2-29-g5209f08.  Try
> cherry-picking.
>
> Best regards
> Uwe
>
>  =20


--=20
Iratxo Pichel Ortiz
Software Development Manager

Albentia Systems S.A.
http://www.albentia.com

Tel: +34 914400567
Cel: +34 663808405
=46ax: +34 914400569

C\Margarita Salas 22
Parque Tecnol=F3gico de Legan=E9s
Legan=E9s (28918)
Madrid
Spain

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
