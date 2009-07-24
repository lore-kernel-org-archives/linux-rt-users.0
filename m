From: Gregory Haskins <gregory.haskins@gmail.com>
Subject: Re: Host latency peaks due to kvm-intel
Date: Fri, 24 Jul 2009 08:01:57 -0400
Message-ID: <4A69A2B5.4010303@gmail.com>
References: <4A68A6E5.6010808@siemens.com> <4A68BD5D.1070302@gmail.com> <4A6981B0.3000008@siemens.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD647FB58A9F3E3C160C097DF"
Cc: kvm-devel <kvm@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>, Avi Kivity <avi@redhat.com>,
	"Yang, Sheng" <sheng.yang@intel.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qy0-f196.google.com ([209.85.221.196]:63242 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916AbZGXMKN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 24 Jul 2009 08:10:13 -0400
In-Reply-To: <4A6981B0.3000008@siemens.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD647FB58A9F3E3C160C097DF
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Gregory Haskins wrote:
>  =20
>> Jan Kiszka wrote:
>>    =20
>>> Hi,
>>>
>>> did anyone recently tried current KVM for Intel over some real-time
>>> Linux? I'm seeing more than 500 us latency peaks on the host,
>>> specifically during VM startup. This applies to both 2.6.29.6-rt23 an=
d
>>> Xenomai/I-pipe. For -rt, I both tried the included (patched) KVM modu=
les
>>> as well as kvm.git head with some additionally required -rt fixes.
>>> Xenomai ran over a 2.6.30 kernel with my own KVM-enabler patch.
>>>
>>> Early instrumentation actually points to the guest exit itself: I add=
ed
>>> markers right before and after the assembly part of vmx_vcpu_run, and=

>>> further instrumentation reports that the next host APIC tick should g=
o
>>> off right inside guest mode. But KVM leaves the switching part 500 us=

>>> too late in that case - as if guest exit on external IRQs was disable=
d.
>>>
>>> Will debug this further, but I'm also curious to hear other user
>>> experiences.
>>>
>>> Jan
>>>
>>>  =20
>>>      =20
>> Hi Jan,
>>   Did you try to run with latency-tracer enabled?  If not, this may
>> pinpoint the source for you.
>>    =20
>
> I did, see above.
>  =20

Ah, sorry.  It wasn't clear what "instrumenation" was or if you felt it
was definitively pinpointed.  :P

Regards,
-Greg



--------------enigD647FB58A9F3E3C160C097DF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.11 (Darwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkpporUACgkQP5K2CMvXmqFeVACeKGPbwas0TUsoQ/R0r9f197C1
4W4Ani5SUPV9E1VPS/JM5sYMRL53Kr2l
=c9w5
-----END PGP SIGNATURE-----

--------------enigD647FB58A9F3E3C160C097DF--
