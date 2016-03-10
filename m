From: Clark Williams <williams@redhat.com>
Subject: Re: rt-tests Android.mk for cyclictest and hackbench
Date: Thu, 10 Mar 2016 10:18:41 -0600
Message-ID: <20160310101841.2bf5ee3b@sluggy.hsv.redhat.com>
References: <CAB+ZbRV_5c_+e2YrcCSPFg6+7pxHfxZVvLGeWoGcH1Mf7_czLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/gUrPH2gFg0Z_.fgb6UVy32R"; protocol="application/pgp-signature"
Cc: John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org
To: Eric Jensen <ericcj@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33417 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752932AbcCJQSs (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 10 Mar 2016 11:18:48 -0500
In-Reply-To: <CAB+ZbRV_5c_+e2YrcCSPFg6+7pxHfxZVvLGeWoGcH1Mf7_czLw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/gUrPH2gFg0Z_.fgb6UVy32R
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 10 Mar 2016 09:59:05 -0500
Eric Jensen <ericcj@gmail.com> wrote:

> I couldn't find one of these on the web, but I think it would be nice to
> include in the git repo to make it easy for people to add to their manife=
st
> when building AOSP.  This Android.mk is working for me on lollipop and I
> think would work for others:
>=20

I'm ok with including this file.=20

For future reference the correct way to submit this sort of thing is in pat=
ch format. I grabbed your file and stuck it in the top level directory, add=
ed it to my git tree then ran 'git format-patch' with the SHA1 of the commi=
t following your commit. This generated the patch below, which gives us att=
ribution information, the files location and contents, and the appropriate =
mode for the newly created file. Please let me know if I put it in the righ=
t place with the right permissions.=20

Clark


=46rom 6fa0bf068fdbff809a4a903bcb28aa499b1f88c7 Mon Sep 17 00:00:00 2001
From: Eric Jensen <ericcj@gmail.com>
Date: Thu, 10 Mar 2016 10:11:25 -0600
Subject: [PATCH] Android Makefile for rt-tests

Signed-off-by: Clark Williams <williams@redhat.com>
---
 Android.mk | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Android.mk

diff --git a/Android.mk b/Android.mk
new file mode 100644
index 000000000000..0df3aac9db1f
--- /dev/null
+++ b/Android.mk
@@ -0,0 +1,39 @@
+LOCAL_PATH:=3D $(call my-dir)
+
+commonFlags :=3D -Wall -Wno-nonnull -O2 -DPTHREAD_BIONIC -DVERSION=3D0.96
+-D_GNU_SOURCE
+
+include $(CLEAR_VARS)
+LOCAL_MODULE :=3D librttest
+LOCAL_MODULE_TAGS :=3D eng
+FILE_LIST :=3D $(wildcard $(LOCAL_PATH)/src/lib/*.c)
+LOCAL_SRC_FILES :=3D $(FILE_LIST:$(LOCAL_PATH)/%=3D%)
+LOCAL_CFLAGS +=3D $(commonFlags)
+LOCAL_LDLIBS +=3D -ldl
+LOCAL_LDFLAGS +=3D -pie
+LOCAL_C_INCLUDES +=3D $(LOCAL_PATH)/src/include
+include $(BUILD_STATIC_LIBRARY)
+
+include $(CLEAR_VARS)
+LOCAL_MODULE :=3D cyclictest
+LOCAL_MODULE_TAGS :=3D eng
+LOCAL_STATIC_LIBRARIES :=3D librttest
+FILE_LIST :=3D $(wildcard $(LOCAL_PATH)/src/cyclictest/*.c)
+LOCAL_SRC_FILES :=3D $(FILE_LIST:$(LOCAL_PATH)/%=3D%)
+LOCAL_CFLAGS +=3D $(commonFlags)
+LOCAL_LDLIBS +=3D -ldl
+LOCAL_LDFLAGS +=3D -pie
+LOCAL_C_INCLUDES +=3D $(LOCAL_PATH)/src/include
+include $(BUILD_EXECUTABLE)
+
+include $(CLEAR_VARS)
+LOCAL_MODULE :=3D hackbench
+LOCAL_MODULE_TAGS :=3D eng
+LOCAL_STATIC_LIBRARIES :=3D librttest
+FILE_LIST :=3D $(wildcard $(LOCAL_PATH)/src/hackbench/*.c)
+LOCAL_SRC_FILES :=3D $(FILE_LIST:$(LOCAL_PATH)/%=3D%)
+LOCAL_CFLAGS +=3D $(commonFlags)
+LOCAL_LDLIBS +=3D -ldl
+LOCAL_LDFLAGS +=3D -pie
+LOCAL_C_INCLUDES +=3D $(LOCAL_PATH)/src/include
+include $(BUILD_EXECUTABLE)
--=20
2.5.0



--Sig_/gUrPH2gFg0Z_.fgb6UVy32R
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJW4Z5hAAoJEOI5asVwYXLrXYUP/i4JldEY1CQoXuGs2V9IlD57
BF8aYVqfWqA5CMEYxMF6QbqYQJYEx2SWPUpYOEdt5vMtzW6L7i5bLScVdASc9SHk
8kKrAy+vSSCC2OegTQdTiITzsK1RgXn0Ky2CZgyS6Foat4TvKH6HKWyb+OwKJP5l
r2SKgQC4xocVTiPIrTMNsq9v+26vfVT2cA+tZOzGkp/t73U8OlTYZ1De3wLm3zU6
UrrMivnL7VaslU4u5aTw8mStP8D3jm4MOgyfanOd16hX79ifPsF+IHlOunK+kFnh
Uio/AafrXU85TOOr2cloGj+nLjKBF6x73jP7BA3up3EzGUcrQliE3rMplAT/YRm0
z/Ueoj+D+T5WDt3IvEyMa7br3agoTXedIRjoDSjL8liW6pr0TnZusarrnXw9LQ4E
gS2CTgDnYHSE7e0QQp8XujhrhHfL71Kxp/gjKNqjMkOqp7SoMkODxoA1jDlx2HSQ
ZlXnS2t6/aeCptO7fxmiRMLplltBx9KdZCkiDZ2Zt1kybe75X9IS+NdT9OlZkXmw
qrSTlWFaYQlSBqwp26Pg9FliUho2NNLvVm8/NJOGyVLUF9QQp+23GF1Cb6iGpDAQ
7j/JwHs8D+DGejj8dVJnZO/KGZnTlZXiLZgcwtb26Orhj545080zEB0mYiUvcwxO
dkr0WaxtdyDtDZ481h3L
=schh
-----END PGP SIGNATURE-----

--Sig_/gUrPH2gFg0Z_.fgb6UVy32R--
