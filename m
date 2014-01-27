From: Pavel Vasilyev <pavel@pavlinux.ru>
Subject: Re: [ANNOUNCE] 3.12.8-rt11
Date: Mon, 27 Jan 2014 13:42:29 +0400
Message-ID: <52E62A05.7080802@pavlinux.ru>
References: <20140125134519.GA9845@linutronix.de> <52E57D42.60206@pavlinux.ru> <52E61C52.6070104@linutronix.de>
Reply-To: pavel@pavlinux.ru
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="2eNboSgqvcQt5Pw8pNkF8CvIXS2XkbI0L"
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <52E61C52.6070104@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2eNboSgqvcQt5Pw8pNkF8CvIXS2XkbI0L
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

27.01.2014 12:44, Sebastian Andrzej Siewior =D0=BF=D0=B8=D1=88=D0=B5=D1=82=
:
> On 01/26/2014 10:25 PM, Pavel Vasilyev wrote:
>> 25.01.2014 17:45, Sebastian Andrzej Siewior =D0=BF=D0=B8=D1=88=D0=B5=D1=
=82:
>>> Dear RT folks!
>>
>>
>> Gentlemen, let's have a month of stress testing! Divide tasks
>> testing subsystem: USB, NET, MM, ACPI, AUDIO, VIDEO By CPUs:
>> ARM/PPC/X86/X86_64...
>>
>> Purely on observations noted that in September 2013, the quality
>> and stability of the code has deteriorated dramatically.
>=20
> By September 2k13, do you mean a specific v3.10-RT release?
>=20

Any after 3.2.x-rt

Maybe I'm doing something wrong, but:

1) All kernels (3.2, 3.8, 3.12, 3.13,...) are working normally without pa=
tches;

2) 3.2 works fine in CONFIG_PREEMPT_RT_BASE or CONFIG_PREEMPT_RT_FULL mod=
es;

3) 3.10 not works at all, even without -RT patches;

4) 3.12 work only as CONFIG_PREEMPT_RT_BASE or CONFIG_PREEMPT_RT_FULL in
uniprocessor mode (maxcpus=3D0, nosmp).  Newer patches (Oct.-Dec.) did no=
t work,
even in RT_BASE mode.

Varia hardware: One Opteron 285, 2-cpus (4 cores). Six Intel Atoms device=
s
kernels compiled as x86_32.

I have my patches, but I tested both with them and without them.
---

Behold! 3.12.8-rt11, RT_FULL mode, kernel cmdline: init=3D/bin/bash

1.
bash: cannot set terminal process group (-1): Inappropriate ioctl for dev=
ice
bash: no job control in this shell

2.
in single mode: After 2 minutes timeout: see screenshot
http://i59.fastpic.ru/big/2014/0127/bc/0f9e04536181286f820ecaae5a8481bc.j=
pg

3.
command killall -15 freezed system!


Kernel compiled with debug information starts to work normally, but of co=
urse
slower. :D

--=20

                                                         Pavel.


--2eNboSgqvcQt5Pw8pNkF8CvIXS2XkbI0L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCgAGBQJS5ioFAAoJEPtok08Dny2hpr4P+gJy9v+s4W0M8fjVJKcb/mwH
SwR4gbiIMRSLtCWneO+BCSQ+Jcwa2N7N5TM3dVFJovOAZIW9HsbuIWGJWJKv1nvc
CTu1kKPy27YwrCSZJBEHqeX4yxnuzrgInbrapHm3S0ssG/RZwHbdJvJ74TkYnA/0
VXJYowyalpbrb1HIH84UUcuGhREhtSCAKLf0Yg3IZhO3RFESvOHXUxJYJkWl13c6
o1NLkQh8cM4tuQG8qtdu16tXzWgH2Xfi4EsoEfB7DsYodQGwMC95SdMrSj48NUd6
7uJ85EVGoOaAs8DMznpGdXkkYC9CJKXwmlIbhpxn9q2oHXKuAjy312J7ulODWbTw
BPRpojT38il+z186sXJDbbPTC2Hc4j5HAxh2pSnrbu1Bx3gOWJAf4eXwhoVMgMUK
S5kZ5AxIsBrk3iVZltEWJ4g/ZYIwMY2hh8oJN7zzBiX3ewFV2UpIcCfMqiphjZJC
2ePd+q49ZhnqjpIHZA84BthBN+fJxBeqal4Ys6f5BI5yoY/MvrCTan5FM1UpN3bn
OHASDTwHe/pnsgEgEev97HSpSZNdcK108lrr/dihybjdpQYzZuKE/Q20osGOlBsG
xiVR6UeqYuYS1vNVgUjehYwPl1X3QTMW3YQcedOqAJyaovUUBHdbYIvNEN/qGTm1
pYzdUuEDdxndr76Cp0Zu
=aCC3
-----END PGP SIGNATURE-----

--2eNboSgqvcQt5Pw8pNkF8CvIXS2XkbI0L--
