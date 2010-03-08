From: John Kacur <jkacur@redhat.com>
Subject: [PATCH] Revert "simplify equal priority logic for cyclictest"
Date: Mon,  8 Mar 2010 02:18:21 +0100
Message-ID: <1268011104-22451-2-git-send-email-jkacur@redhat.com>
References: <1268011104-22451-1-git-send-email-jkacur@redhat.com>
Cc: rt-users <linux-rt-users@vger.kernel.org>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:61105 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751919Ab0CHBSb (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 7 Mar 2010 20:18:31 -0500
Received: by ey-out-2122.google.com with SMTP id 25so773328eya.19
        for <linux-rt-users@vger.kernel.org>; Sun, 07 Mar 2010 17:18:30 -0800 (PST)
In-Reply-To: <1268011104-22451-1-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Unfortunately this commit introduces a bug because the priority is not
retested, and this can result in reported priorities below 0.
For example,

sudo ./cyclictest -t3 -p1
policy: fifo: loadavg: 0.09 0.06 0.05 1/331 21732

T: 0 (21730) P: 1 I:1000 C:    593 Min:     34 Act:  155 Avg:  100 Max:     672
T: 1 (21731) P: 0 I:1500 C:    395 Min:     15 Act:   43 Avg:   72 Max:     853
T: 2 (21732) P:-1 I:2000 C:    297 Min:     21 Act:   57 Avg:   79 Max:     330

Notice that the last priority is reported as -1.

After reverting this commit, we get the correct expected behaviour.

sudo ./cyclictest -t3 -p1
policy: fifo: loadavg: 0.07 0.05 0.04 2/330 21754

T: 0 (21752) P: 1 I:1000 C:  11600 Min:     13 Act: 7072 Avg: 3593 Max:    7841
T: 1 (21753) P: 0 I:1500 C:   7737 Min:     12 Act: 1572 Avg:  516 Max:    2381
T: 2 (21754) P: 0 I:2000 C:   5804 Min:     12 Act:   53 Avg:   59 Max:     548

I think it can be argued that the original code is also clearer, although
that is somewhat subjective. With the original code I don't need to track
down exactly what "sameprio" means, and it is clear what is being tested.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index dc86b49..d38c0a7 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -801,7 +801,6 @@ static int interval = 1000;
 static int distance = 500;
 static int affinity = 0;
 static int smp = 0;
-static int sameprio = 0;
 
 enum {
 	AFFINITY_UNSPECIFIED,
@@ -1043,9 +1042,7 @@ static void process_options (int argc, char *argv[])
 	if (num_threads < 1)
 		error = 1;
 
-	if (priority && (smp || numa || histogram)) 
-		sameprio = 1;
- 
+
 	if (error)
 		display_help(1);
 }
@@ -1304,7 +1301,7 @@ int main(int argc, char **argv)
 		}
 
 		par->prio = priority;
-		if (!sameprio)
+		if (priority && !histogram && !smp && !numa)
 			priority--;
                 if      (priority && policy <= 1) par->policy = SCHED_FIFO;
                 else if (priority && policy == 2) par->policy = SCHED_RR;
-- 
1.6.0.6

