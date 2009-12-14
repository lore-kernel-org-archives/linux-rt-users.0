From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 1/7] Start a separate library of functions for the rt-test suite. The first couple are taken from cyclictest.
Date: Mon, 14 Dec 2009 16:58:50 +0100
Message-ID: <1260806336-4691-2-git-send-email-jkacur@redhat.com>
References: <1260806336-4691-1-git-send-email-jkacur@redhat.com>
Cc: Carsten Emde <carsten.emde@osadl.org>,
	linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	John Kacur <jkacur@redhat.com>
To: Clark Williams <williams@redhat.com>,
	Carsten Emde <carsten.emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:40002 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757551AbZLNP7V (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Dec 2009 10:59:21 -0500
Received: by bwz27 with SMTP id 27so2113580bwz.21
        for <linux-rt-users@vger.kernel.org>; Mon, 14 Dec 2009 07:59:19 -0800 (PST)
In-Reply-To: <1260806336-4691-1-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Carsten Emde <carsten.emde@osadl.org>

Signed-off-by: Carsten Emde <carsten.emde@osadl.org>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/lib/rt-utils.c |   65 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/lib/rt-utils.h |    6 ++++
 2 files changed, 71 insertions(+), 0 deletions(-)
 create mode 100644 src/lib/rt-utils.c
 create mode 100644 src/lib/rt-utils.h

diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
new file mode 100644
index 0000000..4e7597c
--- /dev/null
+++ b/src/lib/rt-utils.c
@@ -0,0 +1,65 @@
+#include <stdio.h>
+#include <string.h>
+#include <sched.h>
+#include "rt-utils.h"
+
+static char debugfileprefix[MAX_PATH];
+
+/*
+ * Finds the tracing directory in a mounted debugfs
+ */
+char *get_debugfileprefix(void)
+{
+	char type[100];
+	FILE *fp;
+	int size;
+
+	if (debugfileprefix[0] != '\0')
+		return debugfileprefix;
+
+	if ((fp = fopen("/proc/mounts","r")) == NULL)
+		return debugfileprefix;
+
+	while (fscanf(fp, "%*s %"
+		      STR(MAX_PATH)
+		      "s %99s %*s %*d %*d\n",
+		      debugfileprefix, type) == 2) {
+		if (strcmp(type, "debugfs") == 0)
+			break;
+	}
+	fclose(fp);
+
+	if (strcmp(type, "debugfs") != 0) {
+		debugfileprefix[0] = '\0';
+		return debugfileprefix;
+	}
+
+	size = sizeof(debugfileprefix) - strlen(debugfileprefix);
+	strncat(debugfileprefix, "/tracing/", size);
+
+	return debugfileprefix;
+}
+
+int check_privs(void)
+{
+	int policy = sched_getscheduler(0);
+	struct sched_param param;
+
+	/* if we're already running a realtime scheduler
+	 * then we *should* be able to change things later
+	 */
+	if (policy == SCHED_FIFO || policy == SCHED_RR)
+		return 0;
+
+	/* try to change to SCHED_FIFO */
+	param.sched_priority = 1;
+	if (sched_setscheduler(0, SCHED_FIFO, &param)) {
+		fprintf(stderr, "Unable to change scheduling policy!\n");
+		fprintf(stderr, "either run as root or join realtime group\n");
+		return 1;
+	}
+
+	/* we're good; change back and return success */
+	sched_setscheduler(0, policy, NULL);
+	return 0;
+}
diff --git a/src/lib/rt-utils.h b/src/lib/rt-utils.h
new file mode 100644
index 0000000..e9c8cdd
--- /dev/null
+++ b/src/lib/rt-utils.h
@@ -0,0 +1,6 @@
+#define _STR(x) #x
+#define STR(x) _STR(x)
+#define MAX_PATH 256
+
+int check_privs(void);
+char *get_debugfileprefix(void);
-- 
1.6.5.2

