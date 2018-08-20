Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail.klingt.org ([86.59.21.178]:37552 "EHLO klingt.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbeHTRLO (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 20 Aug 2018 13:11:14 -0400
References: <pl0fsj$ohn$1@blaine.gmane.org>
 <0ac9fabc-c316-2a59-c3dd-c7b4e4f93209@bristot.me>
 <20180817095106.GB27071@localhost.localdomain>
 <c2b1a7a4-db8c-b8bd-6623-5c66b55ee6d2@klingt.org>
 <20180817102810.GC27071@localhost.localdomain>
 <513fd544-bc51-7ea6-8b94-983d28922a66@klingt.org>
 <20180820085420.GB8866@localhost.localdomain>
 <d7cd5c88-dbe6-c74d-43e8-724ac0b463ce@klingt.org>
 <4c58c94c-d99d-9f08-a5a3-710defc612c8@bristot.me>
From: Tim Blechmann <tim@klingt.org>
Subject: Re: SCHED_DEADLINE as user
Message-ID: <dfe1cea0-089d-fed9-a349-23de2660889e@klingt.org>
Date: Mon, 20 Aug 2018 21:55:04 +0800
MIME-Version: 1.0
In-Reply-To: <4c58c94c-d99d-9f08-a5a3-710defc612c8@bristot.me>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="DMUcXF7YX0y4G8UCTZH3l7fWWG7cPmDN0"
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Daniel Bristot de Oliveira <daniel@bristot.me>, Juri Lelli <juri.lelli@gmail.com>
Cc: linux-rt-users@vger.kernel.org, Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>, Luca Abeni <luca.abeni@santannapisa.it>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DMUcXF7YX0y4G8UCTZH3l7fWWG7cPmDN0
Content-Type: multipart/mixed; boundary="fHW6N3KV4AU9O0xXzyCETFChJPIgONVeF";
 protected-headers="v1"
From: Tim Blechmann <tim@klingt.org>
To: Daniel Bristot de Oliveira <daniel@bristot.me>,
 Juri Lelli <juri.lelli@gmail.com>
Cc: linux-rt-users@vger.kernel.org,
 Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
 Luca Abeni <luca.abeni@santannapisa.it>
Message-ID: <dfe1cea0-089d-fed9-a349-23de2660889e@klingt.org>
Subject: Re: SCHED_DEADLINE as user
References: <pl0fsj$ohn$1@blaine.gmane.org>
 <0ac9fabc-c316-2a59-c3dd-c7b4e4f93209@bristot.me>
 <20180817095106.GB27071@localhost.localdomain>
 <c2b1a7a4-db8c-b8bd-6623-5c66b55ee6d2@klingt.org>
 <20180817102810.GC27071@localhost.localdomain>
 <513fd544-bc51-7ea6-8b94-983d28922a66@klingt.org>
 <20180820085420.GB8866@localhost.localdomain>
 <d7cd5c88-dbe6-c74d-43e8-724ac0b463ce@klingt.org>
 <4c58c94c-d99d-9f08-a5a3-710defc612c8@bristot.me>
In-Reply-To: <4c58c94c-d99d-9f08-a5a3-710defc612c8@bristot.me>

--fHW6N3KV4AU9O0xXzyCETFChJPIgONVeF
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

>> main audio thread:
>> while running:
>>   snd_pcm_read  // blocks until data is delivered from ALSA
>>   wake helper(s)
>>   do work()
>>   sync_with_helper(s)
>>   snd_pcm_write // blocks until data is delivered to ALSA
>>
>> alsa is basically driven by the hardware, which delivers/requests data=

>> every ~1.3ms.

>> distributing the work is a little tricky: to avoid excessive schedulin=
g
>> overhead, the worker threads are typically woken up (after snd_pcm_rea=
d)
>> and the result is collected where sync_with_helper() typically boils
>> down to busy waiting. in this case, the workers as rate-monotonic in a=

>> similar manner as the main audio thread.
>=20
> When you say "rate-monitonic", do you mean that the worker threads with=

> smaller period (high rate, so) have a higher fixed-priority? If so, wha=
t
> are the other periods?

the period will be the same period: i wake up the workers once per
period of the main thread, distribute the work and collect it at the
end. so "period" is basically the same, "runtime" a little lower.


> as sync_with_helper() does a busy-wait, the "main audio thread" has a
> relative lower priority than the worker threads, right?

typically all threads have the same priority and there will be at most N
threads for N physical CPU cores. so each thread will have a CPU to run
on and no thread will be preempted.


> So, your main wish here is to avoid having a watchdog thread to
> "throttle" misbehaving workload/setup?

mainly ... and nerdy research if SCHED_DEADLINE is useful for audio
applications ... ;)


> For curiosity, what are the "time-constraints" setup used on mach?

it's pretty similar to the SCHED_DEADLINE constraints:

from:
https://opensource.apple.com/source/xnu/xnu-124.7/osfmk/mach/thread_polic=
y.h.auto.html

> /*
>  * THREAD_TIME_CONSTRAINT_POLICY:
>  *
>  * This scheduling mode is for threads which have real time
>  * constraints on their execution.
>  *
>  * Parameters:
>  *
>  * period: This is the nominal amount of time between separate
>  * processing arrivals, specified in absolute time units.  A
>  * value of 0 indicates that there is no inherent periodicity in
>  * the computation.
>  *
>  * computation: This is the nominal amount of computation
>  * time needed during a separate processing arrival, specified
>  * in absolute time units.
>  *
>  * constraint: This is the maximum amount of real time that
>  * may elapse from the start of a separate processing arrival
>  * to the end of computation for logically correct functioning,
>  * specified in absolute time units.  Must be (>=3D computation).
>  * Note that latency =3D (constraint - computation).
>  *
>  * preemptible: This indicates that the computation may be
>  * interrupted, subject to the constraint specified above.
>  */

cheers,
tim


--fHW6N3KV4AU9O0xXzyCETFChJPIgONVeF--

--DMUcXF7YX0y4G8UCTZH3l7fWWG7cPmDN0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIcBAEBCgAGBQJbesg4AAoJEAIkvWiom07DYOwQAJaCiYxXNFyO2Ek2BW5qR5tB
lQk4CXe+hB6SWjOwT+2GuSdr+wRb+xB4nicGnonFomuFmzETN1LAddYsWH428ote
Q3V4yyTcyIuraUNFRFUGlrNfYlFNeWIC2P2io6fcO1ug6lxvI3ASZ6Tn7S4H0Hrq
fK1gNsPFM/TPlczg6y1VZHPU90Vfs+PmaRum3nNGys052PfWfB7HiWV8Qu9VoSOy
NayB7GfvN9LGUARB5EJ9HoSVD1NHdRR2SNSBUcUv6nvoJWnXv+QWYwKCWn/cu4O8
ieLLg9H/1WbOsIeiLMHul8VPv481X1S2dV+ZdBfkt+pgiYOeBGtbCn6b9Pd4fdqA
D4EMbYO9TLk/txR6R8TsL/Rk08tOvm+rGeqSbUcLHCSA/obBZY1pvrpF65pvWlt3
4NWVtQifMdItz5fviO/nND8R9N6oP4rFRYSBKehH62gvtgzZMn4n0mguO0Gkjzhf
PHKVDlHuBfpetmZJKvKapaiZE2ZjP/AgaC5w1LastUO7wVToz588sRrtlTeQXGN/
0Y/9PP4QrSnD+IZhUP/G8k53I95aCKnjV1w5uvvJ1Sg02MOm3XeOXACTah2tHhAR
/LpoOtsEjEabRHVaNgTGUjK/mnVvtxsXrSKMSIbXdH0PWVR9XrRx0WnTWtnoR0yH
Rad7p/lhAiMTybAN+bO6
=qz0L
-----END PGP SIGNATURE-----

--DMUcXF7YX0y4G8UCTZH3l7fWWG7cPmDN0--
