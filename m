From: Gregory Haskins <gregory.haskins@gmail.com>
Subject: Re: Host latency peaks due to kvm-intel
Date: Thu, 23 Jul 2009 15:43:25 -0400
Message-ID: <4A68BD5D.1070302@gmail.com>
References: <4A68A6E5.6010808@siemens.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig55B498C56C17C035599A340D"
Cc: kvm-devel <kvm@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pz0-f192.google.com ([209.85.222.192]:36577 "EHLO
	mail-pz0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866AbZGWUIx (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 23 Jul 2009 16:08:53 -0400
In-Reply-To: <4A68A6E5.6010808@siemens.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig55B498C56C17C035599A340D
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Hi,
>
> did anyone recently tried current KVM for Intel over some real-time
> Linux? I'm seeing more than 500 us latency peaks on the host,
> specifically during VM startup. This applies to both 2.6.29.6-rt23 and
> Xenomai/I-pipe. For -rt, I both tried the included (patched) KVM module=
s
> as well as kvm.git head with some additionally required -rt fixes.
> Xenomai ran over a 2.6.30 kernel with my own KVM-enabler patch.
>
> Early instrumentation actually points to the guest exit itself: I added=

> markers right before and after the assembly part of vmx_vcpu_run, and
> further instrumentation reports that the next host APIC tick should go
> off right inside guest mode. But KVM leaves the switching part 500 us
> too late in that case - as if guest exit on external IRQs was disabled.=

>
> Will debug this further, but I'm also curious to hear other user
> experiences.
>
> Jan
>
>  =20
Hi Jan,
  Did you try to run with latency-tracer enabled?  If not, this may
pinpoint the source for you.

Regards,
-Greg


--------------enig55B498C56C17C035599A340D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.11 (Darwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkpovV0ACgkQP5K2CMvXmqEmEQCfaio2q20QBumCXQuhzYyK8zng
RPMAnifTfYVEiZjwR7GKm6F5K4Q+MfVl
=MQsz
-----END PGP SIGNATURE-----

--------------enig55B498C56C17C035599A340D--
