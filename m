From: Gregory Haskins <ghaskins@novell.com>
Subject: Re: [RFC PATCH 0/3] Series short description
Date: Tue, 11 Nov 2008 13:51:03 -0500
Message-ID: <4919D417.5020500@novell.com>
References: <20081111142323.28477.41235.stgit@dev.haskins.net> <20081111175649.GA12339@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6F1C85D8458E34C041DB35E9"
Cc: rostedt@goodmis.org, peterz@infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751751AbYKKSr1@vger.kernel.org>
In-Reply-To: <20081111175649.GA12339@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6F1C85D8458E34C041DB35E9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Ingo Molnar wrote:
> * Gregory Haskins <ghaskins@novell.com> wrote:
>
>  =20
>> Hi Ingo, Steven, Peter,
>>   This series applies roughly to mainline as an enhancement to the sch=
ed_rt
>>   logic.  Peter and I were discussing some of the unecessary overhead =
in
>>   pull_rt_tasks() via IRC, and this is my RFC attempt to address the p=
roblem.
>>
>>   I have built/booted this on a 4-way C2D Xeon box and it passes preem=
pt-test.
>>
>>   Comments, please.
>>    =20
>
> this direction looks very nifty to me. Peter, do you Ack them?
>
> 	Ingo
>  =20
[I just noticed that I fat-fingered the -rt list address, so here is a
link to the thread for those subscribed to -rt]

http://lkml.org/lkml/2008/11/11/193

-Greg


--------------enig6F1C85D8458E34C041DB35E9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkkZ1BcACgkQlOSOBdgZUxnr1gCdESRbOlYbwhQfvGy3/SU/G7p0
6iwAn0UB67EZYd1/06XdiTWeJxa/Tc3S
=vfKT
-----END PGP SIGNATURE-----

--------------enig6F1C85D8458E34C041DB35E9--
