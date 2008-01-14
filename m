From: "Gregory Haskins" <ghaskins@novell.com>
Subject: Re: 2.6.24-rc7-rt1
Date: Mon, 14 Jan 2008 07:13:00 -0500
Message-ID: <478B0B7C.BA47.005A.0@novell.com>
References: <1200250801.9190.7.camel@localhost.localdomain>
 <200801132143.34889.m.kozlowski@tuxland.pl>
 <Pine.LNX.4.58.0801131552350.10093@gandalf.stny.rr.com>
 <1200299260.4665.17.camel@homer.simson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Ingo Molnar" <mingo@elte.hu>,
	"Thomas Gleixner" <tglx@linutronix.de>,
	"Mariusz Kozlowski" <m.kozlowski@tuxland.pl>,
	"LKML" <linux-kernel@vger.kernel.org>,
	"RT" <linux-rt-users@vger.kernel.org>
To: "Mike Galbraith" <efault@gmx.de>,
	"Steven Rostedt" <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mcclure-nat.wal.novell.com ([130.57.22.22]:36900 "EHLO
	mcclure.wal.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751296AbYANMTJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Jan 2008 07:19:09 -0500
In-Reply-To: <1200299260.4665.17.camel@homer.simson.net>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>>> On Mon, Jan 14, 2008 at  3:27 AM, in message
<1200299260.4665.17.camel@homer.simson.net>, Mike Galbraith <efault@gmx=
=2Ede>
wrote:=20

> On Sun, 2008-01-13 at 15:54 -0500, Steven Rostedt wrote:
>=20
>> OK, -rt2 will take a bit more beating from me before I release it, s=
o it
>> might take some time to get it out (expect it out on Monday).
>=20
> Ah, that reminds me (tests, yup) I still need the patchlet below to
> resume from ram without black screen of death.

I had forgotten about this issue over the holidays...Sorry Mike.

So does that BUG_ON trip if you remove the first hunk?

> No idea why my P4 box
> seems to be the only box in the rt galaxy affected.  (haven't poked a=
t
> it since the holidays)
>=20
> Index: linux-2.6.24.git-rt1/kernel/sched_rt.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.24.git-rt1.orig/kernel/sched_rt.c
> +++ linux-2.6.24.git-rt1/kernel/sched_rt.c
> @@ -33,6 +33,9 @@ static inline void rt_clear_overload(str
> =20
>  static void update_rt_migration(struct rq *rq)
>  {
> +	if (unlikely(num_online_cpus() =3D=3D 1))
> +		return;
> +
>  	if (rq->rt.rt_nr_migratory && (rq->rt.rt_nr_running > 1)) {
>  		if (!rq->rt.overloaded) {
>  			rt_set_overload(rq);
> @@ -105,8 +108,10 @@ static inline void dec_rt_tasks(struct t
>  		} /* otherwise leave rq->highest prio alone */
>  	} else
>  		rq->rt.highest_prio =3D MAX_RT_PRIO;
> -	if (p->nr_cpus_allowed > 1)
> +	if (p->nr_cpus_allowed > 1) {
> +		BUG_ON(!rq->rt.rt_nr_migratory);
>  		rq->rt.rt_nr_migratory--;
> +	}
> =20
>  	if (rq->rt.highest_prio !=3D highest_prio)
>  		cpupri_set(&rq->rd->cpupri, rq->cpu, rq->rt.highest_prio);
>=20
>=20
> btw, CONFIG_INTEL_IOATDMA compile booboo
>=20
>   CC      drivers/dma/ioat_dma.o
> drivers/dma/ioat_dma.c: In function =E2=80=98ioat1_tx_submit=E2=80=99=
:
> drivers/dma/ioat_dma.c:300: error: too few arguments to function=20
> =E2=80=98__list_splice=E2=80=99
> make[2]: *** [drivers/dma/ioat_dma.o] Error 1
>=20
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
