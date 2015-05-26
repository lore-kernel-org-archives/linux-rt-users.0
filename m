From: anna-maria@glx-um.de
Subject: [patch 1/3] cyclictest: Ensure that next wakeup time is never in the
 past
Date: Tue, 26 May 2015 19:07:01 -0000
Message-ID: <20150526190443.567997063@glx-um.de>
References: <20150526190333.510838769@glx-um.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Clark Williams <williams@redhat.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:39449 "EHLO Tesla.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751250AbbEZTv1 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 26 May 2015 15:51:27 -0400
Content-Disposition: inline; filename=calc-next-wakeup.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The calculated next wakeup time is already in the past, if the latency
is longer than the interval. Thereby latency is detected that does not
correspond to latency caused by the system but by cyclictest itself.

Force forward the next wakeup time past now.

Signed-off-by: Anna-Maria Gleixner <anna-maria@glx-um.de>
---
 src/cyclictest/cyclictest.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

Index: rt-tests/src/cyclictest/cyclictest.c
===================================================================
--- rt-tests.orig/src/cyclictest/cyclictest.c
+++ rt-tests/src/cyclictest/cyclictest.c
@@ -369,6 +369,12 @@ static inline void tsnorm(struct timespe
 	}
 }
 
+static inline int tsgreater(struct timespec *a, struct timespec *b)
+{
+	return ((a->tv_sec > b->tv_sec) ||
+		(a->tv_sec == b->tv_sec && a->tv_nsec > b->tv_nsec));
+}
+
 static inline int64_t calcdiff(struct timespec t1, struct timespec t2)
 {
 	int64_t diff;
@@ -949,6 +955,12 @@ void *timerthread(void *param)
 		}
 		tsnorm(&next);
 
+		while (tsgreater(&now, &next)) {
+			next.tv_sec += interval.tv_sec;
+			next.tv_nsec += interval.tv_nsec;
+			tsnorm(&next);
+		}
+
 		if (par->max_cycles && par->max_cycles == stat->cycles)
 			break;
 	}


