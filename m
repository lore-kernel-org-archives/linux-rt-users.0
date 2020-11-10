Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91BDC56201
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Nov 2020 18:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83C0920797
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Nov 2020 18:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KgiMQW1v";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IwsBQA60"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730618AbgKJSAo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 10 Nov 2020 13:00:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59922 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgKJSAo (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 10 Nov 2020 13:00:44 -0500
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605031242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cDjULcWo0N45Zc4U6wS7RxOa3bru8Pmc0BZqUQmU1w8=;
        b=KgiMQW1vT75uBDdrFXa0fPyxz6BAUC0quGGhHrb2/ubDr3CiKr39LZiJBo8h0bZ6OeijGt
        hiZGTGNA8zqM8/L0dOzL2uBMyTo1rY7HiCVjdw/coWVdxcC3zLxB9W4nCwFuawc8Q5z0Gx
        cGQILoHCiQnHOPiWaTVSvjaehihlIkqUUaK/LQ+TUxGnq/0WkzaIuBIyKZgDq1vwOGMN4t
        UkFZVeYtWGF9ye0Jn+v15bZ0xz8CNImtNU2S7I7GFP8Ed349x/Gu94b/2onzz0BRF28rMT
        kHwNV7yfbzo5L7t1Fg/1aVPjPPDTzJqwDMYO/ERXJ2/IgiJYFoWsW/gh4Mp4Lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605031242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cDjULcWo0N45Zc4U6wS7RxOa3bru8Pmc0BZqUQmU1w8=;
        b=IwsBQA60pJGYe1qrHzyhP7bcJAOoQw4intYL/NcqhzUnZ6BVHZhHr1Q43WHLqv9CDgj5Pj
        pc54FzVhLk30WGBg==
To:     linux-rt-users@vger.kernel.org
Cc:     John Kacur <jkacur@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Daniel Wagner <wagi@monom.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/5] signaltest: Remove drunk code
Date:   Tue, 10 Nov 2020 19:00:33 +0100
Message-Id: <20201110180036.859080-3-bigeasy@linutronix.de>
In-Reply-To: <20201110180036.859080-1-bigeasy@linutronix.de>
References: <20201110180036.859080-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

`oldtrace' is set for kernels prior 2.6.18. Remove "support" for them.

The alternative code (for new kernels) issues
	prctl(0, [01]);

which is not valid the kernel returns an error. I have no idea what its
purpose is, remove it.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 src/signaltest/signaltest.c | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
index 1cc3236a8f377..aceb714d3e9d3 100644
--- a/src/signaltest/signaltest.c
+++ b/src/signaltest/signaltest.c
@@ -62,7 +62,6 @@ struct thread_stat {
=20
 static int shutdown;
 static int tracelimit;
-static int oldtrace;
=20
=20
 /*
@@ -105,13 +104,6 @@ void *signalthread(void *param)
=20
 	stat->threadstarted++;
=20
-	if (tracelimit) {
-		if (oldtrace)
-			gettimeofday(0, (struct timezone *)1);
-		else
-			prctl(0, 1);
-	}
-
 	clock_gettime(CLOCK_MONOTONIC, &before);
=20
 	while (!shutdown) {
@@ -152,10 +144,6 @@ void *signalthread(void *param)
=20
 		if (!stopped && tracelimit && (diff > tracelimit)) {
 			stopped++;
-			if (oldtrace)
-				gettimeofday(0, 0);
-			else
-				prctl(0, 0);
 			shutdown++;
 		}
 		stat->act =3D diff;
@@ -260,21 +248,6 @@ static void process_options(int argc, char *argv[])
 		display_help(error);
 }
=20
-static void check_kernel(void)
-{
-	size_t len;
-	char ver[256];
-	int fd, maj, min, sub;
-
-	fd =3D open("/proc/version", O_RDONLY, 0666);
-	len =3D read(fd, ver, 255);
-	close(fd);
-	ver[len-1] =3D 0x0;
-	sscanf(ver, "Linux version %d.%d.%d", &maj, &min, &sub);
-	if (maj =3D=3D 2 && min =3D=3D 6 && sub < 18)
-		oldtrace =3D 1;
-}
-
 static void sighand(int sig)
 {
 	shutdown =3D 1;
@@ -323,8 +296,6 @@ int main(int argc, char **argv)
 			goto out;
 		}
=20
-	check_kernel();
-
 	sigemptyset(&sigset);
 	sigaddset(&sigset, signum);
 	sigprocmask(SIG_BLOCK, &sigset, NULL);
--=20
2.29.2

