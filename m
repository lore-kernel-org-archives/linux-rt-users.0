From: John Kacur <jkacur@redhat.com>
Subject: [PATCH][rt-tests] cyclictest: Make the tracemark option imply
 notrace
Date: Thu, 24 Mar 2016 15:44:39 +0100 (CET)
Message-ID: <alpine.LFD.2.20.1603241543150.8641@riemann>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Luiz Capitulino <lcapitulino@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:33925 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782AbcCXOom (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 24 Mar 2016 10:44:42 -0400
Received: by mail-wm0-f44.google.com with SMTP id p65so277527022wmp.1
        for <linux-rt-users@vger.kernel.org>; Thu, 24 Mar 2016 07:44:42 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>From 6b663b39fc5dc7c4e9c78ab22012f07490e53145 Mon Sep 17 00:00:00 2001
From: John Kacur <jkacur@redhat.com>
Date: Thu, 24 Mar 2016 15:40:03 +0100
Subject: [PATCH] cyclictest: Make the tracemark option imply notrace

The new --tracemark option can be used to run cyclictest under
trace-cmd.

This means we don't want cyclictest's built-in tracing to be used, so
this option is only compatible with --notrace.

Therefore turn --notrace on if --tracemark is invoked even if the user
doesn't explicitly request this.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 4844dfaf33a6..158bceda1204 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1765,6 +1765,7 @@ static void process_options (int argc, char *argv[], int max_cpus)
 #endif
 			break;
 		case OPT_TRACEMARK:
+			notrace = 1; /* using --tracemark implies --notrace */
 			trace_marker = 1; break;
 		}
 	}
-- 
2.4.3

