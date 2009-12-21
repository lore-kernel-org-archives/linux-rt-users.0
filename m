From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 3/4] rt-tests: Clean-up - protect rt-utils.h
Date: Mon, 21 Dec 2009 22:45:49 +0100
Message-ID: <1261431950-28500-4-git-send-email-jkacur@redhat.com>
References: <1261431950-28500-1-git-send-email-jkacur@redhat.com>
 <1261431950-28500-2-git-send-email-jkacur@redhat.com>
 <1261431950-28500-3-git-send-email-jkacur@redhat.com>
Cc: John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org
To: Clark Williams <williams@redhat.com>,
	Carsten Emde <carsten.emde@osadl.org>,
	Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:64114 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757334AbZLUVqK (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 Dec 2009 16:46:10 -0500
Received: by mail-bw0-f227.google.com with SMTP id 27so3775854bwz.21
        for <linux-rt-users@vger.kernel.org>; Mon, 21 Dec 2009 13:46:09 -0800 (PST)
In-Reply-To: <1261431950-28500-3-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Clean-up: Protect rt-utils.h with #ifndef RT_UTILS_H

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/lib/rt-utils.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/src/lib/rt-utils.h b/src/lib/rt-utils.h
index e9c8cdd..fbdcf2b 100644
--- a/src/lib/rt-utils.h
+++ b/src/lib/rt-utils.h
@@ -1,6 +1,11 @@
+#ifndef RT_UTILS.H
+#define RT_UTILS.H
+
 #define _STR(x) #x
 #define STR(x) _STR(x)
 #define MAX_PATH 256
 
 int check_privs(void);
 char *get_debugfileprefix(void);
+
+#endif	/* RT_UTILS.H */
-- 
1.6.5.2

