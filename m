From: Clark Williams <williams@redhat.com>
Subject: Re: cyclictest better values with system load than without
 (OMAP3530 target)
Date: Tue, 26 Nov 2013 10:12:32 -0600
Message-ID: <20131126101232.21636c8f@sluggy>
References: <5294681E.10406@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/Fqba.s6oc8HptI9v/TSTFE_"; protocol="application/pgp-signature"
Cc: linux-rt-users@vger.kernel.org
To: Stefan Roese <stefan.roese@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:6872 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757195Ab3KZQMe (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 26 Nov 2013 11:12:34 -0500
In-Reply-To: <5294681E.10406@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/Fqba.s6oc8HptI9v/TSTFE_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

In my experience (on x86_64 mainly), that behavior (worse times when
not under load) is due to the overhead of coming out of power-save/idle
states. When you've got a big load on the system and all the cores are
active, then the power-save logic and/or the idle logic doesn't kick in
and devices aren't being powered down.

Do you know if your OMAP has power-save logic available? Alternatively
do you know how expensive the idle mechanism is? Have you tried booting
with idle=3Dpoll then measuring without a load?

Clark


On Tue, 26 Nov 2013 10:21:34 +0100
Stefan Roese <stefan.roese@gmail.com> wrote:

> Hi!
>=20
> I'm running cylictest on a OMAP3530 target board and am a bit
> astonished about the results. Especially that the latency values
> are better on a system with system load (hackbench) than on one
> without system load. Here the values I get:
>=20
> With system load (hackbench):
> -----------------------------
> # ./cyclictest -l 10000 -i 1000 -n -p 80 -q
> # /dev/cpu_dma_latency set to 0us
> T: 0 ( 1853) P:80 I:1000 C:  10000 Min:     36 Act:  156 Avg:  154 Max:
>     244
>=20
> Idle system:
> ------------
> # ./cyclictest -l 10000 -i 1000 -n -p 80 -q
> # /dev/cpu_dma_latency set to 0us
> T: 0 ( 2332) P:80 I:1000 C:  10000 Min:     81 Act:  530 Avg:  484 Max:
>     602
>=20
>=20
> Some details to my test/system setup:
> - Linux v3.8.13
> - preempt-rt patch 3.8.13-rt14
> - HW: TI OMAP3530 CM_T35 board
> - Latest cyclictest from rt-tests git repository
>=20
>=20
> I might have misconfigured the system. So here some extracts from
> my .config:
>=20
> ...
> CONFIG_TICK_ONESHOT=3Dy
> CONFIG_NO_HZ=3Dy
> CONFIG_HIGH_RES_TIMERS=3Dy
> ...
> # CONFIG_CPU_FREQ is not set
> # CONFIG_CPU_IDLE is not set
> # CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is not set
> ...
> CONFIG_PREEMPT_RT_FULL=3Dy
> ...
>=20
> With CONFIG_NO_HZ disabled I get slightly better results:
>=20
> With system load (hackbench):
> -----------------------------
> # ./cyclictest -l 10000 -i 1000 -n -p 80 -q
> # /dev/cpu_dma_latency set to 0us
> T: 0 ( 1840) P:80 I:1000 C:  10000 Min:     30 Act:  153 Avg:  154 Max:
>     238
>=20
> Idle system:
> -------------
> # ./cyclictest -l 10000 -i 1000 -n -p 80 -q
> # /dev/cpu_dma_latency set to 0us
> T: 0 ( 1371) P:80 I:1000 C:  10000 Min:     40 Act:  465 Avg:  435 Max:
>     502
>=20
>=20
> Any ideas/explanations are really appreciated.
>=20
> Thanks,
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--Sig_/Fqba.s6oc8HptI9v/TSTFE_
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlKUyHAACgkQHyuj/+TTEp3/uwCfR9vKVdDcQJniZg60lm+YiqNZ
8awAoOYCp9GQJiouTGdEYrOUDvCVAFRT
=AuCm
-----END PGP SIGNATURE-----

--Sig_/Fqba.s6oc8HptI9v/TSTFE_--
