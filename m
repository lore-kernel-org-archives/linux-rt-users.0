From: David Sommerseth <davids@redhat.com>
Subject: [PATCH 3/4] Added --help screen info about -M / --refresh-on-max in cyclictest
Date: Tue, 22 Dec 2009 16:47:37 +0100
Message-ID: <1261496858-12744-4-git-send-email-davids@redhat.com>
References: <1261496858-12744-1-git-send-email-davids@redhat.com>
Cc: jkacur@redhat.com, williams@redhat.com,
	David Sommerseth <davids@redhat.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38866 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753623AbZLVPro (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 22 Dec 2009 10:47:44 -0500
Received: from int-mx05.intmail.prod.int.phx2.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.18])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id nBMFli1k031100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-rt-users@vger.kernel.org>; Tue, 22 Dec 2009 10:47:44 -0500
In-Reply-To: <1261496858-12744-1-git-send-email-davids@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Also renamed --refresh_on_max to --refresh-on-max

Signed-off-by: David Sommerseth <davids@redhat.com>
---
 src/cyclictest/cyclictest.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 223f343..7979a77 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -788,6 +788,7 @@ static void display_help(int error)
 	       "-I       --irqsoff         Irqsoff tracing (used with -b)\n"
 	       "-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
 	       "-m       --mlockall        lock current and future memory allocations\n"
+	       "-M       --refresh-on-max  delay updating the screen until a new max latency is hit\n"
 	       "-n       --nanosleep       use clock_nanosleep\n"
 	       "-N       --nsecs           print results in ns instead of us (default us)\n"
 	       "-o RED   --oscope=RED      oscilloscope mode, reduce verbose output by RED\n"
@@ -910,7 +911,7 @@ static void process_options (int argc, char *argv[])
 			{"irqsoff", no_argument, NULL, 'I'},
 			{"loops", required_argument, NULL, 'l'},
 			{"mlockall", no_argument, NULL, 'm' },
-			{"refresh_on_max", no_argument, NULL, 'M' },
+			{"refresh-on-max", no_argument, NULL, 'M' },
 			{"nanosleep", no_argument, NULL, 'n'},
 			{"nsecs", no_argument, NULL, 'N'},
 			{"oscope", required_argument, NULL, 'o'},
-- 
1.6.2.5

