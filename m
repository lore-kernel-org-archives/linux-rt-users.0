From: Luis Henriques <henrix@sapo.pt>
Subject: [PATCH][rt-tests] Trivial patch for cyclictest
Date: Mon, 9 Feb 2009 18:51:40 +0000
Message-ID: <20090209185140.GA6052@hades.domain.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from relay1.ptmail.sapo.pt ([212.55.154.21]:47652 "HELO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751668AbZBISxF (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 9 Feb 2009 13:53:05 -0500
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The help for the -C option was being printed out inside the help of the -c
option.
Signed-off-by: Luis Henriques <henrix@sapo.pt>

---
 src/cyclictest/cyclictest.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 2706914..63bf140 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -642,9 +642,9 @@ static void display_help(void)
 	       "-b USEC  --breaktrace=USEC send break trace command when latency > USEC\n"
 	       "-B       --preemptirqs     both preempt and irqsoff tracing (used with -b)\n"
 	       "-c CLOCK --clock=CLOCK     select clock\n"
-	       "-C       --context         context switch tracing (used with -b)\n"
 	       "                           0 = CLOCK_MONOTONIC (default)\n"
 	       "                           1 = CLOCK_REALTIME\n"
+	       "-C       --context         context switch tracing (used with -b)\n"
 	       "-d DIST  --distance=DIST   distance of thread intervals in us default=500\n"
 	       "-E       --event           event tracing (used with -b)\n"
 	       "-f       --ftrace          function trace (when -b is active)\n"
-- 
1.5.6.5


