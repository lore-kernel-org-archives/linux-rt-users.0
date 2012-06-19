From: leroy christophe <christophe.leroy@c-s.fr>
Subject: Re: Oops during Init IRQ
Date: Tue, 19 Jun 2012 10:48:14 +0200
Message-ID: <4FE03CCE.8000603@c-s.fr>
References: <4FDF32DD.3010800@c-s.fr> <alpine.LFD.2.02.1206181949160.3086@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from pegase1.c-s.fr ([93.17.236.30]:17459 "EHLO mailhub1.si.c-s.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752586Ab2FSIsQ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 19 Jun 2012 04:48:16 -0400
In-Reply-To: <alpine.LFD.2.02.1206181949160.3086@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

Yes it does fix the issue.
Thanks a lot.

Shall I do anything to ask for this change to be included either in the=
=20
kernel or in the rt patch ?

Best regards
Christophe

Le 18/06/2012 19:53, Thomas Gleixner a =E9crit :
> On Mon, 18 Jun 2012, leroy christophe wrote:
>
>> Hello,
>>
>> I'm trying to use the rt10 patch on a 3.4.2 kernel on a powerpc (MPC=
8xx)
>> system, and I'm having the following Oops during Irq initialisation.=
 This
>> happens with CONFIG_PREEMPT_RT_FULL.
>> It doesn't happen with CONFIG_PREEMPT__LL
>>
>> May someone help ?
> Does the following uncompiled and untested patch fix it for you ?
>
> Thanks,
>
> 	tglx
>
>
> Index: linux-3.4/arch/powerpc/platforms/8xx/m8xx_setup.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-3.4.orig/arch/powerpc/platforms/8xx/m8xx_setup.c
> +++ linux-3.4/arch/powerpc/platforms/8xx/m8xx_setup.c
> @@ -43,6 +43,7 @@ static irqreturn_t timebase_interrupt(in
>  =20
>   static struct irqaction tbint_irqaction =3D {
>   	.handler =3D timebase_interrupt,
> +	.flags =3D IRQF_NO_THREAD,
>   	.name =3D "tbint",
>   };
>  =20
> Index: linux-3.4/arch/powerpc/sysdev/cpm1.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-3.4.orig/arch/powerpc/sysdev/cpm1.c
> +++ linux-3.4/arch/powerpc/sysdev/cpm1.c
> @@ -120,6 +120,7 @@ static irqreturn_t cpm_error_interrupt(i
>  =20
>   static struct irqaction cpm_error_irqaction =3D {
>   	.handler =3D cpm_error_interrupt,
> +	.flags =3D IRQF_NO_THREAD,
>   	.name =3D "error",
>   };
>  =20
>


--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
