From: =?ISO-8859-1?Q?Jo=EBl_Kr=E4hemann?= <joel@weedlight.ch>
Subject: Re: BUG - pthread conditional locks and barriers not reliable
Date: Fri, 29 Mar 2013 02:49:38 +0100
Message-ID: <1364521778.8491.4.camel@debian>
References: <1364458931.4931.8.camel@debian>
	 <1364520685.8268.2.camel@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from kraehem2.nine.ch ([178.209.44.180]:35769 "EHLO kraehem2"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754417Ab3C2Btf (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 28 Mar 2013 21:49:35 -0400
In-Reply-To: <1364520685.8268.2.camel@debian>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi, finished with euphoria. It's an issue with pthread implementation
may be you have to extend kernel API to fix this problem. You can't wra=
p
pthread_barrier_wait with pthread_mutex_lock and pthread_mutex_unlock
because it has a race condition what ends probably in a deadlock.

cu
Jo=C3=ABl

Am Freitag, den 29.03.2013, 02:31 +0100 schrieb Jo=C3=ABl Kr=C3=A4heman=
n:
> Hi, just ignore the spam it was just a programming mistake.
>=20
> Am Donnerstag, den 28.03.2013, 09:22 +0100 schrieb Jo=C3=ABl Kr=C3=A4=
hemann:
> > Hi, I believe that pthread conditional locks and barriers aren't
> > reliable. May be it's a problem with the kernel I just downloaded l=
ibc6
> > to get an entry point.
> >=20
> > The code is located at: sf.org/p/ags
> > affected files: src/ags/audio/ags_devout.c
> >=20
> > I've attached the output of lspci and lscpu.
> >=20
> >=20
> > cu
> > Jo=C3=ABl
> >=20
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
