From: Jan Kiszka <jan.kiszka@web.de>
Subject: Re: Host latency peaks due to kvm-intel
Date: Sun, 26 Jul 2009 16:23:28 +0200
Message-ID: <4A6C66E0.6050306@web.de>
References: <4A68A6E5.6010808@siemens.com> <4A68BD5D.1070302@gmail.com> <4A6981B0.3000008@siemens.com> <4A6ABF28.1010602@redhat.com> <4A6AD69E.7030201@web.de> <4A6B0837.6010608@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6E1868085BDDC26FC6305140"
Cc: Gregory Haskins <gregory.haskins@gmail.com>,
	kvm-devel <kvm@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	"Yang, Sheng" <sheng.yang@intel.com>
To: Avi Kivity <avi@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from fmmailgate03.web.de ([217.72.192.234]:38424 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753512AbZGZOXi (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 26 Jul 2009 10:23:38 -0400
In-Reply-To: <4A6B0837.6010608@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6E1868085BDDC26FC6305140
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Avi Kivity wrote:
> On 07/25/2009 12:55 PM, Jan Kiszka wrote:
>> Avi Kivity wrote:
>>  =20
>>> On 07/24/2009 12:41 PM, Jan Kiszka wrote:
>>>    =20
>>>> I vaguely recall that someone promised to add a feature reporting
>>>> facility for all those nice things, modern VM-extensions may or may =
not
>>>> support (something like or even an extension of /proc/cpuinfo). What=
 is
>>>> the state of this plan? Would be specifically interesting for Intel
>>>> CPUs
>>>> as there seem to be many of them out there with restrictions for
>>>> special
>>>> use cases - like real-time.
>>>>
>>>>       =20
>>> Newer kernels do report some vmx features (like flexpriority) in
>>> /proc/cpuinfo but not all.
>>>
>>>     =20
>>
>> Ah, nice. Then we just need this?
>>
>> ------------>
>>
>> From: Jan Kiszka<jan.kiszka@siemens.com>
>> Subject: [PATCH] x86: Report VMX feature vwbinvd
>>
>> Not all VMX-capable CPUs support guest exists on wbinvd execution. If
>> this is not supported, the instruction will run natively on behalf of
>> the guest. This can cause multi-millisecond latencies to the host whic=
h
>> is very problematic in real-time scenarios.
>>
>> Report the wbinvd trapping feature along with other VMX feature flags,=

>> calling it 'vwbinvd' ('virtual wbinvd').
>>
>>   =20
>=20
> What about AMD cpus that can always trap wbinvd?  do we set the bit or
> do we trust the user to know that it isn't needed on AMD (I suppose the=

> latter)?

I also think that the feature flags should remain vendor-specific.

>=20
> This should go in via tip.git, it isn't really kvm related (except that=

> kvm should start reading these caps one day instead of querying the
> hardware directly).
>=20

OK, will go that way. Probably I will also add some flags for AMD's NPT,
Intel's EPT and they new unrestricted guest mode at this chance.

Jan


--------------enig6E1868085BDDC26FC6305140
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkpsZukACgkQniDOoMHTA+nWuwCdF5fOXnPWXRbUMg8uJ6Pp1+Z+
x38Aniy7i5LCw+qpLkeOOiVnhyZNn5dY
=EvJn
-----END PGP SIGNATURE-----

--------------enig6E1868085BDDC26FC6305140--
