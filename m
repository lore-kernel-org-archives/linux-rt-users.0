Return-Path: <SRS0=qZJ4=ZR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7833C432C0
	for <linux-rt-users@archiver.kernel.org>; Mon, 25 Nov 2019 14:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0FA62084D
	for <linux-rt-users@archiver.kernel.org>; Mon, 25 Nov 2019 14:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgBxy7KD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbfKYORA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 25 Nov 2019 09:17:00 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32942 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbfKYORA (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 25 Nov 2019 09:17:00 -0500
Received: by mail-wr1-f65.google.com with SMTP id w9so18315529wrr.0
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Nov 2019 06:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QXQXHnmHKnggbadoyWvHHCSFBpNckbjw7QZ9Lm8A9jI=;
        b=FgBxy7KDVuvMWost+vSJ/9+HuEPonfuj5kU4p2ZmjHOU+3dSUnuIaLxP1CuuPuI4Ge
         HuzMULpu7FMDi/tYaOnv+HIlrO3OXCh45UPOq5gLqylzQxGpAV6Een41j+e3unPr8fZT
         iw4kdLESUyt+OcRPW/kBFi5vWpiqhLcIGq+Y0wNwxD6kUOLgkJ5lVJDdubQPAdkvGnUU
         wGSYimrAeKyZQ+v3qArmVnCscAFHfedA5p4UEY8PDZuoj2FtG/w0L19apcJ7fjiw8c13
         EcUQF0HZ9D2JDq7ImBFLYn7vQilIYAsO96tamGf9fnvwSPjPIYAjmTpnlJvii0mhd1qR
         stLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=QXQXHnmHKnggbadoyWvHHCSFBpNckbjw7QZ9Lm8A9jI=;
        b=ewYU9pDxgPC3LuWieifOZT/PjD8nXdG+uY+fHOIbG0ttqp0C69i4Kftg0lGUGumGcF
         Qzcb1uiqY7V4B25omOnLd84wOPUmy/PIOzs1QRWpKvqYSXAILIexOwgwb8nRoz26J/64
         Pofm9X8JBEGLBG2He7g2kA2QuJ7tSn0+vMrmnJwdKBTqS1kJCadtvm0a/huZD1Moo05n
         SvjlEoC2P3rEl/Xrsu64iUetEEhnBkw+qT4wA0RWpy71PIhzaMRFIDx+eo8rTgetdeec
         rPZtGwpET4Kj7BjPF5dsr6jdKI40DTp3u8jVjn1e/BaxnuNhwgzHDmEwd3VrLvbCwwol
         oK0A==
X-Gm-Message-State: APjAAAWuz8Xw2p5whbcED43JJMlujpiFllFU0KT6zopVEKke2lm9JI53
        76ziV5a0825IPk8IS9KoIRPfRPaRev4=
X-Google-Smtp-Source: APXvYqyO4RnAMe8uKJFIiaXeNzcCxAdCUwLUac4mksYzvzjHfJnnAYzja2pOG0jFJO2gPZixDRbifA==
X-Received: by 2002:adf:ec89:: with SMTP id z9mr31820208wrn.153.1574691418209;
        Mon, 25 Nov 2019 06:16:58 -0800 (PST)
Received: from planxty.redhat.com (ip1f122014.dynamic.kabel-deutschland.de. [31.18.32.20])
        by smtp.gmail.com with ESMTPSA id q5sm8463456wmc.27.2019.11.25.06.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 06:16:57 -0800 (PST)
From:   John Kacur <jkacur@redhat.com>
To:     rt-users <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 2/8] rt-tests: ssdd: Add short and long functions as well as help
Date:   Mon, 25 Nov 2019 15:16:40 +0100
Message-Id: <20191125141644.4429-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191125141644.4429-1-jkacur@redhat.com>
References: <20191125141644.4429-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Add short and long functions as well as help to make ssdd consistent
with the rest of the test suite. Add a help function as well

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/ssdd/ssdd.8 | 10 +++++++---
 src/ssdd/ssdd.c | 45 +++++++++++++++++++++++++++++++++++++++------
 2 files changed, 46 insertions(+), 9 deletions(-)

diff --git a/src/ssdd/ssdd.8 b/src/ssdd/ssdd.8
index 44638489f0d1..99f30145d079 100644
--- a/src/ssdd/ssdd.8
+++ b/src/ssdd/ssdd.8
@@ -3,7 +3,7 @@
 ssdd \- have a tracer do a bunch of PTRACE_SINGLESTEPs
 .SH SYNOPSIS
 .B ssdd
-.RI "[nforks] [niters]"
+.RI "<options>"
 .SH DESCRIPTION
 Have a tracer do a bunch of PTRACE_SINGLESTEPs against
 a tracee as fast as possible.  Create several of these
@@ -12,15 +12,19 @@ interfere with each other.
 The tracer waits on each PTRACE_SINGLESTEP with a waitpid(2)
 and checks that waitpid's return values for correctness.
 .SH OPTIONS
-.B nforks
+.B \-f, \-\-forks
 number of tracer/tracee pairs to fork off.
 Default is 10.
 .br
 .TP
-.B niters
+.B \-i, \-\-iters
 number of PTRACE_SINGLESTEP iterations to
 do before declaring success, for each tracer/
 tracee pair set up. Default is 10,000.
+.br
+.TP
+.B \-h, \-\-help
+Display usage
 
 .SH AUTHOR
 ssdd was written by Joe Korty <joe.korty@concurrent-rt.com>
diff --git a/src/ssdd/ssdd.c b/src/ssdd/ssdd.c
index 2c3a779be9f1..080ed17107a8 100644
--- a/src/ssdd/ssdd.c
+++ b/src/ssdd/ssdd.c
@@ -27,6 +27,7 @@
 #include <stdlib.h>
 #include <stddef.h>
 #include <unistd.h>
+#include <getopt.h>
 #include <string.h>
 #include <signal.h>
 #include <errno.h>
@@ -65,6 +66,17 @@ static const char *get_state_name(int state)
 
 static int got_sigchld;
 
+enum option_value { OPT_NFORKS=1, OPT_NITERS, OPT_HELP };
+
+static void usage()
+{
+	printf("ssdd <options>\n");
+	printf("\t-f --forks=<number of forks>\n");
+	printf("\t-i --iters=<number of iterations>\n");
+	printf("\t-h --help\n");
+	exit(0);
+}
+
 static int do_wait(pid_t *wait_pid, int *ret_sig)
 {
 	int status, child_status;
@@ -276,13 +288,34 @@ int main(int argc, char **argv)
 
 	setbuf(stdout, NULL);
 
-	argc--, argv++;
-	if (argc) {
-		nforks = atoi(*argv);
-		argc--, argv++;
-		if (argc)
-			nsteps = atoi(*argv);
+	for (;;) {
+		int option_index = 0;
+
+		static struct option long_options[] = {
+			{"forks", required_argument, NULL, OPT_NFORKS},
+			{"iters", required_argument, NULL, OPT_NITERS},
+			{"help", no_argument, NULL, OPT_HELP},
+			{NULL, 0, NULL, 0},
+		};
+		int c = getopt_long(argc, argv, "f:i:h", long_options, &option_index);
+		if (c == -1)
+			break;
+		switch(c) {
+			case 'f':
+			case OPT_NFORKS:
+				nforks = atoi(optarg);
+				break;
+			case 'i':
+			case OPT_NITERS:
+				nsteps = atoi(optarg);
+				break;
+			case 'h':
+			case OPT_HELP:
+				usage();
+				break;
+		}
 	}
+
 	printf("#main : %d\n", getpid());
 	printf("#forks: %d\n", nforks);
 	printf("#steps: %d\n", nsteps);
-- 
2.20.1

