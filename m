From: Carsten Emde <C.Emde@osadl.org>
Subject: [PATCH 1/2] do-not-allow-prio-less-than-one-in-cyclictest.patch
Date: Sun, 07 Mar 2010 21:39:56 +0100
Message-ID: <20100307204241.033320249@osadl.org>
References: <20100307203955.895980022@osadl.org>
Cc: RT-users <linux-rt-users@vger.kernel.org>,
	Carsten Emde <C.Emde@osadl.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:60222 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754855Ab0CGV3q (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 7 Mar 2010 16:29:46 -0500
Content-Disposition: inline; filename=do-not-allow-prio-below-one-in-cyclictest.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

If not in SMP testing mode, the priority may go below 1, if the specified
priority is lower than the number of threads, e.g.
# cyclictest -p2 -t3
T: 0 (21970) P: 2 [..]
T: 1 (21971) P: 1 [..]
T: 2 (21972) P: 0 [..]

Do not allow priority to go below 1.

Signed-off-by: Carsten Emde <C.Emde@osadl.org>

Index: rt-tests/src/cyclictest/cyclictest.c
===================================================================
--- rt-tests.orig/src/cyclictest/cyclictest.c
+++ rt-tests/src/cyclictest/cyclictest.c
@@ -1304,7 +1304,7 @@ int main(int argc, char **argv)
 		}
 
 		par->prio = priority;
-		if (!sameprio)
+		if (priority > 1 && !sameprio)
 			priority--;
                 if      (priority && policy <= 1) par->policy = SCHED_FIFO;
                 else if (priority && policy == 2) par->policy = SCHED_RR;

