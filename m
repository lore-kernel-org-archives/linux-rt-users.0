From: =?UTF-8?B?TmVib2rFoWEgxIZvc2nEhw==?= <nebojsa@asnn.org>
Subject: Re: e1000e 82574L transmit latency?
Date: Tue, 28 May 2013 16:15:58 +0200
Message-ID: <20130528161558.4832d9ba@sth491dt.servo.net>
References: <51A4A6F7.5090909@meduna.org>
	<20130528150135.41a6d6fb@sth491dt.servo.net>
	<51A4B9AD.3060209@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Stanislav Meduna <stano@meduna.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay-b31.telenor.se ([213.150.131.20]:49604 "EHLO
	smtprelay-b31.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933890Ab3E1OQE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 28 May 2013 10:16:04 -0400
Received: from ipb2.telenor.se (ipb2.telenor.se [195.54.127.165])
	by smtprelay-b31.telenor.se (Postfix) with ESMTP id 464B5E9E59
	for <linux-rt-users@vger.kernel.org>; Tue, 28 May 2013 16:16:00 +0200 (CEST)
In-Reply-To: <51A4B9AD.3060209@meduna.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

=D0=94=D0=B0=D0=BD=D0=B0 Tue, 28 May 2013 16:05:33 +0200
Stanislav Meduna <stano@meduna.org> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=
:

> On 28.05.2013 15:01, Neboj=C5=A1a =C4=86osi=C4=87 wrote:
>=20
> > Check
> > http://article.gmane.org/gmane.linux.rt.user/10163 for details
>=20
> Anyway, could you publish the patch? What do you mean
> by "effectively disabling queuing" - that the sending threads
> will wait until the packet is out or that to-be-queued
> packets are thrown away?
>=20
> Thanks
Sending threads are going to sleep on mutex, instead of just passing by
and leaving packets in tx queue for later sending.

Patch is very simple - just comment out spin_* and HARD_TX_* calls in
sch_direct_xmit()


--=20
Neboj=C5=A1a
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
