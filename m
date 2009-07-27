From: =?ISO-8859-15?Q?Jens_D=F6ring?= <j.doering@systektum.de>
Subject: Re: geode-mfgpt oops 2.6.29.6-rt23
Date: Mon, 27 Jul 2009 09:52:19 +0200
Message-ID: <4A6D5CB3.4040306@systektum.de>
References: <4A65E556.4050007@systektum.de> <alpine.LFD.2.00.0907232215100.2936@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:65437 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754114AbZG0Hwf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 27 Jul 2009 03:52:35 -0400
In-Reply-To: <alpine.LFD.2.00.0907232215100.2936@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thomas Gleixner schrieb:
> On Tue, 21 Jul 2009, Jens D=F6ring wrote:
>
>  =20
>> I noticessed the following oops on 2.6.29.6 with -rt23 patch. withou=
t the
>> patch anything is fine.
>>    =20
>
>  =20
>> [    0.800000] BUG: unable to handle kernel NULL pointer dereference=
 at
>> 00000034
>> [    0.800000] IP: [<c0233d54>] tick_periodic+0x59/0x6d
>>    =20
>
> Does the patch below fix it ?
>
> Thanks,
>
> 	tglx
> -----
> Subject: geode-fix.patch
> From: Thomas Gleixner <tglx@linutronix.de>
> Date: Thu, 23 Jul 2009 22:12:40 +0200
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/kernel/mfgpt_32.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Index: linux-2.6-tip/arch/x86/kernel/mfgpt_32.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6-tip.orig/arch/x86/kernel/mfgpt_32.c
> +++ linux-2.6-tip/arch/x86/kernel/mfgpt_32.c
> @@ -347,7 +347,7 @@ static irqreturn_t mfgpt_tick(int irq, v
> =20
>  static struct irqaction mfgptirq  =3D {
>  	.handler =3D mfgpt_tick,
> -	.flags =3D IRQF_DISABLED | IRQF_NOBALANCING,
> +	.flags =3D IRQF_DISABLED | IRQF_NOBALANCING | IRQF_TIMER,
>  	.name =3D "mfgpt-timer"
>  };
> =20
Yes it does .

Thanks a lot.

Regards Jens

--=20

Mit freundlichen Gr=FC=DFen

Dipl.-Ing.(FH) Jens D=F6ring

SYSTEKTUM GmbH
Lise-Meitner-Stra=DFe 14


--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
