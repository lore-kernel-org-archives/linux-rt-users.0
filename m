From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: Re: rt mutex priority boost
Date: Wed, 28 Nov 2007 13:34:29 -0800
Message-ID: <1196285669.12577.4.camel@sx.thebigcorporation.com>
References: <1196257876.4078.195.camel@hermosa.morrealenet>
	 <200711281413.31140.lhenriques@netvisao.pt>
	 <1196260471.4078.200.camel@hermosa.morrealenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Lu=EDs?= Henriques <lhenriques@netvisao.pt>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: "Peter W. Morreale" <pmorreale@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from qmta05.westchester.pa.mail.comcast.net ([76.96.62.48]:40851
	"EHLO QMTA05.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757866AbXK1WIH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 28 Nov 2007 17:08:07 -0500
In-Reply-To: <1196260471.4078.200.camel@hermosa.morrealenet>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2007-11-28 at 07:34 -0700, Peter W. Morreale wrote:
> On Wed, 2007-11-28 at 14:13 +0000, Lu=C3=ADs Henriques wrote:
> > Hi!  Just my 5 cents (or even less!)...
>=20
> >=20
> > I am not very familiar with PI-related code but I believe that at l=
east your=20
> > 1st assumption is not correct, i.e., the number of boost and unboos=
t is not=20
> > necessarily equal.  If you have, for example, a task which priority=
 is boost=20
> > several times in a row (without releasing the resource), it will on=
ly unboost=20
> > once -- when the resource is released.  Thus, the boost/unboost rel=
ation is=20
> > not one-to-one but many-to-one ;)
> >=20
>=20
> Well of course!  That makes perfect sense.  =20
>=20
>=20

If you only count the first boost for each task, then you should see a
1-1.

Sven
