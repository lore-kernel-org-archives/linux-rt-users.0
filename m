From: Luiz Capitulino <lcapitulino@redhat.com>
Subject: [PATCH 3/3] cyclictest: initialize 'stop' early
Date: Thu, 17 Mar 2016 14:29:05 -0400
Message-ID: <1458239345-30892-4-git-send-email-lcapitulino@redhat.com>
References: <1458239345-30892-1-git-send-email-lcapitulino@redhat.com>
Cc: williams@redhat.com, jkacur@redhat.com
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34483 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966473AbcCQS3Q (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 17 Mar 2016 14:29:16 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id 75B5E804E5
	for <linux-rt-users@vger.kernel.org>; Thu, 17 Mar 2016 18:29:16 +0000 (UTC)
In-Reply-To: <1458239345-30892-1-git-send-email-lcapitulino@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

For some modes like MODE_CLOCK_NANOSLEEP, the clock
is already ticking when 'stop' is initialized. This
shouldn't matter, as this memset() should very fast
(I'd guess a few dozens or hundrends nanoseconds at
most?), but I also think there's no reason to do it
this late. So, initialize it along with everything
else.

Signed-off-by: Luiz Capitulino <lcapitulino@redhat.com>
---
 src/cyclictest/cyclictest.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index f5a67dc..202939f 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -829,6 +829,8 @@ static void *timerthread(void *param)
 		tspec.it_interval = interval;
 	}
 
+	memset(&stop, 0, sizeof(stop));
+
 	memset(&schedp, 0, sizeof(schedp));
 	schedp.sched_priority = par->prio;
 	if (setscheduler(0, par->policy, &schedp))
@@ -868,10 +870,10 @@ static void *timerthread(void *param)
 	tsnorm(&next);
 
 	if (duration) {
-		memset(&stop, 0, sizeof(stop)); /* grrr */
 		stop = now;
 		stop.tv_sec += duration;
 	}
+
 	if (par->mode == MODE_CYCLIC) {
 		if (par->timermode == TIMER_ABSTIME)
 			tspec.it_value = next;
-- 
2.1.0

