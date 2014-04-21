From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: i.MX28 milliseconds latencies, interrupts disabled in arch_cpu_idle?
Date: Mon, 21 Apr 2014 12:09:28 +0200
Message-ID: <5354EE58.2060704@xenomai.org>
References: <53503BD8.8000506@meduna.org> <53525197.5040904@xenomai.org> <5354E0AE.2040702@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Stanislav Meduna <stano@meduna.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from sd-51317.dedibox.fr ([62.210.215.82]:38463 "EHLO
	sd-51317.dedibox.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362AbaDUKJd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 Apr 2014 06:09:33 -0400
In-Reply-To: <5354E0AE.2040702@meduna.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Le 21/04/2014 11:11, Stanislav Meduna a =C3=A9crit :
> On 19.04.2014 12:36, Gilles Chanteperdrix wrote:
>=20
>> #1 can be avoided by using the ARM FCSE extension.
>=20
> An interesting stuff, thanks for pointing this up.
>=20
>> A patch exists for #1 which is currently integrated into the Adeos p=
atch
>> but could exist independently. I could post the patch here for Linux
>> vanilla here if there is enough interest, and let you do the merge w=
ith
>> the preempt_rt patch.
>=20
> I am surely not skilled enough to merge and test this, but publishing
> the patch rebased to current kernels somewhere would be surely
> interesting.

The patch has been posted three times on the linux-arm-kernel mailing
list, and received absolutely no comments. So, it does not interest the
mainline ARM linux community. Besides armv5 cores are almost dead now.
However, it may interest the preempt_rt community, which is why I
propose to post it here. The gain in worst case latency is in the 70us
range. Merging with the preempt_rt patch should not be very difficult a=
s
normally, there is no reason for conflicts, the patch only touches ARM
memory management, which the preempt_rt patch probably does not touch.

--=20
Gilles.
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
