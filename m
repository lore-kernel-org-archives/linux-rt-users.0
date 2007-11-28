From: "Peter W. Morreale" <pmorreale@novell.com>
Subject: Re: rt mutex priority boost
Date: Wed, 28 Nov 2007 07:34:31 -0700
Message-ID: <1196260471.4078.200.camel@hermosa.morrealenet>
References: <1196257876.4078.195.camel@hermosa.morrealenet>
	 <200711281413.31140.lhenriques@netvisao.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: =?ISO-8859-1?Q?Lu=EDs?= Henriques <lhenriques@netvisao.pt>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:38813 "EHLO
	victor.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754170AbXK1Ojy (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 28 Nov 2007 09:39:54 -0500
In-Reply-To: <200711281413.31140.lhenriques@netvisao.pt>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2007-11-28 at 14:13 +0000, Lu=C3=ADs Henriques wrote:
> Hi!  Just my 5 cents (or even less!)...

>=20
> I am not very familiar with PI-related code but I believe that at lea=
st your=20
> 1st assumption is not correct, i.e., the number of boost and unboost =
is not=20
> necessarily equal.  If you have, for example, a task which priority i=
s boost=20
> several times in a row (without releasing the resource), it will only=
 unboost=20
> once -- when the resource is released.  Thus, the boost/unboost relat=
ion is=20
> not one-to-one but many-to-one ;)
>=20

Well of course!  That makes perfect sense.  =20



Thx,
-PWM

> Note again that I am not very familiar with this code but I believe t=
his is=20
> the default behaviour of the kernel.
>=20
> Hope this helps you understand the problem...
> --=20
> Lu=C3=ADs Henriques
>=20
> > My expectation would be that all three counters would be more or le=
ss
> > the same.  Further, that we would only boost non-RT tasks in conten=
tion
> > with an RT task.  Is that a wrong assumption?  The code seems to im=
ply
> > that we boost anyone.
> >
> > The samples were taken after a reboot followed by a 'make' in an al=
ready
> > built kernel tree.  The counts (gradually) grow in this proportion =
as
> > time/load passes.  They are currently low due to the reboot.
> >
> > What got me started on this path was noticing the context switch co=
unts
> > go extremely high with the addition of a single process.  Here is t=
he
> > output of a silly little program I wrote that reads /proc/stat and =
calcs
> > context-switches/second:
> >
> > prev:    1990167, current:    1992750, diff:        516/s
> > prev:    1992755, current:    1994567, diff:        362/s
> > prev:    1994569, current:    1997847, diff:        655/s
> > prev:    1997849, current:    2011904, diff:       2811/s # make st=
art
> > prev:    2011913, current:    2041192, diff:       5855/s
> > prev:    2041194, current:    2074749, diff:       6711/s
> > prev:    2074752, current:    2107060, diff:       6461/s
> > prev:    2107065, current:    2139376, diff:       6462/s
> > prev:    2139378, current:    2164268, diff:       4978/s # make ki=
lled
> > prev:    2164274, current:    2166674, diff:        480/s
> > prev:    2166676, current:    2168187, diff:        302/s
> > prev:    2168189, current:    2169576, diff:        277/s
> >
> > Factor of 10x for a single make (no -j) on an otherwise idle system=
=2E
> > Again, this was on an already built kernel tree and taken shortly a=
fter
> > the a previous make invocation (implying the caches should be warm)=
=2E
> > Since I'm hitting on the dcache and inode spin locks (that are now
> > rt_spin_locks) and only contending with other system processes (sys=
log,
> > etc) I'm at a loss attempting to understand why the dramatic increa=
se in
> > the context switch rate.
> >
> > Any insights appreciated....
> >
> > Thx,
> > -PWM
> >
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-rt-=
users"
> > in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> -
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
