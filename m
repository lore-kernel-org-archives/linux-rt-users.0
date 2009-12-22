From: John Kacur <jkacur@redhat.com>
Subject: [PATCH] rt-tests: Clean-up, Fix the comment part of the #endif
 protecting include files
Date: Tue, 22 Dec 2009 01:08:18 +0100 (CET)
Message-ID: <alpine.LFD.2.00.0912220106360.9791@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Clark Williams <williams@redhat.com>,
	Carsten Emde <carsten.emde@osadl.org>,
	Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:27091 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751050AbZLVAIj (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 Dec 2009 19:08:39 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>From b1ff404d5545dd69ecc44b0055efb5478ec624f6 Mon Sep 17 00:00:00 2001
From: John Kacur <jkacur@redhat.com>
Date: Tue, 22 Dec 2009 00:43:04 +0100
Subject: [PATCH] rt-tests: Clean-up, Fix the comment part of the #endif protecting include files

Clean-up, Fix the comment part of the #endif protecting include files

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/lib/rt-get_cpu.h |    2 +-
 src/lib/rt-utils.h   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/lib/rt-get_cpu.h b/src/lib/rt-get_cpu.h
index 2338a56..15d05fc 100644
--- a/src/lib/rt-get_cpu.h
+++ b/src/lib/rt-get_cpu.h
@@ -42,5 +42,5 @@ static inline int getcpu_vdso(void)
 
 #endif
 
-#endif	/* RT_GET_CPU_H */
+#endif	/* __RT_GET_CPU_H */
 
diff --git a/src/lib/rt-utils.h b/src/lib/rt-utils.h
index 61cd800..cc23c33 100644
--- a/src/lib/rt-utils.h
+++ b/src/lib/rt-utils.h
@@ -8,4 +8,4 @@
 int check_privs(void);
 char *get_debugfileprefix(void);
 
-#endif	/* RT_UTILS.H */
+#endif	/* __RT_UTILS.H */
-- 
1.6.0.6

