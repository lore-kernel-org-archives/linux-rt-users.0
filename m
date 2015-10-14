From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 2/7] Fix some trivial typos found by codespell(1)
Date: Wed, 14 Oct 2015 15:32:13 +0200
Message-ID: <1444829538-18465-3-git-send-email-jkacur@redhat.com>
References: <1444829538-18465-1-git-send-email-jkacur@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clark Williams <williams@redhat.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>, John Kacur <jkacur@redhat.com>
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:35867 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753287AbbJNNdH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 14 Oct 2015 09:33:07 -0400
Received: by wicgb1 with SMTP id gb1so231214843wic.1
        for <linux-rt-users@vger.kernel.org>; Wed, 14 Oct 2015 06:33:06 -0700 (PDT)
In-Reply-To: <1444829538-18465-1-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

=46rom: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Inheritence =3D=3D> Inheritance
occured =3D=3D> occurred
surpress =3D=3D> suppress

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/pi_tests/classic_pi.c    | 2 +-
 src/pi_tests/pi_stress.c     | 4 ++--
 src/pi_tests/pip_stress.c    | 2 +-
 src/pi_tests/tst-mutexpi10.c | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/pi_tests/classic_pi.c b/src/pi_tests/classic_pi.c
index 59e907bc98cc..695ee4c4bd03 100644
--- a/src/pi_tests/classic_pi.c
+++ b/src/pi_tests/classic_pi.c
@@ -18,7 +18,7 @@
    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  0211=
0-1301
    USA */
=20
-/* This program tests Priority Inheritence mutexes and their ability
+/* This program tests Priority Inheritance mutexes and their ability
    to avoid Priority Inversion deadlocks
  =20
    The basic premise here is to set up a deadlock scenario and confirm=
 that PI
diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
index a4e6e3df1a3d..a02f70629aa4 100644
--- a/src/pi_tests/pi_stress.c
+++ b/src/pi_tests/pi_stress.c
@@ -132,7 +132,7 @@ unsigned long report_interval =3D (unsigned long)SE=
C_TO_USEC(0.75);
 int shutdown =3D 0;		/* global indicating we should shut down */
 pthread_mutex_t shutdown_mtx;	/* associated mutex */
=20
-/* indicate if errors have occured */
+/* indicate if errors have occurred */
 int have_errors =3D 0;
=20
 /* indicated that keyboard interrupt has happened */
@@ -1025,7 +1025,7 @@ void usage(void)
 	printf("usage: pi_stress <options>\n");
 	printf("    options:\n");
 	printf("\t--verbose\t- lots of output\n");
-	printf("\t--quiet\t\t- surpress running output\n");
+	printf("\t--quiet\t\t- suppress running output\n");
 	printf
 	    ("\t--duration=3D<n>- length of the test run in seconds [infinite=
]\n");
 	printf("\t--groups=3D<n>\t- set the number of inversion groups [%d]\n=
",
diff --git a/src/pi_tests/pip_stress.c b/src/pi_tests/pip_stress.c
index 812a7030aa9d..a0477cc2a35d 100644
--- a/src/pi_tests/pip_stress.c
+++ b/src/pi_tests/pip_stress.c
@@ -64,7 +64,7 @@ useconds_t usleep_val =3D 500;
=20
 pthread_mutex_t *resource;
=20
-/* This records the state to determine whether a priority inversion oc=
cured */
+/* This records the state to determine whether a priority inversion oc=
curred */
 struct State {
 	int low_owns_resource;
 	int high_started;
diff --git a/src/pi_tests/tst-mutexpi10.c b/src/pi_tests/tst-mutexpi10.=
c
index 0244b4a7a7c1..a63ea23ba621 100644
--- a/src/pi_tests/tst-mutexpi10.c
+++ b/src/pi_tests/tst-mutexpi10.c
@@ -21,7 +21,7 @@
    Boston, MA 02111-1307, USA.  */
=20
=20
-/* This program tests Priority Inheritence mutexes and their ability
+/* This program tests Priority Inheritance mutexes and their ability
    to avoid Priority Inversion deadlocks
  =20
    The basic premise here is to set up a deadlock scenario and confirm=
 that PI
--=20
2.4.3

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
