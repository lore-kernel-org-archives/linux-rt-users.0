From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: i.MX28 milliseconds latencies, interrupts disabled in arch_cpu_idle?
Date: Sat, 19 Apr 2014 12:36:07 +0200
Message-ID: <53525197.5040904@xenomai.org>
References: <53503BD8.8000506@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Stanislav Meduna <stano@meduna.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from sd-51317.dedibox.fr ([62.210.215.82]:60493 "EHLO
	sd-51317.dedibox.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043AbaDSKvs (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 19 Apr 2014 06:51:48 -0400
In-Reply-To: <53503BD8.8000506@meduna.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Le 17/04/2014 22:38, Stanislav Meduna a =C3=A9crit :
> Hi,
>=20
> on a i.MX28:
>=20
> Linux nxt 3.12.15-rt25+ #83 PREEMPT RT Thu Apr 17 20:54:00 CEST 2014 =
armv5tejl GNU/Linux
>
> (...)
>
> Maybe it is just some tracing infrastructure interference - the effec=
t
> of enabling the tracing is huge on this platform for some reason.
> Just enabling the irqsoff tracing makes the machine unsuitable
> for any serious load.

=46or the record, latencies on imx28 are high because:
1- it has an arm926 core, which uses a VIVT cache, and Linux chooses to
flush cache at each mm switch to avoid aliasing issues;
2- the arm926 idle routine, in order to work around a hardware bug
flushes the instruction cache before calling the "wfi" instruction.

#2 can be avoided by using nohlt
#1 can be avoided by using the ARM FCSE extension.

A patch exists for #1 which is currently integrated into the Adeos patc=
h
but could exist independently. I could post the patch here for Linux
vanilla here if there is enough interest, and let you do the merge with
the preempt_rt patch.

Regards.

--=20
Gilles.
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
