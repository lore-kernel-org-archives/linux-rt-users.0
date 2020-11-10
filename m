Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20A2C56202
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Nov 2020 18:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 821F020809
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Nov 2020 18:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="otTGfp3V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5HxADKmC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731006AbgKJSAq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 10 Nov 2020 13:00:46 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59938 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgKJSAp (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 10 Nov 2020 13:00:45 -0500
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605031243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KmYmd5g/M2G3cWAvK+VMBZ2tjoqz0CQ3HLJB5iH1L/M=;
        b=otTGfp3VuXiJW7gxpNLZOKBTlgaDC+tjvKYsU9HJ3TwfCZHieF4eaxvLfhe0/m7pUnFh1p
        /ERedZ4EogFkigtZqhpARG3cjNVwKBywCoH5mda1F/755TmQBSYV739uY20yGl8JHvv8pR
        cVwLngBzW8CvZqzyGINdjYt9/5ra3BH08Dqvm1c7ryus24tXm6t65SAsTFjXuSjRkKMLzJ
        CWAoUHC7R0ZC/kLF4EqVYpJiOb3ELRmRrPpsZolQi5DR5GeZPn16NkmOvAm1Zgpx8mXRmo
        7wHi647ZVjTVcRxyEXWN5vyWyF2pEZyAYd4CSG6SkWSYC/vuUdOufxPmsYa1VA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605031243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KmYmd5g/M2G3cWAvK+VMBZ2tjoqz0CQ3HLJB5iH1L/M=;
        b=5HxADKmC/XN4zdSVgpZn/J2c+zt94eZfoxfGhyda+/6y/xvOs1pBfmo7TFYYXFck3iRD8N
        d8oN1cZawtmMuEBg==
To:     linux-rt-users@vger.kernel.org
Cc:     John Kacur <jkacur@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Daniel Wagner <wagi@monom.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 5/5] signaltest: Add tracing bits
Date:   Tue, 10 Nov 2020 19:00:36 +0100
Message-Id: <20201110180036.859080-6-bigeasy@linutronix.de>
In-Reply-To: <20201110180036.859080-1-bigeasy@linutronix.de>
References: <20201110180036.859080-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

This isn't intended for merging.
This is just for Daniel to help him with tracing.

The intention:
- TH0 waits for a signal
- TH1 waits for a signal
- main thread sends a signal to TH1
- TH0 wakes up, sends a signal to TH1, waits for SIGNAL
- TH1 wakes up, sends a signal to TH0, waits for SIGNAL
- loop begin.
  - TH0 wakes up, measures the delay between sending a signal and
    receiving a signal. Sends a signal to TH1.
  - TH1 wakes up, sends a signal to TH0, waits for SIGNAL
  - loop end.

There is nothing that pins the two threads. So the scheduler might be
busy to move them from CPU to another. Pinning everything to one CPU
might make a difference.

  taskset -c 1 ~/signaltest -m -p 98 -b 400

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 src/signaltest/signaltest.c | 47 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
index dacaa63673c48..b504eef149cd9 100644
--- a/src/signaltest/signaltest.c
+++ b/src/signaltest/signaltest.c
@@ -65,6 +65,25 @@ static int shutdown;
 static int tracelimit;
=20
=20
+static int trace_marker =3D -1;
+
+static void trace_log(const char *s)
+{
+	write(trace_marker, s, strlen(s));
+}
+
+
+static int trace_switch =3D -1;
+
+static void trace_on(void)
+{
+	write(trace_switch, "1", 1);
+}
+
+static void trace_off(void)
+{
+	write(trace_switch, "0", 1);
+}
 /*
  * signal thread
  *
@@ -99,8 +118,10 @@ void *signalthread(void *param)
 		long diff;
 		int sigs;
=20
+		trace_log("Before sigwait\n");
 		if (sigwait(&sigset, &sigs) < 0)
 			goto out;
+		trace_log("After sigwait\n");
=20
 		clock_gettime(CLOCK_MONOTONIC, &after);
=20
@@ -108,12 +129,17 @@ void *signalthread(void *param)
 		 * If it is the first thread, sleep after every 16
 		 * round trips.
 		 */
-		if (!par->id && !(stat->cycles & 0x0F))
+		if (!par->id && !(stat->cycles & 0x0F)) {
+			trace_log("Before sleep\n");
 			usleep(10000);
+			trace_log("After sleep\n");
+		}
=20
 		/* Get current time */
 		clock_gettime(CLOCK_MONOTONIC, &now);
+		trace_log("Before phtread_kill\n");
 		pthread_kill(stat->tothread, SIGUSR1);
+		trace_log("After phtread_kill\n");
=20
 		/* Skip the first cycle */
 		if (first) {
@@ -136,6 +162,7 @@ void *signalthread(void *param)
 			stat->interrupted =3D 1;
 			stopped++;
 			shutdown++;
+			trace_log("trace_limit\n");
 		}
 		stat->act =3D diff;
 		stat->cycles++;
@@ -154,6 +181,7 @@ void *signalthread(void *param)
=20
 	stat->threadstarted =3D -1;
=20
+	trace_off();
 	return NULL;
 }
=20
@@ -242,6 +270,7 @@ static void process_options(int argc, char *argv[])
 static void sighand(int sig)
 {
 	shutdown =3D 1;
+	trace_off();
 }
=20
 static void print_stat(struct thread_param *par, int index, int verbose)
@@ -287,6 +316,18 @@ int main(int argc, char **argv)
 			goto out;
 		}
=20
+	trace_marker =3D open("/sys/kernel/debug/tracing/trace_marker", O_WRONLY);
+	if (trace_marker < 0) {
+		printf("Failed to open trace_marker: %m\n");
+		exit(1);
+	}
+
+	trace_switch =3D open("/sys/kernel/debug/tracing/tracing_on", O_WRONLY);
+	if (trace_switch < 0) {
+		printf("Failed to open trace_marker: %m\n");
+		exit(1);
+	}
+
 	sigemptyset(&sigset);
 	sigaddset(&sigset, signum);
 	sigprocmask(SIG_BLOCK, &sigset, NULL);
@@ -305,6 +346,7 @@ int main(int argc, char **argv)
 	if (!stat)
 		goto outpar;
=20
+	trace_on();
 	for (i =3D 0; i < num_threads; i++) {
 		if (verbose) {
 			stat[i].values =3D calloc(VALBUF_SIZE, sizeof(long));
@@ -348,7 +390,9 @@ int main(int argc, char **argv)
 		stat[i].tothread =3D stat[0].thread;
 		break;
 	}
+	trace_log("Main phtread_kill\n");
 	pthread_kill(stat[0].thread, signum);
+	trace_log("Main phtread_kill post\n");
=20
 	while (!shutdown) {
 		char lavg[256];
@@ -374,6 +418,7 @@ int main(int argc, char **argv)
 	}
 	ret =3D 0;
  outall:
+	trace_off();
 	shutdown =3D 1;
 	usleep(50000);
 	if (quiet)
--=20
2.29.2

