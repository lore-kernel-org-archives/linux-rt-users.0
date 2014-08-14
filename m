From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 4/6] cyclictest: Change the output from function sighand() to stderr
Date: Thu, 14 Aug 2014 18:18:08 +0200
Message-ID: <1408033090-24866-5-git-send-email-jkacur@redhat.com>
References: <1408033090-24866-1-git-send-email-jkacur@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
To: rt-users <linux-rt-users@vger.kernel.org>,
	Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:48978 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823AbaHNQSZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 14 Aug 2014 12:18:25 -0400
Received: by mail-we0-f169.google.com with SMTP id u56so1302172wes.14
        for <linux-rt-users@vger.kernel.org>; Thu, 14 Aug 2014 09:18:23 -0700 (PDT)
In-Reply-To: <1408033090-24866-1-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

cyclictest can be run from other tools such as rteval
in order to get current status on long runs, SIGUSR1 is sent to
cyclictest and caught by function sighand()

This creates difficulties for rteval when parsing cyclictest output, so
change the output to stderr.

Note, a RFC was sent out on Apr.15 2014 entitled
"RFC: SIGUSR1 to stderr"
to:	 RT <linux-rt-users@vger.kernel.org>
cc:	 Carsten Emde <C.Emde@osadl.org>,
	 Thomas Gleixner <tglx@linutronix.de>,
	  Clark Williams <williams@redhat.com>

Since I didn't receive any replies, I'm assumin there are no objections

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 64f1764681b0..ad7890ffaa95 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1569,11 +1569,11 @@ static void sighand(int sig)
 		int oldquiet = quiet;
 
 		quiet = 0;
-		printf("#---------------------------\n");
-		printf("# cyclictest current status:\n");
+		fprintf(stderr, "#---------------------------\n");
+		fprintf(stderr, "# cyclictest current status:\n");
 		for (i = 0; i < num_threads; i++)
-			print_stat(stdout, parameters[i], i, 0, 0);
-		printf("#---------------------------\n");
+			print_stat(stderr, parameters[i], i, 0, 0);
+		fprintf(stderr, "#---------------------------\n");
 		quiet = oldquiet;
 		return;
 	}
-- 
1.8.1.4

