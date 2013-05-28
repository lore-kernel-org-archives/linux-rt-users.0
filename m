From: =?UTF-8?B?TmVib2rFoWEgxIZvc2nEhw==?= <nebojsa@asnn.org>
Subject: Re: e1000e 82574L transmit latency?
Date: Tue, 28 May 2013 16:09:07 +0200
Message-ID: <20130528160907.2d98fc65@sth491dt.servo.net>
References: <51A4A6F7.5090909@meduna.org>
	<20130528150135.41a6d6fb@sth491dt.servo.net>
	<51A4B5F9.6010206@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Stanislav Meduna <stano@meduna.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay-h22.telenor.se ([195.54.99.197]:33686 "EHLO
	smtprelay-h22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933933Ab3E1OJM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 28 May 2013 10:09:12 -0400
Received: from ipb5.telenor.se (ipb5.telenor.se [195.54.127.168])
	by smtprelay-h22.telenor.se (Postfix) with ESMTP id 9D4F7C07B
	for <linux-rt-users@vger.kernel.org>; Tue, 28 May 2013 16:09:10 +0200 (CEST)
In-Reply-To: <51A4B5F9.6010206@meduna.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

=D0=94=D0=B0=D0=BD=D0=B0 Tue, 28 May 2013 15:49:45 +0200
Stanislav Meduna <stano@meduna.org> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=
:

> On 28.05.2013 15:01, Neboj=C5=A1a =C4=86osi=C4=87 wrote:
>=20
> > If you are having several processes/threads with different prioriti=
es
> > sending on same eth, combined with high cpu load on RT processes, t=
han
> > it sounds a lot like a problem I had: Check
> > http://article.gmane.org/gmane.linux.rt.user/10163 for details
>=20
> Hm, interesting. However, there is just one thread sending on the
> interface and all threads with higher priority generally only run for
> brief intervals and do not do anything with ethernet. There are
> lower-prio threads doing full TCP/IP but they communivate on another
> interface (also a e100e one).
>=20
> Thanks
Well, I think it still applies. Lock which is responsible for this
problem is driver wise...
Lower prio thread can take driver lock, and thus delay higher thread
from accessing driver. It is enough that there are jobs with higher
prio than lowest prio tcp/ip sending thread, even if they have nothing
to do with network.

--=20
Neboj=C5=A1a
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
