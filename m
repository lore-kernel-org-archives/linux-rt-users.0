From: GeunSik Lim <leemgs1@gmail.com>
Subject: [PATCH 2/3] cyclictest: Fix  the same priority method of many
	threads with -h option.
Date: Sat, 27 Jun 2009 00:38:09 +0900
Message-ID: <1246030689.2153.32.camel@centos51>
Reply-To: leemgs1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: tglx <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-px0-f190.google.com ([209.85.216.190]:40145 "EHLO
	mail-px0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904AbZFZPiP (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 26 Jun 2009 11:38:15 -0400
Received: by pxi28 with SMTP id 28so1749095pxi.33
        for <linux-rt-users@vger.kernel.org>; Fri, 26 Jun 2009 08:38:17 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



>From 63c01db3e4b2c3a76f0dd5191f46535137e310c8 Mon Sep 17 00:00:00 2001
From: GeunSik,Lim <leemgs1@gmail.com>
Date: Fri, 26 Jun 2009 23:36:45 +0900
Subject: [PATCH 2/3] cyclictest: Fix priority-- method of many threads with -h.

If we run a many threads with -t option, "priority--" rt priority will assign
per thread in sequence. But, If we use -h option, all threads is same priority.
Adjust the same prirotiy method about below two examples for consistency.
ex) cyclictest -t 5 -p 50        [enter] <-- without -h
ex) cyclictest -t 5 -p 50 -h 100 [enter] <-- with    -h

        Signed-off-by: GeunSik Lim <geunsik.lim@samsung.com>
---
 src/cyclictest/cyclictest.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index ad4c421..3505de5 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1150,7 +1150,7 @@ int main(int argc, char **argv)
 		}
 
 		par[i].prio = priority;
-		if (priority && !histogram)
+		if (priority)
 			priority--;
                 if      ( policy == 0) par[i].policy = SCHED_OTHER;
                 else if ( policy == 1) par[i].policy = SCHED_FIFO;
-- 
1.6.3.1


-----------------------------------------------
To unsubscribe from this list: send the line "unsubscribe linux-***" 
in the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

GeunSik Lim ( Samsung Electronics )
e-Mail  :1) geunsik.lim@samsung.com
         2) leemgs@gmail.com , leemgs1@gmail.com
HomePage: http://blog.naver.com/invain/
-----------------------------------------------

