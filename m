From: Tommi Rantala <tommi.t.rantala@nokia.com>
Subject: [PATCH 31/34] cyclicdeadline: avoid signed vs unsigned compiler warnings
Date: Mon, 22 May 2017 12:04:21 +0300
Message-ID: <20170522090424.16086-2-tommi.t.rantala@nokia.com>
References: <20170522082540.15467-1-tommi.t.rantala@nokia.com>
 <20170522090424.16086-1-tommi.t.rantala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-rt-users@vger.kernel.org>,
        Tommi Rantala <tommi.t.rantala@nokia.com>
To: Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-db5eur01on0112.outbound.protection.outlook.com ([104.47.2.112]:24346
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751678AbdEVJEq (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 May 2017 05:04:46 -0400
In-Reply-To: <20170522090424.16086-1-tommi.t.rantala@nokia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

src/sched_deadline/cyclicdeadline.c: In function 'do_runtime':
src/sched_deadline/cyclicdeadline.c:757:11: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
  if (diff > stat->max)
           ^
src/sched_deadline/cyclicdeadline.c:759:25: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
  if (!stat->min || diff < stat->min)
                         ^

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 src/sched_deadline/cyclicdeadline.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index e8cc559..5fbfa13 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -754,9 +754,9 @@ static u64 do_runtime(struct sched_data *sd, u64 period)
 
 
 	diff = now - period;
-	if (diff > stat->max)
+	if (diff > (u64)stat->max)
 		stat->max = diff;
-	if (!stat->min || diff < stat->min)
+	if (!stat->min || diff < (u64)stat->min)
 		stat->min = diff;
 	stat->act = diff;
 	stat->avg += (double) diff;
-- 
2.9.3

