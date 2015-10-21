From: Henrik Austad <haustad@cisco.com>
Subject: [PATCH 4/4] rt-sched.h: do not unconditionally define syscall-numbers
Date: Wed, 21 Oct 2015 15:49:02 +0200
Message-ID: <1445435342-16969-5-git-send-email-haustad@cisco.com>
References: <1445435342-16969-1-git-send-email-haustad@cisco.com>
Cc: Henrik Austad <henrik@austad.us>,
	Henrik Austad <haustad@cisco.com>,
	John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from aer-iport-3.cisco.com ([173.38.203.53]:2834 "EHLO
	aer-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013AbbJUNxT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 21 Oct 2015 09:53:19 -0400
In-Reply-To: <1445435342-16969-1-git-send-email-haustad@cisco.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

These could be defined elsewhere, be careful when defining these

Cc: John Kacur <jkacur@redhat.com>
Signed-off-by: Henrik Austad <haustad@cisco.com>
---
 src/include/rt-sched.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/include/rt-sched.h b/src/include/rt-sched.h
index b46b1b16606f..679c4bd10ae2 100644
--- a/src/include/rt-sched.h
+++ b/src/include/rt-sched.h
@@ -43,9 +43,13 @@
 #endif
 
 #ifdef __arm__
+#ifndef __NR_sched_setattr
 #define __NR_sched_setattr		380
+#endif
+#ifndef __NR_sched_getattr
 #define __NR_sched_getattr		381
 #endif
+#endif
 
 #ifdef __tilegx__
 #define __NR_sched_setattr		274
-- 
1.9.1

