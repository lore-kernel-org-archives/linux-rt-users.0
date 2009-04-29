From: GeunSik Lim <leemgs1@gmail.com>
Subject: Re: [PATCH] cyclictest: Remove duplicated description of
	cyclictest usage like -h.
Date: Wed, 29 Apr 2009 11:14:00 +0900
Message-ID: <1240971240.30137.66.camel@centos51>
References: <1240298935.30137.33.camel@centos51>
	 <1240532011.30137.48.camel@centos51>
Reply-To: leemgs1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=euckr
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tglx@linutronix.de, linux-rt-users@vger.kernel.org
To: williams@redhat.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:9814 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755162AbZD2COJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 28 Apr 2009 22:14:09 -0400
Received: by yx-out-2324.google.com with SMTP id 3so538750yxj.1
        for <linux-rt-users@vger.kernel.org>; Tue, 28 Apr 2009 19:14:08 -0700 (PDT)
In-Reply-To: <1240532011.30137.48.camel@centos51>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi All,

Anyone have opinion about below contents that I sent previously?
I want to discuss and fix about duplicated description of -h option=20
after "#> cyclictest --help"command.=20

If I mistake , Correct me.=20
Thanks Reading.=20


Regards,
GeunSik , Lim

2009-04-24 (Fri), 09:13 +0900, GeunSik Lim wrote:
> Dear Clark Williams,
>=20
> I submitted trivial patch about "cyclictest --help" command.
> Can you check patch about duplication display about "-h" option of
> "cyclictest --help" command?
>=20
> for example,
> #> cyclictest --help [enter]
>  -h H_MAX                   latency histogram size in us default 0 (o=
ff)
>  -h       --histogram=3DUS    dump a latency histogram to stdout afte=
r the run
>                             US is the max time to be be tracked in mi=
croseconds
>=20
>=20
>=20
> Thanks reading.
>=20
>=20
>=20
> Regards,
> GeunSik Lim,
>=20
>=20
> 2009-04-21 (=C8=AD), 16:29 +0900, GeunSik Lim =BE=B2=BD=C3=B1=E6:
> > Author: Lim,GeunSik <leemgs1@gmail.com>
> > Date:   Tue Apr 21 16:03:56 2009 +0900
> >=20
> >     [PATCH] cyclictest: Remove duplicated description of cyclictest=
 usage like -h.
> >    =20
> >     We often utilize a various options with "#>cyclictest --help" c=
ommand in the terminal environment.
> >     When We run "#> cyclictest --help" command, We can show duplica=
ted description about "-h" option
> >     for latency histogram.
> >     Unfortunatley, Some of the users is confusing because of two op=
tions about latency histogram.
> >    =20
> >     [root@fedora9 invain]# ./cyclictest --help
> >     cyclictest V 0.36
> >     Usage:
> >     cyclictest <options>
> >    =20
> >     -a [NUM] --affinity        run thread #N on processor #N, if po=
ssible
> >                                with NUM pin all threads to the proc=
essor NUM
> >     -b USEC  --breaktrace=3DUSEC send break trace command when late=
ncy > USEC
> >     -B       --preemptirqs     both preempt and irqsoff tracing (us=
ed with -b)
> >     -c CLOCK --clock=3DCLOCK     select clock
> >                                0 =3D CLOCK_MONOTONIC (default)
> >                                1 =3D CLOCK_REALTIME
> >     -C       --context         context switch tracing (used with -b=
)
> >     -d DIST  --distance=3DDIST   distance of thread intervals in us=
 default=3D500
> >     -E       --event           event tracing (used with -b)
> >     -f       --ftrace          function trace (when -b is active)
> >     -h H_MAX                   latency histogram size in us default=
 0 (off)
> >     -i INTV  --interval=3DINTV   base interval of thread in us defa=
ult=3D1000
> >    =20
> >          ................. [Middle Omission] ...................
> >    =20
> >     -v       --verbose         output values on stdout for statisti=
cs
> >                                format: n:c:v n=3Dtasknum c=3Dcount =
v=3Dvalue in us
> >     -D       --duration=3Dt      specify a length for the test run
> >                                default is in seconds, but 'm', 'h',=
 or 'd' maybe added
> >                                to modify value to minutes, hours or=
 days
> >     -h       --histogram=3DUS    dump a latency histogram to stdout=
 after the run
> >                                US is the max time to be be tracked =
in microseconds
> >    =20
> >     For example,
> >    =20
> >     -h H_MAX                   latency histogram size in us default=
 0 (off)
> >    =20
> >     -h       --histogram=3DUS    dump a latency histogram to stdout=
 after the run
> >                                US is the max time to be be tracked =
in microseconds
> >=20
> >     As you see, We don't need "-h H_MAX  . . . . . ." description. =
  =20
> >     So, I think that We have to remove old option about description=
 of histogram function.
> >    =20
> >     Signed-off-by: GeunSik Lim <leemgs1@gmail.com>
> > ---
> >  src/cyclictest/cyclictest.c |    1 -
> >  1 files changed, 0 insertions(+), 1 deletions(-)
> >=20
> > diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictes=
t.c
> > index 1660893..884f2c3 100644
> > --- a/src/cyclictest/cyclictest.c
> > +++ b/src/cyclictest/cyclictest.c
> > @@ -688,7 +688,6 @@ static void display_help(void)
> >  	       "-d DIST  --distance=3DDIST   distance of thread intervals=
 in us default=3D500\n"
> >  	       "-E       --event           event tracing (used with -b)\n=
"
> >  	       "-f       --ftrace          function trace (when -b is act=
ive)\n"
> > -	       "-h H_MAX                   latency histogram size in us d=
efault 0 (off)\n"
> >  	       "-i INTV  --interval=3DINTV   base interval of thread in u=
s default=3D1000\n"
> >  	       "-I       --irqsoff         Irqsoff tracing (used with -b)=
\n"
> >  	       "-l LOOPS --loops=3DLOOPS     number of loops: default=3D0=
(endless)\n"
> >=20
> >=20
> > -----------------------------------------------
> > To unsubscribe from this list: send the line "unsubscribe linux-***=
"=20
> > in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >=20
> > GeunSik Lim (ELS - OS Group - S/W Lab - SAIT - SAMSUNG)
> > e-Mail  :1) geunsik.lim@samsung.com
> >          2) leemgs@gmail.com , leemgs1@gmail.com
> > HomePage: http://intomail.dnip.net/invain/me/
> > -----------------------------------------------
--=20
-----------------------------------------------
To unsubscribe from this list: send the line "unsubscribe linux-***"=20
in the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

GeunSik Lim (ELS - OS Group - S/W Lab - SAIT - SAMSUNG)
e-Mail  :1) geunsik.lim@samsung.com
         2) leemgs@gmail.com , leemgs1@gmail.com
HomePage: http://intomail.dnip.net/invain/me/
-----------------------------------------------

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
