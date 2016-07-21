From: Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH] cyclictest: Fix a maybe-uninitialized warn on duration option
Date: Wed, 20 Jul 2016 21:48:08 -0300
Message-ID: <1469062088-3608-1-git-send-email-bristot@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39439 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753231AbcGUAsQ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 20 Jul 2016 20:48:16 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 006967F0A4
	for <linux-rt-users@vger.kernel.org>; Thu, 21 Jul 2016 00:48:16 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I am having the following warning while compiling cyclictest on
=46edera 24 (GCC 6.1.1 20160621):

--------------------------%<-------------------------------------------=
-
[root@f24desk rt-tests]# make
cc -D VERSION=3D1.1 -c src/cyclictest/cyclictest.c -Wall -Wno-nonnull -=
O2 -DNUMA -DHAVE_PARSE_CPUSTRING_ALL -D_GNU_SOURCE -Isrc/include -o bld=
/cyclictest.o
src/cyclictest/cyclictest.c: In function =E2=80=98timerthread=E2=80=99:
src/cyclictest/cyclictest.c:427:30: warning: =E2=80=98*((void *)&stop+8=
)=E2=80=99 may be used uninitialized in this function [-Wmaybe-uninitia=
lized]
  diff +=3D ((int) t1.tv_nsec - (int) t2.tv_nsec) / 1000;
                              ^~~~~~~~~~~~~~~~
src/cyclictest/cyclictest.c:980:39: note: =E2=80=98*((void *)&stop+8)=E2=
=80=99 was declared here
  struct timespec now, next, interval, stop;
                                       ^~~~
src/cyclictest/cyclictest.c:426:54: warning: =E2=80=98stop.tv_sec=E2=80=
=99 may be used uninitialized in this function [-Wmaybe-uninitialized]
  diff =3D USEC_PER_SEC * (long long)((int) t1.tv_sec - (int) t2.tv_sec=
);
                                                      ^~~~~~~~~~~~~~~
src/cyclictest/cyclictest.c:980:39: note: =E2=80=98stop.tv_sec=E2=80=99=
 was declared here
  struct timespec now, next, interval, stop;
                                       ^~~~
-------------------------->%-------------------------------------------=
-

This is a false positive, but rather than workaround it using GCC pragm=
a
option, I think it is better to use stop variable itself to define
whether it should be used of not.

Cc: John Kacur <jkacur@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
---
 src/cyclictest/cyclictest.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 5e23fc5..ad11b1b 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -977,7 +977,8 @@ static void *timerthread(void *param)
 	struct sigevent sigev;
 	sigset_t sigset;
 	timer_t timer;
-	struct timespec now, next, interval, stop;
+	struct timespec now, next, interval;
+	struct timespec *stop =3D NULL;
 	struct itimerval itimer;
 	struct itimerspec tspec;
 	struct thread_stat *stat =3D par->stats;
@@ -1066,9 +1067,11 @@ static void *timerthread(void *param)
 	tsnorm(&next);
=20
 	if (duration) {
-		memset(&stop, 0, sizeof(stop)); /* grrr */
-		stop =3D now;
-		stop.tv_sec +=3D duration;
+		stop =3D malloc(sizeof(struct timespec));
+		if (!stop)
+			fatal("error allocating space for duration option\n");
+		stop->tv_sec =3D now.tv_sec + duration;
+		stop->tv_nsec =3D now.tv_nsec;
 	}
 	if (par->mode =3D=3D MODE_CYCLIC) {
 		if (par->timermode =3D=3D TIMER_ABSTIME)
@@ -1185,7 +1188,7 @@ static void *timerthread(void *param)
 		}
=20
=20
-		if (duration && (calcdiff(now, stop) >=3D 0))
+		if (stop && (calcdiff(now, *stop) >=3D 0))
 			shutdown++;
=20
 		if (!stopped && tracelimit && (diff > tracelimit)) {
--=20
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
