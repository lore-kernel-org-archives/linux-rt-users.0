From: "Madovsky" <infos@madovsky.org>
Subject: Re: [solved] Kernel module crashed in 2.6.33.7-rt30
Date: Fri, 28 Jan 2011 12:07:02 -0500
Message-ID: <BFED3D3EBB8D49D2917ACB9D3714378D@e1705>
References: <1295941160.4853.0.camel@vikram-pc> <20110125162136.GD22005@pengutronix.de> <AANLkTikQW6mkV_a6umKY0NnoinD-UnJQK4Gm+kxuKfCa@mail.gmail.com> <20110127075904.GJ1147@pengutronix.de> <AANLkTinW4koreUTXS_ieXb9wGVUKhebTgLvkfEMP4O6y@mail.gmail.com> <AANLkTikceiY2yZHBkHbuhUs+mvRhAfHY2hMLmaXMmy=u@mail.gmail.com> <20110127092039.GK1147@pengutronix.de> <AANLkTimYnhQ_4+=PJogMts65iLsoNcE60NTdnfDwVtJx@mail.gmail.com> <20110128075725.GQ1147@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "linux-rt-users" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ip-67-205-80-138.static.privatedns.com ([67.205.80.138]:46714
	"EHLO node250.e-blokos.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752793Ab1A1RHF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 28 Jan 2011 12:07:05 -0500
Received: from e1705 (localhost.localdomain [127.0.0.1])
	by node250.e-blokos.com (8.14.3/8.14.3) with SMTP id p0SH7212015504
	for <linux-rt-users@vger.kernel.org>; Fri, 28 Jan 2011 12:07:03 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

are these options
	CONFIG_PROVE_LOCKING
	CONFIG_PROVE_RCU
	CONFIG_DEBUG_RT_MUTEXES:
useful on 64 bits ?I can't see these on my config kernelThanks----- Ori=
ginal=20
Message -----=20
=46rom: "Uwe Kleine-K=F6nig" <u.kleine-koenig@pengutronix.de>
To: "Vikram Narayanan" <vikram186@gmail.com>
Cc: <linux-rt-users@vger.kernel.org>
Sent: Friday, January 28, 2011 2:57 AM
Subject: [solved] Kernel module crashed in 2.6.33.7-rt30


> Hello,
>
> [just informing the ml about your issue being solved.]
>
> On Fri, Jan 28, 2011 at 12:08:46PM +0530, Vikram Narayanan wrote:
>> Thanks a lot, I enabled this option. The problem was on having an=20
>> unbalanced
>> spin lock. Now it is resolved. :)
>> Thanks you so much.
>
> --=20
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig      =
      |
> Industrial Linux Solutions                 | http://www.pengutronix.d=
e/  |
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers"=20
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html=20

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
