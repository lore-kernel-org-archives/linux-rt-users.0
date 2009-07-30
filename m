From: Tim Blechmann <tim@klingt.org>
Subject: Re: [ANNOUNCE] 2.6.31-rc4-rt1
Date: Thu, 30 Jul 2009 11:56:36 +0200
Message-ID: <4A716E54.90105@klingt.org>
References: <alpine.LFD.2.00.0902112332370.415@localhost.localdomain> <alpine.LFD.2.00.0904092046440.21577@localhost.localdomain> <alpine.LFD.2.00.0904110003370.21577@localhost.localdomain> <alpine.LFD.2.00.0904181204420.21577@localhost.localdomain> <alpine.LFD.2.00.0904251500150.4529@localhost.localdomain> <alpine.LFD.2.00.0904290036500.4529@localhost.localdomain> <alpine.LFD.2.00.0905012348200.3375@localhost.localdomain> <alpine.LFD.2.00.0905130122250.3561@localhost.localdomain> <alpine.LFD.2.00.0905221459030.3570@localhost.localdomain> <alpine.LFD.2.00.0906101803210.3367@localhost.localdomain> <alpine.LFD.2.00.0906121800590.3369@localhost.localdomain> <alpine.LFD.2.00.0906151117440.2800@localhost.localdomain> <alpine.LFD.2.00.0906170903370.2800@localhost.localdomain> <alpine.LFD.2.00.09
 06231418500.2767@localhost.localdomain> <alpine.LFD.2.00.0907092020410.2768@localhost.localdomain> <alpine.LFD.2.00.0907300006250.2936@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig72BAC721EF3030EE88D796D1"
Cc: LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752620AbZG3KFH@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.0907300006250.2936@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig72BAC721EF3030EE88D796D1
Content-Type: multipart/mixed;
 boundary="------------000600040706050305030305"

This is a multi-part message in MIME format.
--------------000600040706050305030305
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/30/2009 02:48 AM, Thomas Gleixner wrote:
>    Part of that semaphore rework is the RFC patch series I posted
>    recently to get rid of the init_MUTEX[_LOCKED] irritation (minus
>    the ones which turned out to be wrong)

this change breaks the compilation of the binary nvidia kernel module.
in order to build the module, i need to apply the attached patch.

best, tim

--=20
tim@klingt.org
http://tim.klingt.org

Silence is only frightening to people who are compulsively
verbalizing.
  William S. Burroughs

--------------000600040706050305030305
Content-Type: text/x-diff;
 name="rt_preempt_31.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="rt_preempt_31.patch"

--- /home/tim/.emacs.d/backups/!var!lib!dkms!nvidia!185.18.29!build!nv-li=
nux.h.~1~	2009-07-30 11:21:49.069661782 +0200
+++ /usr/src/nvidia-185.18.29/nv-linux.h	2009-07-30 11:38:44.857538204 +0=
200
@@ -721,7 +721,7 @@
 #define nv_up(lock)                     up(&lock)
=20
 #if defined(CONFIG_PREEMPT_RT)
-#define NV_INIT_MUTEX(mutex) init_MUTEX(mutex)
+#define NV_INIT_MUTEX(mutex) semaphore_init(mutex)
 #else
 #if !defined(__SEMAPHORE_INITIALIZER) && defined(__COMPAT_SEMAPHORE_INIT=
IALIZER)
 #define __SEMAPHORE_INITIALIZER __COMPAT_SEMAPHORE_INITIALIZER

--------------000600040706050305030305--

--------------enig72BAC721EF3030EE88D796D1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkpxblQACgkQdL+4qsZfVsswygCgmNAw+26d4Jt0g8CmNNkF0Ssn
65UAoIMSDrMoNRKdZLYgOWjwzc2t9b9P
=cA6B
-----END PGP SIGNATURE-----

--------------enig72BAC721EF3030EE88D796D1--
