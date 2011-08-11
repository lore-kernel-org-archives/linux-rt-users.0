From: "Tim Sander" <tim.sander@hbm.com>
Subject: Re: [ANNOUNCE] 3.0.1-rt8 - Regression to 3.0-rt7
Date: Thu, 11 Aug 2011 17:28:29 +0200
Message-ID: <201108111728.29405.tim.sander@hbm.com>
References: <1312580681.28695.44.camel@twins> <201108111330.28168.tim.sander@hbm.com> <1313064142.7144.1.camel@twins>
Mime-Version: 1.0
Content-Type: text/Plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>,
	"Thomas Gleixner" <tglx@linutronix.de>,
	"Paul E. McKenney" <paulmck@us.ibm.com>,
	"linux-rt-users" <linux-rt-users@vger.kernel.org>
To: "Peter Zijlstra" <peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway.hbm.com ([213.157.30.2]:8858 "EHLO hbmntx5.hbm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751096Ab1HKP2p convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Aug 2011 11:28:45 -0400
Content-class: urn:content-classes:message
In-Reply-To: <1313064142.7144.1.camel@twins>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Peter
> Does the below (on top of -rt8) cure things for you? Shouldn't make a
> difference for PREEMPT_LL though, so maybe there's something else bus=
ted
> as well. But from what I can tell PREEMPT_BASE should be fine with su=
ch
> things disabling preemption..
>=20
> ---
> Index: linux-2.6/include/linux/uaccess.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/include/linux/uaccess.h
> +++ linux-2.6/include/linux/uaccess.h
> @@ -22,7 +22,7 @@ static inline void raw_pagefault_enable(
>  	preempt_check_resched();
>  }
>=20
> -#ifndef CONFIG_PREEMPT_RT_FULL
> +#ifndef CONFIG_PREEMPT_RT_BASE
>  static inline void pagefault_disable(void)
>  {
>  	raw_pagefault_disable();
> Index: linux-2.6/mm/memory.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/mm/memory.c
> +++ linux-2.6/mm/memory.c
> @@ -3438,7 +3438,7 @@ int handle_pte_fault(struct mm_struct *m
>  	return 0;
>  }
>=20
> -#ifdef CONFIG_PREEMPT_RT_FULL
> +#ifdef CONFIG_PREEMPT_RT_BASE
>  void pagefault_disable(void)
>  {
>  	migrate_disable();
The patch fixes the problem for CONFIG_PREEMPT_RTB but not for=20
CONFIG_PREEMPT_LL. With the latter the error is still there.

Thanks
Tim

Hottinger Baldwin Messtechnik GmbH, Im Tiefen See 45, 64293 Darmstadt, =
Germany | www.hbm.com=20

Registered as GmbH (German limited liability corporation) in the commer=
cial register at the local court of Darmstadt, HRB 1147 =20
Company domiciled in Darmstadt | CEO: Andreas Huellhorst | Chairman of =
the board: James Charles Webster

Als Gesellschaft mit beschraenkter Haftung eingetragen im Handelsregist=
er des Amtsgerichts Darmstadt unter HRB 1147=20
Sitz der Gesellschaft: Darmstadt | Geschaeftsfuehrung: Andreas Huellhor=
st | Aufsichtsratsvorsitzender: James Charles Webster

The information in this email is confidential. It is intended solely fo=
r the addressee. If you are not the intended recipient, please let me k=
now and delete this email.

Die in dieser E-Mail enthaltene Information ist vertraulich und ledigli=
ch f=C3=BCr den Empfaenger bestimmt. Sollten Sie nicht der eigentliche =
Empfaenger sein, informieren Sie mich bitte kurz und loeschen diese E-M=
ail.

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
