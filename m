From: =?utf-8?q?Philipp_=C3=9Cberbacher?= <hollunder@lavabit.com>
Subject: Re: future of -rt kernels for realtime audio
Date: Tue, 06 Jul 2010 21:53:37 +0200
Message-ID: <1278444945-sup-9886@eris>
References: <AANLkTikZNjYJnDM6iKgrT1230FP8DSMgHUrZz2lYL4ll@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from karen.lavabit.com ([72.249.41.33]:47450 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754628Ab0GFTxq (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Jul 2010 15:53:46 -0400
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 302FC157557
	for <linux-rt-users@vger.kernel.org>; Tue,  6 Jul 2010 14:53:44 -0500 (CDT)
Received: from localhost (eris.mozart.uni-klu.ac.at [143.205.216.185])
	by lavabit.com with ESMTP id 9HSAS4NMC522
	for <linux-rt-users@vger.kernel.org>; Tue, 06 Jul 2010 14:53:40 -0500
In-reply-to: <AANLkTikZNjYJnDM6iKgrT1230FP8DSMgHUrZz2lYL4ll@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Excerpts from Pedro Ribeiro's message of 2010-07-06 13:19:31 +0200:
> Hi,
>=20
> I've been using -rt kernels since 2.6.29 because I do realtime audio
> on my laptop.
>=20
> The audio stability has been steadily improving since, and now I find
> that I can use 2.6.34 without the -rt patch and achieve the same
> stability as 2.6.33-rt - well, my latency requirements aren't that
> high, I just need to maintain 8.9ms completely stable, however before
> .34 it would be impossible without the -rt patch.
>=20
> So out of curiosity, what changed for .34? According to [1], on .33
> Raw Spinlock Annotation was introduced in the mainline kernel.
> However, as said above, I can't get the same performance than with
> .34.
>=20
> I remember that I read somewhere that the one the biggest problems
> with latency requirements was the use of the BKL. Do you think there
> will be a significant improvement of latency (in specific cases of
> course) with the scheduled removal of BKL for 2.6.36?
>=20
> Thanks for the help,
> Pedro
>=20
> [1] http://www.osadl.org/Realtime-Linux.projects-realtime-linux.0.htm=
l

Ah, nice to hear that the BKL removal is scheduled. Pretty much all I
know is that Linus set the BKL removal as precondition for preempt-rt t=
o
be merged with mainline.
I guess this means that preempt-rt could disappear in some post-.36
version. I won't hold my breath.
Anyway, the stock kernel has been good for a while, but there are some
cases where I still experience big differences. Some, mostly audio
unrelated, actions or kinds of load cause lots of xruns with the stock
kernel and none with -rt. Prime example for me is xrandr, enable an
external monitor -> xruns, not so with -rt. There are a couple of other
cases. It's mostly about this kind of stuff, the achievable latency is
pretty much the same in my experience (which is only with an USB
interface).
--=20
Regards,
Philipp

--
"Wir stehen selbst entt=C3=A4uscht und sehn betroffen / Den Vorhang zu =
und alle Fragen offen." Bertolt Brecht, Der gute Mensch von Sezuan

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
