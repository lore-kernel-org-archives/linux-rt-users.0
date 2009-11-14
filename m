From: Tim Blechmann <tim@klingt.org>
Subject: Re: scheduling latency & CONFIG_HZ
Date: Sat, 14 Nov 2009 11:48:09 +0100
Message-ID: <4AFE8AE9.3050804@klingt.org>
References: <hdf0mo$6gj$1@ger.gmane.org> <alpine.LFD.2.00.0911132133250.24119@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA3BD4369AAE78B59D206890C"
Cc: linux-rt-users@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.klingt.org ([86.59.21.178]:33640 "EHLO klingt.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753380AbZKNKsO (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 14 Nov 2009 05:48:14 -0500
In-Reply-To: <alpine.LFD.2.00.0911132133250.24119@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA3BD4369AAE78B59D206890C
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

>> i am curious, do the values of CONFIG_HZ and CONFIG_NO_HZ somehow affe=
ct the
>> scheduling latency (as reported by cyclictest) of a real-time/vanilla =
kernel,
>> especially when CONFIG_HIGH_RES_TIMERS is enabled?
>=20
> CONFIG_HZ should be pretty irrelevant, but CONFIG_NO_HZ=3Dy especially
> when the CPU does support deeper C-States and the ACPI cpuidle support
> is active may influence it simply because the wake up from deeper
> c-states can take significantly longer than waking up from C1 (the
> default halt state). Note that the wakeup latency from C-States
> depends on the CPU model, chipset, available timer hardware ...

interesting ... from my understanding, the wakeup latency is known to
the kernel (/sys/devices/system/cpu/cpuX/cpuidle/stateY/latency) and is
taken into account when governor selects the next state ... is it
possible to tweak the governor by setting the latency requirement
(pm_qos_requirement(PM_QOS_CPU_DMA_LATENCY)) from userspace?

thanks, tim

--=20
tim@klingt.org
http://tim.klingt.org

Lesser artists borrow, great artists steal.
  Igor Stravinsky


--------------enigA3BD4369AAE78B59D206890C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkr+iukACgkQdL+4qsZfVsvDEQCdFS26AMyLYYaDUDro6tKocMK1
eiAAn1FI6eef0c5Yw/8mNw6Ec/jWShsL
=XuKL
-----END PGP SIGNATURE-----

--------------enigA3BD4369AAE78B59D206890C--
