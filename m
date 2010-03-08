From: John Kacur <jkacur@redhat.com>
Subject: [PATCH] cyclictest: Use symbolic names for scheduling policy
Date: Mon,  8 Mar 2010 02:18:22 +0100
Message-ID: <1268011104-22451-3-git-send-email-jkacur@redhat.com>
References: <1268011104-22451-1-git-send-email-jkacur@redhat.com>
Cc: rt-users <linux-rt-users@vger.kernel.org>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f225.google.com ([209.85.219.225]:62954 "EHLO
	mail-ew0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751843Ab0CHBSb (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 7 Mar 2010 20:18:31 -0500
Received: by mail-ew0-f225.google.com with SMTP id 25so1185630ewy.39
        for <linux-rt-users@vger.kernel.org>; Sun, 07 Mar 2010 17:18:31 -0800 (PST)
In-Reply-To: <1268011104-22451-1-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

- Use symbolic names for scheduling policies, that is, don't assume
	SCHED_RR is 2, use SCHED_RR instead, and so on.

- Fix the logic in handlepolicy(char *polname)
	- remove the test with the unreachable line,
	- make the default SCHED_FIFO if we don't recognize the
	requested policy.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c |   15 +++++----------
 1 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index d38c0a7..066ca79 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -826,13 +826,8 @@ static void handlepolicy(char *polname)
 		policy = SCHED_FIFO;
 	else if (strncasecmp(polname, "rr", 2) == 0)
 		policy = SCHED_RR;
-
-	if (policy == SCHED_FIFO || policy == SCHED_RR) {
-		if (policy == 0)
-			policy = 1;
-	}
-	else 
-		policy = 0;
+	else	/* default policy if we don't recognize the request */
+		policy = SCHED_FIFO;
 }
 
 static char *policyname(int policy)
@@ -1303,9 +1298,9 @@ int main(int argc, char **argv)
 		par->prio = priority;
 		if (priority && !histogram && !smp && !numa)
 			priority--;
-                if      (priority && policy <= 1) par->policy = SCHED_FIFO;
-                else if (priority && policy == 2) par->policy = SCHED_RR;
-                else                              par->policy = SCHED_OTHER;
+                if (priority && policy == SCHED_FIFO) par->policy = SCHED_FIFO;
+                else if (priority && policy == SCHED_RR) par->policy = SCHED_RR;
+                else  par->policy = SCHED_OTHER;
 		par->clock = clocksources[clocksel];
 		par->mode = mode;
 		par->timermode = timermode;
-- 
1.6.0.6

