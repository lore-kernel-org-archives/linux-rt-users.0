Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail.klingt.org ([86.59.21.178]:33288 "EHLO klingt.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbeHTPKq (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 20 Aug 2018 11:10:46 -0400
References: <pl0fsj$ohn$1@blaine.gmane.org>
 <0ac9fabc-c316-2a59-c3dd-c7b4e4f93209@bristot.me>
 <20180817095106.GB27071@localhost.localdomain>
 <c2b1a7a4-db8c-b8bd-6623-5c66b55ee6d2@klingt.org>
 <20180817102810.GC27071@localhost.localdomain>
 <513fd544-bc51-7ea6-8b94-983d28922a66@klingt.org>
 <20180820085420.GB8866@localhost.localdomain>
From: Tim Blechmann <tim@klingt.org>
Subject: Re: SCHED_DEADLINE as user
Message-ID: <d7cd5c88-dbe6-c74d-43e8-724ac0b463ce@klingt.org>
Date: Mon, 20 Aug 2018 19:54:58 +0800
MIME-Version: 1.0
In-Reply-To: <20180820085420.GB8866@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="H6jkRoFCU33RPUWJXtUysCcMyb8t6wH3G"
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Juri Lelli <juri.lelli@gmail.com>
Cc: Daniel Bristot de Oliveira <daniel@bristot.me>, linux-rt-users@vger.kernel.org, Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>, Luca Abeni <luca.abeni@santannapisa.it>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--H6jkRoFCU33RPUWJXtUysCcMyb8t6wH3G
Content-Type: multipart/mixed; boundary="1VeoxWEgyeT3Y122cGAHZhtpBId8i1D7t";
 protected-headers="v1"
From: Tim Blechmann <tim@klingt.org>
To: Juri Lelli <juri.lelli@gmail.com>
Cc: Daniel Bristot de Oliveira <daniel@bristot.me>,
 linux-rt-users@vger.kernel.org,
 Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
 Luca Abeni <luca.abeni@santannapisa.it>
Message-ID: <d7cd5c88-dbe6-c74d-43e8-724ac0b463ce@klingt.org>
Subject: Re: SCHED_DEADLINE as user
References: <pl0fsj$ohn$1@blaine.gmane.org>
 <0ac9fabc-c316-2a59-c3dd-c7b4e4f93209@bristot.me>
 <20180817095106.GB27071@localhost.localdomain>
 <c2b1a7a4-db8c-b8bd-6623-5c66b55ee6d2@klingt.org>
 <20180817102810.GC27071@localhost.localdomain>
 <513fd544-bc51-7ea6-8b94-983d28922a66@klingt.org>
 <20180820085420.GB8866@localhost.localdomain>
In-Reply-To: <20180820085420.GB8866@localhost.localdomain>

--1VeoxWEgyeT3Y122cGAHZhtpBId8i1D7t
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

> In your case - assuming you could already use DEADLINE for !root - do
> you think you would need to use the same interface for the multiple
> threads you are distributing work among? Or would you be fine with
> assigning runtime/deadline for each one of those?

that's a tricky question and depends on the use-case: for me it's "good
enough" to use something like:

main audio thread:
while running:
  snd_pcm_read  // blocks until data is delivered from ALSA
  wake helper(s)
  do work()
  sync_with_helper(s)
  snd_pcm_write // blocks until data is delivered to ALSA

alsa is basically driven by the hardware, which delivers/requests data
every ~1.3ms.


distributing the work is a little tricky: to avoid excessive scheduling
overhead, the worker threads are typically woken up (after snd_pcm_read)
and the result is collected where sync_with_helper() typically boils
down to busy waiting. in this case, the workers as rate-monotonic in a
similar manner as the main audio thread.

one could also use lock-free queues with semaphores to wake only as many
threads as needed for the graph topology (which can depend on user
input). in this case SCHED_FIFO sounds more suitable.

--

from a practical point of view: i'm not targeting a safety critical
system. one advantage i'm seeing of DEADLINE over FIFO/RR is that it's
easier to prevent lockups (e.g. when a user overloads the system). in
the linux audio world this is typically done by a watchdog thread. the
other part of the unix world (mach) is using time-constraint threads by
default for audio use cases. so i'd assume that DEADLINE would free me
from the need to spawn the watchdog thread ...

cheers,
tim


--1VeoxWEgyeT3Y122cGAHZhtpBId8i1D7t--

--H6jkRoFCU33RPUWJXtUysCcMyb8t6wH3G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIcBAEBCgAGBQJbeqwTAAoJEAIkvWiom07DTs4P+wQgiM5akROmFSJtXl1N/qVx
uPGp7MLpvrhTaNPSwOGXhcAFYA2ZxoDBHO4pn2uPoxWhe5psrjoHy85U8OKzKUnb
6opU8kVx722KzKLSkS8iD1Dh9fi9Sw8bZteVe/vkcKKKKVCCr/D9i7aRCXsiz0lt
Al9InP3fIj0oDF3BNvU26AzPz3AXj/zG2QFZqWdBU+gWUYJfg3y9Ow74Mrjx8YYH
M8k+purLxf74vX/IFes1i3/9rLsPzH0OvXByT/339MAmINyGiRTBWURskfbP/Ic4
tBN2p5S4iwTBYOa7rjEoRROmRnV7NfyjM2w8qchF1+zjWudMUpRtlCcf0cCVnWvc
VtllRTL3g4LuBbbk5cn/L0R7KrPkeycIImoYk6DG8d7Jq4sDirkG/fi+Y0oayUfM
JvrYkSrQANFMV+qqTXdV7tfUrHLNFWCJ5mJoKefUrnGNgY/RWRbU47UqFk3k0vFS
ueJqf5Lp6usq3p5whN95hKU2FSIGVfbVuKjC4QcUqsyzCzTtfxru6G1vm34+yAz2
5cRQPXVwAnxXl/cXxvYzEiGvZpDTRpV83FwZ2reYlh/hJ7EpCdCRg4ZdYBN3XOES
1cwTgReJvUf9qJEgG0cw107KRPPW3OkHjS6cL8qigzC9xzdtHTfSUP1w/AKZzvJp
RQzObSrjyjonbLJ4Wn8p
=qyPi
-----END PGP SIGNATURE-----

--H6jkRoFCU33RPUWJXtUysCcMyb8t6wH3G--
