From: Henrik Austad <haustad@cisco.com>
Subject: [PATCH 2/6] Add syscall-number for sched_(gs)etattr() for tile
Date: Mon, 21 Sep 2015 17:27:24 +0200
Message-ID: <1442849248-573-3-git-send-email-haustad@cisco.com>
References: <1442849248-573-1-git-send-email-haustad@cisco.com>
Cc: linux-rt-users@vger.kernel.org, Josh Cartwright <joshc@ni.com>,
	Henrik Austad <haustad@cisco.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from alln-iport-3.cisco.com ([173.37.142.90]:43724 "EHLO
	alln-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756458AbbIUP3e (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 Sep 2015 11:29:34 -0400
In-Reply-To: <1442849248-573-1-git-send-email-haustad@cisco.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Signed-off-by: Henrik Austad <haustad@cisco.com>
---
 src/include/rt-sched.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/include/rt-sched.h b/src/include/rt-sched.h
index 6c45f7a..b46b1b1 100644
--- a/src/include/rt-sched.h
+++ b/src/include/rt-sched.h
@@ -47,6 +47,11 @@
 #define __NR_sched_getattr		381
 #endif
 
+#ifdef __tilegx__
+#define __NR_sched_setattr		274
+#define __NR_sched_getattr		275
+#endif
+
 struct sched_attr {
 	uint32_t size;
 	uint32_t sched_policy;
-- 
1.9.1

