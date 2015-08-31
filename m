From: Josh Cartwright <joshc@ni.com>
Subject: [PATCH rt-tests 2/9] cyclictest: fixup documentation for --priority option
Date: Mon, 31 Aug 2015 11:35:29 -0500
Message-ID: <01e06fd455b51323577b0af9bb144e892281ecf8.1441038216.git.joshc@ni.com>
References: <cover.1441038216.git.joshc@ni.com>
Cc: linux-rt-users@vger.kernel.org
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:44391 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753340AbbHaQfj (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 31 Aug 2015 12:35:39 -0400
In-Reply-To: <cover.1441038216.git.joshc@ni.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Commit 15c6d81986b6 ("[cyclictest] added priority spreading option
--priospread") introduced an additional option with the prefix 'prio';
this means that it is no longer possible for a user to specify '--prio'
instead of the full '--priority'.  Doing so results in the following
error:

  $ cyclictest --prio=4
  cyclictest: option '--prio=4' is ambiguous; possibilities: '--priority' '--priospread'

Fix this up by updating the 'help' output.

Signed-off-by: Josh Cartwright <joshc@ni.com>
---
 src/cyclictest/cyclictest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 9aebe32..4ced67f 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1062,7 +1062,7 @@ static void display_help(int error)
 	       "-N       --nsecs           print results in ns instead of us (default us)\n"
 	       "-o RED   --oscope=RED      oscilloscope mode, reduce verbose output by RED\n"
 	       "-O TOPT  --traceopt=TOPT   trace option\n"
-	       "-p PRIO  --prio=PRIO       priority of highest prio thread\n"
+	       "-p PRIO  --priority=PRIO   priority of highest prio thread\n"
 	       "-P       --preemptoff      Preempt off tracing (used with -b)\n"
 	       "-q       --quiet           print only a summary on exit\n"
 	       "	 --priospread       spread priority levels starting at specified value\n"
-- 
2.5.0

