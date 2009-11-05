From: Tim Blechmann <tim@klingt.org>
Subject: Re: rt file i/o
Date: Thu, 05 Nov 2009 10:29:58 +0100
Message-ID: <4AF29B16.1000104@klingt.org>
References: <hcs6dr$235$1@ger.gmane.org>	<5bdc1c8b0911040743h7e4eaa08w97ac8287b806b54f@mail.gmail.com>	<4AF1A327.3040103@klingt.org>	<20091104171412.GB1702@opentech.at>	<4AF1BAB9.5080104@klingt.org> <20091104164413.3aff479c@torg>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigAB1177ED4C13DF7F062D1A62"
Cc: Nicholas Mc Guire <der.herr@hofr.at>, y@opentech.at,
	Mark Knecht <markknecht@gmail.com>,
	linux-rt-users@vger.kernel.org
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.klingt.org ([86.59.21.178]:36703 "EHLO klingt.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752029AbZKEJaP (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 5 Nov 2009 04:30:15 -0500
In-Reply-To: <20091104164413.3aff479c@torg>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAB1177ED4C13DF7F062D1A62
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/04/2009 11:44 PM, Clark Williams wrote:
> On Wed, 04 Nov 2009 18:32:41 +0100
> Tim Blechmann <tim@klingt.org> wrote:
>=20
>>>> well, if i understand the rt howto correctly, _no_ disc access is
>>>> allowed, neither from rt nor from non-rt threads, since it may produ=
ce
>>>> page faults, which introduce latencies ...
>>>
>>> I would be supprised if the rt howto states that page-faults in non-r=
t
>>> threads is a critical problem - that would not significantly impact R=
T
>>> performance - atelast not the worst case - it will (as every other sy=
stem
>>> load) impact the average case. so having a non-rt thread reading disk=
-files
>>> to a buffer and a rt-thread processing this buffer should be perfectl=
y fine.
>>
>> that is what i thought for years ... but according to [1] a page fault=

>> in an rt process freezes the entire process with both rt and non-rt
>> threads until the page fault is handled ...
>>
>=20
> No, we need to get that fixed in the wiki. It may have been the case
> that the entire process was frozen while a fault was being handled, but=

> I don't believe that is the case now. If you're in a thread on core0
> and a sibling thread on core1 faults, you shouldn't be impacted unless
> you're trying to reference the same memory.=20

well, then my application seems to be real-time safe ... it would be
nice if the wiki would reflect the current state of the rt-preempt
kernel, though ...

thnx, tim

--=20
tim@klingt.org
http://tim.klingt.org

All we composers really have to work with is time and sound - and
sometimes I'm not even sure about sound.
  Morton Feldman


--------------enigAB1177ED4C13DF7F062D1A62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrymxkACgkQdL+4qsZfVssMnQCbB84oz7Z72hr0pKJ5bDO3M7oj
eA0AnjKv29G5vzz+2vaOQYA/X5lYETJZ
=BoFe
-----END PGP SIGNATURE-----

--------------enigAB1177ED4C13DF7F062D1A62--
