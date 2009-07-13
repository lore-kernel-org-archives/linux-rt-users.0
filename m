From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] cyclictest: exit with an error code in error case
Date: Mon, 13 Jul 2009 14:32:09 +0200
Message-ID: <20090713123209.GA2515@www.tglx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: linux-rt-users@vger.kernel.org
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:53182 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755542AbZGMMc3 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 13 Jul 2009 08:32:29 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

if cyclictest is started with invalid arguments or $SOMETHING, then it
prints the help screen and the exit code is 0 which is wrong.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 src/cyclictest/cyclictest.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index bfb8aa9..e1c9e0e 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -746,7 +746,7 @@ out:
 
 
 /* Print usage information */
-static void display_help(void)
+static void display_help(int error)
 {
 	char tracers[MAX_PATH];
 
@@ -805,6 +805,8 @@ static void display_help(void)
                "                           format: --policy=fifo(default) or --policy=rr\n",
 	       tracers
 		);
+	if (error)
+		exit(-1);
 	exit(0);
 }
 
@@ -977,7 +979,7 @@ static void process_options (int argc, char *argv[])
                 case 'w': tracetype = WAKEUP; break;
                 case 'W': tracetype = WAKEUPRT; break;
                 case 'y': handlepolicy(optarg); break;
-		case '?': error = 1; break;
+		case '?': display_help(0); break;
 		}
 	}
 
@@ -1028,7 +1030,7 @@ static void process_options (int argc, char *argv[])
 
 
 	if (error)
-		display_help ();
+		display_help(1);
 }
 
 static int check_kernel(void)
-- 
1.6.2.5
