From: Luiz Capitulino <lcapitulino@redhat.com>
Subject: [PATCH 4/4] cyclictest: initialize 'stop' early
Date: Wed, 24 Feb 2016 15:49:41 -0500
Message-ID: <1456346981-24032-5-git-send-email-lcapitulino@redhat.com>
References: <1456346981-24032-1-git-send-email-lcapitulino@redhat.com>
Cc: williams@redhat.com, jkacur@redhat.com
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48301 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757970AbcBXUtr (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 24 Feb 2016 15:49:47 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id 0ACE165423
	for <linux-rt-users@vger.kernel.org>; Wed, 24 Feb 2016 20:49:47 +0000 (UTC)
In-Reply-To: <1456346981-24032-1-git-send-email-lcapitulino@redhat.com>
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
index 34053c5..22c5403 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -793,6 +793,8 @@ void *timerthread(void *param)
 		tspec.it_interval = interval;
 	}
 
+	memset(&stop, 0, sizeof(stop));
+
 	memset(&schedp, 0, sizeof(schedp));
 	schedp.sched_priority = par->prio;
 	if (setscheduler(0, par->policy, &schedp))
@@ -832,10 +834,10 @@ void *timerthread(void *param)
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

