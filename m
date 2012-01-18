From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 0/4] [ANNOUNCE] 3.0.14-rt32-rc1
Date: Tue, 17 Jan 2012 22:45:31 -0500
Message-ID: <20120118034531.335521323@goodmis.org>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="00GvhwF7k39YY"
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

--00GvhwF7k39YY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable


Dear RT Folks,

This is the RT stable review cycle of patch 3.0.14-rt32-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candida=
te).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 1/20/2012.

Enjoy,

-- Steve


To build 3.0.14-rt32-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.0/linux-3.0.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.0/patch-3.0.14.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.0/patch-3.0.14-rt32-=
rc1.patch.xz

You can also build from 3.0.14-rt31 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/3.0/incr/patch-3.0.14-rt=
31-rt32-rc1.patch.xz


Changes from 3.0.14-rt31:

---


Steven Rostedt (1):
      Linux 3.0.14-rt32-rc1

Thomas Gleixner (3):
      sched: ttwu: Return success when only changing the saved_state value
      wait-simple: Simple waitqueue implementation
      acpi-gpe-use-wait-simple.patch

----
 drivers/acpi/ec.c           |    8 +-
 drivers/acpi/internal.h     |    4 +-
 include/linux/wait-simple.h |  152 +++++++++++++++++++++++++++++++++++++++=
++++
 kernel/Makefile             |    2 +-
 kernel/sched.c              |    4 +-
 kernel/wait-simple.c        |   62 +++++++++++++++++
 localversion-rt             |    2 +-
 7 files changed, 226 insertions(+), 8 deletions(-)

--00GvhwF7k39YY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPFkCvAAoJEIy3vGnGbaoABTMQAN5nYQV9dlXLq6VfpkNeqof+
u4/jZYVQYKY67aZZKIGm9Z1/D7c/JezCe5Z2Y6OkjvGIgbkbcYNe8TwSTLluUf+F
eH7j5iyZGO3u13DkfXcWyiPwMbUtlp7FwoPayZcv9YF7A39l8+mQXVd221Mo5bDe
xI/8/Gj6iCiJft/JmRMqxHMwG62IA7Pz34qHa5IHJIKxE/JFoVJtYv/21KMpuqu8
uENy6A2rZuxzNkd6jkQexjgDH17279bE7AIUpHw23KkpM3s+iimciy/SwKCFsDPk
zMwn6/WVow1c5VQRMWV8IWRE5x3W/6FmQ9wn6bNQglKX3/A6ZGVAkDNtjEhqLTH3
mxNy6SYsNKKCSxCHNIlsHnjIyQQ1E6i7GO+5Lg9vnsvg5O2knAEL1zyqcVZi3qxZ
ZlmM6lHRo/vf//HgYtALo9ZH50OHLOmQHMY7PRlUqLFMWqM81zm8jMBGTCZtX5HJ
as0dTz9PtUuoyj1YaGzD1KFRtYyT7/iomZHCImOPypJ4PLudLOWQU1M703+/mHM4
ekRi4MlZL2lAMPV1jxKsRfXnbgRrAsTzZ2CnMkCq7MW4eyL8Aqg4QyJx6EU78nA6
uCmPnE+1m/TcA3OaZQ1naTHTmxUTXa/6tX4lplEWig7aFFh/CKCV9dHLLAT+3p+y
5fg7GyWUkp2VKRGVW9R9
=1z9/
-----END PGP SIGNATURE-----

--00GvhwF7k39YY--
