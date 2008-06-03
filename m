From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH - cyclictest ] search for debugfs
Date: Tue, 3 Jun 2008 11:47:16 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0806031140170.22839@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Darren Hart <dvhltc@us.ibm.com>,
	Subrata Modak <subrata@linux.vnet.ibm.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.124]:38145 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752788AbYFCPrS (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 3 Jun 2008 11:47:18 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Not everyone mounts debugfs at /debug. This patch makes cyclictest search
for debugfs in the /proc/mounts directory.

Signed-off-by: Steven Rostedt <srostedt@redhat.com>
---
 src/cyclictest/cyclictest.c |   46 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

Index: rt-tests/src/cyclictest/cyclictest.c
===================================================================
--- rt-tests.orig/src/cyclictest/cyclictest.c	2008-06-03 11:33:05.000000000 -0400
+++ rt-tests/src/cyclictest/cyclictest.c	2008-06-03 11:44:57.000000000 -0400
@@ -126,8 +126,12 @@ static struct kvars {
 	char value[KVALUELEN];
 } kv[KVARS];

+#define _STR(x) #x
+#define STR(x) _STR(x)
+#define MAX_PATH 256
+
 static char *procfileprefix = "/proc/sys/kernel/";
-static char *debugfileprefix = "/debug/tracing/";
+static char debugfileprefix[MAX_PATH];

 enum kernelversion {
 	KV_NOT_26,
@@ -136,6 +140,43 @@ enum kernelversion {
 	KV_26_CURR
 };

+enum {
+	ERROR_GENERAL	= -1,
+	ERROR_NOTFOUND	= -2,
+};
+
+/*
+ * Finds the path to the debugfs/tracing
+ */
+static int set_debugfileprefix(void)
+{
+	char type[100];
+	FILE *fp;
+	int size;
+
+	if ((fp = fopen("/proc/mounts","r")) == NULL)
+		return ERROR_GENERAL;
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
+	if (strcmp(type, "debugfs") != 0)
+		return ERROR_NOTFOUND;
+
+	size = strlen(debugfileprefix);
+	size = MAX_PATH - size;
+
+	strncat(debugfileprefix, "/tracing", size);
+
+	return 0;
+}
+
 static int kernvar(int mode, char *name, char *value, size_t sizeofvalue)
 {
 	char filename[128];
@@ -702,8 +743,9 @@ int main(int argc, char **argv)
 		fprintf(stderr, "WARNING: Most functions require kernel 2.6\n");

 	if (tracelimit && kernelversion == KV_26_CURR) {
-		char testname[32];
+		char testname[MAX_PATH];

+		set_debugfileprefix();
 		strcpy(testname, debugfileprefix);
 		strcat(testname, "tracing_enabled");
 		if (access(testname, R_OK)) {
