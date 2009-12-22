From: David Sommerseth <davids@redhat.com>
Subject: [PATCH 4/4] Updated man page to reflect --refresh-on-max agrument name change
Date: Tue, 22 Dec 2009 16:47:38 +0100
Message-ID: <1261496858-12744-5-git-send-email-davids@redhat.com>
References: <1261496858-12744-1-git-send-email-davids@redhat.com>
Cc: jkacur@redhat.com, williams@redhat.com,
	David Sommerseth <davids@redhat.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33742 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753534AbZLVPrq (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 22 Dec 2009 10:47:46 -0500
Received: from int-mx05.intmail.prod.int.phx2.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.18])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id nBMFljcd008936
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-rt-users@vger.kernel.org>; Tue, 22 Dec 2009 10:47:46 -0500
In-Reply-To: <1261496858-12744-1-git-send-email-davids@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Signed-off-by: David Sommerseth <davids@redhat.com>
---
 src/cyclictest/cyclictest.8 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index c0f3fa8..8bf95e2 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -156,7 +156,7 @@ rt-task wakeup tracing (used with \-b)
 set the scheduler policy of the measurement threads 
 where NAME is one of: other, normal, batch, idle, fifo, rr
 .TP
-.B \\-M, \-\-refresh_on_max
+.B \\-M, \-\-refresh-on-max
 delay updating the screen until a new max latency is hit (useful for
 running cyclictest on low-bandwidth connections)
 .\" .SH SEE ALSO
-- 
1.6.2.5

