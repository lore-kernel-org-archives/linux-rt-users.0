From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] cyclictest: remove some uclibc specific defines
Date: Mon, 7 Mar 2011 10:10:04 +0100
Message-ID: <20110307091004.GA3558@www.tglx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: linux-rt-users@vger.kernel.org
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:49505 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753615Ab1CGJKT (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 7 Mar 2011 04:10:19 -0500
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The uClibc stuff I remove here made it into uclibc in 0.9.29-rc1 which
was relase in April 2k7. The final release was in May. I think that is
enough time.

I leave clock_nanosleep() because it made its way into uClibc in
v0.9.32-rc1. Currently there is -rc2 available.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 src/cyclictest/cyclictest.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 0847aed..4756ff8 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -65,14 +65,6 @@ static int clock_nanosleep(clockid_t clock_id, int flags, const struct timespec
 	return syscall(__NR_clock_nanosleep, clock_id, flags, req, rem);
 }
 
-static int sched_setaffinity(pid_t pid, unsigned int cpusetsize,
-		cpu_set_t *mask)
-{
-	return -EINVAL;
-}
