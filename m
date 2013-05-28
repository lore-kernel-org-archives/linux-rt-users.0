From: =?UTF-8?B?TmVib2rFoWEgxIZvc2nEhw==?= <nebojsa@asnn.org>
Subject: Re: e1000e 82574L transmit latency?
Date: Tue, 28 May 2013 15:01:35 +0200
Message-ID: <20130528150135.41a6d6fb@sth491dt.servo.net>
References: <51A4A6F7.5090909@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Stanislav Meduna <stano@meduna.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay-b22.telenor.se ([195.54.99.213]:33834 "EHLO
	smtprelay-b22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933919Ab3E1NBs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 28 May 2013 09:01:48 -0400
Received: from ipb3.telenor.se (ipb3.telenor.se [195.54.127.166])
	by smtprelay-b22.telenor.se (Postfix) with ESMTP id C2187EA3DC
	for <linux-rt-users@vger.kernel.org>; Tue, 28 May 2013 15:01:46 +0200 (CEST)
In-Reply-To: <51A4A6F7.5090909@meduna.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


> Hi,
>=20
> anyone has experience / knows of bugs (not the ASPM one) causing
> high (at least 70 ms) latency on Intel 82574L using the e1000e driver=
?
>=20
> We have an instance of a connected device needing to be serviced
> each 100 ms reporting a timeout while our internal measurements
> show that the packets were given to the kernel max 30 ms apart.
>=20
> These are raw packets, there is no other traffic on that interface,
> no kernel messages, no errors in the /sys/class/net/eth1/statistics/*
> and it happened after 5 days of uptime :/
>=20
> I am using kernel 3.4 with RT PREEMPT - I note that the driver versio=
n
> there is 1.9.5 while in 3.9 it is 2.2.14. Anyone knows if the network
> drivers are back-portable without much hassle that far
> or whether this is a complicated task?
>=20
> e1000-devel: please Cc: me when replying, I am not subscribed
> to the list.
>=20
> Thanks

If you are having several processes/threads with different priorities
sending on same eth, combined with high cpu load on RT processes, than
it sounds a lot like a problem I had: Check
http://article.gmane.org/gmane.linux.rt.user/10163 for details

--=20
Neboj=C5=A1a
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
