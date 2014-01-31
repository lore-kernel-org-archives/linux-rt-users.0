From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH rt-tests v2] Fix tracemark output when the latency threshold is hit on ARM
Date: Fri, 31 Jan 2014 20:16:52 +0100
Message-ID: <1391195812-24833-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1390945793-28357-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58814 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932499AbaAaTRC (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 31 Jan 2014 14:17:02 -0500
In-Reply-To: <1390945793-28357-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On ARM I'm seeing output like:

	cyclicte-623     0....... 19619418us+: tracing_mark_write: hit latency=
 threshold (2000 > 2097)

That's because of a format mismatch in

	tracemark("hit latency threshold (%d > %d)", diff, tracelimit);

diff is a u64 and tracelimit an int. So on ARM the string is passed in =
r0,
tracelimit in r1 and diff in r2+r3. vsnprintf used in tracemark only
expects two ints passed and so only uses r1 and r2 yielding the permuta=
tion
in the output.

This patch also adds a gcc attribute to tracemark that helps catching
similar bugs. In this case just adding the attribute but not touching
the call site, would result in:

	src/cyclictest/cyclictest.c: In function =E2=80=98timerthread=E2=80=99=
:
	src/cyclictest/cyclictest.c:899:4: warning: format =E2=80=98%d=E2=80=99=
 expects argument of type =E2=80=98int=E2=80=99, but argument 2 has typ=
e =E2=80=98uint64_t=E2=80=99 [-Wformat]

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
Hello

after some chatting with Clark and John I dropped the c99 stuff and add=
ed the
attribute annotation.

Best regards
Uwe

 src/cyclictest/cyclictest.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 686a6356659f..638e1ab57634 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -400,6 +400,7 @@ static int trace_file_exists(char *name)
 #define TRACEBUFSIZ 1024
 static __thread char tracebuf[TRACEBUFSIZ];
=20
+static void tracemark(char *fmt, ...) __attribute__((format(printf, 1,=
 2)));
 static void tracemark(char *fmt, ...)
 {
 	va_list ap;
@@ -895,7 +896,8 @@ void *timerthread(void *param)
=20
 		if (!stopped && tracelimit && (diff > tracelimit)) {
 			stopped++;
-			tracemark("hit latency threshold (%d > %d)", diff, tracelimit);
+			tracemark("hit latency threshold (%llu > %d)",
+				  (unsigned long long)diff, tracelimit);
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
