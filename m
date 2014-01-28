From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH rt-tests] Fix tracemark output when the latency threshold is hit on ARM
Date: Tue, 28 Jan 2014 22:49:53 +0100
Message-ID: <1390945793-28357-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34632 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932174AbaA1VuB (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 28 Jan 2014 16:50:01 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On ARM I'm seeing output like:

	cyclicte-623     0....... 19619418us+: tracing_mark_write: hit latency=
 threshold (2000 > 2097)

That's because of a format mismatch in

	tracemark("hit latency threshold (%d > %d)", diff, tracelimit);

diff is a u64 and tracelimit an int. So on ARM the string is passed in =
r0,
tracelimit in r1 and diff in r2+r3. The vsnprintf used in tracemark onl=
y
expects to ints passed and so only uses r1 and r2 yielding the permutat=
ion
in the output.

With a printf attribute annotation for tracemark added this patch fixes=
 a
compiler warning:

	src/cyclictest/cyclictest.c: In function =E2=80=98timerthread=E2=80=99=
:
	src/cyclictest/cyclictest.c:899:4: warning: format =E2=80=98%d=E2=80=99=
 expects argument of type =E2=80=98int=E2=80=99, but argument 2 has typ=
e =E2=80=98uint64_t=E2=80=99 [-Wformat]

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
=46ixes: 7667ff694693 ("add setup and call of tracemark function for br=
eaktrace")
---
Hello,

I'm not sure you like that c99 stuff. Tell me if you prefer a cast
to unsigned long long + %llu.

Also, what do you think about adding the printf annotation? Do we care =
about
non-gcc compilers?

Best regards
Uwe

 src/cyclictest/cyclictest.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 686a6356659f..d1e70901e39f 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -15,6 +15,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <stdint.h>
+#include <inttypes.h>
 #include <stdarg.h>
 #include <unistd.h>
 #include <fcntl.h>
@@ -895,7 +896,7 @@ void *timerthread(void *param)
=20
 		if (!stopped && tracelimit && (diff > tracelimit)) {
 			stopped++;
-			tracemark("hit latency threshold (%d > %d)", diff, tracelimit);
+			tracemark("hit latency threshold (%" PRIu64 " > %d)", diff, traceli=
mit);
 			tracing(0);
 			shutdown++;
 			pthread_mutex_lock(&break_thread_id_lock);
--=20
1.8.5.2

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
