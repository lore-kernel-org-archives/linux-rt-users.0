From: Clark Williams <clark.williams@gmail.com>
Subject: Re: [PATCH] pip_stress: increase usleep for ARM devices
Date: Thu, 15 Jan 2015 12:44:08 -0600
Message-ID: <20150115124408.457e1c83@sluggy>
References: <1418199901-3175-1-git-send-email-chase.qi@linaro.org>
	<54885564.2050904@linaro.org>
	<20141210151650.1995581e@sluggy>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/Rb6X2+p0TsljGM=cNTN6rnR"; protocol="application/pgp-signature"
Cc: chase.qi@linaro.org, linux-rt-users@vger.kernel.org,
	milosz.wasilewski@linaro.org, naresh.kamboju@linaro.org,
	anders.roxell@linaro.org, mike.holmes@linaro.org,
	John Kacur <jkacur@gmail.com>
To: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47]:44766 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753512AbbAOSoS (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 15 Jan 2015 13:44:18 -0500
Received: by mail-qg0-f47.google.com with SMTP id q108so13072371qgd.6
        for <linux-rt-users@vger.kernel.org>; Thu, 15 Jan 2015 10:44:18 -0800 (PST)
In-Reply-To: <20141210151650.1995581e@sluggy>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/Rb6X2+p0TsljGM=cNTN6rnR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Dec 2014 15:16:50 -0600
Clark Williams <clark.williams@gmail.com> wrote:

> On Wed, 10 Dec 2014 09:15:00 -0500
> Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org> wrote:
>=20
> > On 12/10/2014 03:25 AM, chase.qi@linaro.org wrote:
> > > From: Chase Qi <chase.qi@linaro.org>
> > >
> > > Hello,
> > >
> > > pip_stress works out of the box on my x86 based laptop, but
> > > doesn't work on ARM devices, returned 'no inversion incurred'.
> > > Follow the comment to increase usleep value, 2500 worked for
> > > pandaboard and 3000 worked for Beaglebone Black board.
> > >
> > > I propose that increase the usleep value to 3500 from upstream,
> > > so that we can use pip_stress right out of the box.
> > >
> > > Please let me know if this is acceptable.
> >=20
> > I think they should have modified main() to accept the lock time as a p=
arameter
> > instead of simply adding some instructions in the comments
> >=20
> >  * to show that it works. If you are having difficulty triggering an in=
version,
> >  * merely increase the time that the low priority process sleeps while
> >  * holding the lock. (usleep);
> >  * Also note that you have to run as a user with permission to change
> >  * scheduling priorities.
> >  */
> >=20
> > what I would do is actually
> > 1. modify main to accept lock_time
> > 2. send the patch to the rt-tests team
> >=20
> >=20
> >
>=20
> I wish we didn't have to deal with timers here. I used barriers when I
> wrote pi_stress.c and obviously we don't have that luxury with
> pip_stress.c. I guess the best thing we can do right now is add a
> parameter to change the default timer value for pip_stress and see if
> someone comes up with a brilliant state-machine solution that will work
> between processes :).
>=20
> John and I are about to start a sweep through the tests and will
> probably come out with a new rt-tests around the first of the year.=20
>=20
> Clark

Here's what I've got for the problem. Comments?


commit 57f700830439fd036cfd8231f4b4a077c9fc461b
Author: Clark Williams <clark.williams@gmail.com>
Date:   Thu Jan 15 12:35:05 2015 -0600

    pip_stress: parameterize usleep value to work-around platform
    issuess=20
    ARM platforms have timing issues with pip_stress:
   =20
        Hello,
   =20
        pip_stress works out of the box on my x86 based laptop, but
        doesn't work on ARM devices, returned 'no inversion incurred'.
        Follow the comment to increase usleep value, 2500 worked for
        pandaboard and 3000 worked for Beaglebone Black board.
   =20
        I propose that increase the usleep value to 3500 from upstream,
        so that we can use pip_stress right out of the box.
   =20
    Rather than hardcode the usleep value used by pip_stress, I made
    the command line option --usleep which takes a microsecond value
    that defaults to 500us.
   =20
    Reported-by: Chase Qi <chase.qi@linaro.org>
    Signed-off-by: Clark Williams <clark.williams@gmail.com>

diff --git a/src/pi_tests/pip_stress.c b/src/pi_tests/pip_stress.c
index 2b42b8ff2491..66b3dc1c9fea 100644
--- a/src/pi_tests/pip_stress.c
+++ b/src/pi_tests/pip_stress.c
@@ -56,6 +56,12 @@
=20
 #include "pip_stress.h"
=20
+#include <unistd.h>
+#include <getopt.h>
+
+/* default time for low priority thread usleep */
+useconds_t usleep_val =3D 500;
+
 pthread_mutex_t *resource;
=20
 /* This records the state to determine whether a priority inversion
occured */ @@ -73,6 +79,11 @@ struct State *statep;
 const int policy =3D SCHED_FIFO;
 const int prio_min;    /* Initialized for the minimum priority of
policy */=20
+struct option long_options[] =3D {
+    { "usleep", required_argument, 0, 0 },
+    { 0,        0,                 0, 0 },
+};
+
 int main(void)
 {
        void *mptr;     /* memory pointer */
@@ -80,6 +91,7 @@ int main(void)
        cpu_set_t set, *setp =3D &set;
        int res;
        int *minimum_priority =3D (int*)&prio_min;
+       int c;
=20
        *minimum_priority =3D sched_get_priority_min(policy);
=20
@@ -162,7 +174,7 @@ void low(pid_t pid)
                                statep->inversion =3D 0;
                        }
                Pthread_mutex_unlock(statep->mutex);
-               usleep(500);
+               usleep(usleep_val);
        Pthread_mutex_unlock(resource);
        waitpid(pid, &status, 0);
 }


--Sig_/Rb6X2+p0TsljGM=cNTN6rnR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUuAp8AAoJEEersVlSw9NzjBgP/34vnsfXBSYfLpWWb/0Yuep+
W7XmiEYjcVKOSQ1RpsF1uANE+Gh9YQBBEUThGBPSJcpBTBG0Bd+sZnf6yX8Gj3Pk
pLkVrL5bpTuSUJPK87diBByA64qQpopR2mVOhoS89MPvuM9C52Qh9Oe8uQNwT+SS
gYTVlD08vQB0weJANrxGvxbu3CWIC6yXh2Hmw3aMl9Eh5bLSwzkWU+PbOTnol1nv
OxnIF7WcoaWjpWFQzlvEhMMhlTbMgsKYgLMiPpmYq/wjutoEd3nasPYnRZ3EvCVh
GoylXSHN6/T4hj5INSU4Slb5yoojAQiUZH+QwecbZ3ImzOmRaSdzTZhRWAeevXhK
NT3mrbvEWyGt6BHKMqRYhhiqd4aUrjcRAEmyzbX1cD+T3GT+3sHGOxJEq+nTJHqQ
Bm7ti4TgjtiOFQUVTjQ6bJdt85vqIGloqqomkbXBQYXfPotgn65eCLQKkrjbadm/
i/JqgRZd/jQ97xx9ub4u+Dd4JNhZawAIQ6+PGiYYMdS0fcefm24l3z0omEQrRC/m
KD53l8vW0/GCHYHGBV69NQN/aBpY1E5fXGUU8u1NYzguVD/lygIWGWU7yBw5CfFn
CM4+85HroeWPQDBDh5NIDNzYDww3157CEyZxp/IQFcwQLfywnIQdR0sMiHVeztE5
Dd39a4lhEBDdK+8mQo/N
=814I
-----END PGP SIGNATURE-----

--Sig_/Rb6X2+p0TsljGM=cNTN6rnR--
