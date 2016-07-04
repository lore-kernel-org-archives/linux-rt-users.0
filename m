From: Francis Giraldeau <francis.giraldeau@gmail.com>
Subject: [PATCH] Fix cyclictest negative durations
Date: Mon,  4 Jul 2016 12:43:43 -0400
Message-ID: <1467650623-9927-1-git-send-email-francis.giraldeau@gmail.com>
Cc: linux-rt-users@vger.kernel.org,
	Francis Giraldeau <francis.giraldeau@gmail.com>
To: williams@redhat.com, jkacur@redhat.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:36624 "EHLO
	mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734AbcGDQnu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 4 Jul 2016 12:43:50 -0400
Received: by mail-qk0-f194.google.com with SMTP id r68so30806065qka.3
        for <linux-rt-users@vger.kernel.org>; Mon, 04 Jul 2016 09:43:50 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

When the next interval is too far in the future, then now < next, and the
elapsed time calcdiff(now, next) is negative. If such a situation occurs, it is
obvious the calculation of the next interval was wrong, and we rewind it until
we find a positive value.

This bug can be reproduced by setting a very short interval, such as 1us:

Without the patch:
  ./cyclictest -i 1
  T: 0 ( 8429) P: 0 I:1 C:1099294 Min:      0 Act:  -34 Avg:-9223372036854775808 Max:      -1

With the patch:
  ./cyclictest -i 1
  T: 0 ( 8665) P: 0 I:1 C: 419151 Min:      0 Act:    0 Avg:    0 Max:      76

Signed-off-by: Francis Giraldeau <francis.giraldeau@gmail.com>
---
 src/cyclictest/cyclictest.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 34053c5..151b0eb 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -914,6 +914,16 @@ void *timerthread(void *param)
 			goto out;
 		}
 
+		// the next interval was too far in the future, rewind it
+		while (calcdiff_ns(now, next) < 0) {
+			next.tv_sec -= interval.tv_sec;
+			next.tv_nsec -= interval.tv_nsec;
+			if (next.tv_nsec < 0) {
+				next.tv_sec--;
+				next.tv_nsec += NSEC_PER_SEC;
+			}
+		}
+
 		if (use_nsecs)
 			diff = calcdiff_ns(now, next);
 		else
-- 
2.7.4

