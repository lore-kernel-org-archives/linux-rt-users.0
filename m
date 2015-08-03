From: Clark Williams <williams@redhat.com>
Subject: Re: 1us latency?
Date: Mon, 3 Aug 2015 13:53:26 -0500
Message-ID: <20150803135326.3fd23809@sluggy>
References: <55BF4CD7.8000007@pavlinux.ru>
	<20150803114422.0efbea1b@sluggy>
	<55BFAC1C.9020508@pavlinux.ru>
	<55BFB4AA.4020901@pavlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux RT Users <linux-rt-users@vger.kernel.org>
To: pavel <pavel@pavlinux.ru>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51708 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754354AbbHCSx2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 3 Aug 2015 14:53:28 -0400
In-Reply-To: <55BFB4AA.4020901@pavlinux.ru>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 3 Aug 2015 21:36:26 +0300
pavel <pavel@pavlinux.ru> wrote:

> 1. Without patch
>=20
> # ./cyclictest -S -p fifo -D60s
> defaulting realtime priority to 9
> # /dev/cpu_dma_latency set to 0us
> policy: fifo: loadavg: 0.00 0.01 0.05 1/207 12378
>=20
> T: 0 (12361) P: 9 I:1000 C:  59993 Min:      1 Act:    1 Avg:    1 Ma=
x:       8
> T: 1 (12362) P: 9 I:1500 C:  39995 Min:      1 Act:    1 Avg:    1 Ma=
x:       9
> T: 2 (12363) P: 9 I:2000 C:  29996 Min:      1 Act:    1 Avg:    1 Ma=
x:      12
> T: 3 (12364) P: 9 I:2500 C:  23997 Min:      1 Act:    1 Avg:    1 Ma=
x:       9
> T: 4 (12365) P: 9 I:3000 C:  19997 Min:      1 Act:    1 Avg:    1 Ma=
x:       6
> T: 5 (12366) P: 9 I:3500 C:  17141 Min:      1 Act:    1 Avg:    1 Ma=
x:       11
> T: 6 (12367) P: 9 I:4000 C:  14998 Min:      0 Act:    1 Avg:    1 Ma=
x:       10
> T: 7 (12368) P: 9 I:4500 C:  13331 Min:      0 Act:    1 Avg:    1 Ma=
x:       6
>=20
> 2. With patch
>=20
>   # ./cyclictest -S -p fifo -D60s
> defaulting realtime priority to 9
> # /dev/cpu_dma_latency set to 0us
> policy: fifo: loadavg: 0.05 0.04 0.05 1/206 12469
>=20
> T: 0 (12452) P: 9 I:1000 C:  59997 Min:      1 Act:    1 Avg:    1 Ma=
x:       3
> T: 1 (12453) P: 9 I:1500 C:  39998 Min:      1 Act:    1 Avg:    1 Ma=
x:       2
> T: 2 (12454) P: 9 I:2000 C:  29998 Min:      1 Act:    1 Avg:    1 Ma=
x:       4
> T: 3 (12455) P: 9 I:2500 C:  23999 Min:      1 Act:    1 Avg:    1 Ma=
x:       4
> T: 4 (12456) P: 9 I:3000 C:  19999 Min:      1 Act:    1 Avg:    1 Ma=
x:       4
> T: 5 (12457) P: 9 I:3500 C:  17142 Min:      1 Act:    1 Avg:    1 Ma=
x:       3
> T: 6 (12458) P: 9 I:4000 C:  14999 Min:      1 Act:    1 Avg:    1 Ma=
x:       2
> T: 7 (12459) P: 9 I:4500 C:  13332 Min:      1 Act:    1 Avg:    1 Ma=
x:       3
>=20
>=20
> Patch  ---
>=20
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.=
c
> index 34053c5..84a70de 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -1727,6 +1727,9 @@ static void print_stat(FILE *fp, struct thread_=
param *par,=20
> int index, int verbos
>   {
>          struct thread_stat *stat =3D par->stats;
>=20
> +       if ( stat->cycles < 5000)
> +                stat->max =3D 0;
> +
>          if (!verbose) {
>                  if (quiet !=3D 1) {
>                          char *fmt;
>=20
> ---
>=20
>=20
> 03.08.2015 20:59, pavel =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >
> >>
> >>> # ./cyclictest -S -p fifo
> >>> defaulting realtime priority to 9
> >>> # /dev/cpu_dma_latency set to 0us
> >>> policy: fifo: loadavg: 0.00 0.03 0.05 1/218 4240
> >>>
> >>> T: 0 ( 4174) P: 9 I:1000 C: 430806 Min:      1 Act:    1 Avg:    =
1 Max:      10
> >>> T: 1 ( 4175) P: 9 I:1500 C: 287204 Min:      1 Act:    1 Avg:    =
1 Max:       6
> >>> T: 2 ( 4176) P: 9 I:2000 C: 215403 Min:      1 Act:    2 Avg:    =
1 Max:      11
> >>> T: 3 ( 4177) P: 9 I:2500 C: 172322 Min:      1 Act:    1 Avg:    =
1 Max:       9
> >>> T: 4 ( 4178) P: 9 I:3000 C: 143602 Min:      1 Act:    1 Avg:    =
1 Max:      10
> >>> T: 5 ( 4179) P: 9 I:3500 C: 123087 Min:      1 Act:    1 Avg:    =
1 Max:      11
> >>> T: 6 ( 4180) P: 9 I:4000 C: 107701 Min:      1 Act:    1 Avg:    =
1 Max:      10
> >>> T: 7 ( 4181) P: 9 I:4500 C: 108232 Min:      1 Act:    2 Avg:    =
1 Max:      11
> >>>
> >>>
> >>> It possible? 1us latency?  o_O
> >> No, your latency is 11us. Max latency is what we care about, not t=
he
> >> average.
> > By the way, max values appear only at the start, then they are roug=
hly equal to
> > the average.
>=20

Interesting. Betting that's page faults and cache filling.=20

I don't think we want to arbitrarily pick some number of cycles for a
"settle time" (i.e. a grace period for the application to reach steady
state). Possibly we should add an option for that? Specify some number
of cycles or some amount of time that where the measurement threads run
before actual measurements start?

  $ cyclictest --numa -p95 -m --settle=3D10ms

That would say "run the measurement threads for ten milliseconds before
actually starting the measurement period". That would allow them to
fault in and fill cache lines before starting real work.

Anyone else have an opinion?

Clark
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
