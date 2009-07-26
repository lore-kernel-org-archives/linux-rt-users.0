From: Jan Kiszka <jan.kiszka@web.de>
Subject: Re: Host latency peaks due to kvm-intel
Date: Sun, 26 Jul 2009 16:52:52 +0200
Message-ID: <4A6C6DC4.6080909@web.de>
References: <4A68A6E5.6010808@siemens.com> <4A68BD5D.1070302@gmail.com> <4A6981B0.3000008@siemens.com> <4A6B1C15.6090608@redhat.com> <4A6C6970.6060200@web.de> <4A6C6C14.4030805@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigACA15C2D2AF74F37581F50A0"
Cc: Gregory Haskins <gregory.haskins@gmail.com>,
	kvm-devel <kvm@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	"Yang, Sheng" <sheng.yang@intel.com>
To: Avi Kivity <avi@redhat.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <4A6C6C14.4030805@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigACA15C2D2AF74F37581F50A0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Avi Kivity wrote:
> On 07/26/2009 05:34 PM, Jan Kiszka wrote:
>> Avi Kivity wrote:
>>  =20
>>> On 07/24/2009 12:41 PM, Jan Kiszka wrote:
>>>    =20
>>>> Jan (who is now patching his guest to avoid wbinvd where possible)
>>>>
>>>>
>>>>       =20
>>> Is there ever a case where it is required?  What about under a
>>> hypervisor (i.e. check the hypervisor enabled bit).
>>>
>>>     =20
>>
>> Reminds me of the discussion in '07 when I first stumbled over this :)=
 :
>> Yes, the bochs bios could safely skip the wbinvd in qemu mode. But tha=
t
>> won't safe us from Linux and - far more problematic - Windows or any
>> binary-only guest which think they have to issue it.
>>
>> One may the close eyes, fire up the guest and then start the
>> time-critical host application in the hope that the guest remains calm=

>> as long as it's up and running. But, well...
>>   =20
>=20
> Given that it's now '09, how critical is the problem?  Don't most cpus
> have vwbinvd now?

Sadly, in (embedded) industry you have to live with "old" hardware for
quite a long time. And I would have to throw my only 2-years-old
notebook from the table to have a more decent portable test environment.

>=20
> If so, the real-time management application can simply refuse to run on=

> such an old processor.
>=20

At least one could go and collect the cpuinfo from some box that suffers
from high latencies. Normally, you go through extensive testing anyway,
also checking for issues like crazy SMI BIOS code that runs for eternitie=
s.

Jan


--------------enigACA15C2D2AF74F37581F50A0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkpsbcsACgkQniDOoMHTA+lAQACeM0T9hMtcEQmoCC4O7yVnf/vz
SvYAnjol3zzVJjCQu0KtLiuDnX/2leJ5
=W2s4
-----END PGP SIGNATURE-----

--------------enigACA15C2D2AF74F37581F50A0--
